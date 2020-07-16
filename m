Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37819C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E03207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e4FEY+O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGPN3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgGPN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:29:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67ACC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:29:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so10311433wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ekSSt/5t2jmT5g2LzLm9iiouocorbUPUaL0+PSkZByk=;
        b=e4FEY+O3MN9kneCWpjw2AuA6M3EOeHa76eTJCimRqpdrtKBQSSOraxPXNbBS8f8Hzc
         tz6zo/FvGqILsjj+bkWDfBySfy7EQhsxQfhljSHeGFQUXL1R14dAuoybNl747hLEjDPY
         vNppE3yDsKtFgZlvE7vJe6drtvYw7kI2pOfy2MRc5OuRRPF1FSQ8K8uCJQgeihxxobQi
         QVzUMhFg6KbZManF2vD441ml3dsS6g5yEkZFsIp/v/x1LiDzvlWdzu0jxI4KmMVzVDtZ
         mvFloFDMjuuzLmqzI356WyXrn6UiezpZ3f74qnVUym5bzdrugxI4+QulkFaW1qEiGlH3
         oUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ekSSt/5t2jmT5g2LzLm9iiouocorbUPUaL0+PSkZByk=;
        b=P4Pm1Z/8cms23Ggswj/XOPjoqTmzczg8xcNnP9uXLgDAjGZLzllRPxhm3Y2xriLRhZ
         6qfldVJVctiIseVcMT9W1+EeMjIiWLA9mJMkl8GuWjNbgjvCuKojt/sRFBiRjBDcWNG5
         BhHBnTz5jLTcIBJCdwR0KM5Teo60+7yaVVBW7a3kb5/CbIBjmiK7gcCG+5Qb9Ho5fSWA
         6jcNy4LfpqbJuGGsoPFbElWeym6e+ARtd8S9IBOeq8imCEQs7Mlzm3J7cIV9UHFFMLiC
         qYMqOQS7pohzZVEdvo7occzH2g/7xBuYY5IWlGqZF81gtTzrEJT6XvbG4ox+m1cKiq57
         sWpQ==
X-Gm-Message-State: AOAM533sHuYlCrg8tiX7rcsu1AYbuGhKL4BUH4fkacj+9NAQ88aYQPs0
        93DWZHw+hIGdWcJ2P2z+Xkd+wg==
X-Google-Smtp-Source: ABdhPJyADBcDb+XzELdoJ99YW8KYEjCgWzkM0ZKScl+XNUWRXJyRD/oosm2ILnxfvcz3p0ggTeii6Q==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr4618549wmf.38.1594906180632;
        Thu, 16 Jul 2020 06:29:40 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x7sm8945595wrr.72.2020.07.16.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:29:39 -0700 (PDT)
References: <20200716132558.33932-1-jingxiangfeng@huawei.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        khilman@baylibre.com, kuninori.morimoto.gx@renesas.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: add the missed kfree() for axg_card_add_tdm_loopback
In-reply-to: <20200716132558.33932-1-jingxiangfeng@huawei.com>
Date:   Thu, 16 Jul 2020 15:29:39 +0200
Message-ID: <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 16 Jul 2020 at 15:25, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:

> axg_card_add_tdm_loopback() misses to call kfree() in an error path. Add
> the missed function call to fix it.
>
> Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Thanks for fixing this.
Maybe it would be better to use the devm_ variant for the name instead ?

> ---
>  sound/soc/meson/axg-card.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
> index 89f7f64747cd..6eac22ba8b99 100644
> --- a/sound/soc/meson/axg-card.c
> +++ b/sound/soc/meson/axg-card.c
> @@ -121,8 +121,10 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
>  		return -ENOMEM;
>  
>  	dlc = devm_kzalloc(card->dev, 2 * sizeof(*dlc), GFP_KERNEL);
> -	if (!dlc)
> +	if (!dlc) {
> +		kfree(lb->name);
>  		return -ENOMEM;
> +	}
>  
>  	lb->cpus = &dlc[0];
>  	lb->codecs = &dlc[1];

