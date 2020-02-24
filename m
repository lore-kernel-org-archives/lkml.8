Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A19C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DA12084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBXSHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:07:24 -0500
Received: from foss.arm.com ([217.140.110.172]:41084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBXSHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:07:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 285191FB;
        Mon, 24 Feb 2020 10:07:23 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CEF83F703;
        Mon, 24 Feb 2020 10:07:22 -0800 (PST)
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
To:     minyard@acm.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Corey Minyard <cminyard@mvista.com>
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220142214.GC14459@willie-the-truck> <20200220163038.GJ3704@minyard.net>
 <20200220213040.GA2919@minyard.net>
From:   James Morse <james.morse@arm.com>
Message-ID: <9e2eac0b-ab60-6316-4976-686a8ab7ac8f@arm.com>
Date:   Mon, 24 Feb 2020 18:07:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220213040.GA2919@minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

On 20/02/2020 21:30, Corey Minyard wrote:
> On Thu, Feb 20, 2020 at 10:30:38AM -0600, Corey Minyard wrote:
>> On Thu, Feb 20, 2020 at 02:22:14PM +0000, Will Deacon wrote:
>>> On Wed, Feb 19, 2020 at 09:24:03AM -0600, minyard@acm.org wrote:
>>>> After fixing this and doing some more testing, I ran into another issue:
>>>>
>>>> * Kernel enables the pt_regs single step
>>>> * Kernel returns from the exception with ERET.
>>>> * An interrupt or page fault happens on the instruction, causing the
>>>>   instruction to not be run, but the exception handler runs.
>>>
>>> This sounds like you've broken debug; we should take the step exception
>>> in the exception handler. That's the way this is supposed to work.
>>
>> Ok, here is the disconnect, I think.  If that is the case, then what I'm
>> seeing is working like it should.  That doesn't work with gdb, though,
>> gdb expects to be able to single-step and get to the next instruction.
>> The scenario I mentioned at the top of this email.
>>
>> Let me look at this a bit more.  I'll look at this on qemu and maybe a
>> pi.

> Ok, this is the disconnect.  I was assuming that single step would stop
> at the next instruction after returning from an exception.  qemu works
> the same way the hardware I have does.  So I'm assuming arm64 doesn't
> clear PTRACE.SS on an exception, even though that seems to be what the
> manual says.

PSTATE.SS isn't an enable bit for single step ... its part of a bigger state-machine.
(my made-up terminology for it is 'PSTATE.Suppress-Step'...)

The diagram in the Arm-Arm's D2.12.3 "The software step state machine" may help.

MDSCR_EL1.SS enables single-step, if PSTATE.D is clear the CPU will now take step
exceptions instead of pretty much anything else. (active pending state)
To execute one instruction you need to ERET with SPSR_ELx.SS set. (active, not pending)
The CPU will execute one instruction, then clear PSTATE.SS. (taking us back to active pending)

Taking an exception clears PSTATE.SS so that you know you're in active-pending state, and
will take a step exception once you re-enable debug with PSTATE.D. This lets you step the
exception handlers.
(if it was set, you wouldn't see the first instruction in the step handler, if it was
inherited, you couldn't know if you would see the first instruction or not).
If you take something other than a step exception, PSTATE.SS will be preserved in SPSR_EL1.SS.


What I think you are seeing is the step exception once debug is re-enabled, after taking
an exception you didn't want. This happens because MDSCR_EL1.SS is still set.


> You can reproduce this by setting up kgdb on the kernel and hooking up
> gdb, setting a breakpoint somewhere that has interrupts enabled, then
> doing a "continue".  It will hit the same breakpoint again and again
> because the PC doesn't get advanced by the single step and the timer
> interrupt is always going to be pending.  I can do a more detailed set
> of instructions with qemu, if you like.

> I looked at kprobes a bit.  I don't think kprobes will have a problem
> with this particular issue, it disables interrupts while single
> stepping and doesn't allow a probe on any instruction that would modify
> the interrupt settings.  I didn't look at page faults, but I assume that
> it also won't allow a probe where there can be a page fault.

Yes, arch_prepare_kprobe() checks search_exception_tables() for locations that we know may
cause page faults. These are blacklisted.


Thanks,

James
