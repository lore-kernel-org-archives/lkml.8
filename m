Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB539C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05D6215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khQEriv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCKBYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:24:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36804 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgCKBYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:24:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id s1so267504lfd.3;
        Tue, 10 Mar 2020 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFsCMPYEvQ090eghtJnuZSfndIYHXofg6kpzbpjDHcg=;
        b=khQEriv/qXhJIlEcRUfHpUFBBNJlME/YbqhLsz8nEtpslFi3hDMOkwANIKEhmCYLIn
         bKaKw0sRKxN+kYaN9gg0bSnEOl8ctNwfUxBPjELrFcsIjdXUN8o3N7sEblgIC11+H0Hb
         kkTLLOwiDrrUPHBva+FhCK9knYGxysZb+I8src6lLjjdpAPbAG5RDBjMZtFx7uBorF1L
         1JAYEomu+xOdLN23slKQQ9BEgsY5Yrxu7J3PQDfRO706FQnB7t8Y/bGeyZq7inIKNY5s
         phKS+ngDHm2ynGfhdehkvlCeasU4TiC09gHJJy2vY0zw4LQhMRcaidUibP2n68b5TJTW
         nkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFsCMPYEvQ090eghtJnuZSfndIYHXofg6kpzbpjDHcg=;
        b=GQlLO/yZC+MYWFZM5M9LnNgduaOD9pQjJ92QRP26mmcsgjW1d6kW2x1v/8L1VcRtN7
         KmLKsT7AByH0e7XGejkm/jO2rzW+7urHrjnYGpGBnp9IYi/6oNr6YC6X7WlLebth93f6
         j2CmYAM95tmuXBw5F3Fn+GJIi7ZhzAnn6yeWEw4jZUbkbk74RuqPcDkqo6LvWSae7USD
         Ay9opVXP+igzBLC8DZcNuemBqm5SucX3+hHu/WjOIHWfeKPfqs41MpMFNmC778QbVp+N
         iDombWRmn+Yy2U+h3TNdhRdYgKbK3JGIoVyFZfn8SQ8Z+xGkW6MkvmBrqv811zOAOfFR
         tUdw==
X-Gm-Message-State: ANhLgQ0zqldo7H2X3iVk5IJXtu7vNdRuxEE+FUoBoso1ilAUIkWChbhS
        5lbIBjbE1fz23/ChgWTm2+mI1opbeHR3xyZhWIYhJUmn/D4=
X-Google-Smtp-Source: ADFU+vtVBcBmmMm93NbesCcxOezx6ue+FNXn7WKGQmB+8VFPVc0CNlHuwX5yQeRTpTjhhcjyixGtamX00YP1kjg7Q6I=
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr491651lfg.70.1583889850626;
 Tue, 10 Mar 2020 18:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200311010138.10465-1-aford173@gmail.com>
In-Reply-To: <20200311010138.10465-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 Mar 2020 22:24:01 -0300
Message-ID: <CAOMZO5AqjrQxGcHVLPRQXC0nRUM+hOeWtnAK2vJ=O_P28FZ3-g@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: imx: Add Beacon i.mx8mm development kit
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        aford@beaconembeddedworks.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Mar 10, 2020 at 10:01 PM Adam Ford <aford173@gmail.com> wrote:

> +&ecspi2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_espi2>;
> +       cs-gpios = <&gpio5 9 0>;

You could use GPIO_ACTIVE_HIGH instead of hardcoded 0.

> +       status = "okay";
> +
> +       at25@0 {

Node names should be generic:

eeprom@0

> +               compatible = "atmel,at25";

Documentation/devicetree/bindings/eeprom/at25.txt states:

"- compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
  Example "<vendor>,<type>" values:
    "microchip,25lc040"
    "st,m95m02"
    "st,m95256"

> +&i2c4 {
> +

Unneeded blank line.

> diff --git a/arch/arm64/boot/dts/freescale/beacon-imx8mm-kit.dts b/arch/arm64/boot/dts/freescale/beacon-imx8mm-kit.dts
> new file mode 100644
> index 000000000000..417b15d345d5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/beacon-imx8mm-kit.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2020 Compass Electronics Group, LLC
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm.dtsi"
> +#include "beacon-imx8mm-som.dtsi"
> +#include "beacon-imx8mm-baseboard.dtsi"

The naming convention we use is to start the dts names with the i.MX
SoC name, so:

imx8mm-beacon-som.dtsi
imx8mm-beacon-baseboard.dtsi

> +/ {
> +       model = "Beacon EmbeddedWorks i.MX8M Mini Development Kit";
> +       compatible = "fsl,imx8mm";

You should add an Entry for Beacon in
Documentation/devicetree/bindings/vendor-prefixes.yaml on a separate
patch.

and then:

compatible = "beacon,imx8mm-beacon-kit", "fsl,imx8mm"

Also, please add an entry for this board in
Documentation/devicetree/bindings/arm/fsl.yaml

> +&i2c3 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c64";

Same comment about the compatible.

> +&iomuxc {
> +

Unneeded blank line.

> +               pinctrl_fec1: fec1grp {
