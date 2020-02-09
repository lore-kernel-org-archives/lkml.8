Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C362C352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721632081E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581253036;
	bh=6sX0Ip+mK3tsK8D8/OZZvuROxHkWLqF6ytnpDiTpDsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Cglnb22RY7dtYwoFdZj7uPCgFxmb55CxH9dVjvKQeFIA+aJFwtMDg57mcljrlRG1R
	 K578K5Q1ggmsttJ1Hk8qCl+/ILQr4L9pZpX8JXLKTC5zKOia5SO+/SfAFh5O6qqRFs
	 5CnfVVz17rqc0VlWMNDmRE6cHJXSBfybyqV0XP2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBIM5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbgBIM5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:57:15 -0500
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3C620733;
        Sun,  9 Feb 2020 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581253034;
        bh=6sX0Ip+mK3tsK8D8/OZZvuROxHkWLqF6ytnpDiTpDsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uSxZe6b/ilcxBYyy5/bKvhjr7cQ9Ksm4h7zu5SBIPM+dw5YWlfJQkbJeGY3LwRLj0
         cdVypdKUJmaw12ip8kq0HQOgkiYxOtubI4lvvt0hMDgJlMTM7B9KdjyE4HGLtxaDaG
         HiFCNoAPNqKYPRb2357mo+LpyTQFACsKkIqGNa8M=
Date:   Sun, 9 Feb 2020 12:05:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200209110549.GA1621867@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123093628.GA18991@willie-the-truck>
 <20200123085015.GA436361@kroah.com>
 <CAGETcx86rQpS4qodSiv_v+E_8P3DUQDY9jiN_Yq07Jwh9tHQcQ@mail.gmail.com>
 <20200125101130.449a8e4d@lwn.net>
 <20200125014231.GI147870@mit.edu>
 <20200123155340.GD147870@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the realization that having debugfs enabled on "production" systems
is generally not a good idea, debugfs is being disabled from more and
more platforms over time.  However, the functionality of dynamic
debugging still is needed at times, and since it relies on debugfs for
its user api, having debugfs disabled also forces dynamic debug to be
disabled.

To get around this, also create the "control" file for dynamic_debug in
procfs.  This allows people turn on debugging as needed at runtime for
individual driverfs and subsystems.

Reported-by: many different companies
Cc: Jason Baron <jbaron@akamai.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v5: as many people asked for it, now enable the control file in both
    debugfs and procfs at the same time.
v4: tweaks to the .rst text thanks to Randy's review
v3: rename init function as it is now no longer just for debugfs, thanks
    to Jason for the review.
    Fix build warning for debugfs_initialized call.
v2: Fix up octal permissions and add procfs reference to the Kconfig
    entry, thanks to Will for the review.

 .../admin-guide/dynamic-debug-howto.rst       |  3 +++
 lib/Kconfig.debug                             |  7 ++++---
 lib/dynamic_debug.c                           | 20 ++++++++++++++-----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 252e5ef324e5..585451d12608 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
 				<debugfs>/dynamic_debug/control
   -bash: echo: write error: Invalid argument
 
+Note, for systems without 'debugfs' enabled, the control file can also
+be found in ``/proc/dynamic_debug/control``.
+
 Viewing Dynamic Debug Behaviour
 ===============================
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..a15dde66dc4c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -98,7 +98,7 @@ config DYNAMIC_DEBUG
 	bool "Enable dynamic printk() support"
 	default n
 	depends on PRINTK
-	depends on DEBUG_FS
+	depends on (DEBUG_FS || PROC_FS)
 	help
 
 	  Compiles debug level messages into the kernel, which would not
@@ -116,8 +116,9 @@ config DYNAMIC_DEBUG
 	  Usage:
 
 	  Dynamic debugging is controlled via the 'dynamic_debug/control' file,
-	  which is contained in the 'debugfs' filesystem. Thus, the debugfs
-	  filesystem must first be mounted before making use of this feature.
+	  which is contained in the 'debugfs' filesystem or procfs if
+	  debugfs is not present. Thus, the debugfs or procfs filesystem
+	  must first be mounted before making use of this feature.
 	  We refer the control file as: <debugfs>/dynamic_debug/control. This
 	  file contains a list of the debug statements that can be enabled. The
 	  format for each line of the file is:
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..c220c1891729 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -991,15 +991,25 @@ static void ddebug_remove_all_tables(void)
 
 static __initdata int ddebug_init_success;
 
-static int __init dynamic_debug_init_debugfs(void)
+static int __init dynamic_debug_init_control(void)
 {
-	struct dentry *dir;
+	struct proc_dir_entry *procfs_dir;
+	struct dentry *debugfs_dir;
 
 	if (!ddebug_init_success)
 		return -ENODEV;
 
-	dir = debugfs_create_dir("dynamic_debug", NULL);
-	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
+	/* Create the control file in debugfs if it is enabled */
+	if (debugfs_initialized()) {
+		debugfs_dir = debugfs_create_dir("dynamic_debug", NULL);
+		debugfs_create_file("control", 0644, debugfs_dir, NULL,
+				    &ddebug_proc_fops);
+	}
+
+	/* Also create the control file in procfs */
+	procfs_dir = proc_mkdir("dynamic_debug", NULL);
+	if (procfs_dir)
+		proc_create("control", 0644, procfs_dir, &ddebug_proc_fops);
 
 	return 0;
 }
@@ -1077,4 +1087,4 @@ static int __init dynamic_debug_init(void)
 early_initcall(dynamic_debug_init);
 
 /* Debugfs setup must be done later */
-fs_initcall(dynamic_debug_init_debugfs);
+fs_initcall(dynamic_debug_init_control);
-- 
2.25.0

