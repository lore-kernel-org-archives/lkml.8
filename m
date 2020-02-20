Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0EC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C12A24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582201119;
	bh=K/9CMYoxOYoxCxKAlYDI8OjuN+wfuitIF2vrRPoSxjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEjI7FyRSaUX4IIKkcx0F1gUvdKmD01QdqZY4hI0OHCOFWLQQjNWcZqdOP4t1Anm9
	 DzR6108i5QFgQkkAuHpioF9/AJFsa5n2blZdsi1YaZO3SXP/6o/xjdFaV/OStCnZfz
	 GIl2YqUvX6zJEAfzlmewfkiQvaGJAxq4PlDdfOEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBTMSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgBTMSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:18:37 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585F224672;
        Thu, 20 Feb 2020 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201117;
        bh=K/9CMYoxOYoxCxKAlYDI8OjuN+wfuitIF2vrRPoSxjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eq7ncjbXRO9oaLudfxmdpuDcoM9bg46KLdp8sbnQhEJaid7nuMChIuTw+h5msBBUQ
         s23WqwRL+/OZ8GFTdUG5buOdcZ8rXV6rYzIuWu+XcBisAVRncTdgVy8gVM9e9fO55B
         PGMDzbYQchuBbYXV/ghOSJhvxwfvtOKx9V1qgL+c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
Date:   Thu, 20 Feb 2020 21:18:33 +0900
Message-Id: <158220111291.26565.9036889083940367969.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158220110257.26565.4812934676257459744.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set CONFIG_BOOT_CONFIG=n by default. This also warns
user if CONFIG_BOOT_CONFIG=n but "bootconfig" is given
in the kernel command line.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 V2: Use pr_warn() for warning message.
     Remove unneeded "default n" line from Kconfig.
---
 init/Kconfig         |    1 -
 init/main.c          |    8 ++++++++
 kernel/trace/Kconfig |    3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 452bc1835cd4..e76e9241552c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1227,7 +1227,6 @@ endif
 config BOOT_CONFIG
 	bool "Boot config support"
 	depends on BLK_DEV_INITRD
-	default y
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
diff --git a/init/main.c b/init/main.c
index f95b014a5479..ae4e37681247 100644
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

