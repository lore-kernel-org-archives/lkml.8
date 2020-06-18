Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D182CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF9820707
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgFRMcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:32:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53660 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgFRMco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:32:44 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jltiJ-00082t-U1; Thu, 18 Jun 2020 14:32:15 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rockchip: Fix a reference count leak.
Date:   Thu, 18 Jun 2020 14:32:15 +0200
Message-ID: <3050852.oyibrqGndV@diego>
In-Reply-To: <20200613205158.27296-1-wu000273@umn.edu>
References: <20200613205158.27296-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 13. Juni 2020, 22:51:58 CEST schrieb wu000273@umn.edu:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count if pm_runtime_put is not called in
> error handling paths. Call pm_runtime_put if pm_runtime_get_sync fails.
> 
> Fixes: fc05a5b22253 ("ASoC: rockchip: add support for pdm controller")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

somewhat unintuitive, but I checked __pm_runtime_resume for it, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  sound/soc/rockchip/rockchip_pdm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
> index 7cd42fcfcf38..1707414cfa92 100644
> --- a/sound/soc/rockchip/rockchip_pdm.c
> +++ b/sound/soc/rockchip/rockchip_pdm.c
> @@ -590,8 +590,10 @@ static int rockchip_pdm_resume(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(dev);
>  		return ret;
> +	}
>  
>  	ret = regcache_sync(pdm->regmap);
>  
> 




