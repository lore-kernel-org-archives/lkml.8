Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1846C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C964621D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxVHatqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgHETt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgHEQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:54:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD49C0A8886
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+g3sbWo8Ja9JxjGyq6mVY0ZEJVqeXUqG7DKAaCqdzBs=; b=DxVHatqgIQwBZ9FahPp33QYiaL
        JbNRhIZx5Otc3laDLk3mLlio8sKrClfiK3w6vfg8u/tcF+CsHN4mmwJX24Bvyq9gY/PRmRm1u1slB
        9ejtKcqY8ZCJXw1thk0kKk64siUhx+DnaTaqBajAHqkVT1HrqFCMfTtpvu3WeZ3gKSYvjpEfcFnIk
        wpawZvrPIG1AHJSRuXQfe99zAXxoQ5PCuvWzPgVhrj0HEfSPGtLFS/AXi5m/ep7C5WxXRtVMFI/29
        mG8qdeu/pQIoWeTQJUcYY3sG0PfCvQk/m7owy3dyLHE4PFN0y9i9k1u4w1om/1Cp74XO9XPsY0+9d
        r4m56qwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Jgf-0005Ka-Cp; Wed, 05 Aug 2020 13:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 846953012DC;
        Wed,  5 Aug 2020 15:42:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71A9A22B957CE; Wed,  5 Aug 2020 15:42:32 +0200 (CEST)
Date:   Wed, 5 Aug 2020 15:42:32 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com,
        jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev@googlegroups.com,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200805134232.GR2674@hirez.programming.kicks-ass.net>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805132629.GA87338@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:26:29PM +0200, Marco Elver wrote:
> Add missing noinstr to arch_local*() helpers, as they may be called from
> noinstr code.
> 
> On a KCSAN config with CONFIG_PARAVIRT=y, syzbot stumbled across corrupt

Cute, so I've been working on adding objtool support for this a little:

  https://lkml.kernel.org/r/20200803143231.GE2674@hirez.programming.kicks-ass.net

> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 3d2afecde50c..a606f2ba2b5e 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -760,27 +760,27 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
>  	((struct paravirt_callee_save) { func })
>  
>  #ifdef CONFIG_PARAVIRT_XXL
> -static inline notrace unsigned long arch_local_save_flags(void)
> +static inline noinstr unsigned long arch_local_save_flags(void)
>  {
>  	return PVOP_CALLEE0(unsigned long, irq.save_fl);
>  }
>  
> -static inline notrace void arch_local_irq_restore(unsigned long f)
> +static inline noinstr void arch_local_irq_restore(unsigned long f)
>  {
>  	PVOP_VCALLEE1(irq.restore_fl, f);
>  }
>  
> -static inline notrace void arch_local_irq_disable(void)
> +static inline noinstr void arch_local_irq_disable(void)
>  {
>  	PVOP_VCALLEE0(irq.irq_disable);
>  }
>  
> -static inline notrace void arch_local_irq_enable(void)
> +static inline noinstr void arch_local_irq_enable(void)
>  {
>  	PVOP_VCALLEE0(irq.irq_enable);
>  }
>  
> -static inline notrace unsigned long arch_local_irq_save(void)
> +static inline noinstr unsigned long arch_local_irq_save(void)
>  {
>  	unsigned long f;
>  

Shouldn't we __always_inline those? They're going to be really small.
