Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2021AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4CD2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zzm4Pu4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAJRF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:05:26 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40309 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgAJRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:05:26 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so1038311qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DFLvkIvsfRzEeYeMWimySYLVF+WpVlUlb5e+/01GHvo=;
        b=zzm4Pu4tY+i6CjZzXLpu3q8tUORkx30aLLzUewljvt9lD0bcIPQnhmZxTeUIFY5oAP
         xuDP1FF6Ftr/zy0U6/JwPOD2vs0tUhl4wOAT6X7KcUBnenHFJ1yTS8N+V+/WVkUExkXO
         EW3ILIox/xZvxQPYJGFZ+6PD/4Tw8+N32RhPLaXho7FgNDSDudmheN31ju0Gd1v0ZB23
         t9Fw09laMgMRGJFtvJ2JkCpYZfu3leqcfzMdoVsTph6NRLhUczMDHrnS5CSiYtFYjLzq
         u2A1uzCm4hUfImX+tega47fMul0DqHXviCkksWFGQC8RPQsaR6kyzedNn8ZG4GWyKRj9
         O7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DFLvkIvsfRzEeYeMWimySYLVF+WpVlUlb5e+/01GHvo=;
        b=GNH0DsKpamMO1BGYrBS9hzOIPH9I6OaqpFKBLS8lvj4v/I9hqklDfZ8f9y4nBro3+Q
         KhscZlVak+sJp5gXGLUXkGYwA7c30AdKmCwtaUQUHWJZdf6wp0G0tY9JsXszD1Hb50FL
         NquM5dxiivfGK+SZtcaMVCi7A2TdBn/m5oV9qYBGnOY9vgwKOQ/xLl2dVtAju27bspDA
         jv9Ca78PLIIjdYxT8oIp2Tl7NVr9UaqmWxW3jw0cBV8UQZvyDLjMl1hha+URVqNJt2WW
         hkHug1/b4hgWMUAfvA7qZ4dbnnTVxiK+JSnX0uyRMhWz3LMFQ0A97s1h9BOkQMuCj8VW
         INzQ==
X-Gm-Message-State: APjAAAUXG8dCug9R63Z3vD0TNv5aDFRJgUf21m1y+fGtVfi0fCa/KmNN
        m31y+m8R/kpvl5fTvfekUjD2WbfwAPKygcjUgYwlOA==
X-Google-Smtp-Source: APXvYqz0la7Efw22ferpTBoxBVrqBOeHq6hHZrpdbVSdb3RbLMFutQxcZ6MulKHyCuMEVUjVgvyT8CCoi58kSRbAQ/E=
X-Received: by 2002:a0c:d60e:: with SMTP id c14mr3677889qvj.76.1578675925325;
 Fri, 10 Jan 2020 09:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20191224100328.13608-1-brgl@bgdev.pl> <20191224100328.13608-2-brgl@bgdev.pl>
 <c6b69cb6-b784-0d6c-efaf-87926c20db16@linaro.org>
In-Reply-To: <c6b69cb6-b784-0d6c-efaf-87926c20db16@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 10 Jan 2020 18:05:14 +0100
Message-ID: <CAMpxmJWscNUgot8OuxbheSJa=GZA4q-b0JAhATBy9uqYR6EGug@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clocksource: davinci: only enable tim34 in
 periodic mode once it's initialized
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 sty 2020 o 00:12 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
> On 24/12/2019 11:03, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The DM365 platform has a strange quirk (only present when using ancient
> > u-boot - mainline u-boot v2013.01 and later works fine) where if we
> > enable the second half of the timer in periodic mode before we do its
> > initialization - the time won't start flowing and we can't boot.
> >
> > When using more recent u-boot, we can enable the timer, then reinitiali=
ze
> > it and all works fine.
> >
> > I've been unable to figure out why that is, but a workaround for this
> > is straightforward - don't enable the tim34 timer in periodic mode unti=
l
> > it's properly initialized.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Why not move clockevents_config_and_register() after
> davinci_clocksource_init_tim34() is called ?

Ha! Yes, that works too. I'll send a v3 shortly.

Bart
