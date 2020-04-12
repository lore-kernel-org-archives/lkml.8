Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE70EC2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0332087E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 19:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0332087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgDLTxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 15:53:06 -0400
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95D6C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 12:53:06 -0700 (PDT)
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6E1E580475;
        Sun, 12 Apr 2020 21:53:00 +0200 (CEST)
Date:   Sun, 12 Apr 2020 21:52:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>, drinkcat@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        laurent.pinchart@ideasonboard.com, hsinyi@chromium.org,
        matthias.bgg@gmail.com, Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] drm/mediatek: mtk_dsi: Use the drm_panel_bridge API
Message-ID: <20200412195253.GA711@ravnborg.org>
References: <20200408211120.1407512-1-enric.balletbo@collabora.com>
 <20200408211120.1407512-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408211120.1407512-7-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8
        a=_Dwo-_uELdbJNNcBnpoA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric.

Just a "drive-by" comment.
I browsed all the patches - and nothing jumped at me.
But then I did not follow all the changes.

> @@ -1202,10 +1055,19 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -					  &dsi->panel, &dsi->next_bridge);
> +					  &panel, &dsi->next_bridge);
>  	if (ret)
>  		goto err_unregister_host;
>  
> +	if (panel) {
> +		panel->connector_type = DRM_MODE_CONNECTOR_DSI;
This assignment of panel->connector_type is wrong.
We should let the panel tell the type of connector.

And if the panel fails to do so - then fix it in the panel.

One day, when I get sufficiently bored/motivated I plan to go through
all panels to make sure they all update connector_type.

	Sam



> +		dsi->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> +		if (IS_ERR(dsi->panel_bridge)) {
> +			ret = PTR_ERR(dsi->panel_bridge);
> +			goto err_unregister_host;
> +		}
> +	}
> +
>  	dsi->driver_data = of_device_get_match_data(dev);
>  
>  	dsi->engine_clk = devm_clk_get(dev, "engine");
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
