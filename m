Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAC8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 20:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8242075E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 20:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LOCA5F9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHWUZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 16:25:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96765C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 13:25:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so6457321oij.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TTMAabZtXv1v/W56KRwCsWEu0W62vMUeZGZ/7Bh+hY=;
        b=LOCA5F9zkZeu/VxnhLT/ohqejrrx0vUJBviVgbDnnXSUMAL6Om4blNy0pkN/flamIh
         JLHMO60twH07UtWSXQSLAAtRkuw7rx6lc1PbAtNUW2vZILgcv/AGjhsQhD6n1+U7TDcL
         DEjmGbOTCF+VRUuEmXb8DSijTsGSrnn2C9UNAXAWz+ZYx8ptKUxkqsYhKD2tOzRhC+Zx
         PtPC2zfYnl8WCnCl2w6qeSwC5BOZP638NFvIZRoVbrqr31wSI7FIf3t+mkojoEOfmzBx
         TURQ1n09qFm/IzU140Eu/azyYy0h/MRCIa0QNDkiOJhyEG+P1HaKiyhz6w1X1H+tRxN2
         MpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TTMAabZtXv1v/W56KRwCsWEu0W62vMUeZGZ/7Bh+hY=;
        b=a4M3LcA7kE+EGkmA5PZzwNs/d6IagPgHLK1grQbCGVOqYI1ShDzCtWECJpIIWniij7
         cUFuFklIOhf+hmlqUWslXASBX3NqAOFHURGxcEdn7Wh9XIMKDNeCoWu1mHcgcvfQaLtb
         NfcbDzZt4gUnS5mwwQ76CBerX5hzuuT73vg1Yt9gnIZnsKsoXzsgLXk59bA238+UF92b
         3mygGbiYeRZJrgMTM6U9jEJfG+qhGqrdKnwyCvSxWaQOKvC17xmd3bx+XwGbhBi7yP7t
         mRIZ1FEBJuRngx/ym6aYoWrYt9he2MZXWVyNa+DGSJrSRQjC3XHVRl193DPFy8NZe0ST
         nkXw==
X-Gm-Message-State: AOAM530fnkX+r4Ar4bcnoqj6U6IgDoSJjqirdqh7mJyhAPFKjhGVSxQP
        Pdh7UqeALHY6dOlJycpLdQB6OrdHr4uMXHotCXwJR9liTlCN9w==
X-Google-Smtp-Source: ABdhPJw3d/plSErAABmhYra+1g0qqd4u7sUS7YJXUXBwRuTrlHBHP8cR0UlEC6wPuJiJFLg82tfpPMgphT0uWr9mQm0=
X-Received: by 2002:aca:72c4:: with SMTP id p187mr1325629oic.141.1598214325855;
 Sun, 23 Aug 2020 13:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
From:   Thomas Graichen <thomas.graichen@googlemail.com>
Date:   Sun, 23 Aug 2020 22:25:12 +0200
Message-ID: <CAOUEw13NDv9NoFphwLjSzwNpYp8RpVmfXjd0oR8AXNFQHrvcBw@mail.gmail.com>
Subject: Re: [PATCH RESEND v1] ARM: dts: meson8: remove two invalid interrupt
 lines from the GPU node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 8:20 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The 3.10 vendor kernel defines the following GPU 20 interrupt lines:
>   #define INT_MALI_GP                 AM_IRQ(160)
>   #define INT_MALI_GP_MMU             AM_IRQ(161)
>   #define INT_MALI_PP                 AM_IRQ(162)
>   #define INT_MALI_PMU                AM_IRQ(163)
>   #define INT_MALI_PP0                AM_IRQ(164)
>   #define INT_MALI_PP0_MMU            AM_IRQ(165)
>   #define INT_MALI_PP1                AM_IRQ(166)
>   #define INT_MALI_PP1_MMU            AM_IRQ(167)
>   #define INT_MALI_PP2                AM_IRQ(168)
>   #define INT_MALI_PP2_MMU            AM_IRQ(169)
>   #define INT_MALI_PP3                AM_IRQ(170)
>   #define INT_MALI_PP3_MMU            AM_IRQ(171)
>   #define INT_MALI_PP4                AM_IRQ(172)
>   #define INT_MALI_PP4_MMU            AM_IRQ(173)
>   #define INT_MALI_PP5                AM_IRQ(174)
>   #define INT_MALI_PP5_MMU            AM_IRQ(175)
>   #define INT_MALI_PP6                AM_IRQ(176)
>   #define INT_MALI_PP6_MMU            AM_IRQ(177)
>   #define INT_MALI_PP7                AM_IRQ(178)
>   #define INT_MALI_PP7_MMU            AM_IRQ(179)
>
> However, the driver from the 3.10 vendor kernel does not use the
> following four interrupt lines:
> - INT_MALI_PP3
> - INT_MALI_PP3_MMU
> - INT_MALI_PP7
> - INT_MALI_PP7_MMU
>
> Drop the "pp3" and "ppmmu3" interrupt lines. This is also important
> because there is no matching entry in interrupt-names for it (meaning
> the "pp2" interrupt is actually assigned to the "pp3" interrupt line).
>
> Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
> Reported-by: Thomas Graichen <thomas.graichen@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: thomas graichen <thomas.graichen@gmail.com>

sorry - looks like i missed this one

> ---
> re-send of v1 from [0] because it was never picked up
>
>
> [0] https://patchwork.kernel.org/patch/11582619/
>
>
>  arch/arm/boot/dts/meson8.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 277c0bb10453..04688e8abce2 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -240,8 +240,6 @@ mali: gpu@c0000 {
>                                      <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
> --
> 2.28.0
>
