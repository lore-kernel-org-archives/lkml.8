Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B4624649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583806755;
	bh=1D0ruiqPBlq5ljllycoSnscbtRcbZn4ljFZNuTYOETI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mTF4G9FWIITSbZF0mYpNrqMAsyEtjp9DHlg/AuxWJbr8N4PuNdXfBrJtEdQMGvquM
	 C9k3IUJNvqwhYDlXllWBjbYQMZQucYgM2CSbzkaYs3SsNhps5+fJOLpa5rXWOHNyrh
	 ng4+avH1fESNfazroUqbAx+bbxgzC2LInO3wtTL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCJCTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgCJCTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:19:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84EE52146E;
        Tue, 10 Mar 2020 02:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583806753;
        bh=1D0ruiqPBlq5ljllycoSnscbtRcbZn4ljFZNuTYOETI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HeenbLn4LUXYAdfa7EGusttFAS7tb/A3JPIAyPlepJpjfV60jcs/xL2tlVbT39iL0
         VvS7kS3YbhcY8AdOWjDWiFcQiK5bDxEXaM/HIGV1ajMIZUCNr9ME1XyAyTcN6RluX/
         RCyQvmBEEstvI1KFG1cKooXeSOthlifspjq1QqBU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200306130056.7434E80307C4@mail.baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru> <20200306130056.7434E80307C4@mail.baikalelectronics.ru>
Subject: Re: [PATCH 3/5] dt-bindings: clk: Add Baikal-T1 System Devices CCU bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey.Semin@baikalelectronics.ru
Date:   Mon, 09 Mar 2020 19:19:12 -0700
Message-ID: <158380675267.149997.6512279008781160044@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey.Semin@baikalelectronics.ru (2020-03-06 05:00:46)
> diff --git a/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml =
b/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
> new file mode 100644
> index 000000000000..aea09fbafc89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/be,bt1-ccu-sys.yaml
> @@ -0,0 +1,169 @@
[..]
> +  assigned-clock-rates: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bt1-ccu.h>
> +
> +    ccu_sys: ccu_sys@1F04D060 {

Node name should be clock-controller@1f04d060.

Also, binding looks wrong because that address isn't aligned. Most
likely it's one hardware block that has many different functionalities
so splitting it up into different regions isn't doing anything besides
logically splitting up the register space for software benefits.

> +      compatible =3D "be,bt1-ccu-sys";
> +      reg =3D <0x1F04D060 0x0A0>,
> +            <0x1F04D150 0x004>;
> +      #clock-cells =3D <1>;
> +      #reset-cells =3D <1>;
> +
> +      clocks =3D <&osc25>,
> +               <&ccu_pll CCU_SATA_PLL>,
> +               <&ccu_pll CCU_PCIE_PLL>,
> +               <&ccu_pll CCU_ETH_PLL>;
> +      clock-names =3D "ref_clk", "sata_clk", "pcie_clk",
> +                    "eth_clk";
> +
> +      clock-output-names =3D "sys_sata_ref_clk", "sys_apb_clk",
> +                           "sys_gmac0_csr_clk", "sys_gmac0_tx_clk",
> +                           "sys_gmac0_ptp_clk", "sys_gmac1_csr_clk",
> +                           "sys_gmac1_tx_clk", "sys_gmac1_ptp_clk",
> +                           "sys_xgmac_ref_clk", "sys_xgmac_ptp_clk",
> +                           "sys_usb_clk", "sys_pvt_clk",
> +                           "sys_hwa_clk", "sys_uart_clk",
> +                           "sys_spi_clk", "sys_i2c1_clk",
> +                           "sys_i2c2_clk", "sys_gpio_clk",
> +                           "sys_timer0_clk", "sys_timer1_clk",
> +                           "sys_timer2_clk", "sys_wdt_clk";
> +      };
> +...
> diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/re=
set/bt1-ccu.h
> index 4de5b6bcd433..0bd8fd0edb41 100644
> --- a/include/dt-bindings/reset/bt1-ccu.h
> +++ b/include/dt-bindings/reset/bt1-ccu.h
> @@ -20,4 +20,8 @@
>  #define CCU_AXI_HWA_RST                        9
>  #define CCU_AXI_SRAM_RST               10
> =20
> +/* Baikal-T1 System Devices CCU Reset indeces. */

indeces is not a word.

> +#define CCU_SYS_SATA_REF_RST           0
> +#define CCU_SYS_APB_RST                        1
> +
