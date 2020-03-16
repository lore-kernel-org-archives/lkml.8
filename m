Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25533C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C2120663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgCPGdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:33:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:32883 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729407AbgCPGdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:33:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TshR7Hp_1584340410;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TshR7Hp_1584340410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Mar 2020 14:33:31 +0800
Subject: Re: [PATCH] sched: avoid scale real weight down to zero
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <bb14528b-08c3-c4c0-5bcf-4bec1d75227a@linux.alibaba.com>
Message-ID: <b9f775cf-f26a-c76b-681c-126783270ad3@linux.alibaba.com>
Date:   Mon, 16 Mar 2020 14:33:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <bb14528b-08c3-c4c0-5bcf-4bec1d75227a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter

I've done more complicated testing with share 2 and every thing looks fine.

Should we apply this? or is there any concern?

Regards,
Michael Wang

On 2020/3/5 上午10:57, 王贇 wrote:
> During our testing, we found a case that shares no longer
> working correctly, the cgroup topology is like:
> 
>   /sys/fs/cgroup/cpu/A		(shares=102400)
>   /sys/fs/cgroup/cpu/A/B	(shares=2)
>   /sys/fs/cgroup/cpu/A/B/C	(shares=1024)
> 
>   /sys/fs/cgroup/cpu/D		(shares=1024)
>   /sys/fs/cgroup/cpu/D/E	(shares=1024)
>   /sys/fs/cgroup/cpu/D/E/F	(shares=1024)
> 
> The same benchmark is running in group C & F, no other tasks are
> running, the benchmark is capable to consumed all the CPUs.
> 
> We suppose the group C will win more CPU resources since it could
> enjoy all the shares of group A, but it's F who wins much more.
> 
> The reason is because we have group B with shares as 2, since
> A->cfs_rq.load.weight == B->se.load.weight == B->shares/nr_cpus,
> so A->cfs_rq.load.weight become very small.
> 
> And in calc_group_shares() we calculate shares as:
> 
>   load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>   shares = (tg_shares * load) / tg_weight;
> 
> Since the 'cfs_rq->load.weight' is too small, the load become 0
> after scale down, although 'tg_shares' is 102400, shares of the se
> which stand for group A on root cfs_rq become 2.
> 
> While the se of D on root cfs_rq is far more bigger than 2, so it
> wins the battle.
> 
> Thus when scale_load_down() scale real weight down to 0, it's no
> longer telling the real story, the caller will have the wrong
> information and the calculation will be buggy.
> 
> This patch add check in scale_load_down(), so the real weight will
> be >= MIN_SHARES after scale, after applied the group C wins as
> expected.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  kernel/sched/sched.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2a0caf394dd4..75c283f22256 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -118,7 +118,13 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
>  #ifdef CONFIG_64BIT
>  # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOINT_SHIFT)
>  # define scale_load(w)		((w) << SCHED_FIXEDPOINT_SHIFT)
> -# define scale_load_down(w)	((w) >> SCHED_FIXEDPOINT_SHIFT)
> +# define scale_load_down(w) \
> +({ \
> +	unsigned long __w = (w); \
> +	if (__w) \
> +		__w = max(MIN_SHARES, __w >> SCHED_FIXEDPOINT_SHIFT); \
> +	__w; \
> +})
>  #else
>  # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
>  # define scale_load(w)		(w)
> 
