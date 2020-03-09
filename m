Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6607622522
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h5JVtoab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgCIQqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:46:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCIQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:46:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so101575wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=FcE2MUIl7tIBAlEEfVJMghDlrIoIaJrggtMzoLGQxtU=;
        b=h5JVtoabxOIa7/d1qTmT5zFHcuKiW3eFaUaAw56br6NvCKb7Xxtj2MSf6wc1+OXmHg
         /vHfQJh47n8iC0us2CSsP4Ac5/jxY5ma3lZIso7eZu16F7hYSdqcZz5xxOzmP3B3vzkS
         ubFLyWhRvA1Fre8XovsCqZ1AmD/HbIF/+hO1NUM1YjF1v7IvG2HmaTieZwBq8MvtlBHN
         ecPyfGyotLu7BxZJuWzYcWNxjedKrUDAoJrNDjT3Us+RfsOkXstzb2J9eba7kR5IFEF+
         a/lX1j5LS2op0Ft+pTfa05PHD3Fh3FD+p2XsC2zfjUdUTPV1pW+cmN5+2Na+99LWlIcX
         zBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=FcE2MUIl7tIBAlEEfVJMghDlrIoIaJrggtMzoLGQxtU=;
        b=doDKr8qFKYQX8dQKULnwNrRjgpqWxCcTUXbqe/8BQq5Hx9/ViW7QM/+DBLXtOZkvp0
         NNT3R7l6xjk0JViFRfncyrLSsHqFlCzcoqZqUBRHKnJb4BchyEsHG5CHOspTYiQBiyNG
         WmjRR81h99Z0MzptUyll6IgpdAiHMyK6Q83Au+4EEDTrwVfax+POFr2Bl+LSJmeN9vf1
         C3uQKehHRqLJXOn0WBo8YnucwELpwX+6VtOxGXuuvOmKEqFKyFZ7D6fmrC/tIWPckOyO
         LZJ3EztmVLxD2G+YPJ6Gcrnzdo0llrIK0DIFYZLSWk/h09UaJxYIix+pm+rhXwUK1O8B
         r8Eg==
X-Gm-Message-State: ANhLgQ1WjXYpoQCbDLE6fYuWr+V2Ezr4RXuHdXxdd2S9Rhke4j1jZDJN
        BcO0iUg0bRj6jTkmUpgo0zYoVA==
X-Google-Smtp-Source: ADFU+vt6CRz1E/i0REBSGntcAZc9hZwMe0YmueP+IrwFjMtabYMdUF0pqSki2o/pSjJ8sm/pLgl2wA==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr150270wmn.47.1583772382078;
        Mon, 09 Mar 2020 09:46:22 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e22sm110182wme.45.2020.03.09.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:46:21 -0700 (PDT)
References: <20200309162912.GA21498@amd>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pavel Machek <pavel@ucw.cz>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/meson: fix irq leak in error path
In-reply-to: <20200309162912.GA21498@amd>
Date:   Mon, 09 Mar 2020 17:46:20 +0100
Message-ID: <1jeeu14gtf.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 09 Mar 2020 at 17:29, Pavel Machek <pavel@ucw.cz> wrote:

> Irq seems to be leaked in error path. Fix that.
>

Thanks for fixing this.

the Fixes tag is missing here.
Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")

> Signed-off-by: Pavel Machek <pavel@denx.de>
>
> ---
>
> I noticed problem during -stable review, and don't have hardware or
> ability to test the patch. Handle with care.
>
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 2f44e93359f6..fbac6de891cd 100644
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
> @@ -270,8 +269,14 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
>  	/* Take memory arbitror out of reset */
>  	ret = reset_control_deassert(fifo->arb);
>  	if (ret)
> -		clk_disable_unprepare(fifo->pclk);
> +		goto free_clk;
> +
> +	return 0;
>  
> +free_clk:

This label is misleading as it won't free the clock but turn it off.
how about 'err_rst' ?

> +	clk_disable_unprepare(fifo->pclk);
> +free_irq:

and 'err_pclk' here ?

> +	free_irq(fifo->irq, ss);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(axg_fifo_pcm_open);

