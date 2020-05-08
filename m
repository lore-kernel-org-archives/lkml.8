Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676BCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1C5207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHM0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgEHM0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:26:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FFC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:26:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jX25J-0004sf-3y; Fri, 08 May 2020 14:26:33 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1FA61101175; Fri,  8 May 2020 14:26:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about stack irq swizzles
In-Reply-To: <20200508101209.GY5298@hirez.programming.kicks-ass.net>
References: <20200507161020.783541450@infradead.org> <20200507161828.801097834@infradead.org> <20200507173809.GK5298@hirez.programming.kicks-ass.net> <20200507183048.rlf2bgj4cf2g4jy6@treble> <878si3e8v2.fsf@nanos.tec.linutronix.de> <20200508101209.GY5298@hirez.programming.kicks-ass.net>
Date:   Fri, 08 May 2020 14:26:32 +0200
Message-ID: <87sggak3yf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, May 07, 2020 at 11:24:49PM +0200, Thomas Gleixner wrote:
>> But over our IRC conversation I came up with a 3rd variant:
>> 
>>   For most of the vectors the indirect call overhead is just noise, so
>>   we can run them through the ASM switcher, but for the resched IPI
>>   we can just use a separate direct call stub in ASM.
>
> Are we sure the rat-poison crap is noise for all the other system
> vectors? I suppose it is for most since they'll do indirect calls
> themselves anyway, right?

We have different categories:

 1) Uninteresting

    SPURIOUS_APIC_VECTOR, ERROR_APIC_VECTOR, THERMAL_APIC_VECTOR,
    THRESHOLD_APIC_VECTOR, REBOOT_VECTOR, DEFERRED_ERROR_VECTOR

 2) Indirect call poisoned

    LOCAL_TIMER_VECTOR
    X86_PLATFORM_IPI_VECTOR
    IRQ_WORK_VECTOR
    HYPERV_STIMER0_VECTOR
    HYPERVISOR_CALLBACK_VECTOR
    POSTED_INTERRUPT_WAKEUP_VECTOR.
    CALL_FUNCTION_VECTOR
    CALL_FUNCTION_SINGLE_VECTOR
    
 3) Quick

    RESCHEDULE_VECTOR

    POSTED_INTR_VECTOR
    POSTED_INTR_NESTED_VECTOR

        These two postit ones are weird because they are both empty and
        just increment different irq counts.

    HYPERV_REENLIGHTENMENT_VECTOR

        schedules delayed work, i,e. arms a timer which should be
        straight forward, but does it matter?

 4) Others

    UV_BAU_MESSAGE - The TLB flushes are probably more expensive than
                     ratpoutine

Hmm?

Thanks,

        tglx
