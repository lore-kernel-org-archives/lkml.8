Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92046207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFRNDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:03:47 -0400
Received: from foss.arm.com ([217.140.110.172]:49868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgFRNDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:03:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9408F101E;
        Thu, 18 Jun 2020 06:03:45 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.17.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3600B3F71F;
        Thu, 18 Jun 2020 06:03:43 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:03:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jiping Ma <Jiping.Ma2@windriver.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200618130332.GA53391@C02TD0UTHF1T.local>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
 <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
 <20200528075418.GB22156@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528075418.GB22156@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 08:54:19AM +0100, Will Deacon wrote:
> On Thu, May 28, 2020 at 09:06:07AM +0800, Jiping Ma wrote:
> > On 05/27/2020 11:19 PM, Mark Rutland wrote:
> > > On Wed, May 27, 2020 at 09:33:00AM +0800, Jiping Ma wrote:
> > > > On 05/26/2020 06:26 PM, Mark Rutland wrote:
> > > > > On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
> > > > This modification can not fix our issue,ï¿½ we need
> > > > perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 32-bit
> > > > task or not,
> > > > then return the correct PC value.
> > > I must be missing something here.
> > > 
> > > The core code perf_reg_abi(task) is called with the task being sampled,
> > > and the regs are from the task being sampled. For a userspace sample for
> > > a compat task, compat_user_mode(regs) should be equivalent to the
> > > is_compat_thread(task_thread_info(task)) check.
> > > 
> > > What am I missing?
> > This issue caused by PC value is not correct. regs are sampled in function
> > perf_output_sample_regs, that call perf_reg_value(regs, bit) to get PC
> > value.
> > PC value is regs[15] in perf_reg_value() function. it should be regs[32].
> > 
> > perf_output_sample_regs(struct perf_output_handle *handle,
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ struct pt_regs *regs, u64 mask)
> > {
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ int bit;
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ DECLARE_BITMAP(_mask, 64);
> > 
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ bitmap_from_u64(_mask, mask);
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ u64 val;
> > 
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ val = perf_reg_value(regs, bit);
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ perf_output_put(handle, val);
> > ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ }
> > }
> 
> Yes, but Mark's point is that checking 'compat_user_mode(regs)' should be
> exactly the same as checking 'perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32'.
> Are you saying that's not the case? If so, please can you provide an example
> of when they are different?
> 
> Leaving that aside for a second, I also think it's reasonable to question
> whether this whole interface is busted or not. I looked at it last night but
> struggled to work out what it's supposed to do. Consider these three
> scenarios, all under an arm64 kernel:
> 
>   1. 64-bit perf + 64-bit application being profiled
>   2. 64-bit perf + 32-bit application being profiled
>   3. 32-bit perf + 32-bit application being profiled
> 
> It looks like the current code is a bodge to try to handle both (2) and
> (3) at the same time:
> 
>   - In case (3), userspace only asks about registers 0-15
>   - In case (2), we fudge the higher registers so that 64-bit SP and LR
>     hold the 32-bit values as a bodge to allow a 64-bit dwarf unwinder
>     to unwind the stack

I think the fudging is nonsensical to begin with, as I would have
expected that PERF_REGS_ABI_32 should be the same layout regardless of
consumer (and therefore should be identical to the 32-bit arm native
format). I realise that doesn't change that we might be stuck with it...

> So the idea behind the patch looks fine because case (3) is expecting the PC
> in register 15 and instead gets 0, but the temptation is to clean this up so
> that cases (2) and (3) report the same data to userspace (along the lines of
> Mark's patch), namely only the first 16 registers with the PC moved down. We
> can only do that if the unwinder is happy, which it might be if it only ever
> looks up dwarf register numbers based on the unwind tables in the binary.
> Somebody would need to dig into that.

Agreed; I will try to figure out what the perf tool does in the three
cases above. I would be grateful if others could take a look too.

Another slightly scary thought: what happens for a 32-bit perf with a
64-bit application being profiled? I don't see how that'd be forbidden,
but I also don't see how it'd work.

> Otherwise, if it generates unconditional references to things like
> register 30 to grab the link register, then we're stuck with the bodge
> and need to special-case the PC.

I agree that in that case we'd have to keep the existing bodge, and we'd
have to special-case the PC, but I'd prefer to split the logic for case
1 into a separate function for cases 2 and 3 so that we can more easily
avoid getting this more confused.

Let's figure out what userspace does first...

Thanks,
Mark.
