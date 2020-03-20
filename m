Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4962C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C9A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCTLtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:49:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:49:23 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFG9N-0002wo-Oz; Fri, 20 Mar 2020 12:49:18 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 931B8100375; Fri, 20 Mar 2020 12:49:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Singh\, Balbir" <sblbir@amazon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "keescook\@chromium.org" <keescook@chromium.org>,
        "Herrenschmidt\, Benjamin" <benh@amazon.com>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com> <87imj19o13.fsf@nanos.tec.linutronix.de> <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com>
Date:   Fri, 20 Mar 2020 12:49:16 +0100
Message-ID: <8736a3456r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir,

"Singh, Balbir" <sblbir@amazon.com> writes:
> On Thu, 2020-03-19 at 01:38 +0100, Thomas Gleixner wrote:
>> What's the point? The attack surface is the L1D content of the scheduled
>> out task. If the malicious task schedules out, then why would you care?
>> 
>> I might be missing something, but AFAICT this is beyond paranoia.
>> 
>
> I think there are two cases
>
> 1. Task with important data schedules out
> 2. Malicious task schedules in
>
> These patches address 1, but call out case #2

The point is if the victim task schedules out, then there is no reason
to flush L1D immediately in context switch. If that just schedules a
kernel thread and then goes back to the task, then there is no point
unless you do not even trust the kernel thread.

>> > 3. There is a fallback software L1D load, similar to what L1TF does, but
>> >    we don't prefetch the TLB, is that sufficient?
>> 
>> If we go there, then the KVM L1D flush code wants to move into general
>> x86 code.
>
> OK.. we can definitely consider reusing code, but I think the KVM bits require
> tlb prefetching, IIUC before cache flush to negate any bad translations
> associated with an L1TF fault, but the code/comments are not clear on the need
> to do so.

I forgot the gory details by now, but having two entry points or a
conditional and share the rest (page allocation etc.) is definitely
better than two slightly different implementation which basically do the
same thing.

>> > +void enable_l1d_flush_for_task(struct task_struct *tsk)
>> > +{
>> > +     struct page *page;
>> > +
>> > +     if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
>> > +             goto done;
>> > +
>> > +     mutex_lock(&l1d_flush_mutex);
>> > +     if (l1d_flush_pages)
>> > +             goto done;
>> > +     /*
>> > +      * These pages are never freed, we use the same
>> > +      * set of pages across multiple processes/contexts
>> > +      */
>> > +     page = alloc_pages(GFP_KERNEL | __GFP_ZERO, L1D_CACHE_ORDER);
>> > +     if (!page)
>> > +             return;
>> > +
>> > +     l1d_flush_pages = page_address(page);
>> > +     /* I don't think we need to worry about KSM */
>> 
>> Why not? Even if it wouldn't be necessary why would we care as this is a
>> once per boot operation in fully preemptible code.
>
> Not sure I understand your question, I was stating that even if KSM was
> running, it would not impact us (with dedup), as we'd still be writing out 0s
> to the cache line in the fallback case.

I probably confused myself vs. the comment in the VMX code, but that
mentions nested virt. Needs at least some consideration when we reuse
that code.

>> >  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>> >              struct task_struct *tsk)
>> >  {
>> > @@ -433,6 +519,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
>> > mm_struct *next,
>> >               trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
>> >       }
>> > 
>> > +     l1d_flush(next, tsk);
>> 
>> This is really the wrong place. You want to do that:
>> 
>>   1) Just before return to user space
>>   2) When entering a guest
>> 
>> and only when the previously running user space task was the one which
>> requested this massive protection.
>> 
>
> Cases 1 and 2 are handled via
>
> 1. SWAPGS fixes/work arounds (unless I misunderstood your suggestion)

How so? SWAPGS mitigation does not flush L1D. It merily serializes SWAPGS.

> 2. L1TF fault handling
>
> This mechanism allows for flushing not restricted to 1 or 2, the idea is to
> immediately flush L1D for paranoid processes on mm switch.

Why? To protect the victim task against the malicious kernel?

The L1D content of the victim is endangered in the following case:

    victim out -> attacker in

The attacker can either run in user space or in guest mode. So the flush
is only interesting when the attacker actually goes back to user space
or reenters the guest.

The following is completely uninteresting:

    victim out -> kernel thread in/out -> victim in

Even this is uninteresting:

    victim in -> attacker in (stays in kernel, e.g. waits for data) ->
    attacker out -> victim in

So the point where you want to flush conditionally is when the attacker
leaves kernel space either to user mode or guest mode.

So if the victim schedules out it sets a per cpu request to flush L1D
on the borders.

And then you have on return to user:

    if (this_cpu_flush_l1d())
    	flush_l1d()

and in kvm:

    if (this_cpu_flush_l1d() || L1TF_flush_L1D)
    	flush_l1d()

The request does:

    if (!this_cpu_read(l1d_flush_for_task))
        this_cpu_write(l1d_flush_for_task, current)

The check does:

    p = this_cpu_read(l1d_flush_for_task);
    if (p) {
        this_cpu_write(l1d_flush_for_task, NULL);
        return p != current;
    }
    return false;

Hmm?

Thanks,

        tglx

                
