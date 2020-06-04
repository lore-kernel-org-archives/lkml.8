Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D96C2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRPfcB5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgFDKZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgFDKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1EC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qEEnCRuSkGqY17m970ZD2QMrdQ942DugTV6zA6aC45U=; b=gRPfcB5KfRvLV8dCz2PU7CmEmx
        UmOzcUPDKEK1IEfHRkfUVrkMrXOIjl+olPLMoG0javOadcxyRlq4walkjNqRedpJ4w3/0svVl/boP
        IJZ0dwmZVPudgurNkGqOiuNwn7RJopXgTk7wgvDXbP1v3VOpJsVFUjFZvGUs3GMYcpWgA1YuTEbxq
        Vum1012v+Q0gWtqk6jEFb6hJINEf54RiVl2zl4+GBO9lnRBicX7utO6LXIK3hLJfGu93Pesx/tZCl
        OxPVv0bvdt/kkpMotjn7r0je6X+sTVTncL0ceTvRVpLw+0IJ9ZKwFUV9ufm1zRkt4qDkE/ElOg1pz
        j1e+aPBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3e-0001r3-V7; Thu, 04 Jun 2020 10:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE4F630581E;
        Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB15520C8F8FD; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102428.077944145@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 3/8] x86, kcsan: Add __no_kcsan to noinstr
References: <20200604102241.466509982@infradead.org>
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


