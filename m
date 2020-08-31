Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE695C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9103D20767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHaIXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:23:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:49946 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgHaIXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:23:12 -0400
IronPort-SDR: w/Ddlo5YBPbKA5kgUZKsM16ZjbF+QXKtfgd38VLjCMGIcmijlRb8/12nu5TGFBDea2dwKGZv4l
 BklQ9ERfNTlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="136982856"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="136982856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 01:23:11 -0700
IronPort-SDR: 0XcECbqhepTeWhaHH7cPT1S65lvLXxd/ngfZDpOZcau/40oXzHnHQEvYW7gk1ZfSYC2iGgstNw
 lRyp/qy+um6Q==
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="476636607"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 01:23:09 -0700
Date:   Mon, 31 Aug 2020 16:23:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Mel Gorman <mgorman@suse.com>
Cc:     Borislav Petkov <bp@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200831082306.GA61340@shbuild999.sh.intel.com>
References: <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
 <20200825062305.GA83850@shbuild999.sh.intel.com>
 <20200828174839.GD19448@zn.tnic>
 <20200831021638.GB65971@shbuild999.sh.intel.com>
 <20200831075611.GA2976@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831075611.GA2976@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 08:56:11AM +0100, Mel Gorman wrote:
> On Mon, Aug 31, 2020 at 10:16:38AM +0800, Feng Tang wrote:
> > > So why don't you define both variables with DEFINE_PER_CPU_ALIGNED and
> > > check if all your bad measurements go away this way?
> > 
> > For 'arch_freq_scale', there are other percpu variables in the same
> > smpboot.c: 'arch_prev_aperf' and 'arch_prev_mperf', and in hot path
> > arch_scale_freq_tick(), these 3 variables are all accessed, so I didn't 
> > touch it. Or maybe we can align the first of these 3 variables, so
> > that they sit in one cacheline.
> > 
> > > You'd also need to check whether there's no detrimental effect from
> > > this change on other, i.e., !KNL platforms, and I think there won't
> > > be because both variables will be in separate cachelines then and all
> > > should be good.
> > 
> > Yes, these kind of changes should be verified on other platforms.
> > 
> > One thing still puzzles me, that the 2 variables are per-cpu things, and
> > there is no case of many CPU contending, why the cacheline layout matters?
> > I doubt it is due to the contention of the same cache set, and am trying
> > to find some way to test it.
> > 
> 
> Because if you have two structures that are per-cpu and not cache-aligned
> then a write in one can bounce the cache line in another due to
> cache coherency protocol. It's generally called "false cache line
> sharing". https://en.wikipedia.org/wiki/False_sharing has basic examples
> (lets not get into whether wikipedia is a valid citation source, there
> are books on the topic if someone really cared).

For 'arch_freq_scale' and 'tsc_adjust' percpu variable, they are only
accessed by their own CPU, and usually no other CPU will touch them, the
hot node path only use this_cpu_read/write/ptr. And each CPU's static
percpu variables are all packed together in one area (256KB for one CPU on
this test box), so I don't think there is multiple CPUs accessing one cache
line scenario, which is easy to trigger false sharing.

Also our different test shows the test score is higher if 'arch_freq_scale'
and 'tsc_adjust' are in 2 separate cachelines.


> While it's in my imagination, this should happen with the page allocator
> pcpu structures because the core structure is 1.5 cache lines on 64-bit
> currently and not aligned.  That means that not only can two CPUs interfere
> with each others lists and counters but that could happen cross-node.
> 
> The hypothesis can be tested with perf looking for abnormal cache
> misses. In this case, an intense allocating process bound to one CPU
> with intermittent allocations on the adjacent CPU should show unexpected
> cache line bounces. It would not be perfect as collisions would happen
> anyway when the pcpu lists spill over on either the alloc or free side
> to the the buddy lists but in that case, the cache misses would happen
> on different instructions.
> 
> -- 
> Mel Gorman
> SUSE Labs

Thanks,
Feng
