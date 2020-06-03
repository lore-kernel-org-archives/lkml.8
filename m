Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A751206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCPvM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:51:12 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14419 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgFCPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:51:12 -0400
Subject: Re: [tip: core/rcu] rcu/tree: Add a shrinker to prevent OOM due to
 kfree_rcu() batching
To:     <linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>
CC:     <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>
References: <158923077980.390.281247872169365012.tip-bot2@tip-bot2>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <49168aa9-4f3a-e602-edd4-98e8b0138b0b@sony.com>
Date:   Wed, 3 Jun 2020 17:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <158923077980.390.281247872169365012.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VdGJw2h9 c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=nTHF0DUjJn0A:10 a=VwQbUJbxAAAA:8 a=qqdB56dbAAAA:8 a=pGLkceISAAAA:8 a=sI8eI_dASrvGnoftpIIA:9 a=jr1gfDpAJBc7VHt3:21 a=mf2Kd_Fz0wj1fc-T:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ccaIO3UgQCpleZvgly2v:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 10:59 PM, tip-bot2 for Joel Fernandes (Google) wrote:
> The following commit has been merged into the core/rcu branch of tip:
>
> Commit-ID:     9154244c1ab6c9db4f1f25ac8f73bd46dba64287
> Gitweb:        https://git.kernel.org/tip/9154244c1ab6c9db4f1f25ac8f73bd46dba64287
> Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
> AuthorDate:    Mon, 16 Mar 2020 12:32:27 -04:00
> Committer:     Paul E. McKenney <paulmck@kernel.org>
> CommitterDate: Mon, 27 Apr 2020 11:02:50 -07:00
>
> rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching
>
> To reduce grace periods and improve kfree() performance, we have done
> batching recently dramatically bringing down the number of grace periods
> while giving us the ability to use kfree_bulk() for efficient kfree'ing.
>
> However, this has increased the likelihood of OOM condition under heavy
> kfree_rcu() flood on small memory systems. This patch introduces a
> shrinker which starts grace periods right away if the system is under
> memory pressure due to existence of objects that have still not started
> a grace period.
>
> With this patch, I do not observe an OOM anymore on a system with 512MB
> RAM and 8 CPUs, with the following rcuperf options:
>
> rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000
> rcuperf.kfree_rcu_test=1 rcuperf.kfree_mult=2
>
> Otherwise it easily OOMs with the above parameters.
>
> NOTE:
> 1. On systems with no memory pressure, the patch has no effect as intended.
> 2. In the future, we can use this same mechanism to prevent grace periods
>    from happening even more, by relying on shrinkers carefully.
>
> Cc: urezki@gmail.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 156ac8d..e299cd0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2824,6 +2824,8 @@ struct kfree_rcu_cpu {
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
>  	bool initialized;
> +	// Number of objects for which GP not started
> +	int count;


Isn't it better with a atomic counter to avoid the irq handling  in shrink_count?


>  };
>  
>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> @@ -2937,6 +2939,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  				krcp->head = NULL;
>  			}
>  
> +			krcp->count = 0;
> +
>  			/*
>  			 * One work is per one batch, so there are two "free channels",
>  			 * "bhead_free" and "head_free" the batch can handle. It can be
> @@ -3073,6 +3077,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		krcp->head = head;
>  	}
>  
> +	krcp->count++;
> +
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  	    !krcp->monitor_todo) {
> @@ -3087,6 +3093,58 @@ unlock_return:
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
>  
> +static unsigned long
> +kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +	int cpu;
> +	unsigned long flags, count = 0;
> +
> +	/* Snapshot count of all CPUs */
> +	for_each_online_cpu(cpu) {
> +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +
> +		spin_lock_irqsave(&krcp->lock, flags);
> +		count += krcp->count;
> +		spin_unlock_irqrestore(&krcp->lock, flags);
> +	}
> +
> +	return count;
> +}
> +
> +static unsigned long
> +kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +	int cpu, freed = 0;
> +	unsigned long flags;
> +
> +	for_each_online_cpu(cpu) {
> +		int count;
> +		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> +
> +		count = krcp->count;

inside the lock held


> +		spin_lock_irqsave(&krcp->lock, flags);
> +		if (krcp->monitor_todo)
> +			kfree_rcu_drain_unlock(krcp, flags);
> +		else
> +			spin_unlock_irqrestore(&krcp->lock, flags);
> +
> +		sc->nr_to_scan -= count;
> +		freed += count;
> +
> +		if (sc->nr_to_scan <= 0)
> +			break;
> +	}
> +
> +	return freed;
> +}
> +
> +static struct shrinker kfree_rcu_shrinker = {
> +	.count_objects = kfree_rcu_shrink_count,
> +	.scan_objects = kfree_rcu_shrink_scan,
> +	.batch = 0,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>  void __init kfree_rcu_scheduler_running(void)
>  {
>  	int cpu;
> @@ -4007,6 +4065,8 @@ static void __init kfree_rcu_batch_init(void)
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  		krcp->initialized = true;
>  	}
> +	if (register_shrinker(&kfree_rcu_shrinker))
> +		pr_err("Failed to register kfree_rcu() shrinker!\n");
>  }
>  
>  void __init rcu_init(void)


