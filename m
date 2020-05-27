Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1795C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC76F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2qtj4gO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgE0G0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgE0G0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:26:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515DEC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so11370847pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P6+E4rNY0ShstrRFzP9aDE4erNTCDcdqGWfz1gGy5Tk=;
        b=Y2qtj4gOXZpv9dwe3B2zJCPgdSKOXjzqCeMNz05BE0iwci4zEu/+Ioc1p0l8L+4gFY
         9wAvOViH9oCexefyOKLWxf0WA3wO7YLSYW3Qk0EmSd1BjTbMnL5U8QB0/M0OAc5xZX6f
         Ow+J0GAwkQ8CLaO3rvY3tYUfRF4GxaDUl4bRfzfx3sUx3+KrIAhenB+xc8Lq1M1J0O1b
         Y3dgV/rxNbc9z/4J0reSgaH5Zlql1Js4NI//qzNSUxJKh4iYUeeYFz0I6bS/t5e27I20
         SSFic7ZPuO6XvlIvNCENVJGhg0DNIKNQxvXZu7ogZwdgG/FB+mhPoaOTfagNhwUtpMiF
         c8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P6+E4rNY0ShstrRFzP9aDE4erNTCDcdqGWfz1gGy5Tk=;
        b=HVZgKg4uzVsSVcR43mw8uAFrEgMRGG/gq/rN2hkhOvtEp7BhDNMlnfKJHPCx5i+pIa
         qO7IZLY6x6MGExTORPnyia+vcqNEtNTLlcbce3onZ0i8C31JWLowzqvoByB6IjZs6wO8
         6/Hm8C9QXdVsruTfbt5PqNvsHP6cutfvJB0D7rBnJbE4EyxK4vCN3PdAN/pTtr5PI57+
         10HrReGTSsNSvz7uf/f0r09DWFFqd9Sb1EtTbR2B9dTqpXYFKv+sVvXxc15KwIyEwP6y
         m7Xfz8NdFhKnl9u2s78c+yzKEXXq/M/5mFPcdhHLDr+t5qAyMRDK/a/bthy6T2XNI5A7
         ffEw==
X-Gm-Message-State: AOAM533KKc4eRe/i7HXpebd3NnzS4Ay10GyZ5sXRXknydpNdoxKMtFB8
        7y+sL5kRSmtrFZRKAStTWF/xog==
X-Google-Smtp-Source: ABdhPJxqCPtrwHLPLM5xjrsVjHkcD7z0w9QHjATmjWv28YaX6bX0C3nBxR6MF6ImTuiZvaT4qc0FJA==
X-Received: by 2002:a63:6604:: with SMTP id a4mr2568383pgc.12.1590560799838;
        Tue, 26 May 2020 23:26:39 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id m12sm1239121pjs.41.2020.05.26.23.26.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:26:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/4] kdb: Re-factor kdb_printf() message write code
Date:   Wed, 27 May 2020 11:55:56 +0530
Message-Id: <1590560759-21453-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
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
index 924bc92..f6b4d47 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -542,6 +542,33 @@ static int kdb_search_string(char *searched, char *searchfor)
 	return 0;
 }
 
+static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8 ch))
+{
+	if (len <= 0)
+		return;
+
+	while (len--) {
+		io_put_char(*cp);
+		cp++;
+	}
+}
+
+static void kdb_msg_write(char *msg, int msg_len)
+{
+	struct console *c;
+
+	if (msg_len <= 0)
+		return;
+
+	if (dbg_io_ops && !dbg_io_ops->is_console)
+		kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
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

