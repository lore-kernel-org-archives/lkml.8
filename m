Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A01C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C5820693
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598771103;
	bh=qJZMAD9Q2MOXNf2qIsusoobMRyMbqbCp4Y0wWiOf6Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yCRVlpN4UtSo3u5mov3senh2Y+csRLNiSxfy2TZlU4RnSZfkSdskktksIVblIS9AL
	 r74KruMqkErP5N7u43t7eKkQxQoUd2xYXlqwOmV1gtgkhX4KHthDzC1NarhlrxE4Ce
	 RjI87Dd8HMsYHrbaTKAub4yHqOrufDwYXjgX1Sb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgH3HFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgH3HE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:04:58 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB2120693;
        Sun, 30 Aug 2020 07:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598771098;
        bh=qJZMAD9Q2MOXNf2qIsusoobMRyMbqbCp4Y0wWiOf6Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfIZ1vx57j916BoBhdQerDPM8AEsb6NK4bOmf5q7T0QeByeTeWXt/ZDh1fU38a8MY
         OsNxqdRh6Iqjc7R7vhWNKo64ab8Og1SFqJaD9wyZpxIkvbmuvw6uYmgujyFhB1XTZS
         lwq4e956dKCgJz64VTP9PtyVafYqtVCBiG7c2BFQ=
Date:   Sun, 30 Aug 2020 15:04:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] arm64: dts: imx8mm-beacon-kit: Add missing build
 through Makefile
Message-ID: <20200830070452.GG32096@dragon>
References: <20200823172019.18606-1-krzk@kernel.org>
 <20200823172019.18606-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823172019.18606-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 07:20:16PM +0200, Krzysztof Kozlowski wrote:
> Add missing imx8mm-beacon-kit.dts object in Makefile so it will be build
> when building dtbs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

We have applied a patch from Rob [1] for that.

Shawn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=56e79dfd036b538940227fb31371c1cd67b2467f

> ---
>  arch/arm64/boot/dts/freescale/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a39f0a1723e0..903c0eb61290 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> -- 
> 2.17.1
> 
