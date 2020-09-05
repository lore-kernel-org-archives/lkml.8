Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A5DC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4976D2078D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599292784;
	bh=dtE+0E4METvjXqYoV3heYZwK/bZQJ/P/hICKNLHl7XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gFsz9ofylZCBYK5/Ep8tIGCdyQB0PDEKOtjxextZbYVWZMLnqGgwRwlYMAjpbWMcg
	 LMinLBfxcQZ4luJCmPYZZtRoqy9VS0kCyPeNSWIKUrmQr3MXk8N14B9vQmSrCG74Yw
	 vkOrP70qGqFb6VXg3XBNe3AmS5OXKVF4tdxhXRcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgIEH7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEH7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:59:41 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E041620760;
        Sat,  5 Sep 2020 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599292780;
        bh=dtE+0E4METvjXqYoV3heYZwK/bZQJ/P/hICKNLHl7XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUw8KM5qB7IYPglpupr8+0Xsh+w8GX0SvYkKsRgealH+Wo0x28DUbfd3DWG8W6Ibf
         c280tIiAPkYPcPMIe9bkHT6NSgw0hrw0Q8JMLyU0/JRTq4XnLKR5s/E2gtgB7+xHyH
         8zU0tTnhmkLWQ/whS/agcWzWkWDDO5hUUOI0rfDc=
Date:   Sat, 5 Sep 2020 15:59:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6qdl: tqma6: fix indentation
Message-ID: <20200905075934.GQ9261@dragon>
References: <20200903145347.17830-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903145347.17830-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:53:46PM +0200, Matthias Schiffer wrote:
> Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Sorry, I do not take patch with empty commit log.

Shawn

> ---
> 
> v2: no changes
> 
>  arch/arm/boot/dts/imx6qdl-tqma6.dtsi | 188 +++++++++++++--------------
>  1 file changed, 94 insertions(+), 94 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> index 29bcce20f5f3..9513020ddd1a 100644
> --- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> @@ -83,101 +83,101 @@
>  };
>  
>  &pmic {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_pmic>;
> -		interrupt-parent = <&gpio6>;
> -		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> -
> -		regulators {
> -			reg_vddcore: sw1ab {
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1875000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_vddsoc: sw1c {
> -				regulator-min-microvolt = <300000>;
> -				regulator-max-microvolt = <1875000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_gen_3v3: sw2 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_ddr_1v5a: sw3a {
> -				regulator-min-microvolt = <400000>;
> -				regulator-max-microvolt = <1975000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_ddr_1v5b: sw3b {
> -				regulator-min-microvolt = <400000>;
> -				regulator-max-microvolt = <1975000>;
> -				regulator-always-on;
> -			};
> -
> -			sw4_reg: sw4 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_5v_600mA: swbst {
> -				regulator-min-microvolt = <5000000>;
> -				regulator-max-microvolt = <5150000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_snvs_3v: vsnvs {
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_vrefddr: vrefddr {
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			reg_vgen1_1v5: vgen1 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <1550000>;
> -				/* not used */
> -			};
> -
> -			reg_vgen2_1v2_eth: vgen2 {
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <1550000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_vgen3_2v8: vgen3 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_vgen4_1v8: vgen4 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_vgen5_1v8_eth: vgen5 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			reg_vgen6_3v3: vgen6 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pmic>;
> +	interrupt-parent = <&gpio6>;
> +	interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> +
> +	regulators {
> +		reg_vddcore: sw1ab {
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1875000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_vddsoc: sw1c {
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1875000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_gen_3v3: sw2 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_ddr_1v5a: sw3a {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <1975000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_ddr_1v5b: sw3b {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <1975000>;
> +			regulator-always-on;
> +		};
> +
> +		sw4_reg: sw4 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_5v_600mA: swbst {
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5150000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_snvs_3v: vsnvs {
> +			regulator-min-microvolt = <1500000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-always-on;
>  		};
> +
> +		reg_vrefddr: vrefddr {
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		reg_vgen1_1v5: vgen1 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1550000>;
> +			/* not used */
> +		};
> +
> +		reg_vgen2_1v2_eth: vgen2 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1550000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_vgen3_2v8: vgen3 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_vgen4_1v8: vgen4 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_vgen5_1v8_eth: vgen5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_vgen6_3v3: vgen6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
>  };
>  
>  /* eMMC */
> -- 
> 2.17.1
> 
