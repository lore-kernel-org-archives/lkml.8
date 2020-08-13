Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC096C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82BF20838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcx3038H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgHMLOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMLOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:14:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B59C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3yXT+VzQeCJZerzkfhHRMOoMw3nwRNlG4Dk5QZrZdbE=; b=qcx3038HS/M6lDijnVsf34odgx
        83NbmqtWONpNuRcNmFd01Y0egkUO7P1dJ+ug3vqkV+Uzy8ceKY64iYLeSU26xZHEskzGPqq6ideIe
        93M9VP1xOg6wfu3L2A2QuYlc7Cpk4eIT8Z0PqBf9D55m6qXK9zT/Jj514w4eMZJOOLXLrELjpktzl
        g5S3GkawGIhZjnMYkiGoDh8ekM9zzQyYTaWmmyDQlzXuPw2fI68Omn6GP6hCLVFqWozDvAdeg4wXS
        LASeaCQkg7dBdY634ER0uVffD2TZwx2B1j6BOxL6qjzyEIuIDXsphDnVOli7P5dHMKS8Pr9O/k+2J
        Q7j3DOYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6BBC-0000sF-He; Thu, 13 Aug 2020 11:13:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2D973060C5;
        Thu, 13 Aug 2020 13:13:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BAFB2C1BD8B4; Thu, 13 Aug 2020 13:13:51 +0200 (CEST)
Date:   Thu, 13 Aug 2020 13:13:51 +0200
From:   peterz@infradead.org
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/alternatives: Let __text_poke() acquire the pte
 lock with enabled interrupts
Message-ID: <20200813111351.GV2674@hirez.programming.kicks-ass.net>
References: <20200706164215.2502730-1-bigeasy@linutronix.de>
 <87eeoc53o2.fsf@nanos.tec.linutronix.de>
 <20200813104707.fxydmk6ctiwjql75@linutronix.de>
 <20200813105026.bvugytmsso6muljw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200813105026.bvugytmsso6muljw@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:50:26PM +0200, Sebastian Andrzej Siewior wrote:
> The pte lock is never acquired in-IRQ context so it does not require the
> interrupts to be disabled.
> 
> RT complains here because the spinlock_t must not be acquired with
> disabled interrupts.
> 
> use_temporary_mm() expects interrupts to be off because it invokes
> switch_mm_irqs_off() and uses per-CPU (current active mm) data.
> 
> Move the PTE lock handling outside the interrupt disabled region.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Agreed, this should be fine.

Acked-by; Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> v1…v2: Reword the patch description.
> 
>  arch/x86/kernel/alternative.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -875,8 +875,6 @@ static void *__text_poke(void *addr, con
>  	 */
>  	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
>  
> -	local_irq_save(flags);
> -
>  	/*
>  	 * Map the page without the global bit, as TLB flushing is done with
>  	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
> @@ -893,6 +891,8 @@ static void *__text_poke(void *addr, con
>  	 */
>  	VM_BUG_ON(!ptep);
>  
> +	local_irq_save(flags);
> +
>  	pte = mk_pte(pages[0], pgprot);
>  	set_pte_at(poking_mm, poking_addr, ptep, pte);
>  
> @@ -942,8 +942,8 @@ static void *__text_poke(void *addr, con
>  	 */
>  	BUG_ON(memcmp(addr, opcode, len));
>  
> -	pte_unmap_unlock(ptep, ptl);
>  	local_irq_restore(flags);
> +	pte_unmap_unlock(ptep, ptl);
>  	return addr;
>  }
>  
