Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94481C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6555124655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579679027;
	bh=/whmBYaC4rMnY2P9A7GfcDIpf7X1/9zZdmRFzlm610M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aWQETf4BMbKInEVOpUaVI9zS9YCAmHLaQ/FF4qzETtrEEx5mQKYDSF5mMHkpOXrhv
	 yYzEBSCU8qAPTv7MxmCHKx41eA6l7WY5bM124DxkovsNbxNCfwMc+WvKeoqoRwY4UQ
	 l+kyDEbSyXSHtwiGp9tHVK/ZwbwXCTLAVo8+Zg8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAVHnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:43:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgAVHnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:43:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8A524655;
        Wed, 22 Jan 2020 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579679025;
        bh=/whmBYaC4rMnY2P9A7GfcDIpf7X1/9zZdmRFzlm610M=;
        h=Date:From:To:Cc:Subject:From;
        b=yb6xsOrGMvzG3Ptwiwt/om1+S/5rfFSIWAUUR4f6pNNliLpiYvtmiXhWU584zGew/
         jYUHjCUYcFNzB1fHhY7G2jxFpxnPyiAa7+YfKOgXKE8FY4k/MDosdiCM9UBrEMua3s
         GMvEFqwbJY+50BUM2pyEYrGCIcdNe8TSu1o3ixa8=
Date:   Wed, 22 Jan 2020 08:43:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [PATCH] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200122074343.GA2099098@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 .../admin-guide/dynamic-debug-howto.rst         |  3 +++
 lib/Kconfig.debug                               |  2 +-
 lib/dynamic_debug.c                             | 17 ++++++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

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
index 5ffe144c9794..01d4add8b963 100644
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
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..077b2d6623ac 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -993,13 +993,24 @@ static __initdata int ddebug_init_success;
 
 static int __init dynamic_debug_init_debugfs(void)
 {
-	struct dentry *dir;
+	struct dentry *debugfs_dir;
+	struct proc_dir_entry *procfs_dir;
 
 	if (!ddebug_init_success)
 		return -ENODEV;
 
-	dir = debugfs_create_dir("dynamic_debug", NULL);
-	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
+	/* Create the control file in debugfs if it is enabled */
+	if (debugfs_initialized) {
+		debugfs_dir = debugfs_create_dir("dynamic_debug", NULL);
+		debugfs_create_file("control", 0644, debugfs_dir, NULL,
+				    &ddebug_proc_fops);
+		return 0;
+	}
+
+	/* No debugfs so put it in procfs instead */
+	procfs_dir = proc_mkdir("dynamic_debug", NULL);
+	if (procfs_dir)
+		proc_create("control", 0x644, procfs_dir, &ddebug_proc_fops);
 
 	return 0;
 }
-- 
2.25.0

