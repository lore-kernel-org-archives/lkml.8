Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FABAC35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 00:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B542071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 00:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAZAZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 19:25:22 -0500
Received: from foss.arm.com ([217.140.110.172]:33684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgAZAZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 19:25:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E40F328;
        Sat, 25 Jan 2020 16:25:21 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A58333F68E;
        Sat, 25 Jan 2020 16:25:19 -0800 (PST)
Date:   Sun, 26 Jan 2020 00:25:17 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Wei Wang <wvw@google.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        Wei Wang <wei.vince.wang@gmail.com>, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
Message-ID: <20200126002515.gjpiiur565muruas@e107158-lin.cambridge.arm.com>
References: <20200124002811.228334-1-wvw@google.com>
 <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com>
 <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
 <20200124113050.i6ovkibcmutypm3q@e107158-lin>
 <CAGXk5yrTc2-k5oDjGyAwYn2KTroQy0JtEYQzSeOizjg_hyMGkg@mail.gmail.com>
 <20200125235934.wrs2nryuk3wmtkxr@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125235934.wrs2nryuk3wmtkxr@e107158-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/20 23:59, Qais Yousef wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 9b8916fd00a2..a76c02eecdaf 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -421,7 +421,8 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>          * into the same scale so we can compare.
>          */
>         boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> -       return max(boost, util);
> +       boost = max(boost, util);
> +       return uclamp_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
>  }
> 
>  #ifdef CONFIG_NO_HZ_COMMON

Forgot to mention this will work if the background task is the only task
running on this CPU. Like Quentin already pointed out, the iowait_boost might
need more massaging to allow finer per task control.

--
Qais Yousef
