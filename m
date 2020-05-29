Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC2D206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIiY2uXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgE2LLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgE2LLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:11:24 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D34C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:11:23 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id w20so647120uaa.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AwrUer66OLVbJn9gdzvmfOhYQqwIlg5wUQfH8z+L9E=;
        b=gIiY2uXfVx/jE5BgaImYNhlcq8Xd5qTnTI7LkXYOntgiBeoPwssFpKuZ8wqLvAvB4/
         LX7Jb9eMDQ53brUmKsW0F2XDgbLPzN4Q4FoFuovNs+Cc2B4y4GKpsfw2g//pgZBK2Vob
         +bnRipihc4uKFDvIBdDOsJdKn3Mc8C1MrKkbEErgX5WGdtOn6AyBk1TRQdAbwRDahkqN
         IIC/J1PGd7xwDYV8nGUKaW0Ib2K4I9bxCpo+SZIFPdOB9Ho/PjsQXvuDvv6ZEveExO3G
         Wb+c+piCnfmHOantUQDNU3hAcLsNGrgbcjaD/HehEBR66mk+O7DDpSZAPBikBGgHQ0Gj
         8x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AwrUer66OLVbJn9gdzvmfOhYQqwIlg5wUQfH8z+L9E=;
        b=dyL0sLlOobmHqXMYfXZhizC1OEvUstfmJfQ/1zTNX+PM8PnRhkMgK+MsGZ08xvcF1R
         mHAqSd3xJnKIkVJFWK5tyaUcbSHoNxFB3UjTG5r9IWuUzSEgmiA6qzKsBVizAEIudP+H
         1ozyJZtwpiPPQF6I2f3v8XVEtFV2lgTKjITEwJ6QrHq4o0V1S2s0l/Ib37e1kNh08Ixr
         ioO8QKOnVBajDBBnAP/o8t8oeh66nt4isdFhWQZZCM0W/Lry53sGKXLPnb89QSmbShUD
         tADYHOUb5RA8wg+MZQIXUJYU4cc/WDQBGC3CB18t7qpCc1dFX1wOmfKNCGaSCBNCRSw8
         22mg==
X-Gm-Message-State: AOAM5321l8awrCO4DTJ82RjauryfiLPDGyiCP+2uTlZ2VHBnWGjHlnDF
        U1DOG0Y8GjgsKfyaeMhc/6F/8KDeSTS+WEbukaRhvlRJOaM=
X-Google-Smtp-Source: ABdhPJxzIJYkIIPCpHPcwk9GVxYXgVz7s/pLv3zscWWcayOPhVZi78TJgQ2gcLvnE1Sv4H8X+ooqNNHjqbT8vtW53Xg=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr5439045ual.15.1590750682843;
 Fri, 29 May 2020 04:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200521091356.2211020-1-lkundrak@v3.sk> <20200521091356.2211020-2-lkundrak@v3.sk>
 <CAPDyKFogpp+9d44Dgc8gXmeULj2CxoUzo4EhnLp+=_1YcvXT-g@mail.gmail.com> <20200528225445.GB815881@bogus>
In-Reply-To: <20200528225445.GB815881@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 May 2020 13:10:46 +0200
Message-ID: <CAPDyKFpcxncUFf+qMaRGnC1qA0ST1HzQCrars5YZTeMfFVHj6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: mmc: Convert sdhci-pxa to json-schema
To:     Rob Herring <robh@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 00:54, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 09:59:10AM +0200, Ulf Hansson wrote:
> > On Thu, 21 May 2020 at 11:14, Lubomir Rintel <lkundrak@v3.sk> wrote:
> > >
> > > Convert the sdhci-pxa binding to DT schema format using json-schema.
> > >
> > > At the same time, fix a couple of issues with the examples discovered by
> > > the validation tool -- a semicolon instead of a comma and wrong node names.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> >
> > Rob, are you fine with this v2? I am intending to queue it up via my
> > mmc tree, unless you want to pick it?
>
> You can take it if you drop my name from 'maintainers'. Ideally, it
> shouldn't be your name either (should have called it 'owners'
> instead...).

Patch amended!

>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, applied to my next branch!

Kind regards
Uffe
