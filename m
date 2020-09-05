Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22119C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49AD20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599292813;
	bh=kei2H3h0w+PactK7NvTHMOnvBjpz4W19f5W1J90dbbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EHbMTYP59vYPM06XAmwjyI5IPlq0a9BRZigVVsjzFJ9Ey+jySsi2vAsjtzL6luRmi
	 lLPqt+flyMeuhwFGqFUFs3jACTJP6KY/vUuzaHnd84xN0hIANd6nBSwVJTFUV0+RZW
	 y+WKhUFO4kyoeXER40Vge/X6YLIaGvO6hvvNI3Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgIEIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEIAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:00:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE1C20760;
        Sat,  5 Sep 2020 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599292805;
        bh=kei2H3h0w+PactK7NvTHMOnvBjpz4W19f5W1J90dbbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrSuK7gIew7i17cRHZuVpPfq1eX6Y+9JbnTC/zwOTnp2w0/Iaw5LmcNrUV9nfrYK1
         XHqLf5nve43SVnj4UnsWh+GYLLKc74/JNqfDeIEp95FTFTRvQDz67x/cS/fGSocDgt
         a66yd74yJJrGIM3v7NQm3IAJ2QEpvq5oS4LHbPEk=
Date:   Sat, 5 Sep 2020 16:00:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
Message-ID: <20200905080000.GR9261@dragon>
References: <20200903145347.17830-1-matthias.schiffer@ew.tq-group.com>
 <20200903145347.17830-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903145347.17830-2-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:53:47PM +0200, Matthias Schiffer wrote:
> - Fix national,lm75 compatible string
> - Remove obsolete fsl,spi-num-chipselects

Two patches, please.

Shawn

> 
> Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: drop fsl,spi-num-chipselects instead of replacing with num-cs
> 
>  arch/arm/boot/dts/imx6qdl-tqma6.dtsi  | 1 -
>  arch/arm/boot/dts/imx6qdl-tqma6a.dtsi | 2 +-
>  arch/arm/boot/dts/imx6qdl-tqma6b.dtsi | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> index 9513020ddd1a..b18b83ac6aee 100644
> --- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> @@ -20,7 +20,6 @@
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1>;
> -	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
> index c18a06cf7929..b679bec78e6c 100644
> --- a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
> @@ -16,7 +16,7 @@
>  	};
>  
>  	sensor@48 {
> -		compatible = "lm75";
> +		compatible = "national,lm75";
>  		reg = <0x48>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
> index a7460075f517..49c472285c06 100644
> --- a/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
> @@ -16,7 +16,7 @@
>  	};
>  
>  	sensor@48 {
> -		compatible = "lm75";
> +		compatible = "national,lm75";
>  		reg = <0x48>;
>  	};
>  
> -- 
> 2.17.1
> 
