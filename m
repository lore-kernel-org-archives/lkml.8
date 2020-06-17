Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E087C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073A921556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFQNiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:38:10 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:13750 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgFQNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:38:09 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH v3] debugfs: Add access restriction option
Date:   Wed, 17 Jun 2020 15:37:38 +0200
Message-ID: <20200617133738.6631-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VdGJw2h9 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=nTHF0DUjJn0A:10 a=z6gsHLkEAAAA:8 a=tXAC--fUqkprKkcgtVIA:9 a=d-OLMTCWyvARjPbQ-enb:22
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

When enabled it is needed a kernel command line parameter to be activated.

It can be on or off, but also internally on but not seen from user-space.
This no-fs mode do not register a debugfs as filesystem, but client can
register their parts in the internal structures. This data can be readed
with a debugger or saved with a crashkernel. When it is off clients
get EPERM error when accessing the functions for registering their
components.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
v2. Removed MOUNT as part of restrictions. Added API's restrictions as
    separate restriction.
v3  Updated Documentation after Randy Dunlap reviews and suggestions.

 .../admin-guide/kernel-parameters.txt         | 11 +++++
 fs/debugfs/inode.c                            | 47 +++++++++++++++++++
 lib/Kconfig.debug                             | 10 ++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..249c86e53bb7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -827,6 +827,17 @@
 			useful to also enable the page_owner functionality.
 			on: enable the feature
 
+	debugfs=    	[KNL] When CONFIG_DEBUG_FS_RESTRICTED is set, this parameter
+			enables what is exposed to userspace.
+			Format: { on, no_fs, off }
+			on: 	All functions are enabled.
+			no_fs: 	Filesystem is not registered but kernel clients can
+			        access APIs and a crashkernel can be used to read
+				it's content. There its nothing to mount.
+			off: 	(default) Filesystem is not registered and clients
+			        get a -EPERM as result when trying to register files
+				or directories within debugfs.
+
 	debugpat	[X86] Enable PAT debugging
 
 	decnet.addr=	[HW,NET]
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..2bd80a932ae1 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -31,10 +31,17 @@
 #include "internal.h"
 
 #define DEBUGFS_DEFAULT_MODE	0700
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+#define DEBUGFS_ALLOW_API 0x2
+#define DEBUGFS_ALLOW_FS 0x1
+#endif
 
 static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+static unsigned int debugfs_allow;
+#endif
 
 /*
  * Don't allow access attributes to be changed whilst the kernel is locked down
@@ -266,6 +273,10 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
 			int flags, const char *dev_name,
 			void *data)
 {
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
+		return ERR_PTR(-EPERM);
+#endif
 	return mount_single(fs_type, flags, data, debug_fill_super);
 }
 
@@ -385,6 +396,12 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (IS_ERR(dentry))
 		return dentry;
 
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+#endif
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
@@ -541,6 +558,12 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (IS_ERR(dentry))
 		return dentry;
 
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+#endif
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
@@ -583,6 +606,12 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (IS_ERR(dentry))
 		return dentry;
 
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
+		failed_creating(dentry);
+		return ERR_PTR(-EPERM);
+	}
+#endif
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
@@ -786,10 +815,28 @@ bool debugfs_initialized(void)
 }
 EXPORT_SYMBOL_GPL(debugfs_initialized);
 
+static int __init debugfs_kernel(char *str)
+{
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+	if (str && !strcmp(str, "on"))
+		debugfs_allow = DEBUGFS_ALLOW_API | DEBUGFS_ALLOW_FS;
+	if (str && !strcmp(str, "no-fs"))
+		debugfs_allow |= DEBUGFS_ALLOW_API;
+	if (str && !strcmp(str, "off"))
+		debugfs_allow = 0;
+#endif
+	return 0;
+
+}
+early_param("debugfs", debugfs_kernel);
 static int __init debugfs_init(void)
 {
 	int retval;
 
+#ifdef CONFIG_DEBUG_FS_RESTRICTED
+	if (!(debugfs_allow & DEBUGFS_ALLOW_FS))
+		return -EPERM;
+#endif
 	retval = sysfs_create_mount_point(kernel_kobj, "debug");
 	if (retval)
 		return retval;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d74ac0fd6b2d..19fdaae14e36 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -477,6 +477,16 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
+config DEBUG_FS_RESTRICTED
+	bool "Debug Filesystem restricted"
+	depends on DEBUG_FS
+	help
+	  This is an additional restriction for mounting debugfs. It allows
+	  the kernel to have debugfs compiled, but requires that kernel command
+	  line has a debugfs parameter to register as a filesystem.
+
+	  If unsure, say N.
+
 source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
-- 
2.17.1

