Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF268C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B138724673
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579047117;
	bh=HLlIuKSukby77nU8tEm+SpVYPXkB4qmHH90lCBTZ6WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pT9uFZ3URRqJRQVqyY1ISVjJeAvvBS1q8WA1VXxh0qYu08jKj21pyplInTXbNY4Ue
	 BdTWKntgfIk5Z/QIcycnOCcpriSvpvfaVznoBq5dN5ip6FpK9XgnrPh6UOEpUofezz
	 E/Aski0UfZt1MaTkfjRTDH1C8zWJfYgSxr7DyQu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgAOAL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:11:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44710 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOAL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:11:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so14459669otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 16:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rqYwFYlybDxb7rHCNCkg0gK4e3FUvJBmLmo+IxQN78U=;
        b=DAw0DiNPXWkYy/jOs5uSIUxLr6iU9qWd7k3XMsIaj6wTDGxJigxJrwm/GcFGj8xGS+
         o/tKhhbT9xtAUAQN/fut0v1hsuxVtYcYky9fjwIAQHQW/072VGyVjt4yd/eZrWPY1fmL
         clWSYwOYMj2g78h/fnejLQHZ1M0Qe8M+hdL7fFbiGuRmw1+064Pj1KLk44Sde++QinJd
         vVozaKmIga6GWHsm+jkh23GOg8PgRoSP+tkMHSqTrlAzAOswIfGPX9aLRMoPzC42HxMK
         1jcl1E46qJ44yhT9hLiFE9UC6KlRTCLy3jNlxlnrQnL+PEaTkLlkLDA7rojUQEDxMuGq
         L56Q==
X-Gm-Message-State: APjAAAXaK8ZADfFvgmbzlCoEivQFAqhM7uGtWNJkip4Ke95R1EFGDJVu
        m+3PK/puDex0lz0GGFKivttYlho=
X-Google-Smtp-Source: APXvYqx3hmq4EfXe42kTS0r5zIRH50rnbbcS13jmXowU00L5H9UgVHmKuUA/8Qd77PkvSm24W9Rwbg==
X-Received: by 2002:a9d:242:: with SMTP id 60mr779590otb.253.1579047115225;
        Tue, 14 Jan 2020 16:11:55 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h7sm5895085otk.56.2020.01.14.16.11.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:11:54 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 18:11:52 -0600
Date:   Tue, 14 Jan 2020 18:11:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] dt-bindings: pinctrl: Convert i.MX8MM to
 json-schema
Message-ID: <20200115001152.GA12156@bogus>
References: <1578629120-25793-1-git-send-email-Anson.Huang@nxp.com>
 <1578629120-25793-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578629120-25793-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:05:19PM +0800, Anson Huang wrote:
> Convert the i.MX8MM pinctrl binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
>         - use "grp$" instead of "-grp$";
>         - use space instead of tab for "ref$";
> 	- add missed "reg" property;
>         - remove the "maxItem" for "fsl,pins" to avoid build warning, as the item number is changable.
> ---
>  .../bindings/pinctrl/fsl,imx8mm-pinctrl.txt        | 36 -----------
>  .../bindings/pinctrl/fsl,imx8mm-pinctrl.yaml       | 69 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
> deleted file mode 100644
> index e4e01c0..0000000
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -* Freescale IMX8MM IOMUX Controller
> -
> -Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
> -for common binding part and usage.
> -
> -Required properties:
> -- compatible: "fsl,imx8mm-iomuxc"
> -- reg: should contain the base physical address and size of the iomuxc
> -  registers.
> -
> -Required properties in sub-nodes:
> -- fsl,pins: each entry consists of 6 integers and represents the mux and config
> -  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
> -  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> -  <arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h>. The last integer CONFIG is
> -  the pad setting value like pull-up on this pin.  Please refer to i.MX8M Mini
> -  Reference Manual for detailed CONFIG settings.
> -
> -Examples:
> -
> -&uart1 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_uart1>;
> -};
> -
> -iomuxc: pinctrl@30330000 {
> -        compatible = "fsl,imx8mm-iomuxc";
> -        reg = <0x0 0x30330000 0x0 0x10000>;
> -
> -        pinctrl_uart1: uart1grp {
> -                fsl,pins = <
> -                        MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX             0x140
> -                        MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX             0x140
> -                >;
> -        };
> -};
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
> new file mode 100644
> index 0000000..a3c4275
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

Sorry, one other thing.

You're good with GPLv9? Plus this is a license change. Do you have 
rights to do so as some of this comes from the old binding doc? If you 
do, then make it:

(GPL-2.0-only OR BSD-2-Clause)

Rob
