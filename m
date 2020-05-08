Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B7C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4688206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PizcOla2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgEHNVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728662AbgEHMkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:40:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE779C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Af8YZ1WR9/bYbM4de2zvJhVmmyLFQbJLVbWrHU3CFbk=; b=PizcOla2stsgKNJdoQRZ34f9Z6
        OVuBslDAktey2Swlehkpx5IzXJ/IGIQXGWFrkvC/ANGqKsXgSVZkzwWMPfmAaU8RaBxb6ADCR7LAY
        2f+Y+G3IAXyoeGyGE3lC+jNO/Fys8OPrmTrVhN+kU4MyIGp/Xo0IBNIGbdNhr76slNtDC+G4o5HfT
        Z68mHB6K7UhLiwPqIEHKCfNJYlyQk1iaNv0cYlhvsDJ4b4aEj+Zh0jWmmb8OKC6mc6G/fbnN61KlD
        Y3xOzoih+1BmtJlCiUpqIWKw0RlimtLstrzXoPQyHz0HRJStlE75qPR8tB5k/4Vd/XnVAgV9xL/aw
        6cY1m0lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX2IQ-0005x3-RB; Fri, 08 May 2020 12:40:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2AAC307986;
        Fri,  8 May 2020 14:40:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D936E2B843CC9; Fri,  8 May 2020 14:40:04 +0200 (CEST)
Date:   Fri, 8 May 2020 14:40:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about
 stack irq swizzles
Message-ID: <20200508124004.GH5281@hirez.programming.kicks-ass.net>
References: <20200507161020.783541450@infradead.org>
 <20200507161828.801097834@infradead.org>
 <20200507173809.GK5298@hirez.programming.kicks-ass.net>
 <20200507183048.rlf2bgj4cf2g4jy6@treble>
 <878si3e8v2.fsf@nanos.tec.linutronix.de>
 <20200508101209.GY5298@hirez.programming.kicks-ass.net>
 <87sggak3yf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggak3yf.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:26:32PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Thu, May 07, 2020 at 11:24:49PM +0200, Thomas Gleixner wrote:
> >> But over our IRC conversation I came up with a 3rd variant:
> >> 
> >>   For most of the vectors the indirect call overhead is just noise, so
> >>   we can run them through the ASM switcher, but for the resched IPI
> >>   we can just use a separate direct call stub in ASM.
> >
> > Are we sure the rat-poison crap is noise for all the other system
> > vectors? I suppose it is for most since they'll do indirect calls
> > themselves anyway, right?
> 
> We have different categories:
> 
>  1) Uninteresting
> 
>     SPURIOUS_APIC_VECTOR, ERROR_APIC_VECTOR, THERMAL_APIC_VECTOR,
>     THRESHOLD_APIC_VECTOR, REBOOT_VECTOR, DEFERRED_ERROR_VECTOR
> 
>  2) Indirect call poisoned
> 
>     LOCAL_TIMER_VECTOR
>     X86_PLATFORM_IPI_VECTOR
>     IRQ_WORK_VECTOR
>     HYPERV_STIMER0_VECTOR
>     HYPERVISOR_CALLBACK_VECTOR
>     POSTED_INTERRUPT_WAKEUP_VECTOR.
>     CALL_FUNCTION_VECTOR
>     CALL_FUNCTION_SINGLE_VECTOR
>     
>  3) Quick
> 
>     RESCHEDULE_VECTOR
> 
>     POSTED_INTR_VECTOR
>     POSTED_INTR_NESTED_VECTOR
> 
>         These two postit ones are weird because they are both empty and
>         just increment different irq counts.
> 
>     HYPERV_REENLIGHTENMENT_VECTOR
> 
>         schedules delayed work, i,e. arms a timer which should be
>         straight forward, but does it matter?
> 
>  4) Others
> 
>     UV_BAU_MESSAGE - The TLB flushes are probably more expensive than
>                      ratpoutine
> 
> Hmm?

As we just agreed on IRC, 3) can run without changing stack, and then
the rest can use the indirect thing.
