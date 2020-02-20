Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F9C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A510206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGDChIYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgBTVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:37:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38285 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:37:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id i23so4041397qtr.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBuh5ANX049XvoAuYc6kDkKQiW67h+g1q8TDSOz1dqU=;
        b=gGDChIYPb7jifbHXTNEr728+h/KDQM6oZ7iVOorsQNIlKeVpq2/SWfmMjeV3fCn0IT
         5Z2JU3eyCSYgMYZHr282T7BARLiT6neyNUQ8AhMzPP76JzdW6pxlHmMZdB0qc5ODL4h9
         dTIAfGVApio3FQtTS8zEDmHH4KRuYmBYE2XNcUx04fQpRWwqO4r9qVGQpgKTNOi4uEic
         RqehqrYh6mTmB3uzl2Dk9YpAwvbBV1u3Dp+MoE0D4g/Z4K/aN5dyS2UfmMu1bBRLILNw
         Wxkqw+0ZOuLIe+c5df12j53P273GoEdnEFHR3m5YPd1PY/pFyiVUmYdqVU+lm3jINvgH
         mpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBuh5ANX049XvoAuYc6kDkKQiW67h+g1q8TDSOz1dqU=;
        b=DXWaXxWQ3fcqPrUWRWEByiTa0f+io4FJYRzlBFM+ggj985sM9DYwUOGZZGcd+IMpbW
         HDrIKEpYHInn74uG84+XzghOzITYGvWM0S1/vdR2uYaxxo2iWOwSorqaLbeNk5nNmiA3
         DkzQqLOp56m8VrwDrr7uzXD/hLp2Nb2zGow/6FyoWYM/NRW2WaOQcOH/b8DNeRKQVD7X
         MJDoplzfnQlEVKdN78hMRzZpkWxpfcopZlt4YvvLbafrSqIm5vK96TXZfANcQQto9SCS
         GT2x3y0qHYNDMzdAFmBfpiExG7ZwlwACUdrDAxKyv1m40K+vVFyeYRtIhPkHYs1WlYDe
         igrw==
X-Gm-Message-State: APjAAAXhkFFzsS1uA/F/DO7NZ2BRP4cMijC1xDg8OjiBFNfqzBpzU6YF
        iLdKShTwGvAE1J/obrjPA2HZlzL23b/JKK5zcXY=
X-Google-Smtp-Source: APXvYqzVOuz4VOsLhkc8YTufGND1jjwArsxRuKUoHzscIuXxfusDClP5+wUXXUMLe5wT6EW+hBj9NijsRym/f5FvRGs=
X-Received: by 2002:ac8:424f:: with SMTP id r15mr28256802qtm.71.1582234619657;
 Thu, 20 Feb 2020 13:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20200220083508.792071-1-anarsoul@gmail.com> <20200220083508.792071-4-anarsoul@gmail.com>
 <20200220135608.GE4998@pendragon.ideasonboard.com> <20200220212120.GA24526@ravnborg.org>
In-Reply-To: <20200220212120.GA24526@ravnborg.org>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 20 Feb 2020 13:36:46 -0800
Message-ID: <CA+E=qVfFJn_Nx+-2=m8uDk+yisJE0MrsXOEPURqzmbqVLZmEKA@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: Add Guangdong Neweast Optoelectronics
 CO. LTD vendor prefix
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jonas Karlman <jonas@kwiboo.se>, Torsten Duwe <duwe@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 1:21 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Laurent.
>
> > > +  "^neweast,.*":
> > > +    description: Guangdong Neweast Optoelectronics CO., LT
> >
> > Google only returns two hits for this name, beside the ones related to
> > this patch series. Are you sure this is the correct company name ?
>
> Seems legit:
> http://www.eastbl.com/
>
> But maybe their chinese name was better a basis for vendor prefix?
>
> Guangdong New Oriental Optoelectronics

They call themselves "Guangdong NewEast Optoelectronics" in English,
so I think it's better to keep it as is.

>
>         Sam
