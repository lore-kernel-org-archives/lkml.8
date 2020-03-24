Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B365C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B30D2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCXJL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgCXJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaU-0007X1-4B; Tue, 24 Mar 2020 10:11:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B8281C0493;
        Tue, 24 Mar 2020 10:10:58 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:58 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105829.28353.13995420302647105677.tip-bot2@tip-bot2>
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

Commit-ID:     a249a73231e2e30944b948c5351025e5ff65f6d1
Gitweb:        https://git.kernel.org/tip/a249a73231e2e30944b948c5351025e5ff65f6d1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 04 Feb 2020 18:21:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:42:21 +01:00

kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS

Clarify difference between options KCSAN_IGNORE_ATOMICS and
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC in help text.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/Kconfig.kcsan | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 6612685..020ac63 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -132,8 +132,18 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-	  If enabled, never instruments marked atomic accesses. This results in
-	  not reporting data races where one access is atomic and the other is
-	  a plain access.
+	  Never instrument marked atomic accesses. This option can be used for
+	  additional filtering. Conflicting marked atomic reads and plain
+	  writes will never be reported as a data race, however, will cause
+	  plain reads and marked writes to result in "unknown origin" reports.
+	  If combined with CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n, data
+	  races where at least one access is marked atomic will never be
+	  reported.
+
+	  Similar to KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, but including unaligned
+	  accesses, conflicting marked atomic reads and plain writes will not
+	  be reported as data races; however, unlike that option, data races
+	  due to two conflicting plain writes will be reported (aligned and
+	  unaligned, if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
 
 endif # KCSAN
