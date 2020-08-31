Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6FEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 02:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE22071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 02:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHaCQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 22:16:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:33387 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgHaCQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:16:41 -0400
IronPort-SDR: MDBqxKPz+b2wY99KLyEodSMX/ctxTrkCKaUzOl4APJndxSHheWzGgKpTexWPdcK5ZZTrwcLyAD
 MJc/taKCXdUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="218449373"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="218449373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 19:16:40 -0700
IronPort-SDR: rsgjOh+SguclyBP2m+tvWyYXzyMIgJprCZTi9jFL621kEih3GW+Ormhf1X6cFqGTa/pqqF5JTt
 TbmCzzR+f6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="338093341"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2020 19:16:38 -0700
Date:   Mon, 31 Aug 2020 10:16:38 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200831021638.GB65971@shbuild999.sh.intel.com>
References: <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
 <20200825062305.GA83850@shbuild999.sh.intel.com>
 <20200828174839.GD19448@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200828174839.GD19448@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:48:39PM +0200, Borislav Petkov wrote:
> On Tue, Aug 25, 2020 at 02:23:05PM +0800, Feng Tang wrote:
> > Also one good news is, we seem to identify the 2 key percpu variables
> > out of the list mentioned in previous email:  
> > 	'arch_freq_scale'
> > 	'tsc_adjust'
> > 
> > These 2 variables are accessed in 2 hot call stacks (for this 288 CPU
> > Xeon Phi platform):
> > 
> >   - arch_freq_scale is accessed in scheduler tick 
> > 	  arch_scale_freq_tick+0xaf/0xc0
> > 	  scheduler_tick+0x39/0x100
> > 	  update_process_times+0x3c/0x50
> > 	  tick_sched_handle+0x22/0x60
> > 	  tick_sched_timer+0x37/0x70
> > 	  __hrtimer_run_queues+0xfc/0x2a0
> > 	  hrtimer_interrupt+0x122/0x270
> > 	  smp_apic_timer_interrupt+0x6a/0x150
> > 	  apic_timer_interrupt+0xf/0x20
> > 
> >   - tsc_adjust is accessed in idle entrance
> > 	  tsc_verify_tsc_adjust+0xeb/0xf0
> > 	  arch_cpu_idle_enter+0xc/0x20
> > 	  do_idle+0x91/0x280
> > 	  cpu_startup_entry+0x19/0x20
> > 	  start_kernel+0x4f4/0x516
> > 	  secondary_startup_64+0xb6/0xc0
> > 
> > From systemmap file, for bad kernel these 2 sit in one cache line, while
> > for good kernel they sit in 2 separate cache lines.
> > 
> > It also explains why it turns from a regression to an improvement with
> > updated gcc/kconfig, as the cache line sharing situation is reversed.
> > 
> > The direct patch I can think of is to make 'tsc_adjust' cache aligned
> > to separate these 2 'hot' variables. How do you think?
> > 
> > --- a/arch/x86/kernel/tsc_sync.c
> > +++ b/arch/x86/kernel/tsc_sync.c
> > @@ -29,7 +29,7 @@ struct tsc_adjust {
> >  	bool		warned;
> >  };
> >  
> > -static DEFINE_PER_CPU(struct tsc_adjust, tsc_adjust);
> > +static DEFINE_PER_CPU_ALIGNED(struct tsc_adjust, tsc_adjust);
> 
> So why don't you define both variables with DEFINE_PER_CPU_ALIGNED and
> check if all your bad measurements go away this way?

For 'arch_freq_scale', there are other percpu variables in the same
smpboot.c: 'arch_prev_aperf' and 'arch_prev_mperf', and in hot path
arch_scale_freq_tick(), these 3 variables are all accessed, so I didn't 
touch it. Or maybe we can align the first of these 3 variables, so
that they sit in one cacheline.

> You'd also need to check whether there's no detrimental effect from
> this change on other, i.e., !KNL platforms, and I think there won't
> be because both variables will be in separate cachelines then and all
> should be good.

Yes, these kind of changes should be verified on other platforms.

One thing still puzzles me, that the 2 variables are per-cpu things, and
there is no case of many CPU contending, why the cacheline layout matters?
I doubt it is due to the contention of the same cache set, and am trying
to find some way to test it.

Thanks,
Feng

> Hmm?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
