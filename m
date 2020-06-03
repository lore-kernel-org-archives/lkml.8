Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7731520679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDKk6u1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCHXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFCHXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:23:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EA3C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:22:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so1007970pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZZiPsh1/1zA6921CY7D2bWjWgixKjYO5KIMajFrFQ8=;
        b=DDKk6u1fPNb/T0ZtwX3dMrmOO5bXn9bW/74ghMD/pXRmyCkw7jHbkdxMetszKJfWtK
         veXD6gwYd4eg1cWIEvLDloPzbUZaYGBSDa+Re77ULD/sE8UNM1yQnk5bSSUyDMwpVy0T
         Y7/j995qyxR8dwC/OLtn2FZ/EM4qAtf/zb/7k5oZco0ZQ9nkQ7WZKn7LYnnaj6Pb7F+0
         M+ufUnZY6LcZTwV9NRv33/1uMEfH8VN+TfqVcRO9atsUTTAg8vCmPmZx5ULTBcffYe/w
         8UTxAfx3zUaZYcK2HxYcqge/Iahepaoo71EcX3albVDPYSOZDayyVb0cDQJgK8dhIluc
         M8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZZiPsh1/1zA6921CY7D2bWjWgixKjYO5KIMajFrFQ8=;
        b=QVq1a/uhtTt/adULMKZfFRYgX9ZFGKLrgBhWraXmbtHDdOYNaOlyZRH2osp64MRNhk
         WXS8wIlNNdPLZ02MyB8TFOqHDamdxxPiHHAdPuXcRsehznYtWzxBpwx63L1a1qClsPQ7
         Vs0OJUNxAJhsqfiSZx1b9bnZYIT0x7lQFJppnb7aarUAe4qN5Nsn32IFrFPrpXXev2Oj
         Y0XMDdg1GHJq/BdFGva0z/yhIul+hE7i4xQlpPtfz6g8mj4Qh2hiHUz6QM9ldRPs/lQJ
         F7sX2lpaFNl+MOWpbAwPR/gLe6oWt026zNDH1gbXrBaK88prl1ZVB53WOVNdZzFcF/KI
         1rMg==
X-Gm-Message-State: AOAM531V68fetH+EkIXlfJijCjR3L7K561w4g0uhUSWqGPtSPrKaV9iw
        i5P8fkk6b19/a+N5kcsRVkxDKg==
X-Google-Smtp-Source: ABdhPJxe75iTddF1frjRbkTFjkRx0tyZwI/mCeAnINWyuHqzShSQl2ELt84iMQB4pkOjXgqZEA/mqw==
X-Received: by 2002:a05:6a00:14d4:: with SMTP id w20mr15187904pfu.279.1591168979274;
        Wed, 03 Jun 2020 00:22:59 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id j17sm1407272pjy.22.2020.06.03.00.22.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:22:58 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
Date:   Wed,  3 Jun 2020 12:52:15 +0530
Message-Id: <1591168935-6382-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/tty/serial/kgdb_nmi.c | 2 +-
 drivers/tty/serial/kgdboc.c   | 6 +++---
 drivers/usb/early/ehci-dbgp.c | 3 ++-
 include/linux/kgdb.h          | 5 ++---
 kernel/debug/kdb/kdb_io.c     | 4 +++-
 5 files changed, 11 insertions(+), 9 deletions(-)

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
index 4139698..6e182aa 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -178,7 +178,7 @@ static int configure_kgdboc(void)
 		goto noconfig;
 	}
 
-	kgdboc_io_ops.is_console = 0;
+	kgdboc_io_ops.cons = NULL;
 	kgdb_tty_driver = NULL;
 
 	kgdboc_use_kms = 0;
@@ -198,7 +198,7 @@ static int configure_kgdboc(void)
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
 		    idx == tty_line) {
-			kgdboc_io_ops.is_console = 1;
+			kgdboc_io_ops.cons = cons;
 			break;
 		}
 	}
@@ -511,7 +511,6 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
 	.write_char		= kgdboc_earlycon_put_char,
 	.pre_exception		= kgdboc_earlycon_pre_exp_handler,
 	.deinit			= kgdboc_earlycon_deinit,
-	.is_console		= true,
 };
 
 #define MAX_CONSOLE_NAME_LEN (sizeof((struct console *) 0)->name)
@@ -558,6 +557,7 @@ static int __init kgdboc_earlycon_init(char *opt)
 	}
 
 	earlycon = con;
+	kgdboc_earlycon_io_ops.cons = con;
 	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
 	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
 		earlycon = NULL;
diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
index ea0d531..775cf70 100644
--- a/drivers/usb/early/ehci-dbgp.c
+++ b/drivers/usb/early/ehci-dbgp.c
@@ -1058,7 +1058,8 @@ static int __init kgdbdbgp_parse_config(char *str)
 		kgdbdbgp_wait_time = simple_strtoul(ptr, &ptr, 10);
 	}
 	kgdb_register_io_module(&kgdbdbgp_io_ops);
-	kgdbdbgp_io_ops.is_console = early_dbgp_console.index != -1;
+	if (early_dbgp_console.index != -1)
+		kgdbdbgp_io_ops.cons = &early_dbgp_console;
 
 	return 0;
 }
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index c62d764..529116b 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -276,8 +276,7 @@ struct kgdb_arch {
  * the I/O driver.
  * @post_exception: Pointer to a function that will do any cleanup work
  * for the I/O driver.
- * @is_console: 1 if the end device is a console 0 if the I/O device is
- * not a console
+ * @cons: valid if the I/O device is a console; else NULL.
  */
 struct kgdb_io {
 	const char		*name;
@@ -288,7 +287,7 @@ struct kgdb_io {
 	void			(*deinit) (void);
 	void			(*pre_exception) (void);
 	void			(*post_exception) (void);
-	int			is_console;
+	struct console		*cons;
 };
 
 extern const struct kgdb_arch		arch_kgdb_ops;
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 0e4f2ed..683a799 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -549,7 +549,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	if (msg_len == 0)
 		return;
 
-	if (dbg_io_ops && !dbg_io_ops->is_console) {
+	if (dbg_io_ops) {
 		const char *cp = msg;
 		int len = msg_len;
 
@@ -562,6 +562,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
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

