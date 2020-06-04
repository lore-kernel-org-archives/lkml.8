Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3EE206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cg/f1HJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgFDKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgFDKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:01:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C1C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:01:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so2003731plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=szaBEARcWdhYnGpzW+4OEptkrFUZ5UEa9ss6N8oVgrk=;
        b=Cg/f1HJvu0Jm/TeqKUCyK+SdAsQFuo9p66YMZ1DFdsALkVnNz4A0GJoPXrkLOInh/e
         Rc02WahaxbmPUE3cAwfVesS7oVzpKIEjHwL7FYbFobxLK3aggBJhhadp7Ua8BaeDylZ0
         73BUs7w3zpwCZvPi8Haf8fPAXawF3qDy/heO4jnPsW5aAttEkYCf4kOzfnMDBJvq1gvy
         3Td5psKL6JqiIxvmAP9PH/MR5Pl2PubGVrSvZO4JfuEl2mUTC/GEdM7OdWITwz0MDhv+
         3fKj1ZDZoYypiNH4el5JV9WoLesXsyeYNxpgzaufpzak56bCnbSDuhwMADPFC+yEDDON
         5EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=szaBEARcWdhYnGpzW+4OEptkrFUZ5UEa9ss6N8oVgrk=;
        b=KuTXMikx40pR4enehkvAz+V5nqpl70V9yr6GXpPETpQgIO+Pl/pi08xVpJOlvxdqcN
         KGNTaQybulfehdQuaW1Q+Bj3G5sn5bb6jGdUEGvOaV24WFXhLzdxn1f+xrpkwEqL5BOn
         i8I00bKMbH/qYM2VJtS69vAUL1JGmaiNQ0FTe2Tau+Y2NoVMDU1LcXVeF3kCk54ybGLi
         7kvT63jB+DxGX7tH0kp06IvTgadK8KH9smuaYfSzD9NZTTtpiDqdk/DMTZSbwEMcavha
         YsE7qJBDupbL7N29l5CVHt2GLKuaNgXm6Eqrhxojhwnw54ZKoFB7kuzXRPs6V184regX
         3FVA==
X-Gm-Message-State: AOAM532BDvv/HGkapgbOx/04KgYZ/0KXK0CiZ02+uezfWAfS06L57uGx
        ZS6M7fIvbSyOoMIVAwufcQGrIw==
X-Google-Smtp-Source: ABdhPJz+kjDxKZqboJ0smOY5CJB2KU9tBGggUM40V1NuSMBNwyZlbSkz2UXWMnEhe/1HWYkmvPFj5A==
X-Received: by 2002:a17:90b:234c:: with SMTP id ms12mr5449967pjb.164.1591264905624;
        Thu, 04 Jun 2020 03:01:45 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id np5sm5786992pjb.43.2020.06.04.03.01.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 03:01:44 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 1/4] kdb: Re-factor kdb_printf() message write code
Date:   Thu,  4 Jun 2020 15:31:16 +0530
Message-Id: <1591264879-25920-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-factor kdb_printf() message write code in order to avoid duplication
of code and thereby increase readability.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Revieved-by: Petr Mladek <pmladek@suse.com>
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

