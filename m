Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395BBC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1631F2495B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEHNqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727111AbgEHNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A95EC05BD09;
        Fri,  8 May 2020 06:46:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Ki-0001lJ-9I; Fri, 08 May 2020 15:46:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EBE081C03AB;
        Fri,  8 May 2020 15:46:31 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:31 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] Improve KCSAN documentation a bit
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559189.8414.8419412107359719680.tip-bot2@tip-bot2>
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

Commit-ID:     eba9c444d34c9f10cbb463329c2c8e14f2adff25
Gitweb:        https://git.kernel.org/tip/eba9c444d34c9f10cbb463329c2c8e14f2adff25
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 13 Apr 2020 11:03:05 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:10:02 -07:00

Improve KCSAN documentation a bit

This commit simplifies and clarifies the highest level KCSAN Kconfig
help text.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 0f1447f..689b6b8 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -4,17 +4,18 @@ config HAVE_ARCH_KCSAN
 	bool
 
 menuconfig KCSAN
-	bool "KCSAN: dynamic race detector"
+	bool "KCSAN: dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
 	select STACKTRACE
 	help
-	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector,
-	  which relies on compile-time instrumentation, and uses a
-	  watchpoint-based sampling approach to detect races.
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
+	  data-race detector that relies on compile-time instrumentation.
+	  KCSAN uses a watchpoint-based sampling approach to detect races.
 
-	  KCSAN's primary purpose is to detect data races. KCSAN can also be
-	  used to check properties, with the help of provided assertions, of
-	  concurrent code where bugs do not manifest as data races.
+	  While KCSAN's primary purpose is to detect data races, it
+	  also provides assertions to check data access constraints.
+	  These assertions can expose bugs that do not manifest as
+	  data races.
 
 	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
 
