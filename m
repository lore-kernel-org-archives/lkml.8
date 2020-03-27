Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B3020705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWdcmcSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0KVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:21:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36631 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgC0KVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:21:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id s1so7370578lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuB8BNTEMS6Xu4xWKK0GTpM0KTFJDSPd7CoTH260LEY=;
        b=BWdcmcSOZAia9WokqOKv83FwargH+rfDXr2Mp0QwyZsT/mABCSd3y3ZMISvNsbmXhU
         gQMIR1duY1UxdvKr1tbHQzNudMLJvKqINJWtOlrbk9+kwOmXToR95IOMrI3yVrYmqYw4
         ERIXKr3kSqBiWHHSNhbcDl9Iko5A1Q0USZ7lVRGh7i4ZWuu8E4UBLvEJ0Rb7XNIkfIsy
         aw8uoNh4prsuenO/RPpdtz/llUkVRpSahQ6WFiqcc4YqGBOhRx5YxeATNzXZkpF5gRXs
         u9qzGndEeTvD5XvNeditQ2MMZ58/zYFaGXYoaCpP0AzoqV0GaxsvyztxFYEj52lAcoCH
         pBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuB8BNTEMS6Xu4xWKK0GTpM0KTFJDSPd7CoTH260LEY=;
        b=rln4Yd7cKCiM7XyFwTcY1Fa7EA6Hj5H9otsTrpdNMgXDOGVxbx8Kq2q4AygdUu74Cl
         ekfLWcbib3vC7fsbmzCOFfbg6t6dqJP9JAl+sPReNi5Szz0kHaGKxJjJbL30J88k+N5a
         3mY0ryDOIOu7/b05kW4jzOaDmj5JEcrZ0kIqB8tzEIg7O8yvIhM2jl3H5b66X98UaHwO
         dTAOtnB8en9CHmHoV77S1KWC3u+kC3rWmxFYOFSnJJvak3ET+6xQJTxyXy664mhFc/3d
         Ey+Qg5p138DUY2yChhOt218cOJEvGjL2ZSZqbR3Ph76ys7yZx7vC91hFDswu/RY553xW
         N8YA==
X-Gm-Message-State: ANhLgQ3/NjOes02RkWEOr9HJo85T/8x7GE3YxIEKLdYq7FLJ5eOV6/Rt
        CA/v4soNGQrfqUHMkfq2MuREGr0v+RlN/CeVjRs+vg==
X-Google-Smtp-Source: ADFU+vtsIgqK8FyZODtKNKWKI1HxhtKduwTybRXQvKGmxQLsPLeMOqx9p3y4gdOqstKYu6oc3bIWeFZeiamysR3lBHg=
X-Received: by 2002:a19:ac8:: with SMTP id 191mr8675462lfk.77.1585304468041;
 Fri, 27 Mar 2020 03:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200317205017.28280-1-michael@walle.cc> <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
 <9c310f2a11913d4d089ef1b07671be00@walle.cc> <CAMpxmJXmD-M+Wbj6=wgFgP2aDxbqDN=ceHi1XDun4iwdLm55Zg@mail.gmail.com>
 <22944c9b62aa69da418de7766b7741bd@walle.cc>
In-Reply-To: <22944c9b62aa69da418de7766b7741bd@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 11:20:56 +0100
Message-ID: <CACRpkdbJ3DBO+W4P0n-CfZ1T3L8d_L0Nizra8frkv92XPXR4WA@mail.gmail.com>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 9:06 PM Michael Walle <michael@walle.cc> wrote:
> Am 2020-03-25 12:50, schrieb Bartosz Golaszewski:

> > In that case maybe you should use the disable_locking option in
> > regmap_config and provide your own callbacks that you can use in the
> > irqchip code too?
>
> But how would that solve problem (1). And keep in mind, that the
> reqmap_irqchip is actually used for the interrupt controller, which
> is not this gpio controller.
>
> Ie. the interrupt controller of the sl28cpld uses the regmap_irqchip
> and all interrupt phandles pointing to the interrupt controller will
> reference the toplevel node. Any phandles pointing to the gpio
> controller will reference the GPIO subnode.

Ideally we would create something generic that has been on my
mind for some time, like a generic GPIO regmap irqchip now that
there are a few controllers like that.

I don't know how feasible it is or how much work it would be. But
as with GPIO_GENERIC (for MMIO) it would be helpful since we
can then implement things like .set_multiple() and .get_multiple()
for everyone.

Yours,
Linus Walleij
