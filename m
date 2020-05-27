Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7698208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlA8n5lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgE0Kqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgE0Kqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:46:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B924C061A0F;
        Wed, 27 May 2020 03:46:30 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j3so23445007ilk.11;
        Wed, 27 May 2020 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jV5qqlg6B+ZoGgVeaw+flUZDliIqHLZTV9SrChni80o=;
        b=mlA8n5ltaxaXU5Jzq9gQDdiAdLm7WHNtzEPDDmBFHHI5aY7Pd0ha50AJnDMF9b5/Xm
         Z2ZZRZAcqCMtYbCKXy3nceVZD3RnzhXQfF+FLoOHKH8bFRYpXfHoR4oHaf9m4htN+X4B
         kHOeUbi0Es6U1y5RBtZATXe0Vo/gA2fGm6nOOsrDYa+k5mwPj63ViOoY1u9rdK/cGq+8
         TNYJXlgXwwoTT32s8D0Fll3n5Ele44yw479wCHp13y6U/wV9kEPFVAgD6FH+dQ8sbV4q
         7hsp0Qisu5/+NRQsczixdYHaJcgLXXiFIaskLiZHmpQiPYObZI0OhYc25SDBa5uqdRto
         J8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV5qqlg6B+ZoGgVeaw+flUZDliIqHLZTV9SrChni80o=;
        b=N5L3jLQjaFij+uE3WYhoqmzNVPi6mofdTAXFBdxgJIbqks5h+NYPwKJjAnZm5wsHWA
         Do6OUwR2vIvh5RWr0h+VHdr0Itme56VEu3gln0ppNLNUfLf7viLuVw2jS7uHfum79bAo
         91WRYLjysewqTDqkSHKySBrHGiHi1C9pU/qAfwituWNx7PILmC20JnqJexIZjlJCcRJC
         wtcLfZwmUev1MOKiUPPB60mnoplJ8V5GRbAmhohwtJE7cFMEJknXI5M5jC7yOFpeDhRD
         c+WOmU4uqN5SKOWoPGtTgPViHg7waqDNQfJxAxCAKSNW5LHAdogdTVXwJNJkr4Qju2EY
         zcwg==
X-Gm-Message-State: AOAM532bxiT9wyzBGCAVfNh6XIVUb8Lnkb54wNCwVsIeMd51JUDCeW5c
        1xLXBsRoaBQLVyWYI/x2AyMsYleEADXzFO+SyaY=
X-Google-Smtp-Source: ABdhPJxI8DmrhVOnjKvhDVgxWJ8+FIMyXLu/ryLZET7ClD2+54nQb9OTeBYG7x2X1lNxLOkc/LfdMlqtuwE8cn4F3ds=
X-Received: by 2002:a92:dc85:: with SMTP id c5mr4964053iln.270.1590576390035;
 Wed, 27 May 2020 03:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-9-git-send-email-dillon.minfei@gmail.com> <20200527095109.GA5308@sirena.org.uk>
In-Reply-To: <20200527095109.GA5308@sirena.org.uk>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 27 May 2020 18:45:53 +0800
Message-ID: <CAL9mu0JA=XRTj_HONQGtj74X05TAV0__dW2At0AAeymwNvJhEw@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hua Dillon <dillonhua@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 5:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 03:27:32PM +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > in l3gd20 driver startup, there is a setup failed error return from
> > stm32 spi driver
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Hi Mark,

sorry, forget to remove these two patch from this submits, will not
include it in later submits
which ack other's review result.

thanks.

best regards

Dillon,
