Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C271FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965B124656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579721485;
	bh=o2BnmCQVbX1UVnBo117qG0JJqt29R4LDgBWBNwBCcQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P3aR/xV2Vh4aOexBLrToEcC5HXTzsy5JQ5d9866hL4CTLQrQOhhWBvnCV+B6e2Xxr
	 x1D4byPYcBrAzE2jvmQmtHZblNH7kNoAbtxmMsWaMzfCxhNWn5zAcOoPjyoZl1KBpP
	 f4Nefu/R2Etf3rjLbdYrP2u3u2V2caI4829wnYmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVTbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVTbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:31:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16AE20704;
        Wed, 22 Jan 2020 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579721481;
        bh=o2BnmCQVbX1UVnBo117qG0JJqt29R4LDgBWBNwBCcQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPCNSwnvKq6CG8pVShRBsttZS4RrcNSv4Ahv7eME+9bprcKvO+/Gi8oJ7MpK+Ij4F
         8N1DgvPdGzZNBQutcGobd0ROCxCMJkJDVnpDnR/qL8gWzl3JpTFs+SNHZvLaCvmy0k
         LFXPfbpwADUlvJscy+xKm9SDu/pO5tuuUW8eWtE4=
Date:   Wed, 22 Jan 2020 20:31:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200122193118.GA88722@kroah.com>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122192940.GA88549@kroah.com>
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
index 252e5ef324e5..41f43a373a6a 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
 				<debugfs>/dynamic_debug/control
   -bash: echo: write error: Invalid argument
 
+Note, for systems without 'debugfs' enabled, the control file can be
+also found in ``/proc/dynamic_debug/control``.
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

