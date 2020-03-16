Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB26C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30F220674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l3Gqhn+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgCPI2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:28:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41604 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:28:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id f11so3193091wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=szWYYRkGahxA61hsmRUJ5tS74K70qXB8+PDKduH3nHs=;
        b=l3Gqhn+/M4Ha0UXVm0T3q6iV8ObxlaoHrtfqnRe+mfq3J/sCzFKJf4x7NlK7oimIwz
         tN1cuQljn0V24A6ikzf7Lh2Z5FZgBuhhcvzzlycmoWTw5AO/wLuLWUbxFwyAxd0Jt38q
         /YbIiOe4knXylQmu+M/SKDnkj5Ce2vCTOSweGQH50Ef2xnZ4js/HFbH2hFYpHx3TALhu
         4wjaB4vv3tSbPvQLG21Ggst/b5DfZRjtQt537OaHLyEY5TqcODhqXaffxWBzdSqdvD78
         jTvX9ZUunrrWo00MZaFdHDpcGEp9sBOUca60V1fbLklrtGD+8Iu+s+9w+fpmj5Vravvv
         5iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=szWYYRkGahxA61hsmRUJ5tS74K70qXB8+PDKduH3nHs=;
        b=NPKp/WO3y3sFgQsOozJBpXr6qdFmdQ3l1182Zue5i/oCH6vuvWXbLJ2pms/cAGvjmC
         eRX/gVcDpZPwykmaSNtUQJSieYSO42kxkDY7VhBZNdBSAuXGlnX6SeJ5dwPmpsB1RpGu
         aB/HcXna2drRCE/RNl4mN8h0TtSlvR7YQ/UTZOw1l5VwFJ8gEMOLvqSGlF+6baMZIxkw
         KkrNCKWryhVyzAfoGciY8uLe1T48nFVe+rDeihqM/eO1Uvgez1iAFZSjU79JiHqiCaZ9
         ta/TVDTxsdVGy72627So7UXIC0ALFSC9R78XcL6EcK+CjkwuJ+cGux3kYbkCfiOAE8A9
         UoWg==
X-Gm-Message-State: ANhLgQ3jIHoGuKvNJfNjbAybuwC47NdOxOYBEkwnzn6Ihe8xdfd4nPK6
        iubymcgDmx4hAmrAz1tMa34J3w==
X-Google-Smtp-Source: ADFU+vtF0RfkG0k25HaWGkNvoj16Mvu5LgZ52qoUMhowQkFr4iYwgmRJjGLbQodQSmkECLChCJor9w==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr34558588wrv.245.1584347293228;
        Mon, 16 Mar 2020 01:28:13 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k133sm30082169wma.11.2020.03.16.01.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:28:12 -0700 (PDT)
References: <20200316023411.1263-1-sashal@kernel.org> <20200316023411.1263-8-sashal@kernel.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH AUTOSEL 5.4 08/35] ASoC: meson: g12a: add tohdmitx reset
In-reply-to: <20200316023411.1263-8-sashal@kernel.org>
Date:   Mon, 16 Mar 2020 09:28:11 +0100
Message-ID: <1ja74gg0v8.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 16 Mar 2020 at 03:33, Sasha Levin <sashal@kernel.org> wrote:

> From: Jerome Brunet <jbrunet@baylibre.com>
>
> [ Upstream commit 22946f37557e27697aabc8e4f62642bfe4a17fd8 ]
>
> Reset the g12a hdmi codec glue on probe. This ensure a sane startup state.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Link: https://lore.kernel.org/r/20200221121146.1498427-1-jbrunet@baylibre.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

The tohdmitx reset property is not in the amlogic g12a DT in v5.4.
Backporting this patch on v5.4 would break the hdmi sound, and probably
the related sound card since the reset is not optional.

Could you please drop this from v5.4 stable ?
It is ok to keep it for v5.5.

Thanks
Jerome

> ---
>  sound/soc/meson/g12a-tohdmitx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
> index 9cfbd343a00c8..8a0db28a6a406 100644
> --- a/sound/soc/meson/g12a-tohdmitx.c
> +++ b/sound/soc/meson/g12a-tohdmitx.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <sound/pcm_params.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dai.h>
>  
> @@ -378,6 +379,11 @@ static int g12a_tohdmitx_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	void __iomem *regs;
>  	struct regmap *map;
> +	int ret;
> +
> +	ret = device_reset(dev);
> +	if (ret)
> +		return ret;
>  
>  	regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(regs))

