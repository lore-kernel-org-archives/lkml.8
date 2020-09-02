Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6C5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D916F2071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNr7dTiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIBJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIBJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:03:47 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B036C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:03:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id l1so1338104uai.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7z93t1Etv3+Y7YRGqoitCZfELcgVcpVmZuSYiiuAMc=;
        b=ZNr7dTiMyg6AJhHsdVCwXw5CQaH02wnOnH42Zr5wVBHqxb0354fDvNOiMNx6Lmc0hE
         QvUDEGEWKwtU63Sv5gfBy3asdk4Xo6wqAh6SE5d/9t3h1Fxsg32wfjXT/7xiodD5G5pZ
         0EKEDKEi/A7o5IvEbPeol4SFl6PQFNNTja+vjlcRop0AWOnZ6JXzH6BbUGiJylF0O1Lx
         PgOOwKbmHa4RJS0q13zHAf5qCeEB1iseAEndTs3QjRUXhEGIRfelydA6FGU1BnRoV/bw
         KjsQoPeNLOw3BNLzdxNjYZpjA3Mq+Ou8H87Ud5PLEAhDNMXtemEaevQudQWIQhnvouuq
         3ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7z93t1Etv3+Y7YRGqoitCZfELcgVcpVmZuSYiiuAMc=;
        b=c//H+06rOxChstn+SU7FO2SL7Zm37mOTPPDaU2ad2asJW+G6FZr+TDwv84h8T46ZQ8
         CgFPbUg45ZQCFHFn2q+4THpCIjyTmZ+hMRiu16cwkCSbu9N9+csDGJ4mPdlvB0rR8ol0
         wQ7QO2/pm36UZU6khHF+zwvbVQZGfHT0FUI4xeITQi7/v28QbwPyKn4zW53DoRS6Pl1F
         tCYc/YCdVDH5VnpNTeLy6yWrg+N+TVH74Dl2qTV1e/U1oGDMvKj6qV7/7rNEB6f4VlvN
         H4AFQ43xUF9w+0ivL1wW3eHMY4n0z00t0EdBKdzsGQuJjfHOzPeTSDD0MfravXLHZhOj
         x16w==
X-Gm-Message-State: AOAM532gM7RGWIIW2EaMpaPK+tseRzQ3EwuuYK9Sqp+2P6A9RkZ2ymSW
        s5G48pQX1CxkYsILKnoRMwiIx8Q2UjYbN3VvsvBBqebsIZYgKQ==
X-Google-Smtp-Source: ABdhPJyTJjkE0DbQ9blDWav98w+X2eEv5Ao+aqHbo6v8vW6kAJ3iH1xM8Vn6niOHiZAqARCskMhgKTsCoqH+TsHxDac=
X-Received: by 2002:a9f:2722:: with SMTP id a31mr4520715uaa.100.1599037426432;
 Wed, 02 Sep 2020 02:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200829062505.4642-1-krzk@kernel.org>
In-Reply-To: <20200829062505.4642-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:09 +0200
Message-ID: <CAPDyKFrVLZUXEV6pCa6aPJFtFsZ4xv9mtcycUQ1-XHyGOqKi+A@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 at 08:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The i.MX 8 DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
>
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>     From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
>
>   arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v3:
> 1. Fix also example in Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
>
> Changes since v2:
> 1. Remove moved compatibles.
>
> Changes since v1:
> 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> ---
>  .../bindings/clock/imx8qxp-lpcg.yaml          |  2 +-
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> index 1d5e9bcce4c8..33f3010f48c3 100644
> --- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> @@ -62,7 +62,7 @@ examples:
>      };
>
>      mmc@5b010000 {
> -        compatible = "fsl,imx8qxp-usdhc";
> +        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
>          interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
>          reg = <0x5b010000 0x10000>;
>          clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 10b45966f1b8..e71d13c2d109 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -21,23 +21,26 @@ description: |
>
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx25-esdhc
> -      - fsl,imx35-esdhc
> -      - fsl,imx51-esdhc
> -      - fsl,imx53-esdhc
> -      - fsl,imx6q-usdhc
> -      - fsl,imx6sl-usdhc
> -      - fsl,imx6sx-usdhc
> -      - fsl,imx6ull-usdhc
> -      - fsl,imx7d-usdhc
> -      - fsl,imx7ulp-usdhc
> -      - fsl,imx8mq-usdhc
> -      - fsl,imx8mm-usdhc
> -      - fsl,imx8mn-usdhc
> -      - fsl,imx8mp-usdhc
> -      - fsl,imx8qm-usdhc
> -      - fsl,imx8qxp-usdhc
> +    oneOf:
> +      - enum:
> +          - fsl,imx25-esdhc
> +          - fsl,imx35-esdhc
> +          - fsl,imx51-esdhc
> +          - fsl,imx53-esdhc
> +          - fsl,imx6q-usdhc
> +          - fsl,imx6sl-usdhc
> +          - fsl,imx6sx-usdhc
> +          - fsl,imx6ull-usdhc
> +          - fsl,imx7d-usdhc
> +          - fsl,imx7ulp-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
> +              - fsl,imx8mq-usdhc
> +              - fsl,imx8qxp-usdhc
> +          - const: fsl,imx7d-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.17.1
>
