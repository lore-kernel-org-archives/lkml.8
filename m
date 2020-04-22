Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF22C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC7A2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587543561;
	bh=HbETMiCy9zGcZZ64OTbPFZJGb1/+hnLxp8Gs9mlAY3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WtAuSAthVraKx02M8oOvkkgxDOA+yxd3wBqzu2svad16+zqLdc1qhBiZdPnQBlWs9
	 /b/rkYTbYdrFul7kGpGCJ+RzhOujfqBQ5rFpv4mWuJcfQRd2urin8RDiSykM8MWy6p
	 Hg47UCyHnvcdxi3BFoyupTWN6Iweg0UubVsV3VEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgDVITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgDVITU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:19:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397DB20663;
        Wed, 22 Apr 2020 08:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587543560;
        bh=HbETMiCy9zGcZZ64OTbPFZJGb1/+hnLxp8Gs9mlAY3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQ7iQTI7LyLT5ewPJjUZNXToJjteghTh2w1VH+8J6xtfiOr0tcelpq6yqCNEGI7jT
         1Kv32eSod/2GSMV7SbO2KEn/5oRnW6/rCSm1SIPfcCFfVUHfRue9uc/7Qbg9/IeniT
         46KQsy2pm2LBhaE6sCZtLYzd/oR0vFQyHrXZtMnM=
Date:   Wed, 22 Apr 2020 09:19:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Jiping Ma <Jiping.Ma2@windriver.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Perf: support to unwind userspace application stacks
 generated with thumb.
Message-ID: <20200422081914.GC29541@willie-the-truck>
References: <20200416053829.130395-1-jiping.ma2@windriver.com>
 <20200416071023.GB29742@willie-the-truck>
 <01029876-e167-a1ba-cb1a-d97adf23dde4@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01029876-e167-a1ba-cb1a-d97adf23dde4@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:56:04AM +0800, Jiping Ma wrote:
> On 04/16/2020 03:10 PM, Will Deacon wrote:
> > On Thu, Apr 16, 2020 at 01:38:29PM +0800, Jiping Ma wrote:
> > > +void
> > > +user_backtrace_thumb(struct perf_callchain_entry_ctx *entry,
> > > +		     struct pt_regs *regs)
> > > +{
> > > +	u32 sp;
> > > +	u32 *sp_t;
> > > +	/*
> > > +	 * Only push sp, lr to stack.
> > > +	 */
> > > +	for (sp = regs->compat_sp; (sp < current->mm->start_stack) &&
> > > +		(entry->nr < entry->max_stack); sp += 4) {
> > > +		sp_t = (u32 *)(unsigned long)sp;
> > > +		if ((*sp_t > regs->compat_sp) &&
> > > +			(*sp_t < current->mm->start_stack)) {
> > > +			if (*(sp_t + 1) < current->mm->end_code &&
> > > +				*(sp_t + 1) > current->mm->start_code) {
> > > +				perf_callchain_store(entry,  *(sp_t + 1)-1);
> > > +				sp += 4;
> > > +			}
> > > +		}
> > > +	}
> > > +}
> > This looks like a pile of fragile heuristics to me. Why don't you just use
> > libunwind in userspace, the same way you'd have to if you compiled without
> > framepointers?
> 
> Could you share more details for libunwind in userspace? Following is our
> build command for test app.
> bt_perf.thumb: arm-wrs-linux-gnueabi-gcc -march=armv7ve -mthumb -mfpu=neon
> -mfloat-abi=softfp -mcpu=cortex-a15
> --sysroot=sysroots/cortexa15t2-neon-wrs-linux-gnueabi -O0 -g -ggdb -Wall
> -funwind-tables -fno-omit-frame-pointer -frecord-gcc-switches -mapcs-frame
> bt_perf.c -o bt_perf.thumb

You can build the perf tool with support for libunwind, and then it should
handle the unwinding in userspace. I haven't used it for ages, but you may
need to pass '--call-graph dwarf'. Have a play (and you can also read the
code in tools/perf/).

Will
