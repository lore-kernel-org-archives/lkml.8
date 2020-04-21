Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A2F2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587440948;
	bh=0D6hYraBu1DbsgpFZCPm8t6r20cXBzyDrsgU4Z9wbZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t9rBD7cco4H0uFLvmPBOfYGkMo5eRvLjeIirX75YLgLJxbof8ReXaqoB2CXApi4P3
	 npwOkyNp0/ZTtClJDUBbP0d8fx5T8/BE7AdHno/B7p7C0q+vhmjzKtjAgXXKbYzww0
	 oH/nZXtYNUAtpvvJ+3LYkmSgAG0f6gmq/G/MnMhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDUDtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgDUDtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:49:07 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E8420882;
        Tue, 21 Apr 2020 03:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587440946;
        bh=0D6hYraBu1DbsgpFZCPm8t6r20cXBzyDrsgU4Z9wbZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WWyMs0j3tGy9ANeQcxvdnl4D2WfDvXmeTx+v/xAjU3v1syDAcRLuG+jTM8pAN9C8c
         +ugCB2prYMNqzzfI9yUZDDQU/E3+XpLnEbFc8dmEc5PWVfX6iEZUISBELut7DAYoEn
         qZ6RAUv8WCZxTJmFNfy78KPXTD5Iybr6mKPjsOrk=
Received: by mail-lj1-f181.google.com with SMTP id w20so6164597ljj.0;
        Mon, 20 Apr 2020 20:49:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuamOYJ5N702jIpVeGuVmVxHqxl6ilt+TKEKNN5gyFtJVxcigu8E
        qvJxzyYDWQ1QswIvRCY5kdFgK6jeM+awp9q4yuM=
X-Google-Smtp-Source: APiQypJ1or0lDKF5QqUv6w69NTZ4v7V/G08isP2Oq7HTw+F7ljB+CKK2Gz7J3f4a+MkTFc+nuAlbnVCvdthGDNd2ybs=
X-Received: by 2002:a2e:9ada:: with SMTP id p26mr8877859ljj.14.1587440944667;
 Mon, 20 Apr 2020 20:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200416181944.5879-1-jbx6244@gmail.com>
In-Reply-To: <20200416181944.5879-1-jbx6244@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 21 Apr 2020 11:48:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67N6t+C8dVKdjuOv1NzD9=3-n0GZQkshy1Pm6PFPJ87dQ@mail.gmail.com>
Message-ID: <CAGb2v67N6t+C8dVKdjuOv1NzD9=3-n0GZQkshy1Pm6PFPJ87dQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add bus-width properties to mmc
 nodes for rk3328.dtsi
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 2:19 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> 'bus-width' and pinctrl containing the bus-pins
> should be in the same file, so add them to
> all mmc nodes in 'rk3328.dtsi'.

Nope. First of all, pinctrl usage is with pinctrl-N properties, not the
pinctrl device, and there are no defaults set for any of the mmc nodes.
Second, these are board design specific. For example, boards are free to
use just 4 bits for the eMMC if they so desire. So this should be in each
board dts file. If a board is missing this property, fix the board.

This applies to all three patches in the series.

ChenYu

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 175060695..db2c3085e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -861,6 +861,7 @@
>                 clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
>                          <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
>                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +               bus-width = <4>;
>                 fifo-depth = <0x100>;
>                 max-frequency = <150000000>;
>                 status = "disabled";
> @@ -873,6 +874,7 @@
>                 clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
>                          <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
>                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +               bus-width = <4>;
>                 fifo-depth = <0x100>;
>                 max-frequency = <150000000>;
>                 status = "disabled";
> @@ -885,6 +887,7 @@
>                 clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>                          <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +               bus-width = <8>;
>                 fifo-depth = <0x100>;
>                 max-frequency = <150000000>;
>                 status = "disabled";
> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
