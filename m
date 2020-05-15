Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69204C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2EA2078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7UtYf9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEOOn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53508 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgEOOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589553807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1xZ8JfBmNTiGkLsqL/RqkMRLzuSs2G8A+ZbL9b5Sgw=;
        b=H7UtYf9x8X/6t204rJy4dTJV7NlKU1VaV+61u9j/RKzQuG0dScvHqccDF412enQY2RRza5
        feQU5n9DcCNL85G6NCK9P3DnQL2OlOqzL8P9P3pCIhnOgbcA83K9yg35KBwouSvyaKj6LW
        /CTFfpNNg88HVKPRdr43/8gpkfjL9yQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-8joFrlu_PyyBj3ZAoUP9Bw-1; Fri, 15 May 2020 10:43:17 -0400
X-MC-Unique: 8joFrlu_PyyBj3ZAoUP9Bw-1
Received: by mail-ej1-f72.google.com with SMTP id du3so1160040ejc.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1xZ8JfBmNTiGkLsqL/RqkMRLzuSs2G8A+ZbL9b5Sgw=;
        b=NiR8MNweSDp1F9462MMS9MK6nTWHhBj5kgu+A28EGs60xoO8AHVklAOzrlyfmyj7ER
         S4AeMcyRA49cy/cFYwH8f/S5YRQRtj5pK7teGcAPKKzNBe/69WJdLGR9uYLhPWSaQS4i
         p0nTdd/PzrOgONvkBHNfeTHZ0FIFwMckjCNkJ0bAUKeisS7aOxUAa7B9otC3SDwAbhxS
         jHG+vIqNbjZS/sgYP2lolsuHoarwkqGW88P1coOLUBdnWq7C7CdzDdygtmG4j2A/LOO+
         cNw3AIEIXmuZMuyk9/2pHvKIijpnCBLuRIeipyG6I6jDlU87c27i0vXOu78DcVpZwLpj
         m5Jw==
X-Gm-Message-State: AOAM532znR39dH6EPpS2fcWpH/5w0xerdkKle/Ix7pEKPe6TRTFeAKBt
        L5HlJfQrg1dFlkAaB3TIK9+7iwQEqAOkP5D72scswBR4dhochCGZuiocAdPWcKZeZebIilEW9/r
        7cJLSFu5pENbJwY31Qlr5kOmV3yHuORP0bZ4a2UiN
X-Received: by 2002:a17:906:5004:: with SMTP id s4mr3193003ejj.13.1589553796404;
        Fri, 15 May 2020 07:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcynxps1KUucQoqq7068tMVHGCDv6crpjonW5YwDES9DmvKGln6WCa0YEZZgSZ7g+qltCxkx4fwqpnxFZZ12Q=
X-Received: by 2002:a17:906:5004:: with SMTP id s4mr3192981ejj.13.1589553796108;
 Fri, 15 May 2020 07:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net> <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com> <20200513153023.GF3758@techsingularity.net>
In-Reply-To: <20200513153023.GF3758@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 15 May 2020 16:43:04 +0200
Message-ID: <CAE4VaGB=AqOmaHBv4cr85pWVrXyTqFEKvMvnJ3RTkhjxKx+G1g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Complete shot in the dark but restore adjust_numa_imbalance() and try
> this
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a9983da4408..0b31f4468d5b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2393,7 +2393,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>         struct rq_flags rf;
>  #if defined(CONFIG_SMP)
> -       if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> +       if (sched_feat(TTWU_QUEUE)) {
>                 sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>                 ttwu_queue_remote(p, cpu, wake_flags);
>                 return;

Hi Mel,

we have performance results for the proposed patch above ^^^.
Unfortunately, it hasn't helped the performance.

Jirka


On Wed, May 13, 2020 at 5:30 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, May 13, 2020 at 04:57:15PM +0200, Jirka Hladky wrote:
> > Hi Mel,
> >
> > we have tried the kernel with adjust_numa_imbalance() crippled to just
> > return the imbalance it's given.
> >
> > It has solved all the performance problems I have reported.
> > Performance is the same as with 5.6 kernel (before the patch was
> > applied).
> >
> > * solved the performance drop upto 20%  with single instance
> > SPECjbb2005 benchmark on 8 NUMA node servers (particularly on AMD EPYC
> > Rome systems) => this performance drop was INCREASING with higher
> > threads counts (10% for 16 threads and 20 % for 32 threads)
> > * solved the performance drop for low load scenarios (SPECjvm2008 and NAS)
> >
> > Any suggestions on how to proceed? One approach is to turn
> > "imbalance_min" into the kernel tunable. Any other ideas?
> >
> > https://github.com/torvalds/linux/blob/4f8a3cc1183c442daee6cc65360e3385021131e4/kernel/sched/fair.c#L8914
> >
>
> Complete shot in the dark but restore adjust_numa_imbalance() and try
> this
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a9983da4408..0b31f4468d5b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2393,7 +2393,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>         struct rq_flags rf;
>
>  #if defined(CONFIG_SMP)
> -       if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> +       if (sched_feat(TTWU_QUEUE)) {
>                 sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>                 ttwu_queue_remote(p, cpu, wake_flags);
>                 return;
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

