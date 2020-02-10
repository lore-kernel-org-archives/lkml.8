Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA2C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1172C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581369107;
	bh=wt38Mhym5ZWnCPH9lj6WqRDHQEUu2aeLLF6wfdyZzD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWSTJ7Wz6aVUBvPBXJmReZGXMJqKvZ12QWE/3qq+n0vSoVE3VhIZAb6/2REyXO0uB
	 ZwAS9qot3rvVIJnSpzoaaE/eQ+9vKTIgpJyu14g1MswpURxP04OghyXc6OnOH1LLph
	 Ov/7g29G09gw7CbNoa7Lp9buJPo/VizP8ghrdPQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBJVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgBJVLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:11:45 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688F42070A;
        Mon, 10 Feb 2020 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581369103;
        bh=wt38Mhym5ZWnCPH9lj6WqRDHQEUu2aeLLF6wfdyZzD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDb7rkvniOHn1WQlq1D5LQQmx3ut1Mnxdws+AjakBYeO1vQ/kfSeE04pxrgmEJAKh
         TE1G4itYT8Kw3gUsLdOCPMpzvCEWBhXFESNRn5W3+yp1ommfJqMJ1Shez4VWRk14pB
         krBNauxdipP/iPJool2axmooTCsdLxQUW6Wx1HFw=
Date:   Mon, 10 Feb 2020 13:11:42 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200210211142.GB1373304@kroah.com>
References: <20200123093628.GA18991@willie-the-truck>
 <20200123085015.GA436361@kroah.com>
 <CAGETcx86rQpS4qodSiv_v+E_8P3DUQDY9jiN_Yq07Jwh9tHQcQ@mail.gmail.com>
 <20200125101130.449a8e4d@lwn.net>
 <20200125014231.GI147870@mit.edu>
 <20200123155340.GD147870@mit.edu>
 <20200209110549.GA1621867@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209110549.GA1621867@kroah.com>
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
v6: fix up Kconfig help, it was a bit incorrect,thanks to Saravana for
    the review.
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
index 69def4a9df00..7f4992fd8a2e 100644
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
+	  which is contained in the 'debugfs' filesystem or procfs.
+	  Thus, the debugfs or procfs filesystem must first be mounted before
+	  making use of this feature.
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

base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.0

