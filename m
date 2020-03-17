Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D797C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F54B20409
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCQVSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:18:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQVSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:18:09 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEJau-0008WU-H2; Tue, 17 Mar 2020 22:17:48 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6D8C5101161; Tue, 17 Mar 2020 22:17:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck\, Tony" <tony.luck@intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
In-Reply-To: <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com> <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com> <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad> <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com> <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com> <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com> <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com> <20200221232057.GA19671@sinkpad> <20200317005521.GA8244@google.com> <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
Date:   Tue, 17 Mar 2020 22:17:47 +0100
Message-ID: <87imj2bs04.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

Tim Chen <tim.c.chen@linux.intel.com> writes:
>> However, I have the following questions, in particular there are 4 scenarios
>> where I feel the current patches do not resolve MDS/L1TF, would you guys
>> please share your thoughts?
>> 
>> 1. HT1 is running either hostile guest or host code.
>>    HT2 is running an interrupt handler (victim).
>> 
>>    In this case I see there is a possible MDS issue between HT1 and HT2.
>
> Core scheduling mitigates the userspace to userspace attacks via MDS between the HT.
> It does not prevent the userspace to kernel space attack.  That will
> have to be mitigated via other means, e.g. redirecting interrupts to a core
> that don't run potentially unsafe code.

Which is in some cases simply impossible. Think multiqueue devices with
managed interrupts. You can't change the affinity of those. Neither can
you do that for the per cpu timer interrupt.

>> 2. HT1 is executing hostile host code, and gets interrupted by a victim
>>    interrupt. HT2 is idle.
>
> Similar to above.

No. It's the same HT so not similar at all.

>>    In this case, I see there is a possible MDS issue between interrupt and
>>    the host code on the same HT1.
>
> The cpu buffers are cleared before return to the hostile host code.  So
> MDS shouldn't be an issue if interrupt handler and hostile code
> runs on the same HT thread.

OTOH, thats mostly correct. Aside of the shouldn't wording:

  MDS _is_ no issue in this case when the full mitigation is enabled.

Assumed that I have not less information about MDS than you have :)

>> 3. HT1 is executing hostile guest code, HT2 is executing a victim interrupt
>>    handler on the host.
>> 
>>    In this case, I see there is a possible L1TF issue between HT1 and HT2.
>>    This issue does not happen if HT1 is running host code, since the host
>>    kernel takes care of inverting PTE bits.
>
> The interrupt handler will be run with PTE inverted.  So I don't think
> there's a leak via L1TF in this scenario.

How so?

Host memory is attackable, when one of the sibling SMT threads runs in
host OS (hypervisor) context and the other in guest context.

HT1 is in guest mode and attacking (has control over PTEs). HT2 is
running in host mode and executes an interrupt handler. The host PTE
inversion does not matter in this scenario at all.

So HT1 can very well see data which is brought into the shared L1 by
HT2.

The only way to mitigate that aside of disabling HT is disabling EPT.

>> 4. HT1 is idle, and HT2 is running a victim process. Now HT1 starts running
>>    hostile code on guest or host. HT2 is being forced idle. However, there is
>>    an overlap between HT1 starting to execute hostile code and HT2's victim
>>    process getting scheduled out.
>>    Speaking to Vineeth, we discussed an idea to monitor the core_sched_seq
>>    counter of the sibling being idled to detect that it is now idle.
>>    However we discussed today that looking at this data, it is not really an
>>    issue since it is such a small window.

If the victim HT is kicked out of execution with an IPI then the overlap
depends on the contexts:

        HT1 (attack)		HT2 (victim)

 A      idle -> user space      user space -> idle

 B      idle -> user space      guest -> idle

 C      idle -> guest           user space -> idle

 D      idle -> guest           guest -> idle

The IPI from HT1 brings HT2 immediately into the kernel when HT2 is in
host user mode or brings it immediately into VMEXIT when HT2 is in guest
mode.

#A On return from handling the IPI HT2 immediately reschedules to idle.
   To have an overlap the return to user space on HT1 must be faster.

#B Coming back from VEMXIT into schedule/idle might take slightly longer
   than #A.

#C Similar to #A, but reentering guest mode in HT1 after sending the IPI
   will probably take longer.

#D Similar to #C if you make the assumption that VMEXIT on HT2 and
   rescheduling into idle is not significantly slower than reaching
   VMENTER after sending the IPI.

In all cases the data exposed by a potential overlap shouldn't be that
interesting (e.g. scheduler state), but that obviously depends on what
the attacker is looking for.

But all of them are still problematic vs. interrupts / softinterrupts
which can happen on HT2 on the way to idle or while idling. i.e. #3 of
the original case list. #A and #B are only affected my MDS, #C and #D by
both MDS and L1TF (if EPT is in use).

>> My concern is now cases 1, 2 to which there does not seem a good solution,
>> short of disabling interrupts. For 3, we could still possibly do something on
>> the guest side, such as using shadow page tables. Any thoughts on all this?

#1 can be partially mitigated by changing interrupt affinities, which is
   not always possible and in the case of the local timer interrupt
   completely impossible. It's not only the timer interrupt itself, the
   timer callbacks which can run in the softirq on return from interrupt
   might be valuable attack surface depending on the nature of the
   callbacks, the random entropy timer just being a random example.

#2 is a non issue if MDS mitigation is on, i.e. buffers are flushed
   before returning to user space. It's pretty much a non SMT case,
   i.e. same CPU user to kernel attack.

#3 Can only be fully mitigated by disabling EPT 

#4 Assumed that my assumptions about transition times are correct, which
   I think they are, #4 is pretty much redirected to #1

Hope that helps.

Thanks,

        tglx

