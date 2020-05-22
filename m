Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F71C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887D820723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc3jCj4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgEVO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:57:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbgEVO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590159442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kROCnYv6LREfrKUdHHTtWyBXmahp7MvO2JxokBV6UXk=;
        b=Hc3jCj4wTbu1FwPRipGAAlrMnGbAY4nLVG48igpqbX8KCOd79m8tDZLeaPoxrbX2og+L2m
        A+Ah19i5ytmG/02flgHW2OZXNlQBDZv+fOu16ZFKEszLBEziL7kzxTMXceH0q3GssNoO8v
        nHLml7uX4jQ+Wa6z14ebNVNIcS9NGS0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-tsHMKgf-PFCaJLYB0sag-g-1; Fri, 22 May 2020 10:57:21 -0400
X-MC-Unique: tsHMKgf-PFCaJLYB0sag-g-1
Received: by mail-wr1-f71.google.com with SMTP id f4so1795886wrp.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kROCnYv6LREfrKUdHHTtWyBXmahp7MvO2JxokBV6UXk=;
        b=Hcki5YMq2x4zLZX/43eFqce5AlomjHwqxb4wQNStW5izLPr0oLUGfE6MWVJ3C+PZcm
         u0fsrnyAXyWwuBUIP5O7PVU+cPWVnWLYfxOmcM+swB2vPbtSn4OxLXmuXoLPgsf/TpFA
         L/pt9Iq9poH1FbKhMLBIdHG/M7O1T8RUC3L+cAEKQi7vc63yqcigIEk2E7WRpj3ZNwFw
         BjfpOju3LYDEbiyiGx7cJ72Q2zUZJUQXrCwNt5UQnH3uhgS8KbWGstok1e+aqLHZLxRT
         VRj+TX4vodL1+TP6lZ363x9/j7p/pOXWTsyNzatuQIM3R9az1SRQL//VmlvuB/eJ1puQ
         jgOA==
X-Gm-Message-State: AOAM532gx5glDn63j5W5zta/TMQzvWm/uQFRv+CjpoGbb5pDUcmY/NJX
        Egcu1AUWcx4mMlUE5LWwcQs+yOMlVo2TV+4sJv3JzDRIU6gkyCKmWVMIvbQFU3tIienUewT6iqX
        oZ8pfnQ81Tbm+toOswyA7W46P
X-Received: by 2002:a1c:6708:: with SMTP id b8mr3236913wmc.40.1590159439905;
        Fri, 22 May 2020 07:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHV/KbvZIVp0wKxEP+jtMVSN5LGOn/ZT4mrduYmtIcDmFom+oOmj2t8rPOGT4FQowl10Lefg==
X-Received: by 2002:a1c:6708:: with SMTP id b8mr3236882wmc.40.1590159439650;
        Fri, 22 May 2020 07:57:19 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id x6sm9582516wrv.57.2020.05.22.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:57:19 -0700 (PDT)
Date:   Fri, 22 May 2020 16:57:16 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] sched/deadline: Optimize dl_bw_cpus()
Message-ID: <20200522145716.GB600689@localhost.localdomain>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
 <20200520134243.19352-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134243.19352-2-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 15:42, Dietmar Eggemann wrote:
> Return the weight of the root domain (rd) span in case it is a subset
> of the cpu_active_mask.
> 
> Continue to compute the number of CPUs over rd span and cpu_active_mask
> when in hotplug.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 504d2f51b0d6..4ae22bfc37ae 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -54,10 +54,16 @@ static inline struct dl_bw *dl_bw_of(int i)
>  static inline int dl_bw_cpus(int i)
>  {
>  	struct root_domain *rd = cpu_rq(i)->rd;
> -	int cpus = 0;
> +	int cpus;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
>  			 "sched RCU must be held");
> +
> +	if (cpumask_subset(rd->span, cpu_active_mask))
> +		return cpumask_weight(rd->span);
> +
> +	cpus = 0;
> +
>  	for_each_cpu_and(i, rd->span, cpu_active_mask)
>  		cpus++;
>  
> -- 

Acked-by: Juri Lelli <juri.lelli@redhat.com>

