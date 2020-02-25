Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13755C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F92176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgBYSUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:20:30 -0500
Received: from foss.arm.com ([217.140.110.172]:54460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYSU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:20:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C6EBFEC;
        Tue, 25 Feb 2020 09:55:47 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50ACA3F6CF;
        Tue, 25 Feb 2020 09:55:45 -0800 (PST)
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
To:     cminyard@mvista.com
Cc:     minyard@acm.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220142214.GC14459@willie-the-truck> <20200220163038.GJ3704@minyard.net>
 <20200220213040.GA2919@minyard.net>
 <9e2eac0b-ab60-6316-4976-686a8ab7ac8f@arm.com>
 <20200225153801.GD3865@minyard.net>
From:   James Morse <james.morse@arm.com>
Message-ID: <52fbb8a7-9dc9-508a-80f6-36ba42d5dacb@arm.com>
Date:   Tue, 25 Feb 2020 17:55:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225153801.GD3865@minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

On 25/02/2020 15:38, Corey Minyard wrote:
> On Mon, Feb 24, 2020 at 06:07:17PM +0000, James Morse wrote:
>> On 20/02/2020 21:30, Corey Minyard wrote:
>>> Ok, this is the disconnect.  I was assuming that single step would stop
>>> at the next instruction after returning from an exception.  qemu works
>>> the same way the hardware I have does.  So I'm assuming arm64 doesn't
>>> clear PTRACE.SS on an exception, even though that seems to be what the
>>> manual says.
>>
>> PSTATE.SS isn't an enable bit for single step ... its part of a bigger state-machine.
>> (my made-up terminology for it is 'PSTATE.Suppress-Step'...)
>>
>> The diagram in the Arm-Arm's D2.12.3 "The software step state machine" may help.
>>
>> MDSCR_EL1.SS enables single-step, if PSTATE.D is clear the CPU will now take step
>> exceptions instead of pretty much anything else. (active pending state)
>> To execute one instruction you need to ERET with SPSR_ELx.SS set. (active, not pending)
>> The CPU will execute one instruction, then clear PSTATE.SS. (taking us back to active pending)
>>
>> Taking an exception clears PSTATE.SS so that you know you're in active-pending state, and
>> will take a step exception once you re-enable debug with PSTATE.D. This lets you step the
>> exception handlers.
>> (if it was set, you wouldn't see the first instruction in the step handler, if it was
>> inherited, you couldn't know if you would see the first instruction or not).
>> If you take something other than a step exception, PSTATE.SS will be preserved in SPSR_EL1.SS.
>>
>>
>> What I think you are seeing is the step exception once debug is re-enabled, after taking
>> an exception you didn't want. This happens because MDSCR_EL1.SS is still set.


> Ok, I was familiar with that diagram, but I was trying to fit it into
> how the other architectures where I have done this type of work.  This
> is a little bizarre to me, but I understand now.  Your explaination was
> very helpful, though the code I have is correct either way.

| +/*
| + * The task that is currently being single-stepped.  There can be only
| + * one.
| + */
| +struct task_struct *single_step_task;

? I think this would break kprobes and perf's use of single-step on SMP systems.


> The problem is that kgdb doesn't work right with the current
> implementation.  If you continue from a breakpoint, it does not
> continue.  It just stops at the same place.  What happens is:
> 
> * gdb remove the breakpoint and single steps.
> * An exception happens and the single step stops in the kernel entry.
>   Thus the state machine goes to inactive.

(e.g. the original instruction caused a page fault)


> * gdb re-inserts the breakpoint and continues.

> * When the exception returns, the breakpoint is there and is hit again.

Yes, because the original instruction hadn't run, it caused a page fault. This time its
more likely to succeed.

perf's use of arm64's breakpoints is quite happy with this. It means if you hit a
breakpoint in the fault handler, you see those too. If an instruction causes a page-fault,
you may see it twice, but that is because the CPU tried to execute it twice.

(I agree the irq case is probably just annoying for kgdb)


> You can never continue from a breakpoint without removing it, because
> there's alway a timer interrupt pending.

Are you driving the single-step hardware directly here, or using the behaviour from
breakpoint_handler() and reinstall_suspended_bps()?

These disable breakpoints and step the original instruction, then re-enable breakpoints.
This is because breakpoints fire before the instruction runs, and single-step doesn't
suppress breakpoints. This has to happen regardless of asynchronous exceptions.


> You can't single-step through
> instructions (stepi) because it always stops in the kernel entry.  If
> you do a normal gdb single step in code it just hangs because it keeps
> trying to single step through instructions and keeps stopping in kernel
> entry.  So gdb does not expect the behavior that is currently
> implemented.

Is it fair to say that the user driving kgdb is very-slow compared to IRQs firing?
This isn't true for the other consumers of single-step (kprobes, perf).


> The patch as I have posted it is probably the simplest way to fix it.
> It basically makes single-step work like other architectures, and like
> the userspace single step works.  I could ifdef it so that the entry
> code is only there if kgdb is enabled.  You can single step through
> instructions that cause page faults, so it's a little more general.

> The other way is to run the single-stepped instruction with interrupts
> disabled and emulate any messing with the DAIF bits.  I assume
> that's only "MRS <Xt>, DAIF", "MSR DAIF, <Xt>", "MSR DAIFSet, #<imm>",
> and "MSR DAIFClr, #<imm>". 

> Well, I guess ERET also does that, but maybe
> that's ok, probably not a big deal.

(tangent: you can't step ERET!)


> In this case you can't single step over instructions that take page faults.

This works for perf. It doesn't for kprobes, which is why kprobes blacklists those sites.


> I'm not sure if that's a big
> deal or not, but I assume users would do that.  And it's more complex
> since you have to emulate those instructions messing with DAIF.
> 
> I would like to get this fixed, either way.

If the problem is IRQs preventing the very-slow user making forward-progress, it may be
possible for kgdb to ask the irqchip code to mute all IRQs on this CPU while it is
stepping. The PMR mechanism we use for pNMI could do this for the GIC. (Caveat: I don't
know anything about the GIC). For the pi ... no idea.

This doesn't stop you seeing instructions that fault from taking a fault, or taking the
breakpoint twice when the CPU tries to run the instruction twice. This is just the debug
hardware showing you what happened.


Thanks,

James
