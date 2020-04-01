Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA78C10F26
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E420714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mnWZ82pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgDAMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:18:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35829 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbgDAMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:18:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id k13so26732641qki.2;
        Wed, 01 Apr 2020 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYgn6RQydhxEk4Yg/z1Bm/e2sVRk32p5oBa766QTAqk=;
        b=mnWZ82pqNPv0UXH2JHl3te3MYxNR553fID3X8WrACZm/1J602MoPR+mcCg7AmszPk3
         zssmg/U6SuCeVojy8fm8nFWdO86Q13xCaXNse6jfC+hFTyOQL6btumPCb886B1/XsMJJ
         Z343d2vMO94W49HMLzzXhHZChM6iTfzz+WX90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYgn6RQydhxEk4Yg/z1Bm/e2sVRk32p5oBa766QTAqk=;
        b=VQQF6yCu0jIscFmD0PNIu6PAVtEFPAmuPdZNiyveQGcNXrvlDk9aGf9Ks5LM4gDhM+
         L9GJ+xDUjUR5HPSocJW93fzZEdRzYGpptttTd06PXm68/w5Nho3eeZ89xJ+Sl4P+UqW7
         fp9nfRl0T03gb6cxNT7Zoz2yIfySwBOgh6pK406RjZ2LnKcJlvCkGeDZM3u6EtioiBAG
         MDgfeumX/1L5Mv326w2nMqVGwaDguzH9wXRAjsFzONqICYhH4lhCA65wYrtyTPrHxlbO
         DoTDB84pibixodKv/5AEF+JH7CNDL7EcbGbq2HOp31vGnDxRvkMbDvjwwW4AIy7FOaoy
         F+Cw==
X-Gm-Message-State: ANhLgQ2cTQUXe/w05EJ9QxV9tAVaKk/JBEWRL2wSPhY6B2lQFGd1ypKc
        RoZzbHYlZCOKVJMfOUj9YBYpcBQ5/eX9hMCqHI4em/sx
X-Google-Smtp-Source: ADFU+vsGJIiZgzJs5OL/Q4JZje/tqiDApfEfPU29WwaxIGq+J9716ZkBiwCe7NGvvIhWTP92hnvGqh2b7LnBXWG2nyg=
X-Received: by 2002:a37:61d0:: with SMTP id v199mr9555105qkb.292.1585743508846;
 Wed, 01 Apr 2020 05:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200401114023.GA29180@cnn>
In-Reply-To: <20200401114023.GA29180@cnn>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Apr 2020 12:18:17 +0000
Message-ID: <CACPK8Xf+EOUk-HroNmPe5Pjgu6BdP8VU-m6mxQMpTtL1CYBn=A@mail.gmail.com>
Subject: Re: [PATCH v7] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Sai Dasari <sdasari@fb.com>,
        Vijay Khemka <vijaykhemka@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        manikandan.e@hcl.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 at 11:40, Manikandan Elumalai
<manikandan.hcl.ers.epl@gmail.com> wrote:
>
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platform based on AST2500 SoC.
>
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
>
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> Acked-by     : Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by  : Vijay Khemka <vkhemka@fb.com>
> ---
> ---      v7 - Added multi-host SOL feature.
> ---      v6 - Added device tree property for multi-host Mellanox NIC in the ncsi driver.
> ---      v5 - Spell and contributor name correction.
> ---           - License identifier changed to GPL-2.0-or-later.
> ---           - aspeed-gpio.h removed.
> ---           - FAN2 tacho channel changed.
> ---      v4 - Bootargs removed.
> ---      v3 - Uart1 Debug removed .
> ---      v2 - LPC and VUART removed .
> ---      v1 - Initial draft.
> ---
> ---
>  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 186 +++++++++++++++++++++

You need to add the device tree to the makefile.

>  1 file changed, 186 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> new file mode 100644
> index 0000000..bc83901
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2018 Facebook Inc.
> +/dts-v1/;
> +#include "aspeed-g5.dtsi"
> +
> +/ {
> +       model = "Facebook Yosemitev2 BMC";
> +       compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> +       aliases {
> +               serial4 = &uart5;
> +       };
> +       chosen {
> +               stdout-path = &uart5;
> +       };
> +
> +       memory@80000000 {
> +               reg = <0x80000000 0x20000000>;
> +       };
> +
> +       iio-hwmon {
> +               // VOLATAGE SENSOR
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> +               <&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> +               <&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> +               <&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> +       };
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +#include "openbmc-flash-layout.dtsi"
> +       };
> +};
> +
> +&spi1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi1_default>;
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "pnor";
> +       };
> +};
> +&uart1 {
> +       // Host1 Console
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd1_default
> +                    &pinctrl_rxd1_default>;
> +};
> +
> +&uart2 {
> +       // Host2 Console
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd2_default
> +                    &pinctrl_rxd2_default>;
> +
> +};
> +
> +&uart3 {
> +       // Host3 Console
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd3_default
> +                    &pinctrl_rxd3_default>;
> +};
> +
> +&uart4 {
> +       // Host4 Console
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_txd4_default
> +                    &pinctrl_rxd4_default>;
> +};
> +
> +&uart5 {
> +       // BMC Console
> +       status = "okay";
> +};
> +
> +&vuart {
> +       // Virtual UART
> +       status = "okay";
> +};
> +
> +&mac0 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii1_default>;
> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&adc {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc0_default
> +                       &pinctrl_adc1_default
> +                       &pinctrl_adc2_default
> +                       &pinctrl_adc3_default
> +                       &pinctrl_adc4_default
> +                       &pinctrl_adc5_default
> +                       &pinctrl_adc6_default
> +                       &pinctrl_adc7_default
> +                       &pinctrl_adc8_default
> +                       &pinctrl_adc9_default
> +                       &pinctrl_adc10_default
> +                       &pinctrl_adc11_default
> +                       &pinctrl_adc12_default
> +                       &pinctrl_adc13_default
> +                       &pinctrl_adc14_default
> +                       &pinctrl_adc15_default>;
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +       //FRU EEPROM
> +       eeprom@51 {
> +               compatible = "atmel,24c64";
> +               reg = <0x51>;
> +               pagesize = <32>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +       tmp421@4e {
> +       //INLET TEMP
> +               compatible = "ti,tmp421";
> +               reg = <0x4e>;
> +       };
> +       //OUTLET TEMP
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +       //HSC
> +       adm1278@40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +       //MEZZ_TEMP_SENSOR
> +       tmp421@1f {
> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +       //MEZZ_FRU
> +       eeprom@51 {
> +               compatible = "atmel,24c64";
> +               reg = <0x51>;
> +               pagesize = <32>;
> +       };
> +};
> +
> +&pwm_tacho {
> +       status = "okay";
> +       //FSC
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +       fan@0 {
> +               reg = <0x00>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +       };
> +       fan@1 {
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> +       };
> +};
> --
> 2.7.4
>
