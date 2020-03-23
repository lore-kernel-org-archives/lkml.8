Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D0C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAF92076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgCWL6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:58:12 -0400
Received: from foss.arm.com ([217.140.110.172]:47830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgCWL6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:58:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 465AB1FB;
        Mon, 23 Mar 2020 04:58:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14BF3F52E;
        Mon, 23 Mar 2020 04:58:09 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:58:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: reduce trampoline data alignment
Message-ID: <20200323115804.GA2597@C02TD0UTHF1T.local>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200319091407.51449-3-remi@remlab.net>
 <20200321134056.GB3052@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200321134056.GB3052@mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 01:41:01PM +0000, Catalin Marinas wrote:
> On Thu, Mar 19, 2020 at 11:14:07AM +0200, Rémi Denis-Courmont wrote:
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index c36733d8cd75..ecad15443655 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -858,7 +858,7 @@ SYM_CODE_END(tramp_exit_compat)
> >  	.popsection				// .entry.tramp.text
> >  #ifdef CONFIG_RANDOMIZE_BASE
> >  	.pushsection ".rodata", "a"
> > -	.align PAGE_SHIFT
> > +	.align	4	// all .rodata must be in a single fixmap page
> >  SYM_DATA_START(__entry_tramp_data_start)
> >  	.quad	vectors
> >  SYM_DATA_END(__entry_tramp_data_start)
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 9b08f7c7e6f0..6a0e75f48e7b 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -599,9 +599,8 @@ static int __init map_entry_trampoline(void)
> >  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> >  		extern char __entry_tramp_data_start[];
> >  
> > -		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
> > -			     __pa_symbol(__entry_tramp_data_start),
> > -			     PAGE_KERNEL_RO);
> > +		pa_start = __pa_symbol(__entry_tramp_data_start) & PAGE_MASK;
> > +		__set_fixmap(FIX_ENTRY_TRAMP_DATA, pa_start, PAGE_KERNEL_RO);
> >  	}
> >  
> >  	return 0;
> 
> For some reason, I haven't investigated yet, a kernel with KASAN and 64K
> pages enabled does not boot (see the attached config). It seems to lock
> up when starting user space. Bisected to this commit, reverting it fixes
> the issue.

I think the issue might be due to ADRP + ADD :lo12: using 4K offsets,
and so patch 1 isn't quite right for !4K kernels, as we're not
accounting for 4 bits of the address when we try to generate it.

I'll check that now.

Thanks,
Mark.
