Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CC8206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgGAPJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:09:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37536 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbgGAPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:09:52 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 989F420025;
        Wed,  1 Jul 2020 17:09:46 +0200 (CEST)
Date:   Wed, 1 Jul 2020 17:09:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: allows LP commands in video
 mode
Message-ID: <20200701150945.GA669248@ravnborg.org>
References: <20200701145258.2782-1-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701145258.2782-1-yannick.fertre@st.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8b9GpE9nAAAA:8 a=e5mUnYsNAAAA:8
        a=YTZQKkLrOCVqNVj5krQA:9 a=eq0Tk01GMUV6gyqT:21 a=rLxRNCjj-UiVEZYG:21
        a=CjuIK1q_8ugA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick.

On Wed, Jul 01, 2020 at 04:52:58PM +0200, Yannick Fertre wrote:
> From: Antonio Borneo <antonio.borneo@st.com>
> 
> Current code only sends LP commands in command mode.
> 
> Allows sending LP commands also in video mode by setting the
> proper flag in DSI_VID_MODE_CFG.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>

> Change-Id: Ib78fa37bcc7559ce63017acd6ee0bbf00c61a397
Change-Id is not used in kernel patches to my best knowledge.

> Reviewed-on: https://gerrit.st.com/c/mpu/oe/st/linux-stm32/+/153242
> Reviewed-by: CITOOLS <smet-aci-reviews@lists.codex.cro.st.com>
> Reviewed-by: CIBUILD <smet-aci-builds@lists.codex.cro.st.com>
Reviews by humans, not machines..

> Reviewed-by: Yannick FERTRE <yannick.fertre@st.com>
> Reviewed-by: Philippe CORNU <philippe.cornu@st.com>
> Tested-by: Yannick FERTRE <yannick.fertre@st.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index d580b2aa4ce9..0cd43e7a69bb 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -367,6 +367,13 @@ static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
>  
>  	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
>  	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
> +
> +	val = dsi_read(dsi, DSI_VID_MODE_CFG);
> +	if (lpm)
> +		val |= ENABLE_LOW_POWER_CMD;
> +	else
> +		val &= ~ENABLE_LOW_POWER_CMD;
> +	dsi_write(dsi, DSI_VID_MODE_CFG, val);
>  }

We have following code:

static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
                                 unsigned long mode_flags)
{
        dsi_write(dsi, DSI_PWR_UP, RESET);

        if (mode_flags & MIPI_DSI_MODE_VIDEO) {
                dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
                dw_mipi_dsi_video_mode_config(dsi);
                dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
        } else {
                dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
        }

        dsi_write(dsi, DSI_PWR_UP, POWERUP);
}

Here DSI_MODE_CFG is used to set vidoe mode or not.

But the code snip above checks DSI_VID_MODE_CFG.
It looks inconsistent.

I do not know the HW - and just stumbled over this.

	Sam


>  
>  static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
