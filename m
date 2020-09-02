Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D108C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3D82087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Y6ENj5C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIBHJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:09:15 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:15127 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:09:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599030552; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=qiCu81vvcn85lLQWOSgkk1EoFt3FKXqb9z97zN9AnKQ=; b=Y6ENj5C+ka3ca2x+D6b5OItIXAHTTRxBC2AW/5Z91uAmr8r7o/bKTxxoUZ1/zYPUeWDxB5vM
 QHQf7hiGSaGyNEi6+5Rj7VAeG3AdO/mSHNoimGYUu+wKJN4lUwwcdC5mMXxovopsIFmE8SO2
 uvAzO1n3xfU3sGZjzNdUZDelnHk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f4f4517be06707b34cb0301 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 07:09:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFB60C433A1; Wed,  2 Sep 2020 07:09:11 +0000 (UTC)
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DED3EC433C6;
        Wed,  2 Sep 2020 07:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DED3EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 2 Sep 2020 12:38:57 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: Re: [RFC PATCH v7 12/23] sched: Trivial forced-newidle balancer
Message-ID: <20200902070857.GC32426@codeaurora.org>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <fc1dd96eb3dcb71025abf85ceb05fb0f9397ffee.1598643276.git.jdesfossez@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1dd96eb3dcb71025abf85ceb05fb0f9397ffee.1598643276.git.jdesfossez@digitalocean.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:51:13PM -0400, Julien Desfossez wrote:
>  /*
>   * The static-key + stop-machine variable are needed such that:
>   *
> @@ -4641,7 +4656,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	struct task_struct *next, *max = NULL;
>  	const struct sched_class *class;
>  	const struct cpumask *smt_mask;
> -	int i, j, cpu;
> +	int i, j, cpu, occ = 0;
>  	int smt_weight;
>  	bool need_sync;
>  
> @@ -4750,6 +4765,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  				goto done;
>  			}
>  
> +			if (!is_idle_task(p))
> +				occ++;
> +
>  			rq_i->core_pick = p;
>  
>  			/*
> @@ -4775,6 +4793,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  						cpu_rq(j)->core_pick = NULL;
>  					}
> +					occ = 1;
>  					goto again;
>  				} else {
>  					/*
> @@ -4820,6 +4839,8 @@ next_class:;
>  		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
>  			rq_i->core_forceidle = true;
>  
> +		rq_i->core_pick->core_occupation = occ;
> +
>  		if (i == cpu)
>  			continue;
>  
> @@ -4837,6 +4858,113 @@ next_class:;
>  	return next;
>  }
>  
> +static bool try_steal_cookie(int this, int that)
> +{
> +	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
> +	struct task_struct *p;
> +	unsigned long cookie;
> +	bool success = false;
> +
> +	local_irq_disable();
> +	double_rq_lock(dst, src);
> +
> +	cookie = dst->core->core_cookie;
> +	if (!cookie)
> +		goto unlock;
> +
> +	if (dst->curr != dst->idle)
> +		goto unlock;
> +
> +	p = sched_core_find(src, cookie);
> +	if (p == src->idle)
> +		goto unlock;
> +
> +	do {
> +		if (p == src->core_pick || p == src->curr)
> +			goto next;
> +
> +		if (!cpumask_test_cpu(this, &p->cpus_mask))
> +			goto next;
> +
> +		if (p->core_occupation > dst->idle->core_occupation)
> +			goto next;
> +
Can you please explain the rationale behind this check? If I understand
correctly, p->core_occupation is set in pick_next_task() to indicate
the number of matching cookie (except idle) tasks picked on this core.
It is not reset anywhere.

> +		p->on_rq = TASK_ON_RQ_MIGRATING;
> +		deactivate_task(src, p, 0);
> +		set_task_cpu(p, this);
> +		activate_task(dst, p, 0);
> +		p->on_rq = TASK_ON_RQ_QUEUED;
> +
> +		resched_curr(dst);
> +
> +		success = true;
> +		break;
> +
> +next:
> +		p = sched_core_next(p, cookie);
> +	} while (p);
> +
> +unlock:
> +	double_rq_unlock(dst, src);
> +	local_irq_enable();
> +
> +	return success;
> +}

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

