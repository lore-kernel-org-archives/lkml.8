Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3771DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045872074B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 20:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XA88GXBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgFGUnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 16:43:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29EC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 13:43:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so15276438wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=lZvTa+fi3q1fHKnC1NQ/5Z2Ndj1/0QXtbAGtm+dp8V4=;
        b=XA88GXBCMwRC8ua5Zu1G1aq1EuoHHamyB7XfFDreblLDNy9oepc7VRQ+RnWPezXhWu
         F/sI2GLdvWzRd2LxwU/Jh7tU/CChLMG1Oz3GnckfQo2g/B6LZUrz4IbKP5TR7QtIVryP
         y009CvtbXFo+0gbUCpZ3WN7kG1sYxQuZ8XxK70kTohvaJirXKC7V5/0kkvEcW9jYi2eS
         VZoAXCn1itpeEVSF8tIc0A3xYlXfV8sJN9jSgNaKkFxx6bfxFx3kCWUalLQnwP+M/9K8
         DbYTUCE+VM14CJcRNr9eEBr+Fy6SoV9OEf9k/l86n4NH1qcTy4jSFhjhs/6CUxOfnA9d
         tQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=lZvTa+fi3q1fHKnC1NQ/5Z2Ndj1/0QXtbAGtm+dp8V4=;
        b=amaC9eFtfajDr/efBgMvj4MF9tzq211sC5eJUn7lKkxZfIf6SXhWQE1nP+SpY2bWLT
         kS+XjlBuaaTNbw1LZfIkL5cUH8+6oz8Jcr42k+MCnJvcGO3nc4VEtsjrcXNcyCsZ10Gk
         LGPKsrhj3GaCWMckc4gZ7HfzKtxMPDUhye9hle2mIKJ8pHtjvjXmLV0d7ILiP+lWb42T
         TIMSjU4BqrB6MYAQX9suBzQOEdcFeom76YUHxznKxsf8NdFQ8REfR7G+eToUoqyWZmt9
         tHxyCufXB/34qDMqBi3IvuqgdIN8sJmnOOWQ9V6jIRb5plgyEF6qEemDZ5/w2HarE74B
         L2VA==
X-Gm-Message-State: AOAM532dCyby+rW3Yeh+SvlFyQSARt9LrHdnyrRoscDFW3KHVqCvbAl4
        lsq9U24cYmImnXlYwlFfICkb4Q==
X-Google-Smtp-Source: ABdhPJwRg2AKDExNqQAafPVcv9hmJIPslCiSScJq+j3/O2XbJjP3NCsn9vcvUZhDPos5i3JhgsynoA==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr19363506wrx.141.1591562600771;
        Sun, 07 Jun 2020 13:43:20 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id j4sm21175221wma.7.2020.06.07.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:43:20 -0700 (PDT)
References: <20200606153103.GA17905@amd>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pavel Machek <pavel@ucw.cz>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        khilman@baylibre.com, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] soc/meson: add missing free_irq() in error path
In-reply-to: <20200606153103.GA17905@amd>
Date:   Sun, 07 Jun 2020 22:43:18 +0200
Message-ID: <1j5zc2k3o9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 06 Jun 2020 at 17:31, Pavel Machek <pavel@ucw.cz> wrote:

> free_irq() is missing in case of error, fix that.
>
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 2e9b56b29d31..b2e867113226 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -249,7 +249,7 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
>  	/* Enable pclk to access registers and clock the fifo ip */
>  	ret = clk_prepare_enable(fifo->pclk);
>  	if (ret)
> -		return ret;
> +		goto free_irq;
>  
>  	/* Setup status2 so it reports the memory pointer */
>  	regmap_update_bits(fifo->map, FIFO_CTRL1,
> @@ -269,8 +269,14 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
>  	/* Take memory arbitror out of reset */
>  	ret = reset_control_deassert(fifo->arb);
>  	if (ret)
> -		clk_disable_unprepare(fifo->pclk);
> +		goto free_clk;
> +
> +	return 0;
>  
> +free_clk:
> +	clk_disable_unprepare(fifo->pclk);
> +free_irq:
> +	free_irq(fifo->irq, ss);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(axg_fifo_pcm_open);

