Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F92F2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592932758;
	bh=88RROu/Udh8k8VGMaeC38rwcu+eyfh+EM/C+2a0MOZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JEq9PNdFnolg16Jz7n/kJ6vPWGspbmyLRsXl++IBmCHAIKyEin9HyejLgzhZTBoRU
	 I0452SU8C2NB5pE1U4IWWsT9BNa9rCLDoxQ0+wHD2HEsRHD7ksH6beZzkVSqUY84po
	 zINYQJKUcFOLATYEk++gl01Bb1kgD66N1rZesQ5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbgFWRTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732408AbgFWRTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:19:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990D020781;
        Tue, 23 Jun 2020 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592932755;
        bh=88RROu/Udh8k8VGMaeC38rwcu+eyfh+EM/C+2a0MOZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7ePoQ6wpoYX/e81nIXy8P33qv/UlfcE2H0CmdRhh09yI0kfjVqUmDI93TUbSkLy6
         O47eePucoTvcDzNRE9aOu/zmNgo5cjZHiDgfqyowsFjrnEe35EPNvhR1VKoPosnmS0
         xgSRzrJac2oVGstnyhIbIjWn9gRwfcs3rV0JfFlo=
Date:   Tue, 23 Jun 2020 18:19:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jiping Ma <Jiping.Ma2@windriver.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200623171909.GC4819@willie-the-truck>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
 <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
 <20200528075418.GB22156@willie-the-truck>
 <20200618130332.GA53391@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618130332.GA53391@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:03:32PM +0100, Mark Rutland wrote:
> On Thu, May 28, 2020 at 08:54:19AM +0100, Will Deacon wrote:
> > On Thu, May 28, 2020 at 09:06:07AM +0800, Jiping Ma wrote:
> > > On 05/27/2020 11:19 PM, Mark Rutland wrote:
> > > > On Wed, May 27, 2020 at 09:33:00AM +0800, Jiping Ma wrote:
> > > > > On 05/26/2020 06:26 PM, Mark Rutland wrote:
> > > > > > On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
> > > > > This modification can not fix our issue,� we need
> > > > > perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 32-bit
> > > > > task or not,
> > > > > then return the correct PC value.
> > > > I must be missing something here.
> > > > 
> > > > The core code perf_reg_abi(task) is called with the task being sampled,
> > > > and the regs are from the task being sampled. For a userspace sample for
> > > > a compat task, compat_user_mode(regs) should be equivalent to the
> > > > is_compat_thread(task_thread_info(task)) check.
> > > > 
> > > > What am I missing?
> > > This issue caused by PC value is not correct. regs are sampled in function
> > > perf_output_sample_regs, that call perf_reg_value(regs, bit) to get PC
> > > value.
> > > PC value is regs[15] in perf_reg_value() function. it should be regs[32].
> > > 
> > > perf_output_sample_regs(struct perf_output_handle *handle,
> > > ����������������������� struct pt_regs *regs, u64 mask)
> > > {
> > > ������� int bit;
> > > ������� DECLARE_BITMAP(_mask, 64);
> > > 
> > > ������� bitmap_from_u64(_mask, mask);
> > > ������� for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
> > > ��������������� u64 val;
> > > 
> > > ��������������� val = perf_reg_value(regs, bit);
> > > ��������������� perf_output_put(handle, val);
> > > ������� }

wtf happened here?!

> > Yes, but Mark's point is that checking 'compat_user_mode(regs)' should be
> > exactly the same as checking 'perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32'.
> > Are you saying that's not the case? If so, please can you provide an example
> > of when they are different?
> > 
> > Leaving that aside for a second, I also think it's reasonable to question
> > whether this whole interface is busted or not. I looked at it last night but
> > struggled to work out what it's supposed to do. Consider these three
> > scenarios, all under an arm64 kernel:
> > 
> >   1. 64-bit perf + 64-bit application being profiled
> >   2. 64-bit perf + 32-bit application being profiled
> >   3. 32-bit perf + 32-bit application being profiled
> > 
> > It looks like the current code is a bodge to try to handle both (2) and
> > (3) at the same time:
> > 
> >   - In case (3), userspace only asks about registers 0-15
> >   - In case (2), we fudge the higher registers so that 64-bit SP and LR
> >     hold the 32-bit values as a bodge to allow a 64-bit dwarf unwinder
> >     to unwind the stack
> 
> I think the fudging is nonsensical to begin with, as I would have
> expected that PERF_REGS_ABI_32 should be the same layout regardless of
> consumer (and therefore should be identical to the 32-bit arm native
> format). I realise that doesn't change that we might be stuck with it...

Thankfully, I don't think the fudging is affected by the patch here, so I'm
inclined to take it as a fix. In fact, with this change, doesn't the prefix
of the regs returned in (2) look the same as the one you would expect in
32-bit arm?

> > So the idea behind the patch looks fine because case (3) is expecting the PC
> > in register 15 and instead gets 0, but the temptation is to clean this up so
> > that cases (2) and (3) report the same data to userspace (along the lines of
> > Mark's patch), namely only the first 16 registers with the PC moved down. We
> > can only do that if the unwinder is happy, which it might be if it only ever
> > looks up dwarf register numbers based on the unwind tables in the binary.
> > Somebody would need to dig into that.
> 
> Agreed; I will try to figure out what the perf tool does in the three
> cases above. I would be grateful if others could take a look too.
> 
> Another slightly scary thought: what happens for a 32-bit perf with a
> 64-bit application being profiled? I don't see how that'd be forbidden,
> but I also don't see how it'd work.

Although you can obviously feed a 32-bit perf with a 64-bit perf.data,
a 32-bit task cannot spawn a 64-bit child so that rules out a lot of the
runtime weirdness, no?

> > Otherwise, if it generates unconditional references to things like
> > register 30 to grab the link register, then we're stuck with the bodge
> > and need to special-case the PC.
> 
> I agree that in that case we'd have to keep the existing bodge, and we'd
> have to special-case the PC, but I'd prefer to split the logic for case
> 1 into a separate function for cases 2 and 3 so that we can more easily
> avoid getting this more confused.
> 
> Let's figure out what userspace does first...

afaict, perf just slurps all the registers in one go and hands them off
to the unwinder, which will index into them according to the dwarf unwind
tables. I have doubts as to how well that works (for example, unwinder
address corrections due to Thumb would not be applied).

So, I think we should take this patch (which puts the PC where you'd expect
to find it for compat tasks) and then we could consider removing the current
lr/sp fudging as a separate patch, which we could revert if it causes a
problem. However, I'm not sure I want to open that up.

What do you think?

Will
