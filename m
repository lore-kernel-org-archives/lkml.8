Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D8C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A572073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzwTwOQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0TB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:01:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43957 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0TB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:01:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id n20so8741603lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CooN/lA7d5yACqkmjNxbvElnXH9xWYc5D690cPagV5A=;
        b=XzwTwOQ2tZqjO9DLphNswRW0Faz+tkI3lW4QKn8PnDodceq0s69XJc+EX+CaxLUZAc
         DsmeaJdkg7faxGR2WlOr2Q2xOqCK3LhvO83UpvhTPjbrrDITVXe01nU0HW2zIBGLSdNK
         x+SI4S2qeU3EY5SopL7X1UD90wHcT3WjJvLfVVsAO2U5Em5d1XWCXX0PRhRjUwlFbFjC
         /RhNOl/qPgtup89fKy/XuqC10uHh8xb2p99SAbLCDPTbSVvO8tHFnVGOGXPs57VzLKHy
         z3pNrxrHAv/ZVQFSEpVOjEocb4Os2eKubiclJ5LN8KBbJgdGF3NkBVCWlJGOm0DbvFTa
         Y1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CooN/lA7d5yACqkmjNxbvElnXH9xWYc5D690cPagV5A=;
        b=KlyOMtqsuX4o7J9AxHAm6topx9Zfucd6nDx2+mGXrzL1FfTUw4bLpUBhpeg7OUhwfn
         NWfmkrUwuuAiHxJbzoWfPxLBV4bK7C1lzbPFIsmukw2ckEzNYR8a+iabg5XJWKRTkjkx
         pJ5/Y2Y8ZNJGlb70dntFTNdY5AovkioAw0dFPggcOTxbsM1kvu0mckZNHEGDtIvzHPDK
         sHOGljE1WooYGEbrJjLmqnWPeRvOElZEg1JMZ/1xM97oHkKBHRYr8XvGuCYRU/oJHVBg
         P6jYTLN0AJurxyAGdWomAUtn6O/q+4xb1STF0f38MXlfd0zcHQtk0s3iAe0IFKAHPZKp
         kCdw==
X-Gm-Message-State: AGi0PuaRmi/dDR8L6/bIPLQFEZW0hdoDoaPiOnAuLahO+fAwEl/cuGoo
        hfYwzjw3163nOFNjSR/aqhLqiQmJmbYHZgyXYdO8zA==
X-Google-Smtp-Source: APiQypLD/fNDqtD4u7+uuQ8ZqMmHjJHk9/rbkJ2Ows6MzWRJlKEVAAUCTvzeqzTfoWN78XIJxBngK/onAWpgkIOJt00=
X-Received: by 2002:ac2:5f7c:: with SMTP id c28mr457241lfc.4.1585335716191;
 Fri, 27 Mar 2020 12:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200317205017.28280-1-michael@walle.cc> <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
 <9c310f2a11913d4d089ef1b07671be00@walle.cc> <CAMpxmJXmD-M+Wbj6=wgFgP2aDxbqDN=ceHi1XDun4iwdLm55Zg@mail.gmail.com>
 <22944c9b62aa69da418de7766b7741bd@walle.cc> <CACRpkdbJ3DBO+W4P0n-CfZ1T3L8d_L0Nizra8frkv92XPXR4WA@mail.gmail.com>
 <4d8d3bc26bdf73eb5c0e5851589fe085@walle.cc>
In-Reply-To: <4d8d3bc26bdf73eb5c0e5851589fe085@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 20:01:44 +0100
Message-ID: <CACRpkdYwqReW+UcY=4S3ZnC+jFeVr=e+Ns12A_CK6o7VBUXHbA@mail.gmail.com>
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

On Fri, Mar 27, 2020 at 4:28 PM Michael Walle <michael@walle.cc> wrote:

> For starters, would that be a drivers/gpio/gpio-regmap.c or a
> drivers/base/regmap/regmap-gpio.c? I would assume the first,

Yeah I would name it like that. gpio-regmap.c.

Yours,
Linus Walleij
