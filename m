Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DCEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F62074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcScTCo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgFBRfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:35:03 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0185C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qEEnCRuSkGqY17m970ZD2QMrdQ942DugTV6zA6aC45U=; b=bcScTCo5o03L16EphwZn9FJIBk
        HpaiFtnX5ZVlH5kX61jAaxLX1FEe4sVNMEdOojNeQK5oplgWn6jllyy1m7WfJeHcLlNhNtdDgb8vg
        vsgoRiN4tjQhsUSZwm/J5O0KJ5AUxt9t09b5yJECMpsmMXOimb7gxwwXG/ZMrbQRuPkGyj0HENk/N
        1H7Rh+9Syzc3qroEaU4K1E+biXMOz5qkFeKaTbMXlrMEh1PC3LlENLFQ2Dz7+4eC7rXFnwNS+ZNDA
        PVGfUa0U9ACJxW3M4Z4kIRN6plXK9Y6MpFEZ7mGx2x4wtxhtmM0A3kwDu2mWxWFnThn4M1YxuiT5n
        900C9oCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgAoC-0000Q6-Pz; Tue, 02 Jun 2020 17:34:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DA7B304BDF;
        Tue,  2 Jun 2020 19:34:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0A338201B7B84; Tue,  2 Jun 2020 19:34:38 +0200 (CEST)
Message-ID: <20200602173348.458385730@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Jun 2020 19:31:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 3/3] x86, kcsan: Add __no_kcsan to noinstr
References: <20200602173103.931412766@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'noinstr' function attribute means no-instrumentation, this should
very much include *SAN. Because lots of that is broken at present,
only include KCSAN for now, as that is limited to clang11, which has
sane function attribute behaviour.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_types.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -118,10 +118,6 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
-/* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))
-
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
@@ -200,6 +196,10 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/* Section for code which can't be instrumented at all */
+#define noinstr								\
+	noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */


