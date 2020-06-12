Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2B207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLNJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:09:17 -0400
Received: from foss.arm.com ([217.140.110.172]:36196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFLNJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:09:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D93F61F1;
        Fri, 12 Jun 2020 06:09:15 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197103F6CF;
        Fri, 12 Jun 2020 06:09:13 -0700 (PDT)
Subject: Re: [PATCH] drm/mediatek: remove unnecessary conversion to bool
To:     Bernard Zhao <bernard@vivo.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200612124007.4990-1-bernard@vivo.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e070b38f-fa77-5872-ea59-13098cebbe56@arm.com>
Date:   Fri, 12 Jun 2020 14:09:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612124007.4990-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-12 13:40, Bernard Zhao wrote:
> In function mtk_dsi_clk_hs_state, remove unnecessary conversion
> to bool return, this change is to make the code a bit readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 270bf22c98fe..4491e64b3f06 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -319,7 +319,7 @@ static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
>   	u32 tmp_reg1;
>   
>   	tmp_reg1 = readl(dsi->regs + DSI_PHY_LCCON);
> -	return ((tmp_reg1 & LC_HS_TX_EN) == 1) ? true : false;
> +	return ((tmp_reg1 & LC_HS_TX_EN) == 1);

FWIW the "== 1" is also redundant, not to mention a little confusing - 
unless you go and look up the definition of LC_HS_TX_EN, it looks like 
this is doing something more than simply testing if a single bit is set.

Robin.

>   }
>   
>   static void mtk_dsi_clk_hs_mode(struct mtk_dsi *dsi, bool enter)
> 
