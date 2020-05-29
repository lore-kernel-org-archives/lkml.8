Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D3BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DA42074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzySAK8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgE2L10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2L1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:27:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F2C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so1352689pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ctBq+QFlLwI1QYopIw19U7dJqDOQ/tbZAKxzZCAns8=;
        b=kzySAK8hODG2cYbJPTRthw/g8bz7SqzCixHZT8y2YFZkKrIJ6GBecBhOjAVtkZJM6Q
         112LqTSB86oh909HxSy7h2MQhm6ErbCF+VDmFqoFL5VsBuDuvMkxYrBRXJ/lJGyl1uxs
         NzCOwup3zZTYr0jEOGxwm45QIb0w/P0AYqRSJINqDfTD3/pn7hLt+S5Y09ykeiAoX0Ko
         gDPZNDFCOZMnYg/do+73Tt9GUggw4SNAUdIr7ql9H/1yLWnuqBb2tPPzTzljekmXMDPu
         Tl32j7DhBWMHOcNIXDm81RCftktTygtIhWvy9MaBIGfbZdE+n7wLD2qSCqBYpcza3zKO
         NvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ctBq+QFlLwI1QYopIw19U7dJqDOQ/tbZAKxzZCAns8=;
        b=qNLitlzkiB6RJVdVaNY+mK3+9sVRAWjnZRWaWk+hVvAD+6LGBq/uZY1dhHJQs6JVl7
         rG0heAD8H4nMjUCVby/v1+bxZfeupN0YcYPI29HLUG3M1JtfsfkxQ2imP97cer8vzcLS
         YOlxWC5KUV9taVz5Ut3BmVHPN4guenqGdY0m7AJ3+QBpIDFemBxgmKX/816DRz/jbqNP
         MVufVMuWCNxgbnQfYs4qZmL26EaTXfi1zZ6GLuJVHFbP4axXxrEt3MlDEIVAZ0g92SdG
         WM90FR1ROiLO++N6nS0QDMexYLWzVs1eD1aK9Wrsk5Cn/TW+YSPUmM+nHT7xJgNn8h0a
         jdzQ==
X-Gm-Message-State: AOAM531AHRM1aguGHxBWmV1lpjsLxqgingWaT9D0pfXtVTaGmW8TCdeP
        OdTMBSoxqSEhWs0smMrsI0l6gg==
X-Google-Smtp-Source: ABdhPJyZQD0j97uBCkvFSTJVeHWcc/hD1RgDKQB6l+K9JSBkI9QYvpFPoUPe31PoiWJtOhMnWWUhqA==
X-Received: by 2002:a63:33c6:: with SMTP id z189mr8093582pgz.426.1590751643548;
        Fri, 29 May 2020 04:27:23 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id w190sm7016741pfw.35.2020.05.29.04.27.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 04:27:22 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/4] kdb: Re-factor kdb_printf() message write code
Date:   Fri, 29 May 2020 16:56:44 +0530
Message-Id: <1590751607-29676-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-factor kdb_printf() message write code in order to avoid duplication
of code and thereby increase readability.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 61 +++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 924bc92..e46f33e 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -542,6 +542,33 @@ static int kdb_search_string(char *searched, char *searchfor)
 	return 0;
 }
 
+static void kdb_io_write(char *cp, int len)
+{
+	if (len == 0)
+		return;
+
+	while (len--) {
+		dbg_io_ops->write_char(*cp);
+		cp++;
+	}
+}
+
+static void kdb_msg_write(char *msg, int msg_len)
+{
+	struct console *c;
+
+	if (msg_len == 0)
+		return;
+
+	if (dbg_io_ops && !dbg_io_ops->is_console)
+		kdb_io_write(msg, msg_len);
+
+	for_each_console(c) {
+		c->write(c, msg, msg_len);
+		touch_nmi_watchdog();
+	}
+}
+
 int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 {
 	int diag;
@@ -553,7 +580,6 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 	int this_cpu, old_cpu;
 	char *cp, *cp2, *cphold = NULL, replaced_byte = ' ';
 	char *moreprompt = "more> ";
-	struct console *c;
 	unsigned long uninitialized_var(flags);
 
 	/* Serialize kdb_printf if multiple cpus try to write at once.
@@ -687,22 +713,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 	 */
 	retlen = strlen(kdb_buffer);
 	cp = (char *) printk_skip_headers(kdb_buffer);
-	if (!dbg_kdb_mode && kgdb_connected) {
+	if (!dbg_kdb_mode && kgdb_connected)
 		gdbstub_msg_write(cp, retlen - (cp - kdb_buffer));
-	} else {
-		if (dbg_io_ops && !dbg_io_ops->is_console) {
-			len = retlen - (cp - kdb_buffer);
-			cp2 = cp;
-			while (len--) {
-				dbg_io_ops->write_char(*cp2);
-				cp2++;
-			}
-		}
-		for_each_console(c) {
-			c->write(c, cp, retlen - (cp - kdb_buffer));
-			touch_nmi_watchdog();
-		}
-	}
+	else
+		kdb_msg_write(cp, retlen - (cp - kdb_buffer));
+
 	if (logging) {
 		saved_loglevel = console_loglevel;
 		console_loglevel = CONSOLE_LOGLEVEL_SILENT;
@@ -751,19 +766,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			moreprompt = "more> ";
 
 		kdb_input_flush();
-
-		if (dbg_io_ops && !dbg_io_ops->is_console) {
-			len = strlen(moreprompt);
-			cp = moreprompt;
-			while (len--) {
-				dbg_io_ops->write_char(*cp);
-				cp++;
-			}
-		}
-		for_each_console(c) {
-			c->write(c, moreprompt, strlen(moreprompt));
-			touch_nmi_watchdog();
-		}
+		kdb_msg_write(moreprompt, strlen(moreprompt));
 
 		if (logging)
 			printk("%s", moreprompt);
-- 
2.7.4

