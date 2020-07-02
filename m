Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21F0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD89208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/370d7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgGBPpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGBPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:45:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E85C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:45:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so27438690wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NpA1aHPtrtTbDRv3BwJsLYLsdIe49m/oDHB3TNgzSg=;
        b=X/370d7bfe2wKHRZ5XVFz0qdHal5xmGwf85Zc6IDUVi0M5m7ynIAqEOe5ciIVpJVCc
         3QETHIWwNB410S3dKj6anHO02VXlRe+YE2AarzVqruSBap/fwL46PewA1Hmb35m3CN5U
         FCdxSM00IrvR2nkppuhhXlJvmX8Z8kNte5fi6y99bYoOoM8X28fiDIj4vQJQDmgIttuS
         K9ZtI8fQUY+KwDkM9ZWhYF+RlKEtKWaTapv0dlYN2vHNitUWkcXZot0Xnq7eyyZQht3K
         E5Qr2el/qylFUhUFhCbTCBWfTcli7vFi4RBprnREXx2rMFiR6ySlD341+1CJ9GPOCgT4
         aXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NpA1aHPtrtTbDRv3BwJsLYLsdIe49m/oDHB3TNgzSg=;
        b=t7rXF81LvIXdce9aQElw6F5EYPzn5avRBrZCyMabYSoq+PY7i7jWZNW80wQ8lx+FtB
         eHo/Vz3rjKwzfJOt6DfCepPj3C7S1ZH/CzLMmaHPpBsmwRE4Y9w7JXeFwSI0JE52xL3x
         XnWiIPELIZ19ZYACt6eApppoQ59HtAuPap0obi/v3wdafK9jAAcO4EJqrRiGL1dVuO8L
         GuqyDwsl000uq0gdQ/7x+AcOYZKH8jyznsWKK/pR9aWv0r03zdW6QFtu3drrgQ1EzWle
         8tvSHwlmtIPmRGK2McFQ3ZJuDUoSzv4/TA9jr/2eP0Xq1MICn0BRiDk80N/mUTBJ6zxZ
         EzmQ==
X-Gm-Message-State: AOAM5310s+h77BEq/io1BtEZFl313Z7KjQMGEMUXdYlZMv9zopg+cQmM
        ChrG1c0prcyf+TgNwvKhLrZJaKheICVrhw==
X-Google-Smtp-Source: ABdhPJwlMcPNCVDq3OS2q1fYfyx8/F/uGQ83V0/XC1CVgOs9Hb9YYVEhsDV45jr6bLkOuNHiB6Etww==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr32186872wml.170.1593704718790;
        Thu, 02 Jul 2020 08:45:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id u84sm10580204wmg.7.2020.07.02.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:45:18 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:45:14 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 2/7] sched/topology: Define and assign sched_domain
 flag metadata
Message-ID: <20200702154514.GA1072702@google.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-3-valentin.schneider@arm.com>
 <20200702121536.GA765585@google.com>
 <jhjk0zm7zv8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjk0zm7zv8.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Jul 2020 at 15:31:07 (+0100), Valentin Schneider wrote:
> There an "interesting" quirk of asym_cpu_capacity_level() in that it does
> something slightly different than what it says on the tin: it detects
> the lowest topology level where *the biggest* CPU capacity is visible by
> all CPUs. That works just fine on big.LITTLE, but there are questionable
> DynamIQ topologies that could hit some issues.
> 
> Consider:
> 
> DIE [                   ]
> MC  [             ][    ] <- sd_asym_cpucapacity
>      0   1   2   3  4  5
>      L   L   B   B  B  B
> 
> asym_cpu_capacity_level() would pick MC as the asymmetric topology level,
> and you can argue either way: it should be DIE, because that's where CPUs 4
> and 5 can see a LITTLE, or it should be MC, at least for CPUs 0-3 because
> there they see all CPU capacities.

Right, I am not looking forward to these topologies...

> I have a plan on how to fix that, but I haven't been made aware of any
> "real" topology that would seriously break there. The moment one does, this
> will surface up to the top of my todo-list.
> 
> In the meantime, we can make it match the SDF_SHARED_PARENT semantics, and
> this actually fixes an issue with solo big CPU clusters (which I
> anecdotally found out while first writing this series, and forgot to
> include):
> 
> --->8
> From: Valentin Schneider <valentin.schneider@arm.com>
> Date: Wed, 16 Oct 2019 18:12:12 +0100
> Subject: [PATCH 1/1] sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
> 
> We currently set this flag *only* on domains whose topology level exactly
> match the level where we detect asymmetry (as returned by
> asym_cpu_capacity_level()). This is rather problematic.
> 
> Say there are two clusters in the system, one with a lone big CPU and the
> other with a mix of big and LITTLE CPUs:
> 
> DIE [                ]
> MC  [             ][ ]
>      0   1   2   3  4
>      L   L   B   B  B
> 
> asym_cpu_capacity_level() will figure out that the MC level is the one
> where all CPUs can see a CPU of max capacity, and we will thus set
> SD_ASYM_CPUCAPACITY at MC level for all CPUs.
> 
> That lone big CPU will degenerate its MC domain, since it would be alone in
> there, and will end up with just a DIE domain. Since the flag was only set
> at MC, this CPU ends up not seeing any SD with the flag set, which is
> broken.

+1

> Rather than clearing dflags at every topology level, clear it before
> entering the topology level loop. This will properly propagate upwards
> flags that are set starting from a certain level.

I'm feeling a bit nervous about that asymmetry -- in your example
select_idle_capacity() on, say, CPU3 will see less CPUs than on CPU4.
So, you might get fun side-effects where all task migrated to CPUs 0-3
will be 'stuck' there while CPU 4 stays mostly idle.

I have a few ideas to avoid that (e.g. looking at the rd span in
select_idle_capacity() instead of sd_asym_cpucapacity) but all this is
theoretical, so I'm happy to wait for a real platform to be released
before we worry too much about it.

In the meantime:

Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b5667a273bf6..549268249645 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1965,11 +1965,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         /* Set up domains for CPUs specified by the cpu_map: */
>         for_each_cpu(i, cpu_map) {
>                 struct sched_domain_topology_level *tl;
> +		int dflags = 0;
> 
>                 sd = NULL;
>                 for_each_sd_topology(tl) {
> -			int dflags = 0;
> -
>                         if (tl == tl_asym) {
>                                 dflags |= SD_ASYM_CPUCAPACITY;
>                                 has_asym = true;
> --
> 2.27.0

Thanks,
Quentin
