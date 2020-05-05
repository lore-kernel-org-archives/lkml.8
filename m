Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E6AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D75206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2LM4c7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgEESuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEESub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:50:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA7C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:50:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so2756518ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQtcPUQW49oPTnT+jASB+pu5t+m5qPdUelhle+W5F4o=;
        b=e2LM4c7y4U0BetC/gB0eIa7BcxIovrqW2+yMivftL2EUsrm9A/3tzPHnkWrENn0+BY
         3u8nlKnzNbvWltqUbePhaEVeITEBqdy3oJ/OoqwDOACo021vaWG3fpFzoZBwAEfpJ/T7
         +AgIzXtc4NJ1zsQ+y6SrWc1RKchP8F8XxTSv08dWWyQ2BtBnzBt+iy4L92tZ3UliSHEx
         lZPLffC2w/YnG5vf5M2YiUUcpWIt7S3jEiV8hAHP9h79nVayw4X1+qTG0d8wF3MY8iSJ
         v9f/mCqFam0KZFjTCQpO/p7SAEWfWjm3aKaNwCqNALVOt0eWz/CsLXXLRBCOZRGKAVY5
         N1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQtcPUQW49oPTnT+jASB+pu5t+m5qPdUelhle+W5F4o=;
        b=LSQuXYLhlik0NKwjjC0eAFuj91quSGBYx+Mqkvn3SeeCcaiQX8dTvVpgdBmrICORXj
         DTdo7/A/jGf/dUhdxqNTs52s9RpsPkiBTbt+gf6paR1pIjUJDm2W1/z7p1nJ67uT61Ww
         Y4SOTxr5+JWVa2kcCWEJ7BC5d9Oi/H2m0lgG1uQTJPj/yUwLVGEqSweHzVIeSKM3iuDl
         zeEYLiJNbJwWc1be35HOZp5OQ2zuGwRCBIkGn6DU+tXRH5SNZaOT2j1XEMO81gUSSg5J
         dz+fbh42xLqwVfVQBsy3x9P9jwgIFY1UmVcKQHbq8VGtIgblmr1FOXD9lAJ2ewELGRI/
         jVGw==
X-Gm-Message-State: AGi0PuaK8/16zaMytY/E7xggQjYIAL67YOur3K5Gd6wtRPodDgyDV66W
        yTxgsEbLMo+VpDqgqT8dAjK+TVPuL5u09+wg6WnqSw==
X-Google-Smtp-Source: APiQypKvjCJ8PklB3LOXCvVyQOThS4XpKMQ/Afaf/e/kP6nt/5BFFzQYKIqd2OgadCHb/8wFTCM6UEj3k7Ta0f50ic0=
X-Received: by 2002:a05:651c:107a:: with SMTP id y26mr2697805ljm.80.1588704629773;
 Tue, 05 May 2020 11:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200505162123.13366-1-grygorii.strashko@ti.com>
In-Reply-To: <20200505162123.13366-1-grygorii.strashko@ti.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 5 May 2020 20:50:18 +0200
Message-ID: <CADYN=9KZ9GSBv+VOA0MSLHcW312sEOX+T+h5GNyaaAridaLXuA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpts: fix build
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 18:21, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>
> It's possible to have build configuration which will force PTP_1588_CLOCK=m
> and so TI_K3_AM65_CPTS=m while still have TI_K3_AM65_CPSW_NUSS=y. This will
> cause build failures:
>
> aarch64-linux-gnu-ld: ../drivers/net/ethernet/ti/am65-cpsw-nuss.o: in function `am65_cpsw_init_cpts':
> ../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1685: undefined reference to `am65_cpts_create'
> aarch64-linux-gnu-ld: ../drivers/net/ethernet/ti/am65-cpsw-nuss.c:1685:(.text+0x2e20):
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `am65_cpts_create'
>
> Fix it by adding dependencies from CPTS in TI_K3_AM65_CPSW_NUSS as below:
>    config TI_K3_AM65_CPSW_NUSS
>    ...
>      depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS
>
> Note. This will create below dependencies and for NFS boot + CPTS all of them
> have to be built-in.
>   PTP_1588_CLOCK -> TI_K3_AM65_CPTS -> TI_K3_AM65_CPSW_NUSS
>
> While here, clean up TI_K3_AM65_CPTS definition.
>
> Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  drivers/net/ethernet/ti/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 4ab35ce7b451..988e907e3322 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -99,7 +99,7 @@ config TI_K3_AM65_CPSW_NUSS
>         depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>         select TI_DAVINCI_MDIO
>         imply PHY_TI_GMII_SEL
> -       imply TI_AM65_CPTS
> +       depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS

Don't we want to move this so it is below the other 'depends on' ?

Cheers,
Anders

>         help
>           This driver supports TI K3 AM654/J721E CPSW2G Ethernet SubSystem.
>           The two-port Gigabit Ethernet MAC (MCU_CPSW0) subsystem provides
> @@ -112,9 +112,8 @@ config TI_K3_AM65_CPSW_NUSS
>
>  config TI_K3_AM65_CPTS
>         tristate "TI K3 AM65x CPTS"
> -       depends on ARCH_K3 && OF && PTP_1588_CLOCK
> +       depends on ARCH_K3 && OF
>         depends on PTP_1588_CLOCK
> -       select NET_PTP_CLASSIFY
>         help
>           Say y here to support the TI K3 AM65x CPTS with 1588 features such as
>           PTP hardware clock for each CPTS device and network packets
> --
> 2.17.1
>
