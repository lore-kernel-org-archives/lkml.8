Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0182420674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E3gzSfAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFCLm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgFCLmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88783C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7IW00XHgXSVe0eWN0HTd2HDxOWygvcOr4u+CUzB/SvI=; b=E3gzSfAM5W6bRu0zQXJ6k4PaBa
        lwLEFg+ilOwi3MC8cxcnx8Vr5F6qCP53Rk801BLXI7XsrjvqQaSUzWIXApbNYPuu6m5ZJrAGc6ZdM
        7OW0g6971HaO52GDsYG6lZvptB5PQmchQd+SSWpB1CZpjdGjhBC41aDQ6X8P31aVhwbUVP+gKNyIM
        0QKkBZ5v5GodxE5rjQw45GzYb74dQDcQdrOi8jR7OkSdKgA1XkYFwHB2I2/+r51lH0azgD8i9NduA
        1Vo92390X7iklh4xqcSez4W13fbSlZnoqgordlfGSVl6YbDnftxX4e/HFog9zTO2d6odgpTnMxrBk
        1ScduGMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRms-0005of-U0; Wed, 03 Jun 2020 11:42:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E03D306E6D;
        Wed,  3 Jun 2020 13:42:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BEF6D209DB0D4; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114052.243227806@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 8/9] x86/entry: __always_inline CR2 for noinstr
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: exc_page_fault()+0x9: call to read_cr2() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_page_fault()+0x24: call to prefetchw() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_page_fault()+0x21: call to kvm_handle_async_pf.isra.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: exc_nmi()+0x1cc: call to write_cr2() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/kvm_para.h      |    2 +-
 arch/x86/include/asm/processor.h     |    2 +-
 arch/x86/include/asm/special_insns.h |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -141,7 +141,7 @@ static inline void kvm_disable_steal_tim
 	return;
 }
 
-static inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
+static __always_inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	return false;
 }
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -823,7 +823,7 @@ static inline void prefetch(const void *
  * Useful for spinlocks to avoid one state transition in the
  * cache coherency protocol:
  */
-static inline void prefetchw(const void *x)
+static __always_inline void prefetchw(const void *x)
 {
 	alternative_input(BASE_PREFETCH, "prefetchw %P1",
 			  X86_FEATURE_3DNOWPREFETCH,
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -28,14 +28,14 @@ static inline unsigned long native_read_
 	return val;
 }
 
-static inline unsigned long native_read_cr2(void)
+static __always_inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
 	return val;
 }
 
-static inline void native_write_cr2(unsigned long val)
+static __always_inline void native_write_cr2(unsigned long val)
 {
 	asm volatile("mov %0,%%cr2": : "r" (val), "m" (__force_order));
 }
@@ -160,12 +160,12 @@ static inline void write_cr0(unsigned lo
 	native_write_cr0(x);
 }
 
-static inline unsigned long read_cr2(void)
+static __always_inline unsigned long read_cr2(void)
 {
 	return native_read_cr2();
 }
 
-static inline void write_cr2(unsigned long x)
+static __always_inline void write_cr2(unsigned long x)
 {
 	native_write_cr2(x);
 }


