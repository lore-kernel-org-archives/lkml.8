Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A6FC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AF2207FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1Uryj1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCDTas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:30:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41854 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDTas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:30:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so3295061oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1hBDuTj5DKdqI1D6QdlHihqCJQwThRu8E8B+XZMHIU=;
        b=r1Uryj1NDD0JkgMwSl0hQiab0O6yqkh4uEnZ/4nlsIy0yG3tWZvd8iRX3ps02nVZPp
         SL2XkqBEBwi36q74phYiRf39TroHOQ5Xbnrt0B1XXvcGwZH65CR5Qy0htnBBEkNQqXe1
         HZFKQN0v99OX20sIHWjqY4cb4HUC7BRkCVXDmIIxsiHp7XO5bu0TBJmb8cSRwx7d4B75
         gQehAp4b5UR2IZrFIgErt0I4g/BmiXk2BP5zMJCZK9+y+ihkba6EFF/jaAETxiAniQX1
         DlvWUkb0Ys6HgKId3oQNjFkNQV7fAipuKCe3lx4FStT3PRPwiPoEzcWXuPW5mX8BlV7R
         6WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1hBDuTj5DKdqI1D6QdlHihqCJQwThRu8E8B+XZMHIU=;
        b=DiDWNhu0uCbcMeXH1YaUUgayhPuttIkhbDa2iaIeGiElEl4K3MzDmG1Z4hx2l7H4v/
         l8bV+EYcn/nNot+XnfkH4dsq0wQT5JKtLoEJNV8LrNv8+m7CSFeKeUPv+48jU+sug0Lz
         uJuTe3oSdWZFa69821/qwGQJ1BxjgSLpHri4PtDFmvLI/K0U9neVxsdPGmOllWiL9eJu
         7TEyc9EugNFfKqoQKK/orpOIvpZL+8GXF7aY6KgJQG6wB0t9s5WRM3CaVbBDnDipvxG1
         7YSY/hLUNOb9vYLOiW+CVHVrc6yuto/pKVRpJK74EOuRCJfAVmcsY/SljfnYZRnLPnpc
         Y5sg==
X-Gm-Message-State: ANhLgQ1k2JVytRNhHbcbMCB84qdJcFdy9Axqkud6uUNPU4evzR8AlonN
        kNXKF6xJSKvdm4opOQplcciw4WxkZ67MPTxFNNlX6w==
X-Google-Smtp-Source: ADFU+vs2vaQrQ7kp2NGMoTMDmG2l6VuaVi60jgfpU4RAjhIzPvbNOqgBhKY9euHn5Qg/96Y3B1qg3tPDPviuetP3eBc=
X-Received: by 2002:a05:6808:d7:: with SMTP id t23mr2913141oic.69.1583350246176;
 Wed, 04 Mar 2020 11:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
In-Reply-To: <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 4 Mar 2020 11:30:10 -0800
Message-ID: <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com>
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 1:22 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 11/01/2020 06:21, Saravana Kannan wrote:
> > > Timer initialization is done during early boot way before the driver
> > > core starts processing devices and drivers. Timers initialized during
> > > this early boot period don't really need or use a struct device.
> > >
> > > However, for timers represented as device tree nodes, the struct devices
> > > are still created and sit around unused and wasting memory. This change
> > > avoid this by marking the device tree nodes as "populated" if the
> > > corresponding timer is successfully initialized.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/clocksource/timer-probe.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> > > index ee9574da53c0..a10f28d750a9 100644
> > > --- a/drivers/clocksource/timer-probe.c
> > > +++ b/drivers/clocksource/timer-probe.c
> > > @@ -27,8 +27,10 @@ void __init timer_probe(void)
> > >
> > >               init_func_ret = match->data;
> > >
> > > +             of_node_set_flag(np, OF_POPULATED);
> > >               ret = init_func_ret(np);
> > >               if (ret) {
> > > +                     of_node_clear_flag(np, OF_POPULATED);
> >
> > Isn't it in conflict with:
> >
> > drivers/clocksource/ingenic-timer.c
> >
> > ?
>
> No, it won't interfere with that driver because:
> 1. This flag is getting set only if the driver already registered a
> timer init function using TIMER_OF_DECLARE.
> 2. And if the function fails, we clear the flag.
>
> So in the case of ingenic-timer, the device will still be there and be
> probed by the driver.

Daniel, friendly reminder. Or do you have a patchworks link too that I
can keep an eye on?

-Saravana
