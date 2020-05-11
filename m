Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7448C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CD924960
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbgEKVA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732059AbgEKVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145CC061A0C;
        Mon, 11 May 2020 13:59:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWo-0005wn-7W; Mon, 11 May 2020 22:59:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B059D1C0864;
        Mon, 11 May 2020 22:59:38 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:38 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add KCSAN stubs to update.c
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077862.390.13286328655842233823.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c76e7e0bce10876e6b08ac2ce8af5ef7cba684ff
Gitweb:        https://git.kernel.org/tip/c76e7e0bce10876e6b08ac2ce8af5ef7cba684ff
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 14 Apr 2020 10:19:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:50 -07:00

rcu: Add KCSAN stubs to update.c

This commit adds stubs for KCSAN's data_race(), ASSERT_EXCLUSIVE_WRITER(),
and ASSERT_EXCLUSIVE_ACCESS() macros to allow code using these macros
to move ahead.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 28a8bdc..74a698a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -51,6 +51,19 @@
 #endif
 #define MODULE_PARAM_PREFIX "rcupdate."
 
+#ifndef data_race
+#define data_race(expr)							\
+	({								\
+		expr;							\
+	})
+#endif
+#ifndef ASSERT_EXCLUSIVE_WRITER
+#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
+#endif
+#ifndef ASSERT_EXCLUSIVE_ACCESS
+#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
+#endif
+
 #ifndef CONFIG_TINY_RCU
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
