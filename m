Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C5C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B120771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLq7Ypyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgDHREO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:04:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45854 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:04:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id f8so5668896lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGglepjmycB/unQeYfbl18WIvTQ2qrXEhsStCYUcvCs=;
        b=uLq7Ypyg4WR6l91r0+uGFO2S9ospCFtjto42uvZSuUD9ukRkdLaLxiqx62UPv9rkwq
         xH6oS0WlJdRqLEaIUERf3hI4fErWYsjn+kceTusdjGkQOWwh/O5UY+un7xAueXOKQRjV
         WnLVzhGAtgqx4Rc1OUqWOii0yN4SDSWAPuYgIrpANlb48DR5v0e9IAig2Q1FBlev81ph
         oEkfxkWt/lQUzB7e1KRHqkguALpG0g/UzZldFF4LO8/PrBoGIJIdpNMHAMDOCyog1jJQ
         5RHmBtiSExHPdE5cO0pyEg5Ku4aDdsZDVnEE1ZV1s7ERUJBghFp0JL/753gjZsGiFWHv
         eJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGglepjmycB/unQeYfbl18WIvTQ2qrXEhsStCYUcvCs=;
        b=a1JFgIGbiysKpIjMdvhUZ8/NxULw3Xbt+2Fk4xm54YyXhbi1xyKlp8nQNoHDd4S9V2
         jyA66sTdKMsB1dQC9M6Ft8DVkNvqvr3xS8wjJ/BJRKwLkX0XtQRv43ehLRrtCA+AisE1
         T28T5wPzdplnCfk3HjS6EhAs/cWr9yQTk0DLoAM9KGN5sibLbmnuWmxY/qac9yqwc2/6
         KNBjtnBaCgPK0a2cn8SwUmozzZV1mcZwKG09Xwi40w6GkRRkxYKxgZlshKwWgyBgSUz7
         MX6f5Fa2XXFAB4uS3Y8AjAQpDC+UfwuQtjIghCrg07LnkNizBJhkPm1TmdioLEjsyUrD
         jC0w==
X-Gm-Message-State: AGi0PubIhUNEE76u2+Xe4HMaaKLf7CDa84pukAfR6yzgZqQCJPHmxbm8
        nkrSZaR39FigZsVxQCA37K5Lb4DK6xJxfkTjpDHntQ==
X-Google-Smtp-Source: APiQypLSAujexYPX6QNDaAN+VCJWlZlJeEnbUWr9D0QXtHCUl+p6Mh0gtFmrmvKpeuIy1Q71ockpoSZJ6/KfMT1wYwA=
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr4872095lfo.25.1586365449621;
 Wed, 08 Apr 2020 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com> <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
 <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com>
In-Reply-To: <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Apr 2020 19:03:57 +0200
Message-ID: <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 at 18:31, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08.04.20 14:29, Vincent Guittot wrote:
> > On Wed, 8 Apr 2020 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> [...]
>
> >>  /**
> >> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> index 8344757bba6e..74b0c0fa4b1b 100644
> >> --- a/kernel/sched/topology.c
> >> +++ b/kernel/sched/topology.c
> >> @@ -2052,12 +2052,17 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >>         /* Attach the domains */
> >>         rcu_read_lock();
> >>         for_each_cpu(i, cpu_map) {
> >> +               unsigned long cap = arch_scale_cpu_capacity(i);
> >
> > Why do you replace the use of rq->cpu_capacity_orig by
> > arch_scale_cpu_capacity(i) ?
> > There is nothing about this change in the commit message
>
> True. And I can change this back.
>
> It seems though that the solution is not sufficient because of the
> 'rd->span &nsub cpu_active_mask' issue discussed under patch 2/4.
>
> But this remind me of another question I have.
>
> Currently we use arch_scale_cpu_capacity() more often (16 times) than
> capacity_orig_of()/rq->cpu_capacity_orig .
>
> What's hindering us to remove rq->cpu_capacity_orig and the code around
> it and solely rely on arch_scale_cpu_capacity()? I mean the arch
> implementation should be fast.

Or we can do the opposite and only use capacity_orig_of()/rq->cpu_capacity_orig.

Is there a case where the max cpu capacity changes over time ? So I
would prefer to use cpu_capacity_orig which is a field of scheduler
instead of always calling an external arch specific function
