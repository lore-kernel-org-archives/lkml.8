Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60098207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sx9MLkrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHUNEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgHUNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:04:08 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF55DC061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:04:07 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i20so392112vkk.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ag9vhIrITQpJEm39f+7OC9szPXt04RbAHbvMxPWSdZU=;
        b=Sx9MLkrA4coWxp/6zwxJU1Xob9ceBPQVinMuzOOanr+ml/ZBrbRiogTGboi8y1rtgo
         3ajd9nhZjSIMyM8JKHjnQoV3Zr0ZleW/n6B7uYLq4sLyG+p9UOYxwmSgJ/b5RaKpix5I
         TvwQOGBI8Zq+wJOy+8pFIwuw2/mixwL+MA+kLF4R2vlUyWmZYyMcgTm41ZKUnU9pVH/E
         Euqdq5WOIGdKmRlRzX0kzRZiShfDwTPVXCDdaH2tpQJ+4BCc9TjVBzAAjNzBY4MfZ+zS
         8QOJ1MfoqcTnQFoC0yr1WUkcbomtdVzXxAsvJ6a/yRmgSV6ss6FEXylUhCjeNMsOGa1L
         bXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ag9vhIrITQpJEm39f+7OC9szPXt04RbAHbvMxPWSdZU=;
        b=T+YsTww15lf+CVA1oyYsOeubckD4P7gZ6LQcoJzOSeVbdnVgVkwbIzqEj0iCzJF6eD
         CXzYFbOIslqCavMEVuZg14Qy9pp1JOuo3E8JhbyxnZSQeSIiE5PhbLtefTxGlSQ2DGZO
         AsuLUhdKc73Huuhy1cTotwEzav25tX7NBrAdTYDjhuQncd+8EEtHCXrYw47pt2TXmZ6G
         HwNH6ueI4iv5kP8fly+bR+IozqJe7sWPasHP2AmYKUGkThWYAxI0udxSzIBshrmrU+Z8
         /AiLyITaUpsxeqsBrFAxGf73FHGqs4+pIQD5s1ii1t19kbxyXzjff4I03VPPCcj6ckgw
         4lXQ==
X-Gm-Message-State: AOAM530oFUyphQ85WaBOCMlKePPPwLjg/3+da4wUTHGdqbgZ1hLnn1TZ
        3IuV3FTF1OJVbH8wa6pIoqEgENHibe3saiEH9uz+eQ==
X-Google-Smtp-Source: ABdhPJxKyZLQ8FSJ60agO2QvRppq9TDfuGiXVMqkDYSZ51SV1Ha7hGPPGCWgDSLcFz63E+E7JMjlx4MozuEZ9n30evM=
X-Received: by 2002:a1f:9d85:: with SMTP id g127mr1496139vke.101.1598015047149;
 Fri, 21 Aug 2020 06:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200809192001.19156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200809192001.19156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:30 +0200
Message-ID: <CAPDyKFqKYVeva2XD6GX7n4jDQYwJrkLqGn9+zwMZLz7pFUCnXA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: renesas,sdhi: Add r8a774e1 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Aug 2020 at 21:20, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document SDHI controller for RZ/G2H (R8A774E1) SoC, which is compatible
> with R-Car Gen3 SoC family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2
> * Rebased the patch on YAML binding conversion changes (this patch
>   is part of series [1], reset of the patches have been picked up).
> * I have restored the Ack's from v1
>   [1] https://lkml.org/lkml/2020/7/8/1211
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index e5dbc20456e5..04eb0d3c5fa4 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -50,6 +50,7 @@ properties:
>                - renesas,sdhi-r8a774a1 # RZ/G2M
>                - renesas,sdhi-r8a774b1 # RZ/G2N
>                - renesas,sdhi-r8a774c0 # RZ/G2E
> +              - renesas,sdhi-r8a774e1 # RZ/G2H
>                - renesas,sdhi-r8a7795  # R-Car H3
>                - renesas,sdhi-r8a7796  # R-Car M3-W
>                - renesas,sdhi-r8a77961 # R-Car M3-W+
> --
> 2.17.1
>
