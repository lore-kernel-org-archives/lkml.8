Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2A420708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E52FG35o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbgAXM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:59:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36486 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbgAXM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 07:59:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so1634897wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SX6pF2MqSkPo4+6BXXVN1ZKKWknrqPrgEhzCKmi/Y7Y=;
        b=E52FG35osGpByI8vWBvj9cyKwceZaiMZ3oE7UaUcMcLcCuRH7oGcWgffJcFB0/U4YX
         MUBi2HiZkQU74y01qFsvqoDRLy0+yW1PDtQu1UmLW+iIIC1WWQvVLc8qSehTTeDLwri9
         B01I4sqk1ZaYSDCszX2fhgYcyGPUPl5/U3bFLkqgwGliLCrCrT9CUg0dumJc+e0Bj/67
         ra7WmsfVj1ro7myhzKaaS+Bw+dv8XHOCeo4kg868xBA06O7fp4S+dPa3gfOALiU8Qe7b
         JKUW2W/u4k5Lh5cmlWs6tWUhv4cyjmJ3SnB+TfvnMpscY9JlD6zCQom4ngnvvGB8OWTM
         oouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SX6pF2MqSkPo4+6BXXVN1ZKKWknrqPrgEhzCKmi/Y7Y=;
        b=ChdQJnK8fq8kvkJY91CJJUjGMv0bXwcpD9axe6WZD6qxnjdEc78eqfV/V1r85APaZA
         3uNNKBjQgDW7LJ9yd0nJMtEMAIfTqF/+OIIY3ISq6Aa+V2b4eGixYsnoNGIY6lG6Oq3H
         JG4y1tp5k5rE0YIL98jEzffcMqlqrmIL+6bHB2GA0w7Lm72ufxj7fzXmlGhvHMJ5SN5Y
         xTLT+BXN+y5fVpckK3V+MTY2LbdatQvzGMTDsRG0PMZER6TeusBofGF7LL8525Q5mItl
         P4UhJEpVxVSxC/2ETTwn+DjdtFQg1gnUTok3HNDxbiOqHuh1mqD96JsGLLtjnlxJhmPM
         uzww==
X-Gm-Message-State: APjAAAXlJsb/e6lUCX4kZOubtaGnzSincKDDt4kfZ63roA4sklnVOpxI
        4KwE3hozsthi6k3uoiSIYsnkKA==
X-Google-Smtp-Source: APXvYqzXH8yGTn3Gz57GoQv/Bv7tQBrxRo+xsScrJ+ciDcfmPl2KlG1L7wWEGbFc+I2qHsoFuDLtbw==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr3300590wmc.74.1579870749770;
        Fri, 24 Jan 2020 04:59:09 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id b68sm6811088wme.6.2020.01.24.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 04:59:09 -0800 (PST)
Date:   Fri, 24 Jan 2020 12:59:05 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org
Subject: Re: [PATCH 1/3] sched/fair: Add asymmetric CPU capacity wakeup scan
Message-ID: <20200124125905.GA173888@google.com>
References: <20200124124255.1095-1-valentin.schneider@arm.com>
 <20200124124255.1095-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124124255.1095-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Valentin,

On Friday 24 Jan 2020 at 12:42:53 (+0000), Valentin Schneider wrote:
> +/*
> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
> + * the task fits.
> + */
> +static int select_idle_capacity(struct task_struct *p, int target)
> +{
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	struct sched_domain *sd;
> +	int cpu;
> +
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +		return -1;
> +
> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> +	if (!sd)
> +		return -1;
> +

You might want 'sync_entity_load_avg(&p->se)' here no ?
find_idlest_cpu() and wake_cap() need one, but since we're going to use
them, you'll want to sync here too I think.


> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
> +		if (!available_idle_cpu(cpu))
> +			continue;
> +		if (!task_fits_capacity(p, capacity_of(cpu)))
> +			continue;
> +
> +		return cpu;
> +	}

If we found an idle CPU, but not one big enough, should we still go
ahead and choose it ? Misfit / idle balance will fix that later when a
big CPU does become available.

> +
> +	return -1;
> +}
> +

Thanks,
Quentin
