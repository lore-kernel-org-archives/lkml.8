Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81698C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5517D207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZK2+XXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgE2L1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2L1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:27:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FCC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so546066pgh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmVANo270ZVKU00Ntn1LhIr6gWxMXan2SJfCFjNoHEo=;
        b=aZK2+XXMoRhPCXVUxsDPkb9kSqkhrNLxdLS+VK2l0Him6ssCZoZ21SrepRXjgt/lH1
         wPjs4bZldxfBqAaXCCEOgOuDzZIo90LTmU1RT/71D8xO0wPNCIUzGGSYGdQ/YlanXpD5
         tymc4udXM1EAeCFRdG9SjmTIW5McowgBQ5xdltp87Mjr/9ZLzv6N3NqTBvAjgtCeoxsu
         v4PFPvGPqrYUCHiSh9M2l/R3XrNtZKY6OAI+2/ACo4+9Duzf3wYHSifzOX1jZu6qukFL
         /EKSR23Jf8Bwkh8PskSWU0NwhMmi3NCwCZz4IMTmvf/+sWcAWs4bWG8i+OfY2epqOy06
         S+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmVANo270ZVKU00Ntn1LhIr6gWxMXan2SJfCFjNoHEo=;
        b=sM/Xr4I7gOk3zUOJs+S+9k9vAUW+qsjF3zOFDeLU44YkqFAcdqDWr74SbI3b1G84hH
         d2+sCogT46F/Mk6AwnZlOkVY7gy2dfm9Fd7EN08vBSYEPaLr2k2XAeGSB/5SfkSiDAqY
         2AVf/Efn5G9uuvYUB8jpnwqJ5WMEW2+/240sjE/kF5GmAaSM48Z9mtz3WQLEj2Dj76M6
         yMad4cy3I3f4zEs800rHArKogkyGFp+UivxLJcmcJ3K0xAwu2Z0DuHdibSH8/bG+kIJA
         njkLB2LmGUFOKOfSx4ux4oIJNuUWQzptEkvDAXVKd2kwJDVfaIvUXL3TT/IEEQ6aBjOT
         9yNw==
X-Gm-Message-State: AOAM532o87hLwqcWAainSFv23PfOCE2+MZoo0WuyN2GXV66kV/17vxdu
        mgGocsWugrN24lY5FOTwDZJIsA==
X-Google-Smtp-Source: ABdhPJzS/gqMxxiyYyZH1I3fTV851M9JRdWhE5v8GMU+1CdSJsblvJLl+ZsTF6SL8JmpR+LIeAWx2w==
X-Received: by 2002:a62:2ad1:: with SMTP id q200mr8012952pfq.225.1590751661689;
        Fri, 29 May 2020 04:27:41 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id w190sm7016741pfw.35.2020.05.29.04.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 04:27:40 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
Date:   Fri, 29 May 2020 16:56:47 +0530
Message-Id: <1590751607-29676-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kgdb context, calling console handlers aren't safe due to locks used
in those handlers which could in turn lead to a deadlock. Although, using
oops_in_progress increases the chance to bypass locks in most console
handlers but it might not be sufficient enough in case a console uses
more locks (VT/TTY is good example).

Currently when a driver provides both polling I/O and a console then kdb
will output using the console. We can increase robustness by using the
currently active polling I/O driver (which should be lockless) instead
of the corresponding console. For several common cases (e.g. an
embedded system with a single serial port that is used both for console
output and debugger I/O) this will result in no console handler being
used.

In order to achieve this we need to reverse the order of preference to
use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
store "struct console" that represents debugger I/O in dbg_io_ops and
while emitting kdb messages, skip console that matches dbg_io_ops
console in order to avoid duplicate messages. After this change,
"is_console" param becomes redundant and hence removed.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 2 +-
 drivers/tty/serial/kgdboc.c   | 4 ++--
 drivers/usb/early/ehci-dbgp.c | 3 ++-
 include/linux/kgdb.h          | 5 ++---
 kernel/debug/kdb/kdb_io.c     | 4 +++-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 5022447..6004c0c 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -50,7 +50,7 @@ static int kgdb_nmi_console_setup(struct console *co, char *options)
 	 * I/O utilities that messages sent to the console will automatically
 	 * be displayed on the dbg_io.
 	 */
-	dbg_io_ops->is_console = true;
+	dbg_io_ops->cons = co;
 
 	return 0;
 }
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c9f94fa..c7ffa87 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -153,7 +153,7 @@ static int configure_kgdboc(void)
 		goto noconfig;
 	}
 
-	kgdboc_io_ops.is_console = 0;
+	kgdboc_io_ops.cons = NULL;
 	kgdb_tty_driver = NULL;
 
 	kgdboc_use_kms = 0;
@@ -173,7 +173,7 @@ static int configure_kgdboc(void)
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
 		    idx == tty_line) {
-			kgdboc_io_ops.is_console = 1;
+			kgdboc_io_ops.cons = cons;
 			break;
 		}
 	}
diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
index ea0d531..8c32d1a 100644
--- a/drivers/usb/early/ehci-dbgp.c
+++ b/drivers/usb/early/ehci-dbgp.c
@@ -1058,7 +1058,8 @@ static int __init kgdbdbgp_parse_config(char *str)
 		kgdbdbgp_wait_time = simple_strtoul(ptr, &ptr, 10);
 	}
 	kgdb_register_io_module(&kgdbdbgp_io_ops);
-	kgdbdbgp_io_ops.is_console = early_dbgp_console.index != -1;
+	if (early_dbgp_console.index != -1)
+		kgdbdbgp_io_ops.cons = early_dbgp_console;
 
 	return 0;
 }
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb..bc0face3 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -273,8 +273,7 @@ struct kgdb_arch {
  * the I/O driver.
  * @post_exception: Pointer to a function that will do any cleanup work
  * for the I/O driver.
- * @is_console: 1 if the end device is a console 0 if the I/O device is
- * not a console
+ * @cons: valid if the I/O device is a console.
  */
 struct kgdb_io {
 	const char		*name;
@@ -284,7 +283,7 @@ struct kgdb_io {
 	int			(*init) (void);
 	void			(*pre_exception) (void);
 	void			(*post_exception) (void);
-	int			is_console;
+	struct console		*cons;
 };
 
 extern const struct kgdb_arch		arch_kgdb_ops;
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9e5a40d..5e00bc8 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -560,12 +560,14 @@ static void kdb_msg_write(char *msg, int msg_len)
 	if (msg_len == 0)
 		return;
 
-	if (dbg_io_ops && !dbg_io_ops->is_console)
+	if (dbg_io_ops)
 		kdb_io_write(msg, msg_len);
 
 	for_each_console(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
+		if (c == dbg_io_ops->cons)
+			continue;
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
-- 
2.7.4

