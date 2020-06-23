Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6637FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEEC20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592913613;
	bh=codoLjtaO6/vACrA8fcNCAUkyN1GZZcCITUujEgiBZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zRgJGHi85B/SZw8X5yxkISsktM8OhvsrjKlR5N5iQdP6+1aYZZA48RzKjjuZcLA3l
	 A3YTzAQMmwrVoWkAjlQjdvq1hYM4TEz3940rSgc7zQdaJRqL3lmaCmNXgjJpbqdojt
	 p1MqpXZMzvi4jAXE9fbEgTCNbTWBjQKTfJupVppU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbgFWMAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732439AbgFWMAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:00:11 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91D620738;
        Tue, 23 Jun 2020 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592913610;
        bh=codoLjtaO6/vACrA8fcNCAUkyN1GZZcCITUujEgiBZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ov6NH+vkbi2pEf8lpT8UQlcNQEELk0Gbnq78hdjhNznmH7Sblva4W78HHv/ND68Vo
         /c9KWFOCKIZhjbSLGqB7Wj9CBwpDC46xDfegFEKyiCeMNIUXTS5hELN3yqC2tJn5CP
         ncg9VRUAXpK89bqH3V1I9HA8t1t3t/wdzpEEmvnw=
Date:   Tue, 23 Jun 2020 20:00:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     ran.wang_1@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v2 3/4] arm64: dts: ls1012a/ls1043a/ls1046a/ls1088a/ls208xa:
 add ftm_alarm0 node
Message-ID: <20200623120004.GD30139@dragon>
References: <20200614143206.24993-1-biwen.li@oss.nxp.com>
 <20200614143206.24993-3-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614143206.24993-3-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 10:32:05PM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The patch adds ftm_alarm0 DT node
> 	- add new rcpm node
> 	- add ftm_alarm0 node
> 	- aliases ftm_alarm0 as rtc1
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v2:
> 	- use generic name
> 	- use definition
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 15 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 14 ++++++++++++++
>  5 files changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 006e544..4742efe 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -22,6 +22,7 @@
>  		rtic-c = &rtic_c;
>  		rtic-d = &rtic_d;
>  		sec-mon = &sec_mon;
> +		rtc1 = &ftm_alarm0;

Sorry. I did not catch it during v1 review.  But we want to keep them
sort alphabetically.

Shawn

>  	};
>  
>  	cpus {
> @@ -512,6 +513,20 @@
>  					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
>  		};
> +
> +		rcpm: power-controller@1ee2140 {
> +			compatible = "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-2.1+";
> +			reg = <0x0 0x1ee2140 0x0 0x4>;
> +			#fsl,rcpm-wakeup-cells = <1>;
> +		};
> +
> +		ftm_alarm0: timer@29d0000 {
> +			compatible = "fsl,ls1012a-ftm-alarm";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x20000>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			big-endian;
> +		};
>  	};
>  
>  	firmware {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 3b641bd..55ceae7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -27,6 +27,7 @@
>  		ethernet4 = &enet4;
>  		ethernet5 = &enet5;
>  		ethernet6 = &enet6;
> +		rtc1 = &ftm_alarm0;
>  	};
>  
>  	cpus {
> @@ -829,6 +830,19 @@
>  			big-endian;
>  		};
>  
> +		rcpm: power-controller@1ee2140 {
> +			compatible = "fsl,ls1043a-rcpm", "fsl,qoriq-rcpm-2.1+";
> +			reg = <0x0 0x1ee2140 0x0 0x4>;
> +			#fsl,rcpm-wakeup-cells = <1>;
> +		};
> +
> +		ftm_alarm0: timer@29d0000 {
> +			compatible = "fsl,ls1043a-ftm-alarm";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x20000>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			big-endian;
> +		};
>  	};
>  
>  	firmware {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index d4c1da3..3c92c21 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -28,6 +28,7 @@
>  		ethernet5 = &enet5;
>  		ethernet6 = &enet6;
>  		ethernet7 = &enet7;
> +		rtc1 = &ftm_alarm0;
>  	};
>  
>  	cpus {
> @@ -765,6 +766,20 @@
>  			queue-sizes = <64 64>;
>  			big-endian;
>  		};
> +
> +		rcpm: power-controller@1ee2140 {
> +			compatible = "fsl,ls1046a-rcpm", "fsl,qoriq-rcpm-2.1+";
> +			reg = <0x0 0x1ee2140 0x0 0x4>;
> +			#fsl,rcpm-wakeup-cells = <1>;
> +		};
> +
> +		ftm_alarm0: timer@29d0000 {
> +			compatible = "fsl,ls1046a-ftm-alarm";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x20000>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			big-endian;
> +		};
>  	};
>  
>  	reserved-memory {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 36a7995..169f474 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -18,6 +18,7 @@
>  
>  	aliases {
>  		crypto = &crypto;
> +		rtc1 = &ftm_alarm0;
>  	};
>  
>  	cpus {
> @@ -781,6 +782,19 @@
>  				};
>  			};
>  		};
> +
> +		rcpm: power-controller@1e34040 {
> +			compatible = "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-2.1+";
> +			reg = <0x0 0x1e34040 0x0 0x18>;
> +			#fsl,rcpm-wakeup-cells = <6>;
> +		};
> +
> +		ftm_alarm0: timer@2800000 {
> +			compatible = "fsl,ls1088a-ftm-alarm";
> +			reg = <0x0 0x2800000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	firmware {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 3944ef1..0c74021 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -24,6 +24,7 @@
>  		serial1 = &serial1;
>  		serial2 = &serial2;
>  		serial3 = &serial3;
> +		rtc1 = &ftm_alarm0;
>  	};
>  
>  	cpu: cpus {
> @@ -763,6 +764,19 @@
>  			reg = <0x0 0x04000000 0x0 0x01000000>;
>  			interrupts = <0 12 4>;
>  		};
> +
> +		rcpm: power-controller@1e34040 {
> +			compatible = "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-2.1+";
> +			reg = <0x0 0x1e34040 0x0 0x18>;
> +			#fsl,rcpm-wakeup-cells = <6>;
> +		};
> +
> +		ftm_alarm0: timer@2800000 {
> +			compatible = "fsl,ls208xa-ftm-alarm";
> +			reg = <0x0 0x2800000 0x0 0x10000>;
> +			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	ddr1: memory-controller@1080000 {
> -- 
> 2.7.4
> 
