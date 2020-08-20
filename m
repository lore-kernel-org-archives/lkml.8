Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6FEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A93C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbrhuEOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHTOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHTOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:16:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB4C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:16:10 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 93so1575915otx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+J7lomXgLWNuigG3s6WQmeUx7fd4tzzG7fep5GXpWg=;
        b=WbrhuEOSwzQ0ObGN6ndI+J0+7iTyfNthtQmgj+fnMQADnHHK3EPfetHC5BUhedeKPH
         Y+hfciCpC4WmXkhwhQwJD7zhOYw6Rgy4UPQyjDiIHHCbm6/LZR67casnXVlDPtSolXkf
         LmolHZcKRMZxk1Dh7gcPAwYVXC+akqCuYFlIaq/7kBVz+CLFgDG/VI+C7DuB5RtkUT0d
         rumxxRq1ctpPnL1UXaR5CR7LaNo70qzCxLERpnuJ0u5D3pnZyy7psjon5x3Svql6w0uQ
         R43abRN1sfpJN/pbJKs5o+d8s4OgkOWTvf6z9H47bzkykLrCEfS8EaSX+2A8o5/FHTLB
         k+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+J7lomXgLWNuigG3s6WQmeUx7fd4tzzG7fep5GXpWg=;
        b=KY2wXpsdmowJt/UQYqTV7yemE2tIgGnJ5xmhU7SMv2kjKmPS21VLbljyhmBsdyd3yY
         KdvlSlDUbDl786KY6LoNwmmaYOY51P72zK5NC6eMVIJSYO8qPaXagiL7ZHmRp43dKx0h
         xI3jn4MEf1r3CnFfpFUpzbPNlZn/YpgRGs7vkAmF8QcPc7mOtpg4zaOThnDHCRps8Eji
         X8i7b03zyIEro48OXut6TafhSTsh851GbM/BQqQN/ReWpjj+Dp4QPQp5LBS4Sh01QXlr
         0WnAEhRtE5cOcWZ1epHtSxELrUjMmebPsnRl1keM4OSp5356oIbDSbAyUCSnuajafuNz
         AJng==
X-Gm-Message-State: AOAM531cjGkAtCcJkxotIy7Nuu0YFf4V49ncmaiABsObP9qboZt4Paip
        dgSKr6rSIGu33knphruJcFi9HQ4QSdl9g7pn5SQ=
X-Google-Smtp-Source: ABdhPJyjc3/KwaQUMUvpqjECzPLWZFAanHrS3/z6f9rfWU56q1DncZ7INMgLPG7Ho1ujeFYaffDBCFT4H+W2wNT8wDQ=
X-Received: by 2002:a9d:6b0c:: with SMTP id g12mr2426931otp.4.1597932969941;
 Thu, 20 Aug 2020 07:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
In-Reply-To: <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 20 Aug 2020 22:15:59 +0800
Message-ID: <CAPJCdBmrLu7-RDrPSeMRNEF0tdFJfRveupqpFFR2AELax2rpWw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 20:51, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 20 Aug 2020 at 14:00, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > From: Jiang Biao <benbjiang@tencent.com>
> >
> > Vruntime compensation has been down in place_entity() to
> > boot the waking procedure for fair tasks. There is no need to
>
> s/boot/boost/ ?
Yes. -:)
>
> > do that for SCHED_IDLE task actually.
> >
> > Not compensating vruntime for SCHED_IDLE task could make
> > SCHED_IDLE task more harmless for normal tasks.
> >
> > Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1a68a0536add..adff77676a0a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >                 vruntime += sched_vslice(cfs_rq, se);
> >
> >         /* sleeps up to a single latency don't count. */
> > -       if (!initial) {
> > +       if (!initial && likely(!task_has_idle_policy(task_of(se)))) {
>
> What if se is not a task ?
Is it ok to limit the case to task se, like?
+       if (!initial && likely(!entity_is_task(se) ||
!task_has_idle_policy(task_of(se)))) {

Thx.
Regards,
Jiang
>
> >                 unsigned long thresh = sysctl_sched_latency;
> >
> >                 /*
> > --
> > 2.21.0
> >
