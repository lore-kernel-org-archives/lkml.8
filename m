Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4599120723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgEVQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgEVQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:08:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B8C061A0E;
        Fri, 22 May 2020 09:08:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcAE3-00009v-QX; Fri, 22 May 2020 18:08:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2316D1C0095;
        Fri, 22 May 2020 18:08:47 +0200 (CEST)
Date:   Fri, 22 May 2020 16:08:47 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Update Documentation to change supported
 compilers
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521142047.169334-8-elver@google.com>
References: <20200521142047.169334-8-elver@google.com>
MIME-Version: 1.0
Message-ID: <159016372701.17951.14792231377616807344.tip-bot2@tip-bot2>
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

Commit-ID:     345043266de282a4059bc8336e2bcdd3680cc8f0
Gitweb:        https://git.kernel.org/tip/345043266de282a4059bc8336e2bcdd3680cc8f0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 21 May 2020 16:20:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 May 2020 15:13:45 +02:00

kcsan: Update Documentation to change supported compilers

Document change in required compiler version for KCSAN, and remove the
now redundant note about __no_kcsan and inlining problems with older
compilers.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200521142047.169334-8-elver@google.com
---
 Documentation/dev-tools/kcsan.rst |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index f4b5766..ce4bbd9 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -8,8 +8,7 @@ approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 Usage
 -----
 
-KCSAN is supported in both GCC and Clang. With GCC it requires version 7.3.0 or
-later. With Clang it requires version 7.0.0 or later.
+KCSAN requires Clang version 11 or later.
 
 To enable KCSAN configure the kernel with::
 
@@ -121,12 +120,6 @@ the below options are available:
     static __no_kcsan_or_inline void foo(void) {
         ...
 
-  Note: Older compiler versions (GCC < 9) also do not always honor the
-  ``__no_kcsan`` attribute on regular ``inline`` functions. If false positives
-  with these compilers cannot be tolerated, for small functions where
-  ``__always_inline`` would be appropriate, ``__no_kcsan_or_inline`` should be
-  preferred instead.
-
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
 
