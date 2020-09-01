Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601B7206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQs2nIpv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2o0DQvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIAOP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:15:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgIALt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:28 -0400
Date:   Tue, 01 Sep 2020 11:48:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kasz4ywG7LhJWVjmtq4Val0RF1UWPJ3KkUO7H9xHB3A=;
        b=MQs2nIpvAtL0j09Me68xlF/SqKUCztL8URBYOo3RvQEzO4Hq0aJh28R7wLM82gMHIj3+iu
        +E0YcMwxo1h3bvhDS+oORffwun8tNnQDf+tyNWgIPt9y6LxwWZ6vSiNxwvQmr6W7S1z3pc
        ML63U1UuQdAAR08973xWtIyTEpZvorgOE5NpN3bU9B/dIlRNVf8fI9onJL07rU3ZIxS2wN
        vVMUxiQYSoO1vheMzY1i/CN3vHqMYj9GSuZmt20/Qmm6S+v6QXhCNw4waCiScwgXPXGwQ4
        3Rcriif2OpU8kicDQ9QG1vQi7Mjp5iDhiYZi7Aps8c5JyYDQrs1CAhY68rSEGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kasz4ywG7LhJWVjmtq4Val0RF1UWPJ3KkUO7H9xHB3A=;
        b=v2o0DQvTeuw62ayZCf8fh/Coc8kIA+8+MCC0/rJMmv/pO6eSfmpPq7M1kvo87V/ZJnSi7h
        Fj9sJidcNTx7qaCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Add simple self-test for static calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.922581202@infradead.org>
References: <20200818135804.922581202@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088487.20229.10616348998847001332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     f03c412915f5f69f2d17bcd20ecdd69320bcbf7b
Gitweb:        https://git.kernel.org/tip/f03c412915f5f69f2d17bcd20ecdd69320bcbf7b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:05 +02:00

static_call: Add simple self-test for static calls

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200818135804.922581202@infradead.org
---
 arch/Kconfig         |  6 ++++++-
 kernel/static_call.c | 43 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2c4936a..76ec339 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -106,6 +106,12 @@ config STATIC_KEYS_SELFTEST
 	help
 	  Boot time self-test of the branch patching code.
 
+config STATIC_CALL_SELFTEST
+	bool "Static call selftest"
+	depends on HAVE_STATIC_CALL
+	help
+	  Boot time self-test of the call patching code.
+
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 753b2f1..97142cb 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -369,3 +369,46 @@ static void __init static_call_init(void)
 #endif
 }
 early_initcall(static_call_init);
+
+#ifdef CONFIG_STATIC_CALL_SELFTEST
+
+static int func_a(int x)
+{
+	return x+1;
+}
+
+static int func_b(int x)
+{
+	return x+2;
+}
+
+DEFINE_STATIC_CALL(sc_selftest, func_a);
+
+static struct static_call_data {
+      int (*func)(int);
+      int val;
+      int expect;
+} static_call_data [] __initdata = {
+      { NULL,   2, 3 },
+      { func_b, 2, 4 },
+      { func_a, 2, 3 }
+};
+
+static int __init test_static_call_init(void)
+{
+      int i;
+
+      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
+	      struct static_call_data *scd = &static_call_data[i];
+
+              if (scd->func)
+                      static_call_update(sc_selftest, scd->func);
+
+              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
+      }
+
+      return 0;
+}
+early_initcall(test_static_call_init);
+
+#endif /* CONFIG_STATIC_CALL_SELFTEST */
