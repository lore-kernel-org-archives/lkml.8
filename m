Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDFA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V90esOam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405157AbgFYNew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:34:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46860 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404883AbgFYNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593092089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09+fTYNd95SDGGKDwt8BrhJmqNTFAjuqhVxVc40SVsI=;
        b=V90esOam2b9nvpySBF/3qNLfisRtWbXS6bDW9x+yrwljorFyPenMX0hvrX7Lmss8ynAVO9
        fhMI3XX3B+yoizCZ+GXTI/dWXjLHGie09DYgvok89hNxlBLH2n5s1RzSvI6n5BJM7QqOXb
        MMxDNTLfr5nxupKd4o9X+kcVuqAXe7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-EHCLg4BkNXypShWPKAECtw-1; Thu, 25 Jun 2020 09:34:47 -0400
X-MC-Unique: EHCLg4BkNXypShWPKAECtw-1
Received: by mail-wr1-f71.google.com with SMTP id e11so6873371wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09+fTYNd95SDGGKDwt8BrhJmqNTFAjuqhVxVc40SVsI=;
        b=oWjpLZvSOAU7mwIA2GjeRqxGJ9w7T+TcK5OJhyYSzcdmR3Vd8MTpZX18eBZpGbhTUt
         6mciSTYaH8ki2TNhv+JBgYJg1V2TyQkCknDUtyLvu/L6gwBFxJtPqXUSrPGZhVWvCmVn
         hgbEITPDN9WHicDuo7Jh+1rxkVu6PV9yXFGf2AQsUrUAL6lnFz/4tjQdi+fLJi+lu6Qa
         +EiSh0UIpMUYJo/gK+1X1nwmPJ74mmZx8oi0+LcP9OKR2LmcL5z5BU9fAkJZakARETqG
         Ud9e4/ucSxM3YRSK/FFk8/s/SpjKPlC6mURKcPPpSrudyNE7KHKEvgU3EHl/doYPW1e6
         HCfg==
X-Gm-Message-State: AOAM533b43rGYDA6lzw2EqNnezOg28eGCPZeD5keV0/NautKaYKVXmVu
        A4dFtGR5k/0AQQo0rwh51Bi+Dde4j01Hl9FRdXh8wNrwfD/U9Dzbrl9fmcXrqCVnQiPaQBCQixT
        2QVmfHERmHRF8sRkPSw2OahoU
X-Received: by 2002:a5d:4607:: with SMTP id t7mr29457164wrq.251.1593092086511;
        Thu, 25 Jun 2020 06:34:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVs80JYUKeuedepRXnHMw9aA0kaFHrIbJMxp3wkfoS+pI6CTS5+7LKDDYqfG3a6oNxXWhJqA==
X-Received: by 2002:a5d:4607:: with SMTP id t7mr29457132wrq.251.1593092086206;
        Thu, 25 Jun 2020 06:34:46 -0700 (PDT)
Received: from localhost.localdomain ([151.29.187.107])
        by smtp.gmail.com with ESMTPSA id d28sm34118699wrc.50.2020.06.25.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:34:45 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:34:43 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sai Harshini Nimmala <snimmala@codeaurora.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, adharmap@codeaurora.org,
        shalagra@codeaurora.org, dickey@codeaurora.org,
        satyap@codeaurora.org, pkondeti@codeaurora.org,
        clingutla@codeaurora.org, aiquny@codeaurora.org,
        rgottimu@codeaurora.org, Puja Gupta <pujag@codeaurora.org>
Subject: Re: [PATCH] Revert "sched/deadline: Remove cpu_active_mask from
 cpudl_find()"
Message-ID: <20200625133443.GJ5763@localhost.localdomain>
References: <1593065595-17794-1-git-send-email-snimmala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593065595-17794-1-git-send-email-snimmala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/06/20 23:13, Sai Harshini Nimmala wrote:
> The original commit 9659e1ee removes checking the cpu_active_mask
> while finding the best cpu to place a deadline task, citing the reason that
> this mask rarely changes and removing the check will give performance
> gains.
> However, on hotplugging, the cpu dying path has a brief duration between
> the CPUHP_TEARDOWN_CPU and CPUHP_AP_SCHED_STARTING hotplug states where
> the DL task can be scheduled on this cpu because the corresponding cpu
> bit in cpu->free_cpus has not been cleared yet. Without the
> cpu_active_mask check we could end up putting a DL task on such cpus
> leading to a BUG.
> The cpu_active_mask will be updated promptly before either of these
> states and will provide a more accurate check for the use case above.
> 
> Signed-off-by: Puja Gupta <pujag@codeaurora.org>
> Signed-off-by: Sai Harshini Nimmala <snimmala@codeaurora.org>
> ---
>  kernel/sched/cpudeadline.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 5cc4012..0346837 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -120,7 +120,8 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  	const struct sched_dl_entity *dl_se = &p->dl;
>  
>  	if (later_mask &&
> -	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
> +	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr) &&
> +	    cpumask_and(later_mask, later_mask, cpu_active_mask)) {
>  		return 1;
>  	} else {
>  		int best_cpu = cpudl_maximum(cp);

So, I believe the patch you want to revert only removed the condition
above.

> @@ -128,6 +129,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
>  
>  		if (cpumask_test_cpu(best_cpu, p->cpus_ptr) &&
> +		    cpumask_test_cpu(best_cpu, cpu_active_mask) &&
>  		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
>  			if (later_mask)
>  				cpumask_set_cpu(best_cpu, later_mask);

Did you actually experience issues with this second part as well? I'm
thinking the WARN_ON should have fired in that case, no?

Thanks,

Juri

