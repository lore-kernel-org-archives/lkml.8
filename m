Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD3E207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E9/wvJgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgHUI5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgHUI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA6C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=p8/n/lCRp9W1xRSaaJny9wd35WKr6FVit2c+dBY+Q7A=; b=E9/wvJgl7u/01cszdcAnBw5EpC
        rFw1QVn8gwwp6kjvLvvgcoJATfckIgssDuYJ0D+bZ3dWfOKr/iTZRfo8xJ+aWFJ/iPb1FwKsNDmFY
        4yfrgjfROLBUMscpBYYQJYB+G+HNdrTkLGf+Z8CeWlT9mbA3rQLdsGnN9ktmR2C1uAlGnUjzVVL17
        B2Z1bT0uoagj8XhbUnGgZK7b28eF+vjuBsxhzq76Z4RiM9K6P9xt+Jzfg1iNtGH9nicN6Jci96hLo
        m+dPR5ZhDZpywp8OQgSo9ceaoNmV8nIborZZy69P07ADYSxE/Sv7EZMLWJge6Qe5TN8onf90BFcy9
        PjrAG+Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92pJ-0007SH-5x; Fri, 21 Aug 2020 08:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 850CD3060F3;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 070822B64991C; Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Message-ID: <20200821085348.664425120@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 09/11] arm64: Implement arch_irqs_disabled()
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/irqflags.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -95,6 +95,11 @@ static inline int arch_irqs_disabled_fla
 	return res;
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;


