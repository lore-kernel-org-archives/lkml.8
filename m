Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E541C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7A12054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBbwtwOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbgEMQVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:21:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728354AbgEMQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589386880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmKbJoODrCw94ZBl2xgCJxvLpqY6+B8gI0ZQxp+7Cl8=;
        b=HBbwtwOPBCOvLYudk295neKnNy3DBDFgbAQn5uUIlzte+nb527rUm/zWqy/oN+B+zoU67z
        3HT3jpU/PoXPPFJcsgWDMdzv0vCYPcFezLhaoDxw1WSBzvpCgUtUB0yckkvjoxuNgE/AZt
        NF8vm6lgR/6v6fHIW0TPJKJn4cy8cJg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-uIPreNYiP_Sj0kUCneWPog-1; Wed, 13 May 2020 12:21:06 -0400
X-MC-Unique: uIPreNYiP_Sj0kUCneWPog-1
Received: by mail-ej1-f72.google.com with SMTP id n15so7251934ejh.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmKbJoODrCw94ZBl2xgCJxvLpqY6+B8gI0ZQxp+7Cl8=;
        b=RWCrXeJ1yNyMXmAvINamxVeLl7C+aHDVK7NwCBiEdX1LPt1LnUTDSEFHtGmeg7dAkG
         lcSi95AicRrXF39zzbKA+IrRhvlkkpaGah3lakZNeFOg8XbMRK1SnAKUHlazDsg9Q14f
         HmcJ+TRLZEWRfOHJcBlzxIdPuXgekhd4i7ofcaJx/fMLYcVHcaa45NxrJqvso9g5/nN5
         kVz5q+DxC95bsaUTxmHS8QS9pKAYumAJdlUYW2RZXpwXOI36knLVTg4W0fPQ2r00Kfad
         9zN+Gs7wmN9bPGztu10ueCekoRxOD+pDqHnAQUwsI3nyIC5auOHS6jVJUHjBjLMs28Yb
         F+lA==
X-Gm-Message-State: AOAM5308R1X2emAEkTJ2FC0hNrp/HVj3OfWU8Cz/dJLspsm5Xixmczwt
        eJ3eCGoXc2pnig3JruujziypbxuK6NUGgmvwhy438JJin7lz8RdHLTbm51XQklAlGq0OHtS50Mw
        PEhlxMexl+xBz2PyyT+kfwyNC1ilZV0HtsIPb2ML9
X-Received: by 2002:a05:6402:688:: with SMTP id f8mr380352edy.233.1589386864838;
        Wed, 13 May 2020 09:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNy9IZUbce9YTv3AWNvBS4HgKqkS7OkmoMFTSfQgRI7Ieh/H+H7lZ6kbRFwjmSpzhc+Fpgc0Pu9TRIRiBq9XM=
X-Received: by 2002:a05:6402:688:: with SMTP id f8mr380328edy.233.1589386864603;
 Wed, 13 May 2020 09:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net> <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com> <20200513153023.GF3758@techsingularity.net>
In-Reply-To: <20200513153023.GF3758@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 13 May 2020 18:20:53 +0200
Message-ID: <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
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

Thank you, Mel!

I think I have to make sure we cover the scenario you have targeted
when developing adjust_numa_imbalance:

=======================================================================
https://github.com/torvalds/linux/blob/4f8a3cc1183c442daee6cc65360e3385021131e4/kernel/sched/fair.c#L8910

/*
* Allow a small imbalance based on a simple pair of communicating
* tasks that remain local when the source domain is almost idle.
*/
=======================================================================

Could you point me to a benchmark for this scenario? I have checked
https://github.com/gormanm/mmtests
and we use lots of the same benchmarks but I'm not sure if we cover
this particular scenario.

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

