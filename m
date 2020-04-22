Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCEEC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EE9214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PL47Y8bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgDVQmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:41:59 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09848C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:41:58 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id v192so598965vkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dur1iaXVo9CPR42vzqkU7tLshZ6Yb7TjK27awkJG38U=;
        b=PL47Y8bicCWSlXLU0ILHZEsNo3jjKNLIJrq0EBYI4ReeXYwvwrpSPMARkXeqM9hj8w
         rz2E6buOe1HVCeWAznZlSr2+Lnp/2MiGWXdJUBx+Aa2sIyIPzE8BBo6ivuM3CaMlLM1L
         ECPSZjoMpNaQHjRhwR3ujW75wBSkZHcDihAR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dur1iaXVo9CPR42vzqkU7tLshZ6Yb7TjK27awkJG38U=;
        b=UnqvgZWbLelCeJlft5GTmXdGZe5xwOVKHL2E60pL6No4iAGpvH2tU1B5GRAmcfwsow
         8yPA94kqxu5suDFgDDBAqBJlTMep8iH6wJ1KaEzFT8eaVv81iVRguYvaFEkCzRWjYNWA
         LLgOavbezK3DQt9MF4/Y+fC+qRnepaewRGMExO+ECykqiurNevaxlt3HpVAWlN1tW7jO
         /on9qS0MhTKOTTm7y2gJNotO9PXNXBUGun5te9+i3uQQIviLZrvhgy2WabgSUXuYSJCu
         mEDsbhBEEWtla2ofqL2xMSfYgo+QC3a4TpfopKVyUToXIy/yYGwJi+yXs3z8PjLOsGBz
         Q0YQ==
X-Gm-Message-State: AGi0PuawuXM+Hoeu88aBBWQPo++KTcz3C0fLSI+xiqelpqUh+A80RlJn
        DQllieUfZ9hiW7F3CCCeB+StNFpfZa0=
X-Google-Smtp-Source: APiQypLr1XZmmCm4eGokvjE5GlJKaBRXKeGUgJKV00lh222Xy5iyyALOd0/H/bGaxpq7RZ2C5gDxZQ==
X-Received: by 2002:ac5:cb1a:: with SMTP id r26mr7194206vkl.31.1587573716475;
        Wed, 22 Apr 2020 09:41:56 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 204sm1723146vka.32.2020.04.22.09.41.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:41:55 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a10so2340610uad.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:41:55 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr17366394uab.8.1587573715089;
 Wed, 22 Apr 2020 09:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.870192415@infradead.org>
 <20200422135628.GH4898@sirena.org.uk> <CAD=FV=VcbXoxtzyvLsFZuCDXJwCv8Y3pUdYBKMUmJaNcueBrqQ@mail.gmail.com>
 <CABXOdTd-ze8=s8nXNvPSjBBQKX9N3e4v3xQfs_mbJfKaUrvZ0g@mail.gmail.com>
In-Reply-To: <CABXOdTd-ze8=s8nXNvPSjBBQKX9N3e4v3xQfs_mbJfKaUrvZ0g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Apr 2020 09:41:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWVk4UQPozEX1D6wKVXAd=JpGgvB74mcR=j+av+Qyv6w@mail.gmail.com>
Message-ID: <CAD=FV=XWVk4UQPozEX1D6wKVXAd=JpGgvB74mcR=j+av+Qyv6w@mail.gmail.com>
Subject: Re: [PATCH 11/23] sched,spi: Convert to sched_set_fifo*()
To:     Guenter Roeck <groeck@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, qais.yousef@arm.com,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 22, 2020 at 8:48 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Wed, Apr 22, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Apr 22, 2020 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Wed, Apr 22, 2020 at 01:27:30PM +0200, Peter Zijlstra wrote:
> > > > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > > > take away the priority field, the kernel can't possibly make an
> > > > informed decision.
> > > >
> > > > No effective change.
> > >
> > > Copying Doug who did this change and Guenter who reviewed it.  This
> > > looks fine to me but I've no particular involvement with the code or
> > > platforms that are affected here.
> >
> > Thanks!  Probably the maintainers of cros_ec_spi.c (Benson and Enric)
> > should be aware of it, too.  CCing them.
> >
> > From my point of view, my response is pretty much identical to the one
> > I wrote when the priority was reduced from "MAX_RT_PRIO - 1" to
> > "MAX_RT_PRIO / 2" [1].  Basically, any priority that keeps us from
> > being preempted by tasks that are only high priority for performance
> > reasons (like dm crypt and loopback did when I last analyzed) is fine.
> > Our priority needs to be high not for performance reasons but for
> > correctness reasons (the other side will drop our data if we don't
> > respond in time).
> >
> The crypto engine ends up running at the same priority level, so I am
> a bit concerned that this patch series will re-introduce the problem
> that Doug's initial patch tried to solve.

Do you have a pointer to the code you're looking at?  Digging through
my old investigation for dm-crypt showed the problem to be the code
touched by commit a1b89132dc4f ("dm crypt: use
WQ_HIGHPRI for the IO and crypt workqueues").  Interestingly enough,
that's been reverted in commit f612b2132db5 ("Revert "dm crypt: use
WQ_HIGHPRI for the IO and crypt workqueues"").

Even if something is using WQ_HIGHPRI, last I checked WQ_HIGHPRI was
the highest non-relatime priority.  Looking quickly I see
"HIGHPRI_NICE_LEVEL" which is MIN_NICE.  I don't think that implies
realtime, but I assume sched_fifo() still does.

-Doug
