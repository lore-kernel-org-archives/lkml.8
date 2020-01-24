Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48093C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217A52071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgAXJNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:13:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgAXJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:13:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuv1u-0007dI-7S; Fri, 24 Jan 2020 10:13:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD9321C1A4E;
        Fri, 24 Jan 2020 10:13:29 +0100 (CET)
Date:   Fri, 24 Jan 2020 09:13:29 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Document static blacklisting options
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157985720971.396.14375878627578374891.tip-bot2@tip-bot2>
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

Commit-ID:     7161177481d521e725a7bc6c9308ac2968fee038
Gitweb:        https://git.kernel.org/tip/7161177481d521e725a7bc6c9308ac2968fee038
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 12 Dec 2019 01:07:08 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 07 Jan 2020 07:47:23 -08:00

kcsan: Document static blacklisting options

Updates the section on "Selective analysis", listing all available
options to blacklist reporting data races for: specific accesses,
functions, compilation units, and entire directories.

These options should provide adequate control for maintainers to opt out
of KCSAN analysis at varying levels of granularity. It is hoped to
provide the required control to reflect preferences for handling data
races across the kernel.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index a6f4f92..65a0be5 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -101,18 +101,28 @@ instrumentation or e.g. DMA accesses.
 Selective analysis
 ~~~~~~~~~~~~~~~~~~
 
-To disable KCSAN data race detection for an entire subsystem, add to the
-respective ``Makefile``::
+It may be desirable to disable data race detection for specific accesses,
+functions, compilation units, or entire subsystems.  For static blacklisting,
+the below options are available:
 
-    KCSAN_SANITIZE := n
+* KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
+  any data races due to accesses in ``expr`` should be ignored and resulting
+  behaviour when encountering a data race is deemed safe.
+
+* Disabling data race detection for entire functions can be accomplished by
+  using the function attribute ``__no_kcsan`` (or ``__no_kcsan_or_inline`` for
+  ``__always_inline`` functions). To dynamically control for which functions
+  data races are reported, see the `debugfs`_ blacklist/whitelist feature.
 
-To disable KCSAN on a per-file basis, add to the ``Makefile``::
+* To disable data race detection for a particular compilation unit, add to the
+  ``Makefile``::
 
     KCSAN_SANITIZE_file.o := n
 
-KCSAN also understands the ``data_race(expr)`` annotation, which tells KCSAN
-that any data races due to accesses in ``expr`` should be ignored and resulting
-behaviour when encountering a data race is deemed safe.
+* To disable data race detection for all compilation units listed in a
+  ``Makefile``, add to the respective ``Makefile``::
+
+    KCSAN_SANITIZE := n
 
 debugfs
 ~~~~~~~
