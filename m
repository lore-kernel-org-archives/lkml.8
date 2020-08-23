Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB05AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F2D2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHWPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 11:11:08 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37040 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgHWPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 11:11:04 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A05A880512;
        Sun, 23 Aug 2020 17:10:59 +0200 (CEST)
Date:   Sun, 23 Aug 2020 17:10:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Peter Senna Tschudin <peter.senna@gmail.com>,
        ldv-project@linuxtesting.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Martin Donnelly <martin.donnelly@ge.com>
Subject: Re: [PATCH] drm/brige/megachips: Add checking if
 ge_b850v3_lvds_init() is working correctly
Message-ID: <20200823151058.GB1047718@ravnborg.org>
References: <20200819143756.30626-1-lutovinova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819143756.30626-1-lutovinova@ispras.ru>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=HH5vDtPzAAAA:8 a=xjQjg--fAAAA:8 a=e5mUnYsNAAAA:8
        a=hQuFlIxVr7xEOWb3pwQA:9 a=CjuIK1q_8ugA:10 a=QM_-zKB-Ew0MsOlNKMB5:22
        a=L4vkcYpMSA5nFlNZ2tk3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadezda

On Wed, Aug 19, 2020 at 05:37:56PM +0300, Nadezda Lutovinova wrote:
> If ge_b850v3_lvds_init() does not allocate memory for ge_b850v3_lvds_ptr,
> then a null pointer dereference is accessed.
> 
> The patch adds checking of the return value of ge_b850v3_lvds_init().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>

Thanks, applied to drm-misc-next, so it will hit upstream during the
next merge window.

	Sam

> ---
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index 6200f12..ab81748 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -302,8 +302,12 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
>  				       const struct i2c_device_id *id)
>  {
>  	struct device *dev = &stdp4028_i2c->dev;
> +	int ret;
> +
> +	ret = ge_b850v3_lvds_init(dev);
>  
> -	ge_b850v3_lvds_init(dev);
> +	if (ret)
> +		return ret;
>  
>  	ge_b850v3_lvds_ptr->stdp4028_i2c = stdp4028_i2c;
>  	i2c_set_clientdata(stdp4028_i2c, ge_b850v3_lvds_ptr);
> @@ -361,8 +365,12 @@ static int stdp2690_ge_b850v3_fw_probe(struct i2c_client *stdp2690_i2c,
>  				       const struct i2c_device_id *id)
>  {
>  	struct device *dev = &stdp2690_i2c->dev;
> +	int ret;
> +
> +	ret = ge_b850v3_lvds_init(dev);
>  
> -	ge_b850v3_lvds_init(dev);
> +	if (ret)
> +		return ret;
>  
>  	ge_b850v3_lvds_ptr->stdp2690_i2c = stdp2690_i2c;
>  	i2c_set_clientdata(stdp2690_i2c, ge_b850v3_lvds_ptr);
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
