Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A1C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B926D21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSjKMLtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgBMIFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:05:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43028 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:05:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so3578550lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 00:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5hRnTB16rR+pKGopsGrMh3cBd31p82Y/7wFqqMJ/Jc=;
        b=hSjKMLtrgyw+zjg0ndioHTiJLzVc1uxGiE9BAN1YhI9xmavr4S/4tAy/3HdOFBsaRX
         KT/cEkixpavVgvBYR2CxU4ODhNijWIevxW7pWxHSH7cQAt5WCzezmOopMPWJn44puA0d
         UdfEZLkflHKAV1a0gG4Nb88N+gfaet6ZJYX5+ZBIbpFf+bgdFcV0AAsyiaTCSl5n0HL3
         kSEtkHl3wbAsZ+mSf9eCOR7o54ZURxNcErOWx/nqiePgi7pgB6t4oluPB61eBMf2k7Ua
         D2URkGn/G24ZnuldTshi9Z4xWNlavI/veH5ev/Ti7bqxBMdQdvSRkQj3xL4JoNDGYXyX
         QH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5hRnTB16rR+pKGopsGrMh3cBd31p82Y/7wFqqMJ/Jc=;
        b=aY3P50rfBlv1DwFcI1lS6vw05cYftuQsbzN6u+SrsaDNX1agJaG9w33ssdHc/Hnxc7
         xkQMxvDTu+l7kqova9LwFnD8JsM7ovtb0f8Qp+QnsSDTAhkxHiaAKxY4FH/EB0Te9jHX
         R2oDP7qGtDyriNLEyFBpz0EcVvhgoM4FzrMhSaaIfhKm4HNr7BP1fu0qFmY7PJw7/ETB
         xxg9njqxTvA9sqaWcArtF69Y/E8sf03JRmA6vKOxxsuYNweJlBJIgc0yu1/Ucs53WkMm
         wJOaT1SiBFOGvJSDSgFYmnAYRYsf3Q03SQuY6pUZ51nHlx3xJDPK97aBIRM3A+xtxlaO
         fMYw==
X-Gm-Message-State: APjAAAXh9rNLKiqzt+Ak2oiRoz9tuDUcowlHreEes3uYmKewheDEv+gB
        BAW0EwvfQSLO/NxBdol+GXzAWk408ltOziFBOINr/g==
X-Google-Smtp-Source: APXvYqzdxKvLHJKnaBtpjJmeoTyPdZOj2khQPpzSezNMIv7p39fFA0oLytldPw4yuM+pfQIRalokJKdS4/7FLPi+l70=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr8823371lfp.190.1581581147089;
 Thu, 13 Feb 2020 00:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org> <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net>
In-Reply-To: <20200212194903.GS3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Feb 2020 09:05:35 +0100
Message-ID: <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 20:49, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Feb 12, 2020 at 01:37:15PM +0000, Mel Gorman wrote:
> > >  static void task_numa_assign(struct task_numa_env *env,
> > >                          struct task_struct *p, long imp)
> > >  {
> > > @@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
> > >     long orig_src_load, orig_dst_load;
> > >     long src_capacity, dst_capacity;
> > >
> > > +
> > > +   /* If dst node has spare capacity, there is no real load imbalance */
> > > +   if (env->dst_stats.node_type == node_has_spare)
> > > +           return false;
> > > +
> >
> > Not exactly what the load balancer thinks though, the load balancer
> > may decide to balance the tasks between NUMA groups even when there is
> > capacity. That said, what you did here is compatible with the current code.
> >
> > I'll want to test this further but in general
> >
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> >
>
> And I was wrong. I worried that the conflict with the load balancer would
> be a problem when I wrote this comment.  That was based on finding that
> I had to account for the load balancer when using capacity to decide
> whether an idle CPU can be used. When I didn't, performance went to
> hell but thought that maybe you had somehow avoided the same problem.
> Unfortunately, testing indicates that the same, or similar, problem is
> here.
>
> This is specjbb running two JVMs on a 2-socket Haswell machine with 48
> cores in total. This is just your first two patches, I have found that

thanks for the test results. Unfortunately i haven't specjbb to
analyse the metrics and study what is going wrong

> the group classify patches do not recover it.
>
> Hmean     tput-1     39748.93 (   0.00%)    39568.77 (  -0.45%)
> Hmean     tput-2     88648.59 (   0.00%)    85302.00 (  -3.78%)
> Hmean     tput-3    136285.01 (   0.00%)   131280.85 (  -3.67%)
> Hmean     tput-4    181312.69 (   0.00%)   179903.17 (  -0.78%)
> Hmean     tput-5    228725.85 (   0.00%)   223499.65 (  -2.28%)
> Hmean     tput-6    273246.83 (   0.00%)   268984.52 (  -1.56%)
> Hmean     tput-7    317708.89 (   0.00%)   314593.10 (  -0.98%)
> Hmean     tput-8    362378.08 (   0.00%)   337205.87 *  -6.95%*
> Hmean     tput-9    403792.00 (   0.00%)   349014.39 * -13.57%*
> Hmean     tput-10   446000.88 (   0.00%)   379242.88 * -14.97%*
> Hmean     tput-11   486188.58 (   0.00%)   341951.27 * -29.67%*
> Hmean     tput-12   522288.84 (   0.00%)   388877.07 * -25.54%*
> Hmean     tput-13   532394.06 (   0.00%)   437005.34 * -17.92%*
> Hmean     tput-14   539440.66 (   0.00%)   467479.65 * -13.34%*
> Hmean     tput-15   541843.50 (   0.00%)   455477.03 ( -15.94%)
> Hmean     tput-16   546510.71 (   0.00%)   483599.58 ( -11.51%)
> Hmean     tput-17   544501.21 (   0.00%)   506189.64 (  -7.04%)
> Hmean     tput-18   544802.98 (   0.00%)   535869.05 (  -1.64%)
> Hmean     tput-19   545265.27 (   0.00%)   533050.57 (  -2.24%)
> Hmean     tput-20   543284.33 (   0.00%)   528100.03 (  -2.79%)
> Hmean     tput-21   543375.11 (   0.00%)   528692.97 (  -2.70%)
> Hmean     tput-22   542536.60 (   0.00%)   527160.27 (  -2.83%)
> Hmean     tput-23   536402.28 (   0.00%)   521023.49 (  -2.87%)
> Hmean     tput-24   532307.76 (   0.00%)   519208.85 *  -2.46%*
> Stddev    tput-1      1426.23 (   0.00%)      464.57 (  67.43%)
> Stddev    tput-2      4437.10 (   0.00%)     1489.17 (  66.44%)
> Stddev    tput-3      3021.47 (   0.00%)      750.95 (  75.15%)
> Stddev    tput-4      4098.39 (   0.00%)     1678.67 (  59.04%)
> Stddev    tput-5      3524.22 (   0.00%)     1025.30 (  70.91%)
> Stddev    tput-6      3237.13 (   0.00%)     2198.39 (  32.09%)
> Stddev    tput-7      2534.27 (   0.00%)     3261.18 ( -28.68%)
> Stddev    tput-8      3847.37 (   0.00%)     4355.78 ( -13.21%)
> Stddev    tput-9      5278.55 (   0.00%)     4145.06 (  21.47%)
> Stddev    tput-10     5311.08 (   0.00%)    10274.26 ( -93.45%)
> Stddev    tput-11     7537.76 (   0.00%)    16882.17 (-123.97%)
> Stddev    tput-12     5023.29 (   0.00%)    12735.70 (-153.53%)
> Stddev    tput-13     3852.32 (   0.00%)    15385.23 (-299.38%)
> Stddev    tput-14    11859.59 (   0.00%)    24273.56 (-104.67%)
> Stddev    tput-15    16298.10 (   0.00%)    45409.69 (-178.62%)
> Stddev    tput-16     9041.77 (   0.00%)    58839.77 (-550.75%)
> Stddev    tput-17     9322.50 (   0.00%)    77205.45 (-728.16%)
> Stddev    tput-18    16040.01 (   0.00%)    15021.07 (   6.35%)
> Stddev    tput-19     8814.09 (   0.00%)    27509.99 (-212.11%)
> Stddev    tput-20     7812.82 (   0.00%)    31578.68 (-304.19%)
> Stddev    tput-21     6584.58 (   0.00%)     3639.48 (  44.73%)
> Stddev    tput-22     8294.36 (   0.00%)     3033.49 (  63.43%)
> Stddev    tput-23     6887.93 (   0.00%)     5450.38 (  20.87%)
> Stddev    tput-24     6081.83 (   0.00%)      390.32 (  93.58%)
>
> Note that how it reaches the point where the node is almost utilised
> ( near tput-12) that performance drops.  Graphing mpstat on a per-node
> basis shows there is imbalance in the CPU utilisation between nodes.

ok. So the has_spare_capacity condition that i added in
load_too_imbalanced() is probably to aggressive although the goal was
to let task moving on their preferred node

>
> NUMA locality is not bad, scanning and migrations are a bit higher but
> overall this is a problem.
>
> On a 4-socket machine, I see slightly different results -- there is still
> a big drop although not a statistically significant one. However, the
> per-node CPU utilisation is skewed as nodes approach being fully utilised.
>
> I see similarly bad results on a 2-socket Broadwell machine.
>
> I don't have other results yet for other workloads but I'm not optimistic
> that I'll see anything different. I still think that this probably didn't
> show up with hackbench because it's too short-lived for NUMA balancing
> to be a factor.
>
> --
> Mel Gorman
> SUSE Labs
