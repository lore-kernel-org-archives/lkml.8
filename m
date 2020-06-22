Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C5206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFVIas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:30:48 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:15484 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgFVIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:30:45 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH 2/2] debugfs: Add access restriction option
Date:   Mon, 22 Jun 2020 10:30:19 +0200
Message-ID: <20200622083019.15479-3-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622083019.15479-1-peter.enderborg@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200622083019.15479-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=B7jHL9lM c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=nTHF0DUjJn0A:10 a=z6gsHLkEAAAA:8 a=T63rtsT0MoZSlwSC9SoA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debugfs include sensitive information it need to be treated
carefully. But it also has many very useful debug functions for userspace.
With this option we can have same configuration for system with
need of debugfs and a way to turn it off. This gives a extra protection
for exposure on systems where user-space services with system
access are attacked.

It is controlled by a configurable default value that can be override
with a kernel command line parameter. (debugfs=)

It can be on or off, but also internally on but not seen from user-space.
This no-fs mode do not register a debugfs as filesystem, but client can
register their parts in the internal structures. This data can be readed
with a debugger or saved with a crashkernel. When it is off clients
get EPERM error when accessing the functions for registering their
components.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 .../admin-guide/kernel-parameters.txt         | 12 ++++++
 fs/debugfs/inode.c                            | 37 +++++++++++++++++++
 fs/debugfs/internal.h                         | 14 +++++++
 lib/Kconfig.debug                             | 32 ++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..236aacaceaf5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -827,6 +827,18 @@
 			useful to also enable the page_owner functionality.
 			on: enable the feature
 
+	debugfs=    	[KNL] This parameter enables what is exposed to userspace
+			and debugfs internal clients.
+			Format: { on, no-fs, off }
+			on: 	All functions are enabled.
+			no-fs: 	Filesystem is not registered but kernel clients can
+			        access APIs and a crashkernel can be used to read
+				its content. There is nothing to mount.
+			off: 	Filesystem is not registered and clients
+			        get a -EPERM as result when trying to register files
+				or directories within debugfs.
+			Default value is set in build-time with a kernel configuration.
+
 	debugpat	[X86] Enable PAT debugging
 
 	decnet.addr=	[HW,NET]
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..a4a1c92ae478 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -35,6 +35,7 @@
 static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
+static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ACCESS_BITS;
 
 /*
  * Don't allow access attributes to be changed whilst the kernel is locked down
@@ -266,6 +267,9 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
 			void *data)
 {
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT))
+		return ERR_CAST(ERR_PTR(-EPERM));
+
 	return mount_single(fs_type, flags, data, debug_fill_super);
 }
 
@@ -311,6 +315,9 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT))
+		return ERR_PTR(-EPERM);
+
 	pr_debug("creating file '%s'\n", name);
 
 	if (IS_ERR(parent))
@@ -385,6 +392,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (IS_ERR(dentry))
 		return dentry;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
@@ -541,6 +553,11 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (IS_ERR(dentry))
 		return dentry;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
@@ -583,6 +600,11 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (IS_ERR(dentry))
 		return dentry;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
@@ -786,10 +808,25 @@ bool debugfs_initialized(void)
 }
 EXPORT_SYMBOL_GPL(debugfs_initialized);
 
+static int __init debugfs_kernel(char *str)
+{
+	if (str && !strcmp(str, "on"))
+		debugfs_allow = DEBUGFS_ALLOW_API_BIT | DEBUGFS_ALLOW_FS_BIT;
+	if (str && !strcmp(str, "no-fs"))
+		debugfs_allow = DEBUGFS_ALLOW_API_BIT;
+	if (str && !strcmp(str, "off"))
+		debugfs_allow = 0;
+
+	return 0;
+}
+early_param("debugfs", debugfs_kernel);
 static int __init debugfs_init(void)
 {
 	int retval;
 
+	if (!(debugfs_allow & DEBUGFS_ALLOW_FS_BIT))
+		return -EPERM;
+
 	retval = sysfs_create_mount_point(kernel_kobj, "debug");
 	if (retval)
 		return retval;
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 034e6973cead..dba138f8d418 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -29,4 +29,18 @@ struct debugfs_fsdata {
  */
 #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
 
+/* Access BITS */
+#define DEBUGFS_ALLOW_API_BIT BIT(0)
+#define DEBUGFS_ALLOW_FS_BIT BIT(1)
+
+#ifdef CONFIG_DEBUG_FS_ACCESS_ALL
+#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_FS_BIT|DEBUGFS_ALLOW_API_BIT)
+#endif
+#ifdef CONFIG_DEBUG_FS_ACCESS_NO_FS
+#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_API_BIT)
+#endif
+#ifdef CONFIG_DEBUG_FS_ACCESS_NONE
+#define DEFAULT_DEBUGFS_ACCESS_BITS (0)
+#endif
+
 #endif /* _DEBUGFS_INTERNAL_H_ */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d74ac0fd6b2d..4c699ffad1fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -477,6 +477,38 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
+choice
+	prompt "Debugfs default access"
+	depends on DEBUG_FS
+	default DEBUG_FS_ACCESS_ALL
+	help
+	  This select the default access restricions for debugfs.
+	  It can be overridden with kernel command line option
+	  debugfs=[on,no-fs,off] The restrictions apply for API access
+	  and filesystem registration. .
+
+config DEBUG_FS_ACCESS_ALL
+       bool "Access all"
+       help
+	  No restrictions applies. Both API and filesystem registration
+	  is on.
+
+config DEBUG_FS_ACCESS_NO_FS
+       bool "Do not register debugfs as filesystem"
+       help
+	 The API is open but filesystem not loaded. Client can still do
+	 their work and readed with debug tools that does not need
+	 debugfs filesystem.
+
+config DEBUG_FS_ACCESS_NONE
+       bool "No access"
+       help
+	  Access is off. Clients get EPERM when trying to create nodes in
+	  debugfs tree and debugfs is not registred as an filesystem.
+	  Client can then back-off or continue without debugfs access.
+
+endchoice
+
 source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
-- 
2.26.2

