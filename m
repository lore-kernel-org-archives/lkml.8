Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E0C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE9420732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBXRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgBXRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EF321556;
        Mon, 24 Feb 2020 17:21:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPx-001Afo-Cb; Mon, 24 Feb 2020 12:21:17 -0500
Message-Id: <20200224172117.257281873@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-linus][PATCH 09/15] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Set CONFIG_BOOT_CONFIG=n by default. This also warns
user if CONFIG_BOOT_CONFIG=n but "bootconfig" is given
in the kernel command line.

Link: http://lkml.kernel.org/r/158220111291.26565.9036889083940367969.stgit@devnote2

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/Kconfig         | 1 -
 init/main.c          | 8 ++++++++
 kernel/trace/Kconfig | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4a672c6629d0..f586878410d2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1218,7 +1218,6 @@ endif
 config BOOT_CONFIG
 	bool "Boot config support"
 	depends on BLK_DEV_INITRD
-	default y
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
diff --git a/init/main.c b/init/main.c
index 48c87f47a444..d96cc5f65022 100644
--- a/init/main.c
+++ b/init/main.c
@@ -418,6 +418,14 @@ static void __init setup_boot_config(const char *cmdline)
 }
 #else
 #define setup_boot_config(cmdline)	do { } while (0)
+
+static int __init warn_bootconfig(char *str)
+{
+	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
+	return 0;
+}
+early_param("bootconfig", warn_bootconfig);
+
 #endif
 
 /* Change NUL term back to "=", to make "param" the whole string. */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 91e885194dbc..795c3e02d3f1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -143,7 +143,8 @@ if FTRACE
 
 config BOOTTIME_TRACING
 	bool "Boot-time Tracing support"
-	depends on BOOT_CONFIG && TRACING
+	depends on TRACING
+	select BOOT_CONFIG
 	default y
 	help
 	  Enable developer to setup ftrace subsystem via supplemental
-- 
2.25.0


