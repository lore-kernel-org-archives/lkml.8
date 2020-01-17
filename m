Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981FC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA552072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuxGtcgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAQPju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:39:50 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:43492 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:39:50 -0500
Received: by mail-lj1-f174.google.com with SMTP id a13so26892543ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xCbY7FMjigCuairfD/dpXsbJlPPArVKVur2HZKJ7k0=;
        b=UuxGtcgm6BCvBPiWvO1GG+7oNqXBg2s+2147Kp4KqV2HhGf89imdR5FCUnaD9G/6SJ
         QocrHDvPtK2hr75tl8+OHTkxy3CiUUhylgxz2Q4S8RSFbxJmlfZDgZBPORtCmOm37V7X
         QBkwGhNgybYSheAPtQ6KtmJsaUw1aW4nJptzpYM2JQ7f31/ZK7gg4/xo8C2AlYScMboL
         itP6Im4K0WjEuwD9FVmx/yGpR41pMnbyMssW6eg8Wj+An41l0fsEy9S62k10R1j4cXXZ
         vzgOfJcXT2u3VDHEgBEm+EMo732oUkmokhWyTNRn1qcoyVJlQEFD+jW9xNIV1ChH5LU/
         nTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xCbY7FMjigCuairfD/dpXsbJlPPArVKVur2HZKJ7k0=;
        b=IAYaNMNEE/AIIv2p0QDZ7FUz9pNmvTlORYqIyC0ym6UDy/HKNHQepnCjKQPMqJqy3f
         Kf3NwOR1F1c46YfbRqT907UdtqVsdLEMn4Kfqj0gJwe4yzJbef5eBJ1gjpwLeh4c1XkJ
         vg/j/VDnLDGHncVLDCWOB62S7wkwGo/7IKSJ8IT1XXCRkts1KrYc0QNIU74zP5FIbmxp
         JdlrvaoRozPaFOqEbtjSV3JtV2vBEhVsE0b61ua3Nk+6GBTsZOuM7jkJZ5O0P2HMtteI
         zad+V/f5xpvCfswBEJQLgndzzG+A/wnDlHBEnD8tQY1L1zWP7F/w8rRV8zrS28imEvPD
         cE6Q==
X-Gm-Message-State: APjAAAVSG0ch4wTrKcuD8ggln1XaWqNSjywwx4QCcJfI1Jmzaye0g89P
        K6bch895nTVIx7K7FJqDf9R20w+9MgdbgMAS4F/0qA==
X-Google-Smtp-Source: APXvYqwFnpRW8+KeFOIlvnEzdT6nqsdTwYFc+Bs6CuC5ct5UMHSh2Kp9Lj/GX9ZPQa+vXgbyCS1z23PnIzxCZuJevO0=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr5957930ljk.201.1579275588343;
 Fri, 17 Jan 2020 07:39:48 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net> <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
 <20200117145544.GE14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200117145544.GE14879@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jan 2020 16:39:37 +0100
Message-ID: <CAKfTPtAzgNAV5c_sTycSocmi8Y4oGGT5rDNSYmgL3tCjZ1RAQw@mail.gmail.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
> > On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > >
> > > That there indentation trainwreck is a reason to rename the function.
> > >
> > >         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> > >                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > >                   update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
> > >                   update_irq_load_avg(rq, 0);
> > >
> > > Is much better.
> > >
> > > But now that you made me look at that, I noticed it's using a different
> > > clock -- it is _NOT_ using now/rq_clock_pelt(), which means it'll not be
> > > in sync with the other averages.
> > >
> > > Is there a good reason for that?
> >
> > We don't need to apply frequency and cpu capacity invariance on the
> > thermal capping signal which is  what rq_clock_pelt does
>
> Hmm, I suppose that is true, and that really could've done with a
> comment. Now clock_pelt is sort-of in sync with clock_task, but won't it
> still give weird artifacts by having it on a slightly different basis?

No we should not. Weird artifacts happens when we
add/subtract/propagate signals between each other and then apply pelt
algorithm on the results. In the case of thermal signal, we only add
it to others to update cpu_capacity but pelt algo is then not applied
on it. The error because of some signals being at segment boundaries
whereas others are not, is limited to 2% and doesn't accumulate over
time.

>
> Anyway, looking at this, would it make sense to remove the @now argument
> from update_*_load_avg()? All those functions already take @rq, and
> rq_clock_*() are fairly trivial inlines.

TBH I was thinking of doing the opposite for update_irq_load_avg which
hides the clock that is used for irq_avg. This helps to easily
identify which signals use the exact same clock and can be mixed to
create a new pelt signal and which can't
