Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C224BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F22074B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KdOyqU9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgFGUjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgFGUjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:39:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B04C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 13:39:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so15978933ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=cxAlOko9t8uVXP+cvSgKgh4pcthYDznq/xdMjGJwWF8=;
        b=KdOyqU9ND3HG5d87XzvYCfQ2uByF1009R35nYXeDDMLn3vhVJNmlnwuNBXc0HasUMj
         LyKvjV0OHT0/GFgDE/03M8ppq31jNA/14gxV99DDyqL8qAre2/OHH5LtP6yQKvfznyX2
         LROlH2K/f/dx1Vn/5b4xOX0oA7ArWmNxLbjZ1JVMq+Vnt/1ms3tCRN/hGC71MCrsqjUd
         GIPFEFAU/eZqHJivwmZWwKWtr3PRkJqQ1obBpY+x+MD2ytvfqSzxenTN/wm1iaf4iXcG
         kNiefj+tDTqhRm+1eJYp0/rg7yaWUj0T9E5B1oGeYm2hbTCHEqv2buK6/vOkL0BGK6WX
         fsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=cxAlOko9t8uVXP+cvSgKgh4pcthYDznq/xdMjGJwWF8=;
        b=oRyx+Rlx7otKRbr9zTAqgodfSL2HHJ3lnZ5+J0TsVcI1G2gQxk9mOVP/80fcxoGfIw
         caT57Brgi26P+SJfOvyxzCt3Xyi3uq1xp0RtM3bd2Az5FprK7ZX6C/aCgh8+mxxUXQ1v
         cNX3/Cdtcw8qHBjyQrRXapmH5tzAABsevw1WRGenntKArIolDL0dxABNiYNWhcjaJ4EG
         w8oKZllmQsVNkhIxQOU0gqtx2Tay8XBd5F+XeyQ636CRHEMoi3sbAnJ6/CPljFRhs9SL
         NtzqBYtkAKZxmb0fZ7WbcfmOSJkrgGJ6wU4+zBe+CEZn9w8SMfex61nFE/KvEWlXXchq
         uSEQ==
X-Gm-Message-State: AOAM531vAg55U6JM0jOAEyL/TdIhEygIW/lBURaA508MEfjVKEVl8Oe7
        iJQNew3+7g3ho85NMb/m3NSQ/w==
X-Google-Smtp-Source: ABdhPJxhaSuBhybacMUdhNX3W1cQmnqaVuUYl4vqsJiFOjecWMYGoz4GLI7EUeGpnCcBDZ6WR7g6xQ==
X-Received: by 2002:a17:906:a387:: with SMTP id k7mr19195332ejz.408.1591562389607;
        Sun, 07 Jun 2020 13:39:49 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id v29sm10754839edb.62.2020.06.07.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:39:48 -0700 (PDT)
References: <20200604171216.60043-1-colin.king@canonical.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: fix memory leak of links if allocation of ldata fails
In-reply-to: <20200604171216.60043-1-colin.king@canonical.com>
Date:   Sun, 07 Jun 2020 22:39:47 +0200
Message-ID: <1j7dwik3u4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 04 Jun 2020 at 19:12, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently if the allocation of ldata fails the error return path
> does not kfree the allocated links object.  Fix this by adding
> an error exit return path that performs the necessary kfree'ing.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good, Thx

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  sound/soc/meson/meson-card-utils.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
> index 2ca8c98e204f..5a4a91c88734 100644
> --- a/sound/soc/meson/meson-card-utils.c
> +++ b/sound/soc/meson/meson-card-utils.c
> @@ -49,19 +49,26 @@ int meson_card_reallocate_links(struct snd_soc_card *card,
>  	links = krealloc(priv->card.dai_link,
>  			 num_links * sizeof(*priv->card.dai_link),
>  			 GFP_KERNEL | __GFP_ZERO);
> +	if (!links)
> +		goto err_links;
> +
>  	ldata = krealloc(priv->link_data,
>  			 num_links * sizeof(*priv->link_data),
>  			 GFP_KERNEL | __GFP_ZERO);
> -
> -	if (!links || !ldata) {
> -		dev_err(priv->card.dev, "failed to allocate links\n");
> -		return -ENOMEM;
> -	}
> +	if (!ldata)
> +		goto err_ldata;
>  
>  	priv->card.dai_link = links;
>  	priv->link_data = ldata;
>  	priv->card.num_links = num_links;
>  	return 0;
> +
> +err_ldata:
> +	kfree(links);
> +err_links:
> +	dev_err(priv->card.dev, "failed to allocate links\n");
> +	return -ENOMEM;
> +
>  }
>  EXPORT_SYMBOL_GPL(meson_card_reallocate_links);

