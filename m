Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4102146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583907706;
	bh=bxHbcWq3Q5XazUANfBEywJc2ZDNiPxRoRkmScQum/gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jC9g+nwH+XyE/T3POu4yZ1fpRtMGy5cyEgIb3MOmdS82dgbGU+kSyuRcakQF1e8WG
	 e5aJU0YlgF6CDNj3vR6/tnJvcae+LPckF2tECuns7ys6WUuMMzKRm+Rj96ObifEv1a
	 3jOi05SSj0x3ezEYmXlat4QftmzkDHWMHEEeJIZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCKGVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgCKGVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:21:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB053208E4;
        Wed, 11 Mar 2020 06:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583907704;
        bh=bxHbcWq3Q5XazUANfBEywJc2ZDNiPxRoRkmScQum/gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtC9c4umeXVYs3RkeQddsCzb5NHjtl182YykeKhuz95KjItwjyPJWsbYl6g1UcCTt
         eQFG9GNzzXicUGy5alBx6ORZTBcr8L60hTuEhWIYGznCmTVJYAcSsjwDaCsNvt9+Bm
         iXsI5Biw92smgp2SKMVUqX2uC4Ua9FuNU4YaZgyw=
Date:   Wed, 11 Mar 2020 14:21:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com
Subject: Re: [PATCH] ARM64: dts: imx8m: fix aips dts node
Message-ID: <20200311062135.GD29269@dragon>
References: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:44:02AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per binding doc fsl,aips-bus.yaml, compatible and reg is

Where can I find this binding doc?

> required. And for reg, the AIPS configuration space should be
> used, not all the AIPS bus space.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Prefix 'arm64: ...' for arch/arm64 patches.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 12 ++++++++----
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 16 ++++++++--------
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++------
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++++++----
>  4 files changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index b3d0b29d7007..a4356d2047cd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -227,7 +227,8 @@
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  
>  		aips1: bus@30000000 {
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x301f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x30000000 0x30000000 0x400000>;
> @@ -496,7 +497,8 @@
>  		};
>  
>  		aips2: bus@30400000 {
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x305f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x30400000 0x30400000 0x400000>;
> @@ -555,7 +557,8 @@
>  		};
>  
>  		aips3: bus@30800000 {
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x309f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x30800000 0x30800000 0x400000>;
> @@ -800,7 +803,8 @@
>  		};
>  
>  		aips4: bus@32c00000 {
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x32df0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x32c00000 0x32c00000 0x400000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index f2775724377f..4848ce82f083 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -203,8 +203,8 @@
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  
>  		aips1: bus@30000000 {
> -			compatible = "simple-bus";
> -			reg = <0x30000000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x301f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -401,8 +401,8 @@
>  		};
>  
>  		aips2: bus@30400000 {
> -			compatible = "simple-bus";
> -			reg = <0x30400000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x305f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -461,8 +461,8 @@
>  		};
>  
>  		aips3: bus@30800000 {
> -			compatible = "simple-bus";
> -			reg = <0x30800000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x309f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -707,8 +707,8 @@
>  		};
>  
>  		aips4: bus@32c00000 {
> -			compatible = "simple-bus";
> -			reg = <0x32c00000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x32df0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 71b0c8f23693..eb67f56cdfe2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -144,8 +144,8 @@
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  
>  		aips1: bus@30000000 {
> -			compatible = "simple-bus";
> -			reg = <0x30000000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x301f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -309,8 +309,8 @@
>  		};
>  
>  		aips2: bus@30400000 {
> -			compatible = "simple-bus";
> -			reg = <0x30400000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x305f0000 0x400000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -369,8 +369,8 @@
>  		};
>  
>  		aips3: bus@30800000 {
> -			compatible = "simple-bus";
> -			reg = <0x30800000 0x400000>;
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x309f0000 0x400000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 6a1e83922c71..07070464063d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -290,7 +290,8 @@
>  		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
>  
>  		bus@30000000 { /* AIPS1 */
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x301f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x30000000 0x30000000 0x400000>;
> @@ -692,7 +693,8 @@
>  		};
>  
>  		bus@30400000 { /* AIPS2 */
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x305f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x30400000 0x30400000 0x400000>;
> @@ -751,7 +753,8 @@
>  		};
>  
>  		bus@30800000 { /* AIPS3 */
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x309f0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x30800000 0x30800000 0x400000>,
> @@ -1023,7 +1026,8 @@
>  		};
>  
>  		bus@32c00000 { /* AIPS4 */
> -			compatible = "simple-bus";
> +			compatible = "fsl,aips", "simple-bus";
> +			reg = <0x32df0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0x32c00000 0x32c00000 0x400000>;
> -- 
> 2.16.4
> 
