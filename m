Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443ADC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2070620870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCXJLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgCXJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaS-0007Vz-3C; Tue, 24 Mar 2020 10:11:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDEB51C0451;
        Tue, 24 Mar 2020 10:10:57 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:57 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Fix 0-sized checks
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105740.28353.3796925960754075309.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     ed95f95c86cd53621103d865d62b5e1f96e60edb
Gitweb:        https://git.kernel.org/tip/ed95f95c86cd53621103d865d62b5e1f96e60edb
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 05 Feb 2020 11:14:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:42:42 +01:00

kcsan: Fix 0-sized checks

Instrumentation of arbitrary memory-copy functions, such as user-copies,
may be called with size of 0, which could lead to false positives.

To avoid this, add a comparison in check_access() for size==0, which
will be optimized out for constant sized instrumentation
(__tsan_{read,write}N), and therefore not affect the common-case
fast-path.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kcsan/core.c |  7 +++++++
 kernel/kcsan/test.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index e3c7d8f..82c2bef 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -456,6 +456,13 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	long encoded_watchpoint;
 
 	/*
+	 * Do nothing for 0 sized check; this comparison will be optimized out
+	 * for constant sized instrumentation (__tsan_{read,write}N).
+	 */
+	if (unlikely(size == 0))
+		return;
+
+	/*
 	 * Avoid user_access_save in fast-path: find_watchpoint is safe without
 	 * user_access_save, as the address that ptr points to is only used to
 	 * check if a watchpoint exists; ptr is never dereferenced.
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
index cc60002..d26a052 100644
--- a/kernel/kcsan/test.c
+++ b/kernel/kcsan/test.c
@@ -92,6 +92,16 @@ static bool test_matching_access(void)
 		return false;
 	if (WARN_ON(matching_access(9, 1, 10, 1)))
 		return false;
+
+	/*
+	 * An access of size 0 could match another access, as demonstrated here.
+	 * Rather than add more comparisons to 'matching_access()', which would
+	 * end up in the fast-path for *all* checks, check_access() simply
+	 * returns for all accesses of size 0.
+	 */
+	if (WARN_ON(!matching_access(8, 8, 12, 0)))
+		return false;
+
 	return true;
 }
 
