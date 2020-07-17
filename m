Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C89DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBE32074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CcrWH877"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGQIok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:44:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73190C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:44:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so10152950wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=9x6fTHZjafmueEMmRdi+LdlMzC2EII5ZkFzc9Fwx204=;
        b=CcrWH877Ri20PNsFBMBPs4KP9jLSBxVMwMQejX+OakrhCpNGurKvg/YYuWyooyngHO
         PGII9nSP3QITVgwaA4IMlURWO0b7gngGMwk2tXW0Z30dsgpHUZLhxbzH/rTNZ6LaErsg
         7bkbz0aMZlBSeE8sWKk1eu+xm6tMvSYt1dz3W5nHlHPy0+YrsvYM20RZqDXAcgy0hIFY
         IFcZv1BdkCGDXemcAcUKGgqaTS1rWgYSHbLZmWdaW+gVOH6Yvi9Ca51nI3rlF4f4cg4Q
         4J6q5a2drV9N+LEkPNNOqAy8bOGoph8gzskNnKVVKah64U9qztXuUs/d7VCVkGxWUC63
         2AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=9x6fTHZjafmueEMmRdi+LdlMzC2EII5ZkFzc9Fwx204=;
        b=GjIwttUeIHcOTFbYFRD5w8iBY9mfA+yDrebq6VnLEd3Hmwm+ukhVUv9aP0CLj/XWu3
         ebrjNv7ULA4KukMh0G9HoQykh2sO9KLvAYmZ0OdhDV51cA6ZmHAM8y6pmXp/hR1xDueK
         WeQTUh7T78qzaS9wmJTmF8qO+XH7yoJQr6KAndcmc+sgvxJ/GTbRvvuWo2TOFzEYCFrz
         Gg521owS0t09hdC2/sQ7UpYxFFc0BJ0kbQHOHy58nnhv5Kr7btrsCSoVDlVKY3XUuurp
         Kt15C+HK/GvQuz776M7LLUOwr3EZpbFxujcI/+ybXeTMLeC/UHYW3ukW3QONOCnV1N4+
         aWFw==
X-Gm-Message-State: AOAM531ZLS3lqCoyW8YKn430iA6P616zZ4RMmhTe/n1NDsS8OT1thcFe
        iw38ULr4XNDL+9YStxwNbYSwEQ==
X-Google-Smtp-Source: ABdhPJyovxSTvHHpc7ZiBtlMV3klZ1rwvUq3jT7v0dWg3bOYRkcwggR2do8xcR8ffqqZT8dB2S5bOA==
X-Received: by 2002:adf:f311:: with SMTP id i17mr9496093wro.237.1594975477992;
        Fri, 17 Jul 2020 01:44:37 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k20sm12480834wmi.27.2020.07.17.01.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:44:35 -0700 (PDT)
References: <20200717082242.130627-1-jingxiangfeng@huawei.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        khilman@baylibre.com, kuninori.morimoto.gx@renesas.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: meson: fixes the missed kfree() for axg_card_add_tdm_loopback
In-reply-to: <20200717082242.130627-1-jingxiangfeng@huawei.com>
Date:   Fri, 17 Jul 2020 10:44:35 +0200
Message-ID: <1j7dv2sf7w.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 17 Jul 2020 at 10:22, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:

> axg_card_add_tdm_loopback() misses to call kfree() in an error path. We
> can use devm_kasprintf() to fix the issue, also improve maintainability.
> So use it instead.
>
> Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  sound/soc/meson/axg-card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
> index 89f7f64747cd..47f2d93224fe 100644
> --- a/sound/soc/meson/axg-card.c
> +++ b/sound/soc/meson/axg-card.c
> @@ -116,7 +116,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
>  
>  	lb = &card->dai_link[*index + 1];
>  
> -	lb->name = kasprintf(GFP_KERNEL, "%s-lb", pad->name);
> +	lb->name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-lb", pad->name);
>  	if (!lb->name)
>  		return -ENOMEM;

