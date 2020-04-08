Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D918C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C9B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rmLITQ6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgDHPso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:32948 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgDHPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:48:40 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2D4EC522;
        Wed,  8 Apr 2020 17:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586360919;
        bh=/JgXmN/0WyKx0OrE+QYBVoprM4aMOvGu9pmddBBOTck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmLITQ6k1FTf27YU2enzczolQS74XPSGlFhJ/EQQXSIXI1XzLyqq5RoGVNMucXZPG
         SVY4hg6v413eemiT/yEG6hyHsjdzKF2HpRnG4MZTMN8JK+mNVsgXuH6nBgN1O7qS9M
         hsypevpJn75bHjg5BVE1q1AujS4QIYgPCk64QV3A=
Date:   Wed, 8 Apr 2020 18:48:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/5] arm64: defconfig: add DRM_DISPLAY_CONNECTOR
Message-ID: <20200408154829.GI4881@pendragon.ideasonboard.com>
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
 <20200408143040.57458-3-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408143040.57458-3-max.krummenacher@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Thank you for the patch.

On Wed, Apr 08, 2020 at 04:30:37PM +0200, Max Krummenacher wrote:
> Add DRM_DISPLAY_CONNECTOR. This got introduced with the bridge rework
> Which renamed among others DRM_DUMB_VGA_DAC.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> 
> ---
> 
> Changes in v2:
> - additional patch adding DRM_DISPLAY_CONNECTOR as recommended by Geert and Laurent
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ae908c3f43c76..d765a920a20b9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -612,6 +612,7 @@ CONFIG_DRM_PANEL_LVDS=m
>  CONFIG_DRM_PANEL_SIMPLE=m
>  CONFIG_DRM_SIMPLE_BRIDGE=m
>  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
> +CONFIG_DRM_DISPLAY_CONNECTOR=m
>  CONFIG_DRM_SII902X=m
>  CONFIG_DRM_THINE_THC63LVD1024=m
>  CONFIG_DRM_TI_SN65DSI86=m

-- 
Regards,

Laurent Pinchart
