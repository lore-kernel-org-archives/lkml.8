Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC79C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1262076A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588131767;
	bh=bojJWi5XJi3ClxQXdVn2A9s6TfcUQxHlWdtAUv5I/gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ik+NwHbKsYLHd066ZmYfz0v/+oaWoS7f4V3x7lXC8nGjU+mlc9jrBoDv4j+lSg4Pf
	 Vu/uDQHp7c6vQHAvsmG7on9ual29c53OIdeLx2Ym9wHkfrTWRQRJ+5TpWn/fQkifAx
	 E7VFdMqdC8fA/cetk6+tHCTwQdrCQ0C1jjIQRfCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2Dmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgD2Dmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:42:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8EF206D8;
        Wed, 29 Apr 2020 03:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588131765;
        bh=bojJWi5XJi3ClxQXdVn2A9s6TfcUQxHlWdtAUv5I/gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSszIX2Uee13BiiD799bAITkerLbcJvPluBlKNurlmTAiUIMxUhow2p+NqX36zOsv
         3dFAW5g/eIFAb0ylOIjedjbN9DYxOpGpCsj9ebhjdXkp++3shfLtDL0i2LA+oRqeUQ
         gQt/afvMMwL1P624kQ8cTi5nTRiw5NE1T7Db5MD0=
Date:   Wed, 29 Apr 2020 11:42:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: freescale: imx8mm: correct VDDARM@1.6GHz
Message-ID: <20200429034239.GR32592@dragon>
References: <1587852408-6483-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587852408-6483-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 06:06:48AM +0800, Robin Gong wrote:
> Correct VDDARM to 0.95V@1.6Ghz with datasheet.

Please add more details about the data sheet like version, download
address, etc.

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

I know it might be hard to follow, but for historic reason, we use
subject prefix 'ARM: dts: ...' for arm32 and 'arm64: dts: ...' for arm64
dts patches on IMX platform.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index cc7152e..a226030 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -129,7 +129,7 @@
>  
>  		opp-1600000000 {
>  			opp-hz = /bits/ 64 <1600000000>;
> -			opp-microvolt = <900000>;
> +			opp-microvolt = <950000>;
>  			opp-supported-hw = <0xc>, <0x7>;
>  			clock-latency-ns = <150000>;
>  			opp-suspend;
> -- 
> 2.7.4
> 
