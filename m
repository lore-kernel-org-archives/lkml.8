Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E13204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8dNKvhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgFOIKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:10:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BEBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:10:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y20so13810361wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4lsR+KdrM+rAuWZB0sfjwWn68IrQ4qd+3+1WwICdD5g=;
        b=S8dNKvhZ9lZj8/ICeDisKckf+KrtVzwxPvqN6LhknEEZEWcOKBQlgLfDQ9XQDxHzRR
         mJm+1cWZVmKmvPKJV4KLOo7nugHhto5x9HgTfknGjVmQMQq/sp5uYc9/dciZpO9b/lRk
         3ft/KhXvXC0ucMR8c0VhjgmQ9DSLxz4OnWAA/LTpxOlv3G2LA0QdJ+Y+NZlOMvqKxXEx
         qjxkG3uz+CWupRLgv01qFAznFomr9vZoX46SNZ89a4lxdEfhRcWGsv1xEfkC5G8dP/9L
         w+2a1R0VgwkRjcue4MZqWjTDWv6NfU8rdjK2VbY+P2SIEcA79QBX8msFqEjiu30a252R
         hyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4lsR+KdrM+rAuWZB0sfjwWn68IrQ4qd+3+1WwICdD5g=;
        b=qRZskvypKOXGmISjkcopz6CWFF4fs7VlrmX+sbrDB23ouEvKcZrKL5otB2hl93xUcZ
         mqXjCD0sUqYurznV1hWdmWctiO0nxrBEd2II/3NADhpGjhqU4F2Uxi8KFOObiIiSx4eu
         hSz9S9nSr4KgmD4cbo8zlHKeB75dD/Quz1MMjtgftFfaUxV+hu+IUjvCQNJWW66Io4aD
         BbYHuZjNaOIn8DiMa2Hv+HQYgd6hRiPgZrOpfXhAHb3uSz8cirtIbQufGLCJqMBvSSiu
         antDWA4nCFQHM1kUfrC4c2Aadc5VxoYLo74xJyY1RbaQJcHD8sLcSAJPMN36jDBu509l
         4NGQ==
X-Gm-Message-State: AOAM532C3q3k76HYhuJ3HSE81RNTdMWRcECYOFAK/2oLfv/kaRFgJ7uL
        W0bvR403Ep92vxLlKh+5Q82miw==
X-Google-Smtp-Source: ABdhPJxC6XoA/2NifBJa9/15MkQSgdgsOrw4/DVct371sAQIw/0V1HSDqkbAK1RhDNfLJac9JYwklw==
X-Received: by 2002:a1c:9c49:: with SMTP id f70mr11515376wme.74.1592208644560;
        Mon, 15 Jun 2020 01:10:44 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:7c8d:f422:4266:5958])
        by smtp.gmail.com with ESMTPSA id a3sm20920944wmb.7.2020.06.15.01.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 01:10:43 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:10:41 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
Message-ID: <20200615081041.GA16990@vingu-book>
References: <20200319023819.GO11705@shao2-debian>
 <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xing,

Le lundi 15 juin 2020 à 15:26:59 (+0800), Xing Zhengjun a écrit :
> 
> 
> On 6/12/2020 7:06 PM, Hillf Danton wrote:
> > 
> > On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:

...

> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8215,12 +8215,8 @@ group_has_capacity(unsigned int imbalanc
> >   	if (sgs->sum_nr_running < sgs->group_weight)
> >   		return true;
> > -	if ((sgs->group_capacity * imbalance_pct) <
> > -			(sgs->group_runnable * 100))
> > -		return false;
> > -
> > -	if ((sgs->group_capacity * 100) >
> > -			(sgs->group_util * imbalance_pct))
> > +	if ((sgs->group_capacity * 100) > (sgs->group_util * imbalance_pct) &&
> > +	    (sgs->group_capacity * 100) > (sgs->group_runnable * imbalance_pct))
> >   		return true;
> >   	return false;
> > @@ -8240,12 +8236,8 @@ group_is_overloaded(unsigned int imbalan
> >   	if (sgs->sum_nr_running <= sgs->group_weight)
> >   		return false;
> > -	if ((sgs->group_capacity * 100) <
> > -			(sgs->group_util * imbalance_pct))
> > -		return true;
> > -
> > -	if ((sgs->group_capacity * imbalance_pct) <
> > -			(sgs->group_runnable * 100))
> > +	if ((sgs->group_capacity * 100) < (sgs->group_util * imbalance_pct) ||
> > +	    (sgs->group_capacity * 100) < (sgs->group_runnable * imbalance_pct))
> >   		return true;
> >   	return false;
> > 
> 
> I apply the patch based on v5.7, the regression still existed.

Thanks for the test. I don't know if it's relevant or not but the results seem a bit
better with the patch and I'd like to check that it's only a matter of threshold to
fix the problem.

Could you try the patch below which is quite aggressive but will help to confirm this ?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28be1c984a42..3c51d557547b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8322,10 +8322,13 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
+       unsigned long imb;
+
        if (sgs->sum_nr_running < sgs->group_weight)
                return true;

-       if ((sgs->group_capacity * imbalance_pct) <
+       imb = sgs->sum_nr_running * 100;
+       if ((sgs->group_capacity * imb) <
                        (sgs->group_runnable * 100))
                return false;

@@ -8347,6 +8350,8 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
+       unsigned long imb;
+
        if (sgs->sum_nr_running <= sgs->group_weight)
                return false;

@@ -8354,7 +8359,8 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
                        (sgs->group_util * imbalance_pct))
                return true;

-       if ((sgs->group_capacity * imbalance_pct) <
+       imb = sgs->sum_nr_running * 100;
+       if ((sgs->group_capacity * imb) <
                        (sgs->group_runnable * 100))
                return true;


> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
> 
> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
> 
> commit:
>   9f68395333ad7f5bfe2f83473fed363d4229f11c
>   070f5e860ee2bf588c99ef7b4c202451faa48236
>   v5.7
>   6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)
> 
> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
> 6b33257768b8dd3982054885ea3
> ---------------- --------------------------- ---------------------------
> ---------------------------
>          %stddev     %change         %stddev     %change %stddev     %change
> %stddev
>              \          |                \          |                \
> |                \
>       0.69           -10.3%       0.62            -9.1%       0.62
> -10.1%       0.62        reaim.child_systime
>       0.62            -1.0%       0.61            +0.5%       0.62
> +0.3%       0.62        reaim.child_utime
>      66870           -10.0%      60187            -7.6%      61787
> -8.3%      61305        reaim.jobs_per_min
>      16717           -10.0%      15046            -7.6%      15446
> -8.3%      15326        reaim.jobs_per_min_child
>      97.84            -1.1%      96.75            -0.4%      97.43
> -0.5%      97.37        reaim.jti
>      72000           -10.8%      64216            -8.3%      66000
> -8.3%      66000        reaim.max_jobs_per_min
>       0.36           +10.6%       0.40            +7.8%       0.39
> +9.4%       0.39        reaim.parent_time
>       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
> +33.2%       2.11        reaim.std_dev_percent
>       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
> +65.3%       0.01 ±  3%  reaim.std_dev_time
>      50800            -2.4%      49600            -1.6%      50000
> -1.8%      49866        reaim.workload
> 
> 
> 
> -- 
> Zhengjun Xing
