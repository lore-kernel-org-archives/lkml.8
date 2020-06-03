Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035212074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUg/amR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgFCHWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgFCHWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:22:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A2C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:22:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so1134707pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nS87rNXwinnHDsGB1oC64mLmKOn8axqbhCBxaNZelVE=;
        b=bUg/amR6dUGFEel35oo/78r5Yt5+WBc6ZWXun66sFPubpQg6pHyd3IcxzKPe139OrB
         00IAwmsdkfpsic3xI7r7pVSqJ5zkop0ag9pKt1ZR98hL8SaiyFMZg+aunIdAlnYiAApH
         W8zgHMe/XNv1qlr3EzsOoA8NT7IPxKbsanzhFVkj1nWuycfvcQAUvRJSpwVUTj+XGdRd
         YaoBvmPoQhRcVi6IHElQXrazKZa/2YztF9rM2FA6ea+BET5gHz+tT216iVm7aWut4+PE
         xBXtZhTgy9xaPCsrvfLsBd1PZocQI1357oPPjGgaoMJKZCXMhNgsYMzhiHkVYrqNjdb4
         nOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nS87rNXwinnHDsGB1oC64mLmKOn8axqbhCBxaNZelVE=;
        b=I9+sl3ieayBSZmNX1A75H1TpMfyTPESdxmaNXn4yrlySKEM7b0ZWahB50VV+FkJr7i
         wo3XI9GlF7vY9Ie96ShPeaDdKKX8dCk5PYkSFBfYsArCDxAHdPsFGMXV0mBga92SOEN4
         Sur78bQ49ZnapchOkfAxMdrZ6aVsUwmTdfkotI0oZ8vVw89uSfUJJDn9HsHrPB03g3YL
         lkuTEEPKb6YvZzjoKBHgWLuhwN5Ocd6CnESBTjVYb5IJrcH19YwNABooeN5lvhWab56D
         xSSyCPZhwaA17c9oMtaNdxNwt5g2ubScrhvR0eJRtbjZlRwm/Br8INTqGAsOtEi/vMPv
         f0iw==
X-Gm-Message-State: AOAM533rbrWVOMcYF+fDwRNoceDUcHPIWyOfkHc9zv7ljMIU0f4alq5h
        2Hn0Haiz5h47pNBl7X2nAdzEeg==
X-Google-Smtp-Source: ABdhPJxcYCJw8NIGR/pP1ssdZ6dnNo4HHzOY2wq0rXT4XquUDuO/aanzpIG61NaJdmTMUrYjzlKuGg==
X-Received: by 2002:a62:7e8d:: with SMTP id z135mr6428446pfc.251.1591168960181;
        Wed, 03 Jun 2020 00:22:40 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id j17sm1407272pjy.22.2020.06.03.00.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:22:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 1/4] kdb: Re-factor kdb_printf() message write code
Date:   Wed,  3 Jun 2020 12:52:12 +0530
Message-Id: <1591168935-6382-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-factor kdb_printf() message write code in order to avoid duplication
of code and thereby increase readability.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_io.c | 57 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 924bc92..2d42a02 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -542,6 +542,29 @@ static int kdb_search_string(char *searched, char *searchfor)
 	return 0;
 }
 
+static void kdb_msg_write(const char *msg, int msg_len)
+{
+	struct console *c;
+
+	if (msg_len == 0)
+		return;
+
+	if (dbg_io_ops && !dbg_io_ops->is_console) {
+		const char *cp = msg;
+		int len = msg_len;
+
+		while (len--) {
+			dbg_io_ops->write_char(*cp);
+			cp++;
+		}
+	}
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
@@ -553,7 +576,6 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 	int this_cpu, old_cpu;
 	char *cp, *cp2, *cphold = NULL, replaced_byte = ' ';
 	char *moreprompt = "more> ";
-	struct console *c;
 	unsigned long uninitialized_var(flags);
 
 	/* Serialize kdb_printf if multiple cpus try to write at once.
@@ -687,22 +709,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
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
@@ -751,19 +762,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
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

