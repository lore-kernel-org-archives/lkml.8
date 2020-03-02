Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96613C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3C521775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hITb9uSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgCBQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:35:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCBQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=luRVVK0pX3V9dHOJ/EkElogYTnQsICycmjNTVj/0FE0=; b=hITb9uSkJF6M/Ma3L74kyzbAOt
        2YOOQ2jXvdq5b5xCTEySAZQVbevObolRGus06OBmoe7T9mLkdvVwb+JYtOqD3NM4i9HVQW7NJPn06
        pGm9UwzfaKfwbWnC34PAkZzd4MvEu50E/N/mXFcE/zT6Ew0EPfyI8LsQ5brivWA4Wa+TGfXFWyjy5
        kUpU9QJ6/i5jB8KQNF9ytq6unB2m3/O2/bLjYsPodG8a3XJUEPJYLeW6cIsyjGuLkBzupCTFVNqgg
        6WeGL2gQWrIz2LkT746MZKUkyU5MTwb+FaIwHPjwdVJpEhAflID2hv0nUySrMkJymyuN28G02obIr
        oHhRqPrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8o2I-0001E5-UE; Mon, 02 Mar 2020 16:35:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A9FA304D2B;
        Mon,  2 Mar 2020 17:33:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0FB5203E9E4B; Mon,  2 Mar 2020 17:35:16 +0100 (CET)
Date:   Mon, 2 Mar 2020 17:35:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: x2apic_wrmsr_fence vs. Intel manual
Message-ID: <20200302163516.GB2579@hirez.programming.kicks-ass.net>
References: <783add60-f6c7-c8c6-b369-42e5ebfbf8c9@siemens.com>
 <87lfoienjp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfoienjp.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:20:26PM +0100, Thomas Gleixner wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> > as I generated a nice bug around fence vs. x2apic icr writes, I studied 
> > the kernel code and the Intel manual in this regard more closely. But 
> > there is a discrepancy:
> >
> > arch/x86/include/asm/apic.h:
> >
> > /*
> >  * Make previous memory operations globally visible before
> >  * sending the IPI through x2apic wrmsr. We need a serializing instruction or
> >  * mfence for this.
> >  */
> > static inline void x2apic_wrmsr_fence(void)
> > {
> >         asm volatile("mfence" : : : "memory");
> > }
> >
> > Intel SDM, 10.12.3 MSR Access in x2APIC Mode:
> >
> > "A WRMSR to an APIC register may complete before all preceding stores 
> > are globally visible; software can prevent this by inserting a 
> > serializing instruction or the sequence MFENCE;LFENCE before the WRMSR."
> >
> > The former dates back to ce4e240c279a, but that commit does not mention 
> > why lfence is not needed. Did the manual read differently back then? Or 
> > why are we safe? To my reading of lfence, it also has a certain 
> > instruction serializing effect that mfence does not have.
> 
> The 2011 SDM says:
> 
>   A WRMSR to an APIC register may complete before all preceding stores
>   are globally visible; software can prevent this by inserting a
>   serializing instruction, an SFENCE, or an MFENCE before the WRMSR.
> 
> Sigh....

*groan*, The only way I can explain this is...

... because we changed the definition of LFENCE from:

 - wait until completion of all prior LOADs

to

 - wait until completion of all prior instructions

Because Spectre (and because apparently it was implemented that way,
mostly). It could be that MFENCE, which is basically a completion
barrier for all prior LOADs *AND* STOREs, is no longer a stict superset
of LFENCE anymore...

Which makes the otherwise perverted sequence: MFENCE;LFENCE, actually
mean something :/

la-la-la

Would be good to have that clarified though.


