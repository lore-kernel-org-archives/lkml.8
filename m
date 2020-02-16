Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69101C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3CC208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="BXOaOEv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBPQPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 11:15:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41203 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgBPQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:15:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so10426579qtr.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3cNauMywvmvrNjMdZIsRhBPNnoWHlOKi7QO8UB6MPk=;
        b=BXOaOEv8BbApLvLetaTwVC1B1Auzb4otCcb98Psh406JCqev8lW/eR9r8ZNu3kRHy2
         Dgu/Oa6jnNd0wh/TzxGD44AbXOhCbQsXlnNTyc2IRrrS1QJ9kQswauFOnlQjPfE/Lz41
         sU7nXO5LtsgLywhpTUHs6kGD8vI6llgCiw8QeIxrAe0ZK8WA5SXRevH1q4esCPUxrPQh
         g59BzejUIUZM4+k6R8/gxEhO0zdLdgjCKAuLSIk9+IXitpS3tJNk+uU4GMjo5Qcx2jJa
         McQu0BQZ+m9xB5IbGTUwffQE225n3cQfwlSXVHyrZAWCeUYkJtSFP1OpGqvTWseg2wih
         q9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3cNauMywvmvrNjMdZIsRhBPNnoWHlOKi7QO8UB6MPk=;
        b=Pbp9JJZSk97+HOE6VVbBhjIolbY9TEmKamPBI7LC9INSOhrfnnqcpMh9uoIpzYxCn/
         bNok8fWSujt4UsDu8jbl8agPzcx97zjXbPqtIVGDH+KTe+JQ/BM+nbm56LgcBkh+2x4g
         H7d3Xw0vCeI2Pde8p8Jg4zvnYpTZ+BlBZfCLoLF2+Kyr73RdRecYwfdeumnuwCWkO9pZ
         lrIZBsHT0WT5r7u0AH7OicFbgKUD4gTzi4Oc5s8bN7y0Ur5aoW5yXeQWY4zdado2nP1Q
         zEY5Qp24vQ1vpM+B2sTDyAFQ43mLNRUO2Thb1Nu8iczyJo4qNhK/ajE/XiQFZ9hHZahJ
         CDnA==
X-Gm-Message-State: APjAAAWbIOunbcbssGLhwlMoIk81DHgy5cSiKH4exmxTPqco/5WDCws3
        fHkfoYToVU+eoEnfGmGXpR6gUw==
X-Google-Smtp-Source: APXvYqzioS28BG97ZxGGZ27cm1611TLDSQG3gxp4BWjtUmDJDMTBOrkgxSFIzXZFctQ7+JKhEqGE9w==
X-Received: by 2002:ac8:37e6:: with SMTP id e35mr10046559qtc.302.1581869720982;
        Sun, 16 Feb 2020 08:15:20 -0800 (PST)
Received: from localhost.localdomain ([179.159.237.245])
        by smtp.gmail.com with ESMTPSA id b12sm7385014qkl.0.2020.02.16.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 08:15:20 -0800 (PST)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Alifer Moraes <alifer.wsdm@gmail.com>, marco.franchi@nxp.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8mq-phanbell: Add support for ethernet
Date:   Sun, 16 Feb 2020 13:15:16 -0300
Message-Id: <20200216161516.15568-1-vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211134828.138-1-alifer.wsdm@gmail.com>
References: <20200211134828.138-1-alifer.wsdm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alifer Moraes <alifer.wsdm@gmail.com> wrote:
> Date: Tue, 11 Feb 2020 10:48:28 -0300
> 
> Add support for ethernet on Google's i.MX 8MQ Phanbell
> 
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mq-phanbell.dts    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> index 3f2a489a4ad8..16ed13c44a47 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> @@ -201,6 +201,27 @@
>  	};
>  };
>  
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <10>;
> +	phy-reset-post-delay = <30>;
> +	phy-handle = <&ethphy0>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -254,6 +275,26 @@
>  };
>  
>  &iomuxc {
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
> +			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f

Tested-by: Vitor Massaru Iha <vitor@massaru.org>

Tested on Coral Dev board.

BR,
Vitor
