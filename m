Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F292074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgFOWcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgFOWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:31:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECCC061A0E;
        Mon, 15 Jun 2020 15:31:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkxdq-0006y0-Mh; Tue, 16 Jun 2020 00:31:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A82221C06FE;
        Tue, 16 Jun 2020 00:31:45 +0200 (CEST)
Date:   Mon, 15 Jun 2020 22:31:45 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] kcsan: Remove __no_kcsan_or_inline
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159226030540.16989.18200401419200684098.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     e79302ae8c8cceb51cf642d5ace9da02668cb7b4
Gitweb:        https://git.kernel.org/tip/e79302ae8c8cceb51cf642d5ace9da02668cb7b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 02 Jun 2020 17:04:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:08 +02:00

kcsan: Remove __no_kcsan_or_inline

There are no more user of this function attribute, also, with us now
actively supporting '__no_kcsan inline' it doesn't make sense to have
in any case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/dev-tools/kcsan.rst | 6 ------
 include/linux/compiler_types.h    | 5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index ce4bbd9..b38379f 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -114,12 +114,6 @@ the below options are available:
   To dynamically limit for which functions to generate reports, see the
   `DebugFS interface`_ blacklist/whitelist feature.
 
-  For ``__always_inline`` functions, replace ``__always_inline`` with
-  ``__no_kcsan_or_inline`` (which implies ``__always_inline``)::
-
-    static __no_kcsan_or_inline void foo(void) {
-        ...
-
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 21aed09..9382498 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -193,10 +193,7 @@ struct ftrace_likely_data {
 
 #define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
-# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
-# define __no_sanitize_or_inline __no_kcsan_or_inline
-#else
-# define __no_kcsan_or_inline __always_inline
+# define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
 #endif
 
 #ifndef __no_sanitize_or_inline
