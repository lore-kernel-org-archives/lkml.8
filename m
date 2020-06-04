Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E22CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C264206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y75M8TLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgFDMOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgFDMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:14:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE847C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:14:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so6953902ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlDYXxS2JGaW9oqhfwr72GR90WvNVl/rf+ikmqymshU=;
        b=Y75M8TLfL9rSSpXGXb8K8MFVC18J0eAM0SF0caZVUrt68qgjI/84/39Fht41FC2kOx
         UsgiIq3enG4a74Q6U5keVL1q3ho7zS89ox7MAnjkqnTNmSYMASgiuvgtMgvVhKAKg28A
         La06hoCzVWz6l5wTaXIc3Kmz+90onNg0XGBR9QjW5fGtH5l/Bb2Oxxhsl0YKzLR5DlvL
         W3eQ9BNfGbL/U+wT3WG0ajpHNSxejrIPESQRXU53vNw6OznHR6eiounLCt1EgB+TOdQR
         cf8T5mJVwym8YCXtV/4vOjAdz4iYFSzU4DsvFRRg1+lA5yIqLs8ZOAXfJzSMowqXLc82
         jO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlDYXxS2JGaW9oqhfwr72GR90WvNVl/rf+ikmqymshU=;
        b=ElFew4f84j/aIgYwDND3+G1IYZhl/9PmbLVicmpBk++MoxTLUC7rmM372YEn+UkHei
         c7zh1kb6+XKXcSRkGaeKntta0nCZKcy9Rr5uuxPOHRvl/jPb4/9elPiNJGl7h8y8/sS8
         hRBfpDnC3/ExG0oiHWHsSn7StTV7b0ag5qYOyuKy9j0IYx05rrgOUkaDofpFMgB7yI/z
         OJMaDbiFVja5AMbTA7/+c3l8ELsNkcj+moAXOg5429pOSUiNd5GCFDuXS2dAMvnu3eM1
         kT2DlNst+fIf+Cf4+V0/1g4jDsqaKab+5tZBsNiUdn91Ee0smGSNbdTVIenIfD/hAHzG
         QeNQ==
X-Gm-Message-State: AOAM533wTVjsW9+hC0w14zJesd+JTx0DUYIu8cdX4svD1GjopPF5Obaz
        PDbT8zq+6QnYgGexhqC6oLp6kqpgA0bjqHcuOaCHRA==
X-Google-Smtp-Source: ABdhPJwOMNoiewBY+XdDj+EcVkhMGMGCpyeD1UMylpzuebdRxF5LWVJCHWfG+dg/l3cyQOkjQfJt0gT9KNt/LeE9mUg=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr2087665ljp.177.1591272891933;
 Thu, 04 Jun 2020 05:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200511154053.7822-1-qais.yousef@arm.com> <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de> <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 4 Jun 2020 14:14:40 +0200
Message-ID: <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 18:52, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/03/20 16:59, Vincent Guittot wrote:
> > When I want to stress the fast path i usually use "perf bench sched pipe -T "
> > The tip/sched/core on my arm octo core gives the following results for
> > 20 iterations of perf bench sched pipe -T -l 50000
> >
> > all uclamp config disabled  50035.4(+/- 0.334%)
> > all uclamp config enabled  48749.8(+/- 0.339%)   -2.64%
> >
> > It's quite easy to reproduce and probably easier to study the impact
>
> Thanks Vincent. This is very useful!
>
> I could reproduce that on my Juno.
>
> One of the codepath I was suspecting seems to affect it.
>
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0464569f26a7..9f48090eb926 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1063,10 +1063,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>          * e.g. due to future modification, warn and fixup the expected value.
>          */
>         SCHED_WARN_ON(bucket->value > rq_clamp);
> +#if 0
>         if (bucket->value >= rq_clamp) {
>                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
>                 WRITE_ONCE(uc_rq->value, bkt_clamp);
>         }
> +#endif
>  }
>
>  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>
>
>
> uclamp_rq_max_value() could be expensive as it loops over all buckets.
> Commenting this whole path out strangely doesn't just 'fix' it, but produces
> better results to no-uclamp kernel :-/
>
>
>
> # ./perf bench -r 20 sched pipe -T -l 50000
> Without uclamp:         5039
> With uclamp:            4832
> With uclamp+patch:      5729
>
>
>
> It might be because schedutil gets biased differently by uclamp..? If I move to
> performance governor these numbers almost double.
>
> I don't know. But this promoted me to look closer and I think I spotted a bug
> where in the if condition we check for '>=' instead of '>', causing us to take
> the supposedly impossible fail safe path.
>
> Mind trying with the below patch please?

I have tried your patch and I don't see any difference compared to
previous tests. Let me give you more details of my setup:
I create 3 levels of cgroups and usually run the tests in the 4 levels
(which includes root). The result above are for the root level

But I see a difference at other levels:

                           root           level 1       level 2       level 3

/w patch uclamp disable     50097         46615         43806         41078
tip uclamp enable           48706(-2.78%) 45583(-2.21%) 42851(-2.18%)
40313(-1.86%)
/w patch uclamp enable      48882(-2.43%) 45774(-1.80%) 43108(-1.59%)
40667(-1.00%)

Whereas tip with uclamp stays around 2% behind tip without uclamp, the
diff of uclamp with your patch tends to decrease when we increase the
number of level

Beside this, that's also interesting to notice the ~6% of perf impact
between each level for the same image

>
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0464569f26a7..50d66d4016ff 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1063,7 +1063,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>          * e.g. due to future modification, warn and fixup the expected value.
>          */
>         SCHED_WARN_ON(bucket->value > rq_clamp);
> -       if (bucket->value >= rq_clamp) {
> +       if (bucket->value > rq_clamp) {
>                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
>                 WRITE_ONCE(uc_rq->value, bkt_clamp);
>         }
>
>
>
> Thanks
>
> --
> Qais Yousef
