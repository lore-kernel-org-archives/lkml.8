Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F30BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A97F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhOqLbtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgDAMz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:55:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35853 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbgDAMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:55:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so9595866plo.3;
        Wed, 01 Apr 2020 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imztvQkg/OfJphlP/GAnsDsoLdxnN0XJIH9r9Mz1XVY=;
        b=OhOqLbtWOzKFWAxdLXahqXvU16jQ3KUZNemWuJ4JacyMc4BEIAl5XPhQ07GRBLgPdr
         +KEIz+iXHrYRKDTFH9T9pDEn8bdFgpmbbE/5ZLZnO9Ub+CnXTpqnHeucf3FyDZ3ODo6s
         c8lGekoj8gD27Gvy0kjBb0UTVVwfPIZSaNnGf9V8x/wm8YCAMzWJR/o5Ic9Y1EiFwEHl
         Hz/KFZs7dLyQ41COl582Nr7IMWv/Osb8d6x3hKoU0rcSVWOACR+NzwpqhfjhqmZ6YSBr
         AFwpHdSnfKU2Ha2k2FgW81HW8VDN9B9LygfkjJijtdOwO1jys6khfmxKNXiFjsSPi0v1
         1+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imztvQkg/OfJphlP/GAnsDsoLdxnN0XJIH9r9Mz1XVY=;
        b=R+JLLNhTKNwyaIefbbuCVuMJoLXQ8+3GiclTKWsC4Pgi5/7GShwtRYGoKk6/rP9joJ
         vNWi29mxlCYL8qT7DAg4h64hW1H7TffCA4+p1X+4VJzKwfsE+tlg9Hz2ssUoQvPYj7ih
         ul7ChYreZcvfoqwHZauxv9TQnD37SBC/91zHJLWVs8ZMMJYT/Ukzo9WgMdKPzbkEbYxc
         4nGSmPJiwY5cUECDgD5NNdAyi3AqIGwEOLPWlW4G9/v6loRsGULhktomirctVD4lf0Gq
         GstFDDawScgHOqAwa8jzeYglUe3pO7rMjTi7p+NrVHig4tcL2GTgqpyT/bhfLfTs8fWz
         Gcow==
X-Gm-Message-State: AGi0PuaziBGGA8c1tQCqojXNIyaMwbErifnvFUWrlfH1o+QpiKlQ8XhY
        xGOVj6HjWI9JXxP8JaYSNaEXT7sj
X-Google-Smtp-Source: APiQypIHrdXxu06Ot6UNjHWrirAAakD8L29/0ar3aOgCEqFzSkqJM1yTy4kwBCAjLgPlL47p2uznmQ==
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr4749241pjv.49.1585745753856;
        Wed, 01 Apr 2020 05:55:53 -0700 (PDT)
Received: from cnn ([2402:3a80:463:99ca:94f8:dc27:324a:484e])
        by smtp.gmail.com with ESMTPSA id q80sm1592325pfc.17.2020.04.01.05.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 05:55:53 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:25:46 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     andrew@aj.id.au, sdasari@fb.com, vijaykhemka@fb.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v7] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20200401125546.GA24979@cnn>
References: <20200401114023.GA29180@cnn>
 <CACPK8Xf+EOUk-HroNmPe5Pjgu6BdP8VU-m6mxQMpTtL1CYBn=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf+EOUk-HroNmPe5Pjgu6BdP8VU-m6mxQMpTtL1CYBn=A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:18:17PM +0000, Joel Stanley wrote:
> On Wed, 1 Apr 2020 at 11:40, Manikandan Elumalai
> <manikandan.hcl.ers.epl@gmail.com> wrote:
> >
> > The Yosemite V2 is a facebook multi-node server
> > platform that host four OCP server. The BMC
> > in the Yosemite V2 platform based on AST2500 SoC.
> >
> > This patch adds linux device tree entry related to
> > Yosemite V2 specific devices connected to BMC SoC.
> >
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> > Acked-by     : Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by  : Vijay Khemka <vkhemka@fb.com>
> > ---
> > ---      v7 - Added multi-host SOL feature.
> > ---      v6 - Added device tree property for multi-host Mellanox NIC in the ncsi driver.
> > ---      v5 - Spell and contributor name correction.
> > ---           - License identifier changed to GPL-2.0-or-later.
> > ---           - aspeed-gpio.h removed.
> > ---           - FAN2 tacho channel changed.
> > ---      v4 - Bootargs removed.
> > ---      v3 - Uart1 Debug removed .
> > ---      v2 - LPC and VUART removed .
> > ---      v1 - Initial draft.
> > ---
> > ---
> >  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 186 +++++++++++++++++++++
> 
> You need to add the device tree to the makefile.
    Thanks for review Joel. I will submit another patch with Makefile.
> 
> >  1 file changed, 186 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > new file mode 100644
> > index 0000000..bc83901
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> > @@ -0,0 +1,186 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +// Copyright (c) 2018 Facebook Inc.
> > +/dts-v1/;
> > +#include "aspeed-g5.dtsi"
> > +
> > +/ {
> > +       model = "Facebook Yosemitev2 BMC";
> > +       compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> > +       aliases {
> > +               serial4 = &uart5;
> > +       };
> > +       chosen {
> > +               stdout-path = &uart5;
> > +       };
> > +
> > +       memory@80000000 {
> > +               reg = <0x80000000 0x20000000>;
> > +       };
> > +
> > +       iio-hwmon {
> > +               // VOLATAGE SENSOR
> > +               compatible = "iio-hwmon";
> > +               io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> > +               <&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> > +               <&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> > +               <&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> > +       };
> > +};
> > +
> > +&fmc {
> > +       status = "okay";
> > +       flash@0 {
> > +               status = "okay";
> > +               m25p,fast-read;
> > +#include "openbmc-flash-layout.dtsi"
> > +       };
> > +};
> > +
> > +&spi1 {
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_spi1_default>;
> > +       flash@0 {
> > +               status = "okay";
> > +               m25p,fast-read;
> > +               label = "pnor";
> > +       };
> > +};
> > +&uart1 {
> > +       // Host1 Console
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_txd1_default
> > +                    &pinctrl_rxd1_default>;
> > +};
> > +
> > +&uart2 {
> > +       // Host2 Console
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_txd2_default
> > +                    &pinctrl_rxd2_default>;
> > +
> > +};
> > +
> > +&uart3 {
> > +       // Host3 Console
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_txd3_default
> > +                    &pinctrl_rxd3_default>;
> > +};
> > +
> > +&uart4 {
> > +       // Host4 Console
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_txd4_default
> > +                    &pinctrl_rxd4_default>;
> > +};
> > +
> > +&uart5 {
> > +       // BMC Console
> > +       status = "okay";
> > +};
> > +
> > +&vuart {
> > +       // Virtual UART
> > +       status = "okay";
> > +};
> > +
> > +&mac0 {
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_rmii1_default>;
> > +       use-ncsi;
> > +       mlx,multi-host;
> > +};
> > +
> > +&adc {
> > +       status = "okay";
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_adc0_default
> > +                       &pinctrl_adc1_default
> > +                       &pinctrl_adc2_default
> > +                       &pinctrl_adc3_default
> > +                       &pinctrl_adc4_default
> > +                       &pinctrl_adc5_default
> > +                       &pinctrl_adc6_default
> > +                       &pinctrl_adc7_default
> > +                       &pinctrl_adc8_default
> > +                       &pinctrl_adc9_default
> > +                       &pinctrl_adc10_default
> > +                       &pinctrl_adc11_default
> > +                       &pinctrl_adc12_default
> > +                       &pinctrl_adc13_default
> > +                       &pinctrl_adc14_default
> > +                       &pinctrl_adc15_default>;
> > +};
> > +
> > +&i2c8 {
> > +       status = "okay";
> > +       //FRU EEPROM
> > +       eeprom@51 {
> > +               compatible = "atmel,24c64";
> > +               reg = <0x51>;
> > +               pagesize = <32>;
> > +       };
> > +};
> > +
> > +&i2c9 {
> > +       status = "okay";
> > +       tmp421@4e {
> > +       //INLET TEMP
> > +               compatible = "ti,tmp421";
> > +               reg = <0x4e>;
> > +       };
> > +       //OUTLET TEMP
> > +       tmp421@4f {
> > +               compatible = "ti,tmp421";
> > +               reg = <0x4f>;
> > +       };
> > +};
> > +
> > +&i2c10 {
> > +       status = "okay";
> > +       //HSC
> > +       adm1278@40 {
> > +               compatible = "adi,adm1278";
> > +               reg = <0x40>;
> > +       };
> > +};
> > +
> > +&i2c11 {
> > +       status = "okay";
> > +       //MEZZ_TEMP_SENSOR
> > +       tmp421@1f {
> > +               compatible = "ti,tmp421";
> > +               reg = <0x1f>;
> > +       };
> > +};
> > +
> > +&i2c12 {
> > +       status = "okay";
> > +       //MEZZ_FRU
> > +       eeprom@51 {
> > +               compatible = "atmel,24c64";
> > +               reg = <0x51>;
> > +               pagesize = <32>;
> > +       };
> > +};
> > +
> > +&pwm_tacho {
> > +       status = "okay";
> > +       //FSC
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> > +       fan@0 {
> > +               reg = <0x00>;
> > +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> > +       };
> > +       fan@1 {
> > +               reg = <0x01>;
> > +               aspeed,fan-tach-ch = /bits/ 8 <0x01>;
> > +       };
> > +};
> > --
> > 2.7.4
> >
