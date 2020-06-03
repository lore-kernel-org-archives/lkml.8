Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D710C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7027620738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjVx+5Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFCLmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFCLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC039C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Zodw8aXeLpceTUL1wV4Hv4B/SlGPd+0UwOQWXPD0C6I=; b=TjVx+5ZuXFkbXzujLqTQe9hvX/
        1OYt7SlRd10W4KgiYgDjpVmtp+wWAn+uMgunqvKYk3oPicAgQ5JetBexp8mvLsxx4PlJyGcoTRSyo
        LC0d8/T+QS8yk7WnSykoC2zE8Ci45pDhA+nu1es6BKn07mRQhZTt/9x0D/Ej/0mK8iA4JnkeQePSj
        dUckKCJX4TsMnpXMQF5qjmmg2EzTf8Rs89C0WCm/d1cqd/kci9LqdukSnooRydYNosyM/898IDphx
        n6XTtFdsM4PlbmHEgs6f4eY8XMTnX23sCmDsgGkEsNlNIUKdje5VOb+JQ0BK/PtVKtAoLhGjRKLQs
        ljs4dQog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRmt-0005ju-8u; Wed, 03 Jun 2020 11:42:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD077306BB7;
        Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AB926209DB0C4; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114051.954401211@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 3/9] x86/entry: __always_inline debugreg for noinstr
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: exc_debug()+0x21: call to native_get_debugreg() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/debugreg.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU(unsigned long, cpu_dr7);
 	native_set_debugreg(register, value)
 #endif
 
-static inline unsigned long native_get_debugreg(int regno)
+static __always_inline unsigned long native_get_debugreg(int regno)
 {
 	unsigned long val = 0;	/* Damn you, gcc! */
 
@@ -47,7 +47,7 @@ static inline unsigned long native_get_d
 	return val;
 }
 
-static inline void native_set_debugreg(int regno, unsigned long value)
+static __always_inline void native_set_debugreg(int regno, unsigned long value)
 {
 	switch (regno) {
 	case 0:
@@ -85,7 +85,7 @@ static inline void hw_breakpoint_disable
 	set_debugreg(0UL, 3);
 }
 
-static inline bool hw_breakpoint_active(void)
+static __always_inline bool hw_breakpoint_active(void)
 {
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }


