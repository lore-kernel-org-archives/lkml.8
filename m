Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08EEC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B690D2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587394507;
	bh=mVEx3XY90SEpTFNM9MsmAdX5zzmMS+Pek1Ko35DoHGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A4nAybBjGSd6NZQ1jFCFGTI2zt6DXeuOPfuswKgT+2KApIQTGfbeSYgEtDaL4hZ1e
	 7vAGgGQKsNn0F62OLv/WNmiVV5LzgDw4nTQThux7eXlx96yrFR61MI+9MEeRHeAQuZ
	 +eG/chis1NEwXd5kK8Om+yqD3Qssj0ik774l7bSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgDTOzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDTOzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:55:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72C3206F6;
        Mon, 20 Apr 2020 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587394506;
        bh=mVEx3XY90SEpTFNM9MsmAdX5zzmMS+Pek1Ko35DoHGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjI9Q0xUzkfvTN4Kl2yjClEdUmVRl9wkGgCHQIjBTGpti48OHUrnXIwAtcnY+TGJ1
         9c1mfV8JXFmKyr7PbNilidjiX2RPiCQYR+Bz1afYm2EobOfyfB/z0BFBkF7j1v9wtV
         RX3F1IqZghJwU5oA/IbEwz88bIti8eYUQXgrdW5I=
Date:   Mon, 20 Apr 2020 22:54:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
Message-ID: <20200420145459.GE32419@dragon>
References: <d9bfb11e3d66376792089d54d7d52fe3778efa33.1584636213.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9bfb11e3d66376792089d54d7d52fe3778efa33.1584636213.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 05:46:02PM +0100, Guido Günther wrote:
> According to the imx8mq data sheet running VDD_GPU at 0.9V is enough
> when not overclocking to 1GHz (which we currently don't do).
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

It doesn't apply to my branch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index c47a26cf8e43..736b250bc9c2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -318,7 +318,7 @@
>  				regulator-min-microvolt = <700000>;
>  				regulator-max-microvolt = <1300000>;
>  				regulator-always-on;
> -				rohm,dvs-run-voltage = <1000000>;
> +				rohm,dvs-run-voltage = <900000>;
>  			};
>  
>  			buck4_reg: BUCK4 {
> -- 
> 2.23.0
> 
