Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE6C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF4206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHaIzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:55:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgHaIzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:55:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89E3CABC1;
        Mon, 31 Aug 2020 08:55:53 +0000 (UTC)
Date:   Mon, 31 Aug 2020 09:55:17 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200831085516.GE2976@suse.com>
References: <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
 <20200825062305.GA83850@shbuild999.sh.intel.com>
 <20200828174839.GD19448@zn.tnic>
 <20200831021638.GB65971@shbuild999.sh.intel.com>
 <20200831075611.GA2976@suse.com>
 <20200831082306.GA61340@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200831082306.GA61340@shbuild999.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 04:23:06PM +0800, Feng Tang wrote:
> On Mon, Aug 31, 2020 at 08:56:11AM +0100, Mel Gorman wrote:
> > On Mon, Aug 31, 2020 at 10:16:38AM +0800, Feng Tang wrote:
> > > > So why don't you define both variables with DEFINE_PER_CPU_ALIGNED and
> > > > check if all your bad measurements go away this way?
> > > 
> > > For 'arch_freq_scale', there are other percpu variables in the same
> > > smpboot.c: 'arch_prev_aperf' and 'arch_prev_mperf', and in hot path
> > > arch_scale_freq_tick(), these 3 variables are all accessed, so I didn't 
> > > touch it. Or maybe we can align the first of these 3 variables, so
> > > that they sit in one cacheline.
> > > 
> > > > You'd also need to check whether there's no detrimental effect from
> > > > this change on other, i.e., !KNL platforms, and I think there won't
> > > > be because both variables will be in separate cachelines then and all
> > > > should be good.
> > > 
> > > Yes, these kind of changes should be verified on other platforms.
> > > 
> > > One thing still puzzles me, that the 2 variables are per-cpu things, and
> > > there is no case of many CPU contending, why the cacheline layout matters?
> > > I doubt it is due to the contention of the same cache set, and am trying
> > > to find some way to test it.
> > > 
> > 
> > Because if you have two structures that are per-cpu and not cache-aligned
> > then a write in one can bounce the cache line in another due to
> > cache coherency protocol. It's generally called "false cache line
> > sharing". https://en.wikipedia.org/wiki/False_sharing has basic examples
> > (lets not get into whether wikipedia is a valid citation source, there
> > are books on the topic if someone really cared).
> 
> For 'arch_freq_scale' and 'tsc_adjust' percpu variable, they are only
> accessed by their own CPU, and usually no other CPU will touch them,

Read "false sharing again". Two adjacent per-CPU structures can still
interfere with each other if the structures happen to cross a cache line
boundary and are not cache aligned.

> the
> hot node path only use this_cpu_read/write/ptr. And each CPU's static
> percpu variables are all packed together in one area (256KB for one CPU on
> this test box),

If the structure is not cache aligned (probably 64KB) then there is a
boundary when cache line bounces can occur.

-- 
Mel Gorman
SUSE Labs
