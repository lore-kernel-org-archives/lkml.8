Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FC2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A30B20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgHCGqw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:46:52 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40213 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHCGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:46:51 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AB251FF804;
        Mon,  3 Aug 2020 06:46:46 +0000 (UTC)
Date:   Mon, 3 Aug 2020 08:46:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/rockchip: lvds: ensure ret is assigned before
 checking for an error
Message-ID: <20200803084645.442b5178@xps13>
In-Reply-To: <20200714190003.744069-1-colin.king@canonical.com>
References: <20200714190003.744069-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Colin King <colin.king@canonical.com> wrote on Tue, 14 Jul 2020
20:00:03 +0100:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there are two places where the return status in ret is being
> checked for an error however the assignment of ret has been omitted
> making the checks redundant.  Fix this by adding in the missing assignments
> of ret.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: cca1705c3d89 ("drm/rockchip: lvds: Add PX30 support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 63f967902c2d..b45c618b9793 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -499,11 +499,11 @@ static int px30_lvds_probe(struct platform_device *pdev,
>  	if (IS_ERR(lvds->dphy))
>  		return PTR_ERR(lvds->dphy);
>  
> -	phy_init(lvds->dphy);
> +	ret = phy_init(lvds->dphy);
>  	if (ret)
>  		return ret;
>  
> -	phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
> +	ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
>  	if (ret)
>  		return ret;
>  

I thought I (or Heiko) already sent a patch for that but apparently
not...

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
