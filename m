Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643B20863
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XvfDJypR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCBKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:03:30 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51606 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:03:30 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ABEA354A;
        Mon,  2 Mar 2020 11:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583143408;
        bh=Lc7Yy28cE9d+CVfXGMhAB4DWD8ECf5jY5VejWhcg/q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvfDJypRfkoFhsmusgeTbIqW+/Y922eaLqRsN5OtHZksIqOw1UOpcctZ6GITU1asZ
         NcSDRqkeW1PJ/4k5Lela6uavruWSm9HiorhpZgrNsCp5IbmKzDMXwiqNeowz8laqgm
         dEfllyMcK81dOu2C8oFhN6qckrShCL+RVNf8aFDM=
Date:   Mon, 2 Mar 2020 12:03:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] drm/bridge: synopsys: dw-hdmi: allow ycbcr420
 modes for >= 0x200a
Message-ID: <20200302100303.GI11960@pendragon.ideasonboard.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-6-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206191834.6125-6-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thank you for the patch.

On Thu, Feb 06, 2020 at 08:18:28PM +0100, Neil Armstrong wrote:
> Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
> for these modes in the connector if the platform supports them.
> We limit these modes to DW-HDMI IP version >= 0x200a which
> are designed to support HDMI2.0 display modes.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
>  include/drm/bridge/dw_hdmi.h              | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 15048ad694bc..4b35ea1427df 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3231,6 +3231,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  	hdmi->bridge.of_node = pdev->dev.of_node;
>  #endif
>  
> +	if (hdmi->version >= 0x200a)
> +		hdmi->connector.ycbcr_420_allowed =
> +			hdmi->plat_data->ycbcr_420_allowed;
> +	else
> +		hdmi->connector.ycbcr_420_allowed = false;
> +

The hdmi structure being allocated with kzalloc, you don't need the
second branch of the if, but I'm fine if you prefer keeping it. Any
either case,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	memset(&pdevinfo, 0, sizeof(pdevinfo));
>  	pdevinfo.parent = dev;
>  	pdevinfo.id = PLATFORM_DEVID_AUTO;
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 9d4d5cc47969..0b34a12c4a1c 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -129,6 +129,7 @@ struct dw_hdmi_plat_data {
>  	unsigned long input_bus_format;
>  	unsigned long input_bus_encoding;
>  	bool use_drm_infoframe;
> +	bool ycbcr_420_allowed;
>  
>  	/* Vendor PHY support */
>  	const struct dw_hdmi_phy_ops *phy_ops;

-- 
Regards,

Laurent Pinchart
