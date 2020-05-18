Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F23C20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgERGu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:50:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:3552 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERGu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:50:56 -0400
IronPort-SDR: 1VzzeX53a97xqJ/0HvWkE1I/uDGJ1ZgcorukdYT+FfLpvCVriZ15Q4KOFcuCN7Mf+OfNQFjnhr
 USzs/4g90j2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 23:50:55 -0700
IronPort-SDR: oyhTQGkBJFfmfrsnh7FlhTR9PUcv3yxyDrgk17h7fYIH7QDtkXGb2i0scy4gVGNH5gQQK2aDoo
 /TOYIns6o80g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="373291247"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2020 23:50:51 -0700
Date:   Mon, 18 May 2020 15:00:46 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        OTC LSE PnP <otc.lse.pnp@intel.com>, lkp@lists.01.org
Subject: Re: [sched/fair] 0b0695f2b3:
 phoronix-test-suite.compress-gzip.0.seconds 19.8% regression
Message-ID: <20200518070046.GA23559@xsang-OptiPlex-9020>
References: <20200514141526.GA30976@xsang-OptiPlex-9020>
 <CAKfTPtB3jQWd52FTyKNk5w8mmoDnu+jwYgkFBOiOKjb_BjxqTw@mail.gmail.com>
 <20200515141226.17700-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515141226.17700-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:12:26PM +0800, Hillf Danton wrote:
> 
> On Fri, 15 May 2020 09:43:39 +0800 Oliver Sang wrote:
> > On Thu, May 14, 2020 at 07:09:35PM +0200, Vincent Guittot wrote:
> > > Hi Oliver,
> > > 
> > > On Thu, 14 May 2020 at 16:05, kernel test robot <oliver.sang@intel.com> wrote:
> > > >
> > > > Hi Vincent Guittot,
> > > >
> > > > Below report FYI.
> > > > Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
> > > > vm-scalability.median 3.1% improvement" on link [1].
> > > > but now we found the regression on pts.compress-gzip.
> > > > This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
> > > > load balance" (link [2]), where showed the reworked load balance could have
> > > > both positive and negative effect for different test suites.
> > > 
> > > We have tried to run  all possible use cases but it's impossible to
> > > covers all so there were a possibility that one that is not covered,
> > > would regressed.
> > > 
> > > > And also from link [3], the patch set risks regressions.
> > > >
> > > > We also confirmed this regression on another platform
> > > > (Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
> > > > below is the data (lower is better).
> > > > v5.4    4.1
> > > > fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
> > > > 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
> > > > v5.5    5.18
> > > > v5.6    4.62
> > > > v5.7-rc2    4.53
> > > > v5.7-rc3    4.59
> > > >
> > > > It seems there are some recovery on latest kernels, but not fully back.
> 
> Hi
> 
> Here is a tiny diff for growing balance in the over loaded case. Wish it's
> likely going to help you spot the factors behind the regression.

Thanks Hillf!
just wondering what's the target release of below patch?

> 
> Hillf
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8683,15 +8683,12 @@ find_idlest_group(struct sched_domain *s
>  	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>  	struct sg_lb_stats local_sgs, tmp_sgs;
>  	struct sg_lb_stats *sgs;
> -	unsigned long imbalance;
> +	unsigned long hal, lal;
>  	struct sg_lb_stats idlest_sgs = {
>  			.avg_load = UINT_MAX,
>  			.group_type = group_overloaded,
>  	};
>  
> -	imbalance = scale_load_down(NICE_0_LOAD) *
> -				(sd->imbalance_pct-100) / 100;
> -
>  	do {
>  		int local_group;
>  
> @@ -8744,31 +8741,26 @@ find_idlest_group(struct sched_domain *s
>  
>  	switch (local_sgs.group_type) {
>  	case group_overloaded:
> -	case group_fully_busy:
> -		/*
> -		 * When comparing groups across NUMA domains, it's possible for
> -		 * the local domain to be very lightly loaded relative to the
> -		 * remote domains but "imbalance" skews the comparison making
> -		 * remote CPUs look much more favourable. When considering
> -		 * cross-domain, add imbalance to the load on the remote node
> -		 * and consider staying local.
> -		 */
> -
> -		if ((sd->flags & SD_NUMA) &&
> -		    ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
> -			return NULL;
> +		if (idlest_sgs.avg_load < local_sgs.avg_load) {
> +			hal = local_sgs.avg_load;
> +			lal = idlest_sgs.avg_load;
> +		} else {
> +			lal = local_sgs.avg_load;  /*  low avg load */
> +			hal = idlest_sgs.avg_load; /* high avg load */
> +		}
>  
> -		/*
> -		 * If the local group is less loaded than the selected
> -		 * idlest group don't try and push any tasks.
> -		 */
> -		if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
> +		/* No push if groups are balanced in terms of load */
> +		if (100 * hal <= sd->imbalance_pct * lal)
>  			return NULL;
>  
> -		if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
> +		/* No push if it only grows imbalance */
> +		if (hal == idlest_sgs.avg_load)
>  			return NULL;
>  		break;
>  
> +	case group_fully_busy:
> +		/* No push because groups are unusually balanced */
> +		return NULL;
>  	case group_imbalanced:
>  	case group_asym_packing:
>  		/* Those type are not used in the slow wakeup path */
> --
> 
> > > > We were just wondering whether you could share some lights the further works
> > > > on the load balance after patch set [2] which could cause the performance
> > > > change?
> > > > And whether you have plan to refine the load balance algorithm further?
> > > 
> > > I'm going to have a look at your regression to understand what is
> > > going wrong and how it can be fixed
> > 
> > Thanks a lot!
> > 
> > > 
> > > Thanks
> > > Vincent
> > > 
> > 
> 
