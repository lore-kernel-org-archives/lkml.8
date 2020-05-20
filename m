Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3842CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B172072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8S5mAZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETSim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:38:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbgETSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589999919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXQ+5epfH0IUohGuzl6yDkV1s9DuksnVQ0R3fsPd6/4=;
        b=K8S5mAZ+MvmWfkr9Paw6WNiuWH4n39LG3leiuh4mNzDSodeschmLFIuPahKnAXsfJ6BQP6
        IJGuvEFDZHvsleWyR1KQJkomOJ71aACI9UMlfjlSVD68Ka8Gwp8W8R1EYQT3sjCgblqTQH
        RzSxpZHituhxpe0yqmBEgC6A3IlCl8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Qdzvz2emOOqFvnGIzkmjUQ-1; Wed, 20 May 2020 14:38:37 -0400
X-MC-Unique: Qdzvz2emOOqFvnGIzkmjUQ-1
Received: by mail-wr1-f70.google.com with SMTP id r7so1767429wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXQ+5epfH0IUohGuzl6yDkV1s9DuksnVQ0R3fsPd6/4=;
        b=S+YKhvdeY7EdxImSlWOo171hLdxJQQWTb0LZcBNPorCPevdy7tRWnGg+i4aC52BlDh
         mLHyaH6wnFlyvWdeVEw58u6Ri5AZbe0jVzC4ZZz0iy8NUrYCOG1xBU/LnE8Qjz0TtTY5
         VZBfZm5rq9NEEgJmkndmJc1XH4iWTpmojxkTPd0rE+PE87XJ+rbl2uoLtngpbSCeuvSm
         e9Q21Nf2K0j+IoCpyDjBHgujt2vp3l+4Qd+n5fqmKuUDyLTaC1cCeYtf6suYoxfaHzgZ
         EiPlV1oSpSKogqzm8aAJoh4FLEtrQY2wUum0Ofqjt8KIYHt2o4JVwE9xo8SVjF0KhCYB
         ZfJg==
X-Gm-Message-State: AOAM531XNFF0gEmzJbpnLEaadIzIiBx9Gtq28FtK3H5dZWTJQ/+2AsLW
        ZegWJSN7Z14HUzYRBNR8wPSkUfi36xrfWF6OTX/oLTDweJskV/HUzJawi1zCd3RJbHysGiDbeeQ
        2TE3+JoMiarwgNhb8qHGDy88A
X-Received: by 2002:adf:8b98:: with SMTP id o24mr5386064wra.156.1589999916447;
        Wed, 20 May 2020 11:38:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFocmzJYmKHfClVXT6xi3xafkw9GOIkQ0Dhri2qTWT79BmMj9mhok9inN/J9Oep3mFiITNdA==
X-Received: by 2002:adf:8b98:: with SMTP id o24mr5386028wra.156.1589999915789;
        Wed, 20 May 2020 11:38:35 -0700 (PDT)
Received: from localhost.localdomain ([151.68.137.74])
        by smtp.gmail.com with ESMTPSA id i21sm3888749wml.5.2020.05.20.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:38:35 -0700 (PDT)
Date:   Wed, 20 May 2020 20:38:30 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20200520183830.GN10078@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161357.397880775@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 26/07/19 16:54, Peter Zijlstra wrote:
> 
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched/sysctl.h |    3 +++
>  kernel/sched/deadline.c      |   23 +++++++++++++++++++++--
>  kernel/sysctl.c              |   14 ++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -56,6 +56,9 @@ int sched_proc_update_handler(struct ctl
>  extern unsigned int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>  
> +extern unsigned int sysctl_sched_dl_period_max;
> +extern unsigned int sysctl_sched_dl_period_min;
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  extern unsigned int sysctl_sched_uclamp_util_min;
>  extern unsigned int sysctl_sched_uclamp_util_max;
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2597,6 +2597,14 @@ void __getparam_dl(struct task_struct *p
>  }
>  
>  /*
> + * Default limits for DL period; on the top end we guard against small util
> + * tasks still getting rediculous long effective runtimes, on the bottom end we
> + * guard against timer DoS.
> + */
> +unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
> +unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
> +
> +/*
>   * This function validates the new parameters of a -deadline task.
>   * We ask for the deadline not being zero, and greater or equal
>   * than the runtime, as well as the period of being zero or
> @@ -2608,6 +2616,8 @@ void __getparam_dl(struct task_struct *p
>   */
>  bool __checkparam_dl(const struct sched_attr *attr)
>  {
> +	u64 period, max, min;
> +
>  	/* special dl tasks don't actually use any parameter */
>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
>  		return true;
> @@ -2631,12 +2641,21 @@ bool __checkparam_dl(const struct sched_
>  	    attr->sched_period & (1ULL << 63))
>  		return false;
>  
> +	period = attr->sched_period;
> +	if (!period)
> +		period = attr->sched_deadline;
> +
>  	/* runtime <= deadline <= period (if period != 0) */
> -	if ((attr->sched_period != 0 &&
> -	     attr->sched_period < attr->sched_deadline) ||
> +	if (period < attr->sched_deadline ||
>  	    attr->sched_deadline < attr->sched_runtime)
>  		return false;
>  
> +	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> +	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> +
> +	if (period < min || period > max)
> +		return false;
> +
>  	return true;
>  }
>  
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -443,6 +443,20 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= sched_rt_handler,
>  	},
>  	{
> +		.procname	= "sched_deadline_period_max_us",
> +		.data		= &sysctl_sched_dl_period_max,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "sched_deadline_period_min_us",
> +		.data		= &sysctl_sched_dl_period_min,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
>  		.procname	= "sched_rr_timeslice_ms",
>  		.data		= &sysctl_sched_rr_timeslice,
>  		.maxlen		= sizeof(int),

I think this never made it upstream. And I believe both me and Daniel
were OK with it. Do you recall if any additional change was needed?

Thanks,

Juri

