Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB27A2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgE0PTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:19:33 -0400
Received: from foss.arm.com ([217.140.110.172]:39944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0PTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:19:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A42530E;
        Wed, 27 May 2020 08:19:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBD43F52E;
        Wed, 27 May 2020 08:19:30 -0700 (PDT)
Date:   Wed, 27 May 2020 16:19:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jiping Ma <Jiping.Ma2@windriver.com>
Cc:     will.deacon@arm.com, paul.gortmaker@windriver.com,
        catalin.marinas@arm.com, bruce.ashfield@gmail.com,
        yue.tao@windriver.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200527151928.GC59947@C02TD0UTHF1T.local>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:33:00AM +0800, Jiping Ma wrote:
> 
> 
> On 05/26/2020 06:26 PM, Mark Rutland wrote:
> > On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
> > > Modified the patch subject and the change description.
> > > 
> > > PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
> > > is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
> > > that perf can not parser the backtrace of app with dwarf mode in the
> > > 32bit system and 64bit kernel.
> > > 
> > > Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> > Thanks for this.
> > 
> > 
> > > ---
> > >   arch/arm64/kernel/perf_regs.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> > > index 0bbac61..0ef2880 100644
> > > --- a/arch/arm64/kernel/perf_regs.c
> > > +++ b/arch/arm64/kernel/perf_regs.c
> > > @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
> > >   	if ((u32)idx == PERF_REG_ARM64_PC)
> > >   		return regs->pc;
> > > +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
> > > +		&& idx == 15)
> > > +		return regs->pc;
> > I think there are some more issues here, and we may need a more
> > substantial rework. For a compat thread, we always expose
> > PERF_SAMPLE_REGS_ABI_32 via per_reg_abi(), but for some reason
> > perf_reg_value() also munges the compat SP/LR into their ARM64
> > equivalents, which don't exist in the 32-bit sample ABI. We also don't
> > zero the regs that don't exist in 32-bit (including the aliasing PC).
> > 
> > I reckon what we should do is have seperate functions for the two ABIs,
> > to ensure we don't conflate them, e.g.
> > 
> > u64 perf_reg_value_abi32(struct pt_regs *regs, int idx)
> > {
> > 	if ((u32)idx > PERF_REG_ARM32_PC)
> > 		return 0;
> > 	if (idx == PERF_REG_ARM32_PC)
> > 		return regs->pc;
> > 	
> > 	/*
> > 	 * Compat SP and LR already in-place
> > 	 */
> > 	return regs->regs[idx];
> > }
> > 
> > u64 perf_reg_value_abi64(struct pt_regs *regs, int idx)
> > {
> > 	if ((u32)idx > PERF_REG_ARM64_MAX)
> > 		return 0;
> > 	if ((u32)idx == PERF_REG_ARM64_SP)
> > 		return regs->sp;
> > 	if ((u32)idx == PERF_REG_ARM64_PC)
> > 		return regs->pc;
> > 	
> > 	reutrn regs->regs[idx];
> > }
> > 
> > u64 perf_reg_value(struct pt_regs *regs, int idx)
> > {
> > 	if (compat_user_mode(regs))
> > 		return perf_reg_value_abi32(regs, idx);
> > 	else
> > 		return perf_reg_value_abi64(regs, idx);
> > }
> This modification can not fix our issue,  we need
> perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 32-bit
> task or not,
> then return the correct PC value.

I must be missing something here.

The core code perf_reg_abi(task) is called with the task being sampled,
and the regs are from the task being sampled. For a userspace sample for
a compat task, compat_user_mode(regs) should be equivalent to the
is_compat_thread(task_thread_info(task)) check.

What am I missing?

Thanks,
Mark.
