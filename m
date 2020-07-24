Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31322C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA3A2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyQtjhw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGXKeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:34:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4326C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:34:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so391959lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3V5co3yRSeLZkc3KLbMtdghIhpxZhFIvW5di9NxCXk=;
        b=FyQtjhw6j7uq4vJjlNJa8wKORpW8tvscTwf7wQrnK/S7/7BWWSj9v8xE2wIHDFyYSY
         1iMjJS1eUg5ypXyKE0JYFvqgiViftAa8LcGTIELtc93jlmcPn1DJ+J7hRmIrT07i43rD
         RgV4NfTPKMNJ3H/WaE8cTtcv6Mhj1bAz2HpsrkX28rpsKhbACHwNbCi+GD6diVm94bjN
         diXNBXSbaPWiDHGP3Jooir/kQfJSJ3kIc7j4CHJ1wJ+txRAPztfHfl+BIumRoxEEbQd4
         Zs3/IOmF4kkYt2PmO3gJjQ/7OYQ7GkkT1/9ApsxlBncZPT4TfTfQTtPMraSc+xHxqfyt
         XTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3V5co3yRSeLZkc3KLbMtdghIhpxZhFIvW5di9NxCXk=;
        b=XZSBcoqatu+l1lL59W0EHXnVmBvjmAmtxpRatCqC2SIn3E2JhKneiQ1703x3VQ7OGJ
         3568rbWBHZldqDbLZWM3Baav1Kq6AIySKSTVXSKPOBrl2h1PIk7j3DHd9jRZPm/cglEY
         G2gHG6+4yBpCIHGD/aONBLM5gQn7zcuqI+qBWM32ulWT8VrqMi8Y7QPkFNaggdHLLk+R
         itSTmPYKmS4xBlPvZnkgwB71FQJZcHrcOT6+IZkQPyx86c4xWuEYLnvoem0p97gKUshp
         ZyiHSFrfBFrXi5pCqf41PVNxxOkUTNltqDXhd4iN6q/F1ozJWDmYCS4vlLCy1rUwu0B2
         Ll+A==
X-Gm-Message-State: AOAM533cWDuKwXlYSmg/0MAlURwaoaTc/AOR/4kk0InRj3O/+jzG7mjS
        lbIPTeTQT7krVnhFPwNXU7H4nplCIDV+N6o/uesYCg==
X-Google-Smtp-Source: ABdhPJx0FQ9wbUnFYsYSwDh/mC/GtPIgQOu73tOPTl90mYw/IerYwYsuXnqi9FTUnuG7GGLjI6MEuj5KIGYtVApjp88=
X-Received: by 2002:a19:4844:: with SMTP id v65mr3470177lfa.184.1595586842297;
 Fri, 24 Jul 2020 03:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200723233853.48815-1-humjb_1983@163.com> <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
 <CAPJCdBnv4W5+u6OZ4vbAdJ2U8ubhfAU7+Zt0JUFjfxKEDuGJSw@mail.gmail.com>
In-Reply-To: <CAPJCdBnv4W5+u6OZ4vbAdJ2U8ubhfAU7+Zt0JUFjfxKEDuGJSw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Jul 2020 12:33:50 +0200
Message-ID: <CAKfTPtCXXGEDNG+YxBbRG4vFK1+ig5EBzntmyTxr7MbQw-Q7MA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: consider sched-idle CPU when selecting idle core
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Jiang Biao <humjb_1983@163.com>, Ingo Molnar <mingo@redhat.com>,
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

On Fri, 24 Jul 2020 at 10:12, Jiang Biao <benbjiang@gmail.com> wrote:
>
> On Fri, 24 Jul 2020 at 15:24, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 24 Jul 2020 at 01:39, Jiang Biao <humjb_1983@163.com> wrote:
> > >
> > > From: Jiang Biao <benbjiang@tencent.com>
> > >
> > > Sched-idle CPU has been considered in select_idle_cpu and
> > > select_idle_smt, it also needs to be considered in select_idle_core to
> > > be consistent and keep the same *idle* policy.
> >
> > In the case of select_idle_core, we are looking for a core that is
> > fully idle but if one CPU of the core is running a sched_idle task,
> > the core will not be idle and we might end up having  the wakeup task
> > on a CPU and a sched_idle task on another CPU of the core which is not
> > what we want
> Got it. sched_idle task may interfere its sibling, which brings me
> another question,
> If there's a core with smt1 running sched_idle task and smt2 idle,
> selecting smt1
> rather than smt2 should be more helpful for wakee task, because wakee task
> could suppress the sched_idle task without neighbour interfering.

But the sched_idle will then probably quickly move on the idle smt2

> And there seems to be no consideration about that currently.
> Is it worth improving that?

This will complexify and extend the duration of the search loop  and
as mentioned above, it will most probably be a nop at the end because
of sched_idle task moving on smt2

>
> Thanks a lot.
>
> Regards,
> Jiang
