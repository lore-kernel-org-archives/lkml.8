Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCBE206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rkKiIc4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgGWGe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWGe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:34:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74547C0619E2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:34:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so5126790eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHBydU8vIOvimRwIQ4AVmmdC0WTsfc4hrzMrtnp6v40=;
        b=rkKiIc4bIcWziclAnuygl88kLrosymEFhyaR5U3rtuhiQbRhU/oG9QfgSw6A9Ons5p
         UATja2ojOHWqBgsAldLe/SfxOn3rNlg0RYcHhV+SvOb1w+Zy3Do086g2y+175lAWp6r2
         oEaQbXci13z0gFCVVQAYjUiwdjjx7wso13jrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHBydU8vIOvimRwIQ4AVmmdC0WTsfc4hrzMrtnp6v40=;
        b=Y3JtaQotXS5qI67oALe6JtZ3ij7zpfL1H65UhwQ/SU7F17bySPtQL0mykHNWYMjgGM
         4w3seiBF2tuvN+dTCHxH3RnHaVCE8WGP5cU+mvdQEPJ4BVR3OvgRyXHdwunYQU+ykOFS
         RbaX1yHhUc73wVt7zidLTh3w44LEBR5ggN7uVeVPxzEno8ss5XsbKA/43c+G/BnpmvIb
         lN8aBNDOxfpldXgD0fKXijP5dCNaZZpglRoeprdhl/z2SdFIEm1FFXZY4oK9PgWdFDuB
         ussEWpILbT+FR1Eth6h7zlj4wvR9WFp1vVkvXGq4S3BysevqYrZN1qWhD8J7cmFAUBbY
         rWoQ==
X-Gm-Message-State: AOAM530TT3FIBOpIY4EW4+9pUShoqULU6lXE45kEtsuSJciwT9W4E9sa
        QUszIFqvDwVr58Hy5PTnGPz/E2zO+cZh3LjpZJAxtQ==
X-Google-Smtp-Source: ABdhPJxsyATkUuOcnQe0rXO2IGjkjtHk9Fd38vKQTVik9MvcczWGbe4wq7L/G9FA2hVRAHtaDc0LvXdPYIpmPCd4id0=
X-Received: by 2002:a17:906:e46:: with SMTP id q6mr2058869eji.234.1595486063946;
 Wed, 22 Jul 2020 23:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200722190949.215656-1-jagan@amarulasolutions.com>
 <20200722190949.215656-3-jagan@amarulasolutions.com> <3893924.cuH9TW0V3R@phil>
In-Reply-To: <3893924.cuH9TW0V3R@phil>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 23 Jul 2020 12:04:12 +0530
Message-ID: <CAMty3ZDk28-wg_=wdf_Ps-5RaHK1T-+h0Jn43aK5ReWAz+GTGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: rockchip: Add ROCKPi 4B binding
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Thu, Jul 23, 2020 at 4:43 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> Am Mittwoch, 22. Juli 2020, 21:09:46 CEST schrieb Jagan Teki:
> > Add dt-bindings for ROCKPi 4B which is similar to 4A with
> > additional AP6256 Wifi/BT, PoE.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - new patch
> >
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index 36057c9e4b83..7250adb43d24 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -448,6 +448,12 @@ properties:
> >            - const: radxa,rockpi4a
> >            - const: rockchip,rk3399
> >
> > +      - description: Radxa ROCK Pi 4B
> > +        items:
> > +          - const: radxa,rockpi4
> > +          - const: radxa,rockpi4b
> > +          - const: rockchip,rk3399
> > +
>
> Please do all RockPi4 variants into one entry, so we want something like:
>
>       - description: Radxa ROCK Pi 4

What if the description has something like below.

          - description: Radxa ROCK Pi 4A/B/C

Jagan.
