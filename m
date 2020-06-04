Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED102064C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ztDTJhFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgFDKZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgFDKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wZRor1BzB1/H6lezWifVNSHYwmu48K5Pc1GZOtnXb+s=; b=ztDTJhFdVtjTcjrMk5J5guJ+sG
        rDrAhRTMjcs56oJf+hksiOyiw1+ixCKD8/0G4F3GCXqG5zZS5Kh3nDKnYb5Y0PBpp3dMfIl+EJG8L
        p5ocpz8h3+eI0BCRPJWPgto+hMUvf4ajCeaYAlPNi533TRHTEYL/+CQKjY5tmXX++vekSUpWqJNds
        kDr61SYaDYcks/z48ag5XmyqUXD7ePw4Jvd+jxtALZk3jigxLmruzEhTnaexU+hZ9CckOLkK54t5O
        w1TXZu+qduRGNAmyTra2GROtSKgCYvH26h07Mh3Xd79u7yTh34asaIkwxENbo9E5iZ1bIPgf/l1s1
        weIjjBzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3d-0003tc-9P; Thu, 04 Jun 2020 10:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9E5E301ABC;
        Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D873220C6A1FA; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102428.020498631@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 2/8] kcsan: Remove __no_kcsan_or_inline
References: <20200604102241.466509982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more user of this function attribute, also, with us now
actively supporting '__no_kcsan inline' it doesn't make sense to have
in any case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/dev-tools/kcsan.rst |    6 ------
 include/linux/compiler_types.h    |    5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -114,12 +114,6 @@ functions, compilation units, or entire
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


