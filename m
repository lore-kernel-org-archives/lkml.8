Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1A22075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHGMEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgHGMEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:04:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B4E4AF4E;
        Fri,  7 Aug 2020 12:04:41 +0000 (UTC)
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
        "Paul E. McKenney" <paulmck@kernel.org>
References: <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com>
 <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
Date:   Fri, 7 Aug 2020 14:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807113838.GA3547125@elver.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.20 13:38, Marco Elver wrote:
> On Fri, Aug 07, 2020 at 12:35PM +0200, Jürgen Groß wrote:
>> On 07.08.20 11:50, Marco Elver wrote:
>>> On Fri, Aug 07, 2020 at 11:24AM +0200, Jürgen Groß wrote:
>>>> On 07.08.20 11:01, Marco Elver wrote:
>>>>> On Thu, 6 Aug 2020 at 18:06, Marco Elver <elver@google.com> wrote:
>>>>>> On Thu, 6 Aug 2020 at 15:17, Marco Elver <elver@google.com> wrote:
>>>>>>> On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wrote:
>>>>>>>> On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
>>>>>>>>> Testing my hypothesis that raw then nested non-raw
>>>>>>>>> local_irq_save/restore() breaks IRQ state tracking -- see the reproducer
>>>>>>>>> below. This is at least 1 case I can think of that we're bound to hit.
>>>>>>> ...
>>>>>>>>
>>>>>>>> /me goes ponder things...
>>>>>>>>
>>>>>>>> How's something like this then?
>>>>>>>>
>>>>>>>> ---
>>>>>>>>     include/linux/sched.h |  3 ---
>>>>>>>>     kernel/kcsan/core.c   | 62 ++++++++++++++++++++++++++++++++++++---------------
>>>>>>>>     2 files changed, 44 insertions(+), 21 deletions(-)
>>>>>>>
>>>>>>> Thank you! That approach seems to pass syzbot (also with
>>>>>>> CONFIG_PARAVIRT) and kcsan-test tests.
>>>>>>>
>>>>>>> I had to modify it some, so that report.c's use of the restore logic
>>>>>>> works and not mess up the IRQ trace printed on KCSAN reports (with
>>>>>>> CONFIG_KCSAN_VERBOSE).
>>>>>>>
>>>>>>> I still need to fully convince myself all is well now and we don't end
>>>>>>> up with more fixes. :-) If it passes further testing, I'll send it as a
>>>>>>> real patch (I want to add you as Co-developed-by, but would need your
>>>>>>> Signed-off-by for the code you pasted, I think.)
>>>>>
>>>>> I let it run on syzbot through the night, and it's fine without
>>>>> PARAVIRT (see below). I have sent the patch (need your Signed-off-by
>>>>> as it's based on your code, thank you!):
>>>>> https://lkml.kernel.org/r/20200807090031.3506555-1-elver@google.com
>>>>>
>>>>>> With CONFIG_PARAVIRT=y (without the notrace->noinstr patch), I still
>>>>>> get lockdep DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled()), although
>>>>>> it takes longer for syzbot to hit them. But I think that's expected
>>>>>> because we can still get the recursion that I pointed out, and will
>>>>>> need that patch.
>>>>>
>>>>> Never mind, I get these warnings even if I don't turn on KCSAN
>>>>> (CONFIG_KCSAN=n). Something else is going on with PARAVIRT=y that
>>>>> throws off IRQ state tracking. :-/
>>>>
>>>> What are the settings of CONFIG_PARAVIRT_XXL and
>>>> CONFIG_PARAVIRT_SPINLOCKS in this case?
>>>
>>> I attached a config.
>>>
>>> 	$> grep PARAVIRT .config
>>> 	CONFIG_PARAVIRT=y
>>> 	CONFIG_PARAVIRT_XXL=y
>>> 	# CONFIG_PARAVIRT_DEBUG is not set
>>> 	CONFIG_PARAVIRT_SPINLOCKS=y
>>> 	# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
>>> 	CONFIG_PARAVIRT_CLOCK=y
>>
>> Anything special I need to do to reproduce the problem? Or would you be
>> willing to do some more rounds with different config settings?
> 
> I can only test it with syzkaller, but that probably doesn't help if you
> don't already have it set up. It can't seem to find a C reproducer.
> 
> I did some more rounds with different configs.
> 
>> I think CONFIG_PARAVIRT_XXL shouldn't matter, but I'm not completely
>> sure about that. CONFIG_PARAVIRT_SPINLOCKS would be my primary suspect.
> 
> Yes, PARAVIRT_XXL doesn't make a different. When disabling
> PARAVIRT_SPINLOCKS, however, the warnings go away.

Thanks for testing!

I take it you are doing the tests in a KVM guest?

If so I have a gut feeling that the use of local_irq_save() and
local_irq_restore() in kvm_wait() might be fishy. I might be completely
wrong here, though.

BTW, I think Xen's variant of pv spinlocks is fine (no playing with IRQ
on/off).

Hyper-V seems to do the same as KVM, and kicking another vcpu could be
problematic as well, as it is just using IPI.


Juergen
