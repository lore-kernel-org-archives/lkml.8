Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CDFC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB52074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUIxZHAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXMkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:40:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8D5C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:40:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so8177256wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxrC7srIn644JnxZvKZ6CAG4zZpgCwirCY+CCIdJm7s=;
        b=RUIxZHAJwfFR/SWIIq5sARO+ZVI91NxfVEwDuAIyxMc4FFDGfKuPXPcTjLRrawUz5T
         JOLP3yG2i6iK6X+JEWG5Mr/S/wFLkRIMHBhH8cjunC0bdW9D+kkT5yzQj/s1EbD1WQ0d
         Izb0CuHVEHJAqsOaSDZrivMu34x2NZZ4oOnXyLRVW/csm24sIPQJMcZFtAfGeR5v6j4i
         Sx5Z2z77fukerHtERYPhILwWBIDiIUH+HeNk0KNGlvEQF3T4Z0hyTpwzsJjxkn+nMrqT
         1idDhwaf1ZFu0TnWp4ilbXL2p9bFFveeMTcv7LutBHv5y7zzmDWe31T3TneLPcSlA9+h
         xNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxrC7srIn644JnxZvKZ6CAG4zZpgCwirCY+CCIdJm7s=;
        b=PmRKpDUbzxOlMXN6n2elX7wxXF/NKl6WuivinakqaznrzqogUl13cVxmxnnnOZI8Pj
         NU3PeFNOOCd3ivHcXlcRDSx/S/fAgGx/BF4ACO2afM1RebVfFmKtMX9SYBUd2aXek+eQ
         sFA0tnu2tkIz8Rm1he9OC5Ix2SNNIYF8nfkgllIi7Nftzj3iwOhWHNi1809PbvLvbdk+
         flXc4r4EExt25vi/QO476XOPWkrk3fo25qPVSIh8scODBEKkhNwT3Oo1rZKLQyA4Usc0
         PVsDdql2YxKAyEaAeL6a1ZvmDMgnGtATB2YbUjSWkwGqeq7cyELbXcrru465PggNJXuA
         nqOw==
X-Gm-Message-State: AOAM531FmY8ZLrx9t6//jvH3/6oULT9upBxtuFEPT8FGsD9hCQGtEuBR
        2An1KV++oNC0qflaphVohidlACkMF36DpnaIu2I=
X-Google-Smtp-Source: ABdhPJwHu4H6yeatS6mWn7YpmMc3Ks5DurPCbQ9atoAsPrbXiJE9vljBZf5TDlWsfo4Y/4e8yJCIF8ksxKiRtgeRcOw=
X-Received: by 2002:adf:97d3:: with SMTP id t19mr8015728wrb.138.1595594435777;
 Fri, 24 Jul 2020 05:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200723233853.48815-1-humjb_1983@163.com> <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
 <CAPJCdBnv4W5+u6OZ4vbAdJ2U8ubhfAU7+Zt0JUFjfxKEDuGJSw@mail.gmail.com>
 <CAKfTPtCXXGEDNG+YxBbRG4vFK1+ig5EBzntmyTxr7MbQw-Q7MA@mail.gmail.com>
 <CAPJCdBm=FJp8K1SubXP4Rfa-POr8hDh320faE+4Cjcjk3BL1JQ@mail.gmail.com> <20200724123644.GA634690@gmail.com>
In-Reply-To: <20200724123644.GA634690@gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Fri, 24 Jul 2020 20:40:24 +0800
Message-ID: <CAPJCdBk6qqPi3sgQZdESuERCWHQsc=Vy37nQVSA58EfR2zj2+A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: consider sched-idle CPU when selecting idle core
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Jiang Biao <humjb_1983@163.com>,
        Ingo Molnar <mingo@redhat.com>,
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

On Fri, 24 Jul 2020 at 20:36, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Jiang Biao <benbjiang@gmail.com> wrote:
>
> > On Fri, 24 Jul 2020 at 18:34, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Fri, 24 Jul 2020 at 10:12, Jiang Biao <benbjiang@gmail.com> wrote:
> > > >
> > > > On Fri, 24 Jul 2020 at 15:24, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Fri, 24 Jul 2020 at 01:39, Jiang Biao <humjb_1983@163.com> wrote:
> > > > > >
> > > > > > From: Jiang Biao <benbjiang@tencent.com>
> > > > > >
> > > > > > Sched-idle CPU has been considered in select_idle_cpu and
> > > > > > select_idle_smt, it also needs to be considered in select_idle_core to
> > > > > > be consistent and keep the same *idle* policy.
> > > > >
> > > > > In the case of select_idle_core, we are looking for a core that is
> > > > > fully idle but if one CPU of the core is running a sched_idle task,
> > > > > the core will not be idle and we might end up having  the wakeup task
> > > > > on a CPU and a sched_idle task on another CPU of the core which is not
> > > > > what we want
> > > > Got it. sched_idle task may interfere its sibling, which brings me
> > > > another question,
> > > > If there's a core with smt1 running sched_idle task and smt2 idle,
> > > > selecting smt1
> > > > rather than smt2 should be more helpful for wakee task, because wakee task
> > > > could suppress the sched_idle task without neighbour interfering.
> > >
> > > But the sched_idle will then probably quickly move on the idle smt2
> > >
> > > > And there seems to be no consideration about that currently.
> > > > Is it worth improving that?
> > >
> > > This will complexify and extend the duration of the search loop  and
> > > as mentioned above, it will most probably be a nop at the end because
> > > of sched_idle task moving on smt2
> > Indeed, the complexity is not worth.
> > Thanks for the explanation.
>
> BTW., if you disagree then you could add a bit of debug
> instrumentation to measure to what extent it's a nop at the end of the
> search loop, to turn the "most probably" statement into a specific
> number.
>
> Thanks,
>
>         Ingo
Ok, I'll try.
Thanks for your reply.

Regards,
Jiang
