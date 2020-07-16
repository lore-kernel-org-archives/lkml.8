Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28116C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C2B206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594882835;
	bh=Qct6MZ1QaNERKb7aX6s5WHVRW6dIsCv2vuonJPxJwfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y42MuGUdhlHSGlJG8BZYMDY4GfYYU5VjoraHL+zACPRMErn6CQaGrTm5JG0eFYpT9
	 DrlacpOrYysE6Bei8jnKVEKxcxYwwQG6kN49uc+Di/ExHgwNp/gKwMoiofyR6vcDR/
	 i7T263tB5z+beqFymMRRbssfT3k1/PWSSUWbZC9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgGPHAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPHAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:00:33 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.199.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6DC2064C;
        Thu, 16 Jul 2020 07:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594882833;
        bh=Qct6MZ1QaNERKb7aX6s5WHVRW6dIsCv2vuonJPxJwfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U46Azy+KKOewokELUn/94s4XOAIPTR23B1XiYwcSU/SqGgvTviw/VrHQv4h4JAwxI
         wjE6GyCvV6HKwjzn5dKgNnCkbJzbhtwsy3ltt/SLMdTQfMi1u9QGm29qLwlNnbCDmD
         xXPwaj0ZHWxvERqvk5uXNHDsvxDfP2xDGK098dA0=
Date:   Thu, 16 Jul 2020 12:30:25 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@st.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ARM: dts: stm32: Correct spi4 pins in
 stm32mp15-pinctrl.dtsi
Message-ID: <20200716070025.GF3271@Mani-XPS-13-9360>
References: <20200708114324.7309-1-patrick.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708114324.7309-1-patrick.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:43:24PM +0200, Patrick Delaunay wrote:
> Move spi4_pins_a nodes from pinctrl_z to pinctrl
> as the associated pins are not in BANK Z.
>

Yikes, that's a nasty misplacement! Thanks for fixing.

> Fixes: 498a7014989dfdd9a47864b55704dc829ed0dc90

Fixes tag should be of below:

Fixes: 498a7014989d ("ARM: dts: stm32: Add missing pinctrl entries for STM32MP15")

> Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> 
>  arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 28 ++++++++++++------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index 7eb858732d6d..6aedbd7077ff 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1574,6 +1574,20 @@
>  		};
>  	};
>  
> +	spi4_pins_a: spi4-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> +				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
> +			bias-disable;
> +		};
> +	};
> +
>  	usart2_pins_a: usart2-0 {
>  		pins1 {
>  			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
> @@ -1776,18 +1790,4 @@
>  			bias-disable;
>  		};
>  	};
> -
> -	spi4_pins_a: spi4-0 {
> -		pins {
> -			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> -				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
> -			bias-disable;
> -			drive-push-pull;
> -			slew-rate = <1>;
> -		};
> -		pins2 {
> -			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
> -			bias-disable;
> -		};
> -	};
>  };
> -- 
> 2.17.1
> 
