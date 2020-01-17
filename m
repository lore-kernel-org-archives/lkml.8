Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40062C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD7D20842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmQwSDZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAQOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:30:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47019 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgAQOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:30:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so26623983ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOUktzlDXg0zUzkubFwDmsWxGrWYcwgBd+na/rDWhno=;
        b=FmQwSDZ9h+ChPbSx+HUDFsx3AF4fv5d/eMn9a7u1uEOCoO/c9XWXbUfhUyGp4ZJN7y
         EK/dPu9WgUo3VRcJW9dmKgcevdidRoR8xpduKfeV44he4GBxLYWq+RAsV7s2ZEqJgKpv
         80fH/J/EorhB8PjJjWFtz/+Qvw4ZbwKgdNS2qT//ZrmdQ8HNy8oBJL59G4bWg/e7dJfG
         Z3RCyq3lG8qzLXQ0ZZe45pjXzDiKJ1Y4PdLxhbv61HZQMvUbE1+rhxD4QxjPD0At7Cd/
         qSTLrVsMBpn4KdhNFTkYu965rd2xDF5+UkmIuVM++QhL5fBLXHUuLOj2ZvuoO9wnN5Up
         83DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOUktzlDXg0zUzkubFwDmsWxGrWYcwgBd+na/rDWhno=;
        b=MM+Mjw8MP86R3p7Ax6k0xXT/DkIaS92iFDTiS3uhw2f8x1ootJSOPWng4ye5n0pe4u
         aYrEjTQW6lFDPEA72shb/WtY3YBrc3w6RrKbYDzaPuMwbxeWYE6ijxEi7Ju2caX65xfb
         KNDGE0YJNH5RX/yaBczTXrLosrLgYEXq8W/d9XCsIbIqMosIswpqqqL9FjbmuRseqvAI
         3ZMTGb2p/JdnmFg6th59Tz4WGQzXif9YwBc2fijvgEWUuJ9cFar7GujIDgDmpkqcDJsa
         aqvxpZsJuiOTIVrzWb0M03SBdOrkwERxZWlNgqFzMdqvxql858u/W3N25akJ3JXUV96b
         PXXg==
X-Gm-Message-State: APjAAAWI60TCz21+QG1jICtu36XbxfF66ofUbyHKtNIQV8H+rnjIR/Im
        v5p0fXEd2IxP0mjra75/4B6Uprw3DTVl5S7pRmZCOQ==
X-Google-Smtp-Source: APXvYqyiVtaPmSmRKsJv+E6BT5J2aNfHikdDme4b2COPAIWbQbmpxMSggM9KkYEG9DtxjDGJdxn2gwcpwAI0VlxDI9U=
X-Received: by 2002:a2e:b554:: with SMTP id a20mr5296619ljn.25.1579271404131;
 Fri, 17 Jan 2020 06:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20200114101319.GO3466@techsingularity.net> <CAKfTPtBROKKtTkz55McjJo6b=Qq0QRVckFe2fQS2kdxf8kCJLw@mail.gmail.com>
 <20200117142628.GR3466@techsingularity.net>
In-Reply-To: <20200117142628.GR3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jan 2020 15:29:52 +0100
Message-ID: <CAKfTPtBz=DtstPOUF63N1SJRhTpgFxyH2DpApznH_Cd1og0CVg@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 15:26, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Jan 17, 2020 at 02:16:15PM +0100, Vincent Guittot wrote:
> > > A more interesting example is the Facebook schbench which uses a
> > > number of messaging threads to communicate with worker threads. In this
> > > configuration, one messaging thread is used per NUMA node and the number of
> > > worker threads is varied. The 50, 75, 90, 95, 99, 99.5 and 99.9 percentiles
> > > for response latency is then reported.
> > >
> > > Lat 50.00th-qrtle-1        44.00 (   0.00%)       37.00 (  15.91%)
> > > Lat 75.00th-qrtle-1        53.00 (   0.00%)       41.00 (  22.64%)
> > > Lat 90.00th-qrtle-1        57.00 (   0.00%)       42.00 (  26.32%)
> > > Lat 95.00th-qrtle-1        63.00 (   0.00%)       43.00 (  31.75%)
> > > Lat 99.00th-qrtle-1        76.00 (   0.00%)       51.00 (  32.89%)
> > > Lat 99.50th-qrtle-1        89.00 (   0.00%)       52.00 (  41.57%)
> > > Lat 99.90th-qrtle-1        98.00 (   0.00%)       55.00 (  43.88%)
> >
> > Which parameter changes between above and below tests ?
> >
> > > Lat 50.00th-qrtle-2        42.00 (   0.00%)       42.00 (   0.00%)
> > > Lat 75.00th-qrtle-2        48.00 (   0.00%)       47.00 (   2.08%)
> > > Lat 90.00th-qrtle-2        53.00 (   0.00%)       52.00 (   1.89%)
> > > Lat 95.00th-qrtle-2        55.00 (   0.00%)       53.00 (   3.64%)
> > > Lat 99.00th-qrtle-2        62.00 (   0.00%)       60.00 (   3.23%)
> > > Lat 99.50th-qrtle-2        63.00 (   0.00%)       63.00 (   0.00%)
> > > Lat 99.90th-qrtle-2        68.00 (   0.00%)       66.00 (   2.94%
> > >
>
> The number of worker pool threads. Above is 1 worker thread, below is 2.
>
> > > @@ -8691,16 +8687,37 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> > >                         env->migration_type = migrate_task;
> > >                         lsub_positive(&nr_diff, local->sum_nr_running);
> > >                         env->imbalance = nr_diff >> 1;
> > > -                       return;
> > > -               }
> > > +               } else {
> > >
> > > -               /*
> > > -                * If there is no overload, we just want to even the number of
> > > -                * idle cpus.
> > > -                */
> > > -               env->migration_type = migrate_task;
> > > -               env->imbalance = max_t(long, 0, (local->idle_cpus -
> > > +                       /*
> > > +                        * If there is no overload, we just want to even the number of
> > > +                        * idle cpus.
> > > +                        */
> > > +                       env->migration_type = migrate_task;
> > > +                       env->imbalance = max_t(long, 0, (local->idle_cpus -
> > >                                                  busiest->idle_cpus) >> 1);
> > > +               }
> > > +
> > > +               /* Consider allowing a small imbalance between NUMA groups */
> > > +               if (env->sd->flags & SD_NUMA) {
> > > +                       unsigned int imbalance_min;
> > > +
> > > +                       /*
> > > +                        * Compute an allowed imbalance based on a simple
> > > +                        * pair of communicating tasks that should remain
> > > +                        * local and ignore them.
> > > +                        *
> > > +                        * NOTE: Generally this would have been based on
> > > +                        * the domain size and this was evaluated. However,
> > > +                        * the benefit is similar across a range of workloads
> > > +                        * and machines but scaling by the domain size adds
> > > +                        * the risk that lower domains have to be rebalanced.
> > > +                        */
> > > +                       imbalance_min = 2;
> > > +                       if (busiest->sum_nr_running <= imbalance_min)
> > > +                               env->imbalance = 0;
> >
> > Out of curiosity why have you decided to use the above instead of
> >   env->imbalance -= min(env->imbalance, imbalance_adj);
> >
> > Have you seen perf regression with the min ?
> >
>
> I didn't see a regression with min() but at this point, we're only
> dealing with the case of ignoring a small imbalance when the busiest
> group is almost completely idle. The distinction between using min and
> just ignoring the imbalance is almost irrevelant in that case.

yes you're right

>
> --
> Mel Gorman
> SUSE Labs
