Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4BC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0820838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wtfoox39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgG1KyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgG1KyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:54:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC4C061794;
        Tue, 28 Jul 2020 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W8EGYrbvZ2JVHYH7/4O92e1pVKCkXBCpOwNppiviJYk=; b=Wtfoox39Dk/76/LPPiZmQbB7Q8
        ma4Cgj5I6CFvppLLACjfC+ulmhw/ikvx8xKuq4K4ZT/lcPpweCF9s1X/W6nHXPBaW2WzQ1U7i/+x8
        MeSEecGjjKG7KPW0+GURGhA00crHAaWslebe2FvBrszZJx4y6U9xYk18WCHfspXFwhG/K9iFHT3N7
        Nez/SMmoBFj36/bAJU87dpZNAOu+QZCZb/vhQFCM13w/RHlej0vCqmtWbLb6CLPvKaZnPT991gkAD
        zpYh9IaUYHFcPBXQVRfh5qsmqfbSQWA5vBzvfjHcsHlcwRWAVGNZaAqLl6u5+s03PaK01+nhRDZAQ
        8tu2wF+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0NFL-0003No-RN; Tue, 28 Jul 2020 10:54:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B0CC300238;
        Tue, 28 Jul 2020 12:54:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20B842BE3E477; Tue, 28 Jul 2020 12:54:10 +0200 (CEST)
Date:   Tue, 28 Jul 2020 12:54:10 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 23/24] x86: use asm-generic/mmu_context.h for no-op
 implementations
Message-ID: <20200728105410.GU119549@hirez.programming.kicks-ass.net>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-24-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728033405.78469-24-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 01:34:04PM +1000, Nicholas Piggin wrote:
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/include/asm/mmu_context.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 47562147e70b..255750548433 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -92,12 +92,14 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
>  }
>  #endif
>  
> +#define enter_lazy_tlb enter_lazy_tlb
>  extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
>  
>  /*
>   * Init a new mm.  Used on mm copies, like at fork()
>   * and on mm's that are brand-new, like at execve().
>   */
> +#define init_new_context init_new_context
>  static inline int init_new_context(struct task_struct *tsk,
>  				   struct mm_struct *mm)
>  {
> @@ -117,6 +119,8 @@ static inline int init_new_context(struct task_struct *tsk,
>  	init_new_context_ldt(mm);
>  	return 0;
>  }
> +
> +#define destroy_context destroy_context
>  static inline void destroy_context(struct mm_struct *mm)
>  {
>  	destroy_context_ldt(mm);
> @@ -215,4 +219,6 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  
>  unsigned long __get_current_cr3_fast(void);
>  
> +#include <asm-generic/mmu_context.h>
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> -- 
> 2.23.0
> 
