Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60706C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C8B20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHQFkn7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgAXL0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:03 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35358 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391312AbgAXL0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:26:00 -0500
Received: by mail-vs1-f66.google.com with SMTP id x123so996065vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGsD1sBB17Gd7giKo9E0XOhIIGoiPHUb5uVBe4K6KfQ=;
        b=ZHQFkn7qEfCeDFCKUCYYzCcwyGJdwaRXzv2BuMkWX5iUNbHh0wy5Zs1LqHFZD6MO41
         YymE5o3W53OrflaEhYWSZo0JAgctGarHB5C6nEkJ3e+YBAm+tMVAiOt/0Y3RFvBC9IIN
         DRURUS0/4XLEtZ8t/zyJ9aD6KKE2jsuZeHWwLP+Lfk0jJrKfOTIG8YjC5tFVw0c35xFR
         A7zv0IWvK13GnstfKGbNusTwqgR+nDRLsHrIG05wR84waOMiBwlExbAY/Kuu6WdQww33
         JF8uuFsBR4ctYSC+q9d2b83NhMVqXIdlzDlVhnY7Ya4kjv6xR/I8mSzNGHwDS735ByRX
         byMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGsD1sBB17Gd7giKo9E0XOhIIGoiPHUb5uVBe4K6KfQ=;
        b=prJti7FSIkxQFFfD4b0ZC96TR7qpU8J9OcHbIbmkH7V3Hgb2lXAQ5nLx4NxcBkjfFj
         XD/6oPFw602mtFOq35u+mF7GzFConoJmi++CjWq92AdTlJqbBmIkHnxuCkxQUbhQXVo9
         zhL6qW9S/8LGDbzhU5D1PncEfx5MG8jsjQDp9Ao3vAiW4UomgI2kDuIh5acHZ0jFfSBq
         a4F8QhW+Kw7EqiEig6FTiAyITIU5PvFFFFVyPGwG8JuKTdeFcvF/0AEAUfhb+EWCCKiy
         rmAnlb+JHGT99G0KBJBOM0VxzVu0GoREi5CjcdeyLjFtg1I/20tAeEPiOmvrcYyhKKwa
         W1dA==
X-Gm-Message-State: APjAAAUh0Y2pXfefnPHGjv2rCfZa8QtdhqEsaZBgMtps04gVULjmlG8s
        o0x9b4PCKJPCXKc6CwoLJQiYwpx+JthOHbDwcX+pDQ==
X-Google-Smtp-Source: APXvYqzz0CgsEy9v7WP14mwK3BPa/e7ShAoPeynnFWYXVmg4lZ1WwFjup6ErJ5tLPVN+TwriSjBOwrxaTaR9xEi9ggw=
X-Received: by 2002:a67:cc3:: with SMTP id 186mr1916849vsm.200.1579865159257;
 Fri, 24 Jan 2020 03:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20200116152230.29831-1-jbx6244@gmail.com> <20200116152230.29831-3-jbx6244@gmail.com>
In-Reply-To: <20200116152230.29831-3-jbx6244@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 12:25:23 +0100
Message-ID: <CAPDyKFpE+raCp82aMhm876T+fL3EvPDxSm0-mJTgUuvc8CohFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: rockchip-dw-mshc: add
 description for rk3308
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 16:22, Johan Jonker <jbx6244@gmail.com> wrote:
>
> The description below is already in use for rk3308.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc"
> for mmc nodes on a rk3308 platform to rockchip-dw-mshc.yaml.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 2f70f5ef0..89c3edd6a 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -35,6 +35,8 @@ properties:
>              - rockchip,rk3036-dw-mshc
>              # for Rockchip RK322x
>              - rockchip,rk3228-dw-mshc
> +            # for Rockchip RK3308
> +            - rockchip,rk3308-dw-mshc
>              # for Rockchip RK3328
>              - rockchip,rk3328-dw-mshc
>              # for Rockchip RK3368
> --
> 2.11.0
>
