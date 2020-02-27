Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCAFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060322469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IARaMUZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgB0NAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:00:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53357 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgB0NAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:00:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id f15so3459141wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lF1WpNMmDIC+u5WUFqN6XI3/wXMvIRCjntbaMdrFGfg=;
        b=IARaMUZPJiCDFrzzJwyWb6YRob1J06IUMUj73rqLrl3Ppn2wS5eJPgwlML7IHofhy/
         2vf5hO+Nxf4m1l3oC4JUcc7Hycie16A5bdmxyzvR8ybGG19Vv74J/0OdSSzOtXAIAtFm
         hMdlDcz5qhKEWvM924Bb6wqORS+DdqDMMh0H5v7DlndWs3/uUJKmmlF5c7Pnu8OdtuG1
         VApamd3WADlVVWGzYbr2a6BxRq5U34ILOaDQhh/SURP7x9fisOuMZn2MG+h5CFPxnUuh
         Za4SaJk52aI2JKEpRn4Fpd6QCc2qeQcY9u1+vXWi/UPTVb7jpQ1tclDVVaEd2hmdcgV6
         5/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lF1WpNMmDIC+u5WUFqN6XI3/wXMvIRCjntbaMdrFGfg=;
        b=a6ponZ2+b8rA9VdPJ1tLoAIsj4KT1CnP9Zb9SQR8LZXEq3lfqMOUFteOEjiz2/fhWU
         MRDjLRhO8LNFxB8AqcstCKgDUGZjrtHXU249RIZbIxd1rh+a3xa+YXkjgPFna2Wk+vM5
         OxtzIm2Ac73EBLk/52aQa4jTDxAeEJVlaATHXLajIXw5sM4bn3yaiIDf6BjxeBTwRvYX
         J/PVploI2cK0WfIf8en7Z0BBAu6VXAqDmd0GqP6yt79tDpbSC0ZlqZHtP9DDuF+PEAvv
         brALXZFHWuqSxTdSyZl2YIINNOUmj2XbTB6nlR4B61xevqX4Z+PJO5XPMl6JSYteE3cO
         KOpA==
X-Gm-Message-State: APjAAAXfSBAFT7dqdRTwdK4elMc+O9fogilBHroWJT2J/Qq+2Xzmb48P
        KgyJjubn/9a3MeQUb2Pl00VSaA==
X-Google-Smtp-Source: APXvYqyJc8z85FxR6Y8xbHanOXMr3EKjgHVQ0zhtwSRKjHALBfFlCDS/ccmFZBafwRz3YaXDguz5LA==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5324707wmi.116.1582808405179;
        Thu, 27 Feb 2020 05:00:05 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id e18sm8033429wrw.70.2020.02.27.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:00:04 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:00:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        morten.rasmussen@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH 1/2] sched/topology: Don't enable EAS on SMT systems
Message-ID: <20200227130001.GA107011@google.com>
References: <20200226164118.6405-1-valentin.schneider@arm.com>
 <20200226164118.6405-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226164118.6405-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 Feb 2020 at 16:41:17 (+0000), Valentin Schneider wrote:
> EAS already requires asymmetric CPU capacities to be enabled, and mixing
> this with SMT is an aberration, but better be safe than sorry.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin

> ---
>  kernel/sched/topology.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 00911884b7e7..76cd0a370b9a 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -360,6 +360,10 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>  		goto free;
>  	}
>  
> +	/* EAS definitely does *not* handle SMT */
> +	if (sched_smt_active())
> +		goto free;
> +
>  	for_each_cpu(i, cpu_map) {
>  		/* Skip already covered CPUs. */
>  		if (find_pd(pd, i))
> -- 
> 2.24.0
> 
