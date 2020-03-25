Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D1FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E4320737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFfszCj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCYXGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:06:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35729 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:06:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id k26so3939534otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSeT6PbqAXC+RZ7fex1F/Qco9gPlMFnDZIOtqUymYIY=;
        b=kFfszCj8WOXLltRIen3p/mLqt3nA3hHtMUxnONC2/Xe8FHmTK4+aBGpJSExXNej03h
         zCdraEfzjqh8PZkTTGWuWNbSIE5M1EoEwtxM+00+J0P/Lpt7dZMIrYTPgAc430slst4T
         u44FxJACNVqfv5Cac2DUf4TFzWll1xxaIp+rv7IAyLSPcwZxwHBPpvCxYMYeb0DOrJoa
         87BVL3I3kldHT/5ZOgLDLdbIvYoByRTpl1o5sZyo9PONR9vYNu0MdjmhguRiXqldpiPS
         vKcqL+seFDV+pK6O6ph364nRp6f0qUcISe2kQvr2bthbUAwL7X5NUK1HkEkOyVHGdaEZ
         G8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSeT6PbqAXC+RZ7fex1F/Qco9gPlMFnDZIOtqUymYIY=;
        b=qHtujUpNRu4aP/kwPwKawlQADaLA5otqMmcaWhwop1Q6HMYGl0L/lGGkGSp7Jxk0RP
         AnFWkHslEaQ4Ya9nLUn+FZrH/HV7mSedA1KBCdvtiJq6vtM0y98ylErn8HlzOHeveN9L
         MDLXs8WBss0tVjHqvGyxvQEbGY0lHNZKdWn7pQm9DqOxfNkqt1OLu5Q9pOlRx7qE6DtR
         gs8jEr8nIkFBAcimTeqim2RlJrm+G2GXB04CzJ7wVezRsVb90UgA4gRfr4YPN/tkeLyV
         AzkOUoS9RyeyCluRAcFU9WrRiJpKuUsNj12mz//erml41udwwrjwgLT09lHUWAGpvbTk
         nxuw==
X-Gm-Message-State: ANhLgQ3xLbobsqtpVlXinROLORsRJ2VB7NHSF64rbVhVm2SNmOc+B2Fv
        3Yt0KO6csotlpke23RVuprDfrB+N1UDrH6/nZLcuTA==
X-Google-Smtp-Source: ADFU+vs0O3noWCqvzSEKQGm34TPZtpX8RSea0LBVKeJ7RPXLdbsBi2pRXsGBqAcvYH2k7BJZKzr+p6CkqgZ3OjLmCk0=
X-Received: by 2002:a9d:5ad:: with SMTP id 42mr4495473otd.231.1585177611608;
 Wed, 25 Mar 2020 16:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
 <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
In-Reply-To: <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 25 Mar 2020 16:06:15 -0700
Message-ID: <CAGETcx_BZhSmUpN+Gssp1jcjGzG7SdOmg9TAQRhn4q4G_rFUfg@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 3:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Saravana Kannan <saravanak@google.com> writes:
> > > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> > > I took a closer look. So two different drivers [1] [2] are saying they
> > > know how to handle "arm,vexpress-sysreg" and are expecting to run at
> > > the same time. That seems a bit unusual to me. I wonder if this is a
> > > violation of the device-driver model because this expectation would
> > > never be allowed if these device drivers were actual drivers
> > > registered with driver-core. But that's a discussion for another time.
> > >
> > > To fix this issue you are facing, this patch should work:
> > > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
> >
> > Sorry, that's not a fix. That's a crude hack.
>
> If device nodes are being handled by drivers without binding a driver
> to struct devices, then not setting OF_POPULATED is wrong. So the
> original patch sets it. There are also very valid reasons for allowing
> OF_POPULATED to be cleared by a driver as discussed here [1].

Forgot to include [1]
[1] - https://lore.kernel.org/lkml/20200111052125.238212-1-saravanak@google.com/T/#m7b043de4c75e6c1de309d3ca5146bb0c7b3dfc80
For some reason Paul's email is missing from lore.kernel.org.

-Saravana
