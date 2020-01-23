Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E5C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419822467B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579769420;
	bh=WmUzWil0Ci7WqA90ZgpGxlZoIZbsqRT3FGXduYBahT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bvP7gP5gJWdTTLTxNhs8gSfjdqimRzuRe3HHzNePtl3ykkg9Zzt/FTf1Wd4amt3tr
	 wfDw6RQy2GWk/2CpMbKwkZF6/lvlKBNeTEuhpCuGmtYLB9MaJ4qQJGy/1hQY3kvx+A
	 MJQzkf27XsNhSpbdh0/81mNthiswMecLrPN0ATX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAWIuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWIuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:50:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373E32087E;
        Thu, 23 Jan 2020 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579769417;
        bh=WmUzWil0Ci7WqA90ZgpGxlZoIZbsqRT3FGXduYBahT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8WlXIzR56OYhxv2Xx5yrxdxxXUXq0Z5QV8Sj8YfBZOSvUanc1oF3VjEJ5kjVmC/w
         oatpmjsBUsvscfiYTHxSP1QvqCqMn8id2khfnQSZn55MMYAku3H3+EY0hNrS+ZNqWn
         bo0j7SXyjw1muS5+K1yflfMZFlSVVEQIfXHSy8LA=
Date:   Thu, 23 Jan 2020 09:50:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v4] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200123085015.GA436361@kroah.com>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <ef1172ac-ea78-146e-575e-93e2d65b4606@infradead.org>
 <20200123084847.GA435637@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123084847.GA435637@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the realization that having debugfs enabled on "production" systems is
generally not a good idea, debugfs is being disabled from more and more
platforms over time.  However, the functionality of dynamic debugging still is
needed at times, and since it relies on debugfs for its user api, having
debugfs disabled also forces dynamic debug to be disabled.

To get around this, move the "control" file for dynamic_debug to procfs IFF
debugfs is disabled.  This lets people turn on debugging as needed at runtime
for individual driverfs and subsystems.

Reported-by: many different companies
Cc: Jason Baron <jbaron@akamai.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v4: tweaks to the .rst text thanks to Randy's review
v3: rename init function as it is now no longer just for debugfs, thanks
    to Jason for the review.
    Fix build warning for debugfs_initialized call.
v2: Fix up octal permissions and add procfs reference to the Kconfig
    entry, thanks to Will for the review.

 .../admin-guide/dynamic-debug-howto.rst       |  3 +++
 lib/Kconfig.debug                             |  7 ++++---
 lib/dynamic_debug.c                           | 21 ++++++++++++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 252e5ef324e5..60679dda6007 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
 				<debugfs>/dynamic_debug/control
   -bash: echo: write error: Invalid argument
 
+Note, for systems without 'debugfs' enabled, the control file is located
+in ``/proc/dynamic_debug/control``.
+
 Viewing Dynamic Debug Behaviour
 ===============================
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ffe144c9794..49980eb8c18e 100644
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
index c60409138e13..118e928cdbda 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -991,15 +991,26 @@ static void ddebug_remove_all_tables(void)
 
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
+		return 0;
+	}
+
+	/* No debugfs so put it in procfs instead */
+	procfs_dir = proc_mkdir("dynamic_debug", NULL);
+	if (procfs_dir)
+		proc_create("control", 0644, procfs_dir, &ddebug_proc_fops);
 
 	return 0;
 }
@@ -1077,4 +1088,4 @@ static int __init dynamic_debug_init(void)
 early_initcall(dynamic_debug_init);
 
 /* Debugfs setup must be done later */
-fs_initcall(dynamic_debug_init_debugfs);
+fs_initcall(dynamic_debug_init_control);
-- 
2.25.0

