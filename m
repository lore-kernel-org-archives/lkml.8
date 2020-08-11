Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5D320772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgHKHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgHKHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:04:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 588C8AC7D;
        Tue, 11 Aug 2020 07:05:10 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Liu <wei.liu@kernel.org>
References: <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <CANpmjNM1jASqCFYZpteVrZCa2V2D_DbXaqvoCV_Ac2boYfDXnQ@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <26c3214f-7d8a-7b1f-22fc-e864291f50ce@suse.com>
Date:   Tue, 11 Aug 2020 09:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNM1jASqCFYZpteVrZCa2V2D_DbXaqvoCV_Ac2boYfDXnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.20 09:00, Marco Elver wrote:
> On Fri, 7 Aug 2020 at 17:19, Marco Elver <elver@google.com> wrote:
>> On Fri, Aug 07, 2020 at 02:08PM +0200, Marco Elver wrote:
>>> On Fri, 7 Aug 2020 at 14:04, Jürgen Groß <jgross@suse.com> wrote:
>>>>
>>>> On 07.08.20 13:38, Marco Elver wrote:
>>>>> On Fri, Aug 07, 2020 at 12:35PM +0200, Jürgen Groß wrote:
> ...
>>>>>> I think CONFIG_PARAVIRT_XXL shouldn't matter, but I'm not completely
>>>>>> sure about that. CONFIG_PARAVIRT_SPINLOCKS would be my primary suspect.
>>>>>
>>>>> Yes, PARAVIRT_XXL doesn't make a different. When disabling
>>>>> PARAVIRT_SPINLOCKS, however, the warnings go away.
>>>>
>>>> Thanks for testing!
>>>>
>>>> I take it you are doing the tests in a KVM guest?
>>>
>>> Yes, correct.
>>>
>>>> If so I have a gut feeling that the use of local_irq_save() and
>>>> local_irq_restore() in kvm_wait() might be fishy. I might be completely
>>>> wrong here, though.
>>>
>>> Happy to help debug more, although I might need patches or pointers
>>> what to play with.
>>>
>>>> BTW, I think Xen's variant of pv spinlocks is fine (no playing with IRQ
>>>> on/off).
>>>>
>>>> Hyper-V seems to do the same as KVM, and kicking another vcpu could be
>>>> problematic as well, as it is just using IPI.
>>
>> I experimented a bit more, and the below patch seems to solve the
>> warnings. However, that was based on your pointer about kvm_wait(), and
>> I can't quite tell if it is the right solution.
>>
>> My hypothesis here is simply that kvm_wait() may be called in a place
>> where we get the same case I mentioned to Peter,
>>
>>          raw_local_irq_save(); /* or other IRQs off without tracing */
>>          ...
>>          kvm_wait() /* IRQ state tracing gets confused */
>>          ...
>>          raw_local_irq_restore();
>>
>> and therefore, using raw variants in kvm_wait() works. It's also safe
>> because it doesn't call any other libraries that would result in corrupt
>> IRQ state AFAIK.
> 
> Just to follow-up, it'd still be nice to fix this. Suggestions?
> 
> I could send the below as a patch, but can only go off my above
> hypothesis and the fact that syzbot is happier, so not entirely
> convincing.

Peter has told me via IRC he will look soon further into this.

Your finding suggests that the pv-lock implementation for Hyper-V
needs some tweaking, too. For that purpose I'm adding Wei to Cc.


Juergen

> 
> Thanks,
> -- Marco
> 
>> ------ >8 ------
>>
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index 233c77d056c9..1d412d1466f0 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -797,7 +797,7 @@ static void kvm_wait(u8 *ptr, u8 val)
>>          if (in_nmi())
>>                  return;
>>
>> -       local_irq_save(flags);
>> +       raw_local_irq_save(flags);
>>
>>          if (READ_ONCE(*ptr) != val)
>>                  goto out;
>> @@ -810,10 +810,10 @@ static void kvm_wait(u8 *ptr, u8 val)
>>          if (arch_irqs_disabled_flags(flags))
>>                  halt();
>>          else
>> -               safe_halt();
>> +               raw_safe_halt();
>>
>>   out:
>> -       local_irq_restore(flags);
>> +       raw_local_irq_restore(flags);
>>   }
>>
>>   #ifdef CONFIG_X86_32
> 

