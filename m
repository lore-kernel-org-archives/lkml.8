Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035A122B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E23c3Mc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgBRSzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:55:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgBRSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:55:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so25292588wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ErZHR63GyvAXj/k5szxTb4OUm9B9u05E1RcdCjTAUfI=;
        b=E23c3Mc47XqQCvrDho+eUNOGA8a/hMVEaLa5ltPayqx2Ncqdu/SSzsDxDElTp8NhsI
         wNiQ+xjuehDUCbLWhnbEp8TbjNQZROJMaZSiBrdZ4d7sGEm45WrZ0d1ll6A+2IA4ISwP
         x03PFZMelXhq2BP14LPRp76pCZM3WFOmWZksBVxgUMMB7c32KmaBLOmj+DU995dylNMK
         86+y+rJRunonJz/WuWlNsOPftxKpej9dMUzEkdk/Zpg5So9XbKBpmYobwSXCprEFdjgl
         VDLGtK+OHLln+37e/YDBVJ9FJgmyoMFz0a0Fvx3pX/tXF4RpYNL9BLmdUutcXXogeOSz
         3u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ErZHR63GyvAXj/k5szxTb4OUm9B9u05E1RcdCjTAUfI=;
        b=EaCbj0uJoOhTQ4PEvQn6V3jIhTzCBOrpTCv79o424SyejdBC9o7Mw1Uv4EG53zVZWr
         9CnFFLc2vnHGdcn6MgyTOBAqiDEI1FQLqKYbNI+XhPg0q34oqkWUpSFj2LeKIAR/kQDO
         cr7IhIhF4Axnli+XepRx2aZGlKZJn761qP6W2n2B2qek17+tYakAC7YeSQH9w3Je5Mwc
         jmR0UfPehh1vleHhZCfsuPItGJpUxgdRGa2vZY9vyL94XuV4uXdcAzeydhCx6d54EVTy
         N2Ll7DZ4RXgFe8sinxVZZN8OTFUC5TWgZFXRWZmNBofgKwVbVs4XpMN4k3INFcqkVa7u
         GEig==
X-Gm-Message-State: APjAAAU4LDLjLsjiOYm3ugT1IHEGVAEJcOlWMBhzmZl3vF2pyIn6DqF3
        ZebwHZpaALqwIjZQjiRMNAxt+WHx9jOkKA==
X-Google-Smtp-Source: APXvYqwXudLunX8FJqJ2tRfpjX1YjMDJ7Af867EDxPqLeyN1Ym2kprlGpyMAwfKk45pDeoYRhB3/lg==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr30046394wrw.126.1582052133180;
        Tue, 18 Feb 2020 10:55:33 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id j14sm7229416wrn.32.2020.02.18.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:55:32 -0800 (PST)
References: <20200214134704.342501-1-jbrunet@baylibre.com> <applied-20200214134704.342501-1-jbrunet@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Applied "ASoC: core: ensure component names are unique" to the asoc tree
In-reply-to: <applied-20200214134704.342501-1-jbrunet@baylibre.com>
Date:   Tue, 18 Feb 2020 19:55:31 +0100
Message-ID: <1jblpvraho.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 14 Feb 2020 at 21:56, Mark Brown <broonie@kernel.org> wrote:

> The patch
>
>    ASoC: core: ensure component names are unique
>
> has been applied to the asoc tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark

Hi Mark,

Short Version:
After looking at the problem reported by Marek, I think the best course
of action for now is to revert b2354e4009a7 ("ASoC: core: ensure component names are unique")
while working on a solution. It might take some time.

Longer Version:

1) Multiple components :
I found out that in fact it is common for linux devices to register
multiple components. For most, it is a combination of the dmaengine
generic and the actual device component, but other register more
component. Ex:
- vc4-hdmi
- atmel-classd
- atmel-pdmic
- cros-ec-codec
- mtXXXX-afe-pcm
I suspect these trigger the debugfs warning
Even dummy register two components :D

All devices using devm_snd_dmaengine_pcm_register() and
devm_snd_soc_register_component() are exposed to clean-up issue in case
of deferral. That's because snd_soc_unregister_component() unregisters
all the components registered the device. I suppose there might be other
problems when using the devm API with this function.

2) Fixed component names:
Several card driver assume the component name is the device name and
won't query the actual component name or node. Ex:
- sun4i-codec
- omap-hdmi
- vc4-hdmi
- sof-nocodec

So changing the way ASoC generate the component names might break these
cards. It gets tricky because the same cards driver might register
multiple component themselves, like vc4-hdmi.

>
> From b2354e4009a773c00054b964d937e1b81cb92078 Mon Sep 17 00:00:00 2001
> From: Jerome Brunet <jbrunet@baylibre.com>
> Date: Fri, 14 Feb 2020 14:47:04 +0100
> Subject: [PATCH] ASoC: core: ensure component names are unique
>
> Make sure each ASoC component is registered with a unique name.
> The component is derived from the device name. If a device registers more
> than one component, the component names will be the same.
>
> This usually brings up a warning about the debugfs directory creation of
> the component since directory already exists.
>
> In such case, start numbering the component of the device so the names
> don't collide anymore.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Link: https://lore.kernel.org/r/20200214134704.342501-1-jbrunet@baylibre.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/soc-core.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 03b87427faa7..6a58a8f6e3c4 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2446,6 +2446,33 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
>  	return ret;
>  }
>  
> +static char *snd_soc_component_unique_name(struct device *dev,
> +					   struct snd_soc_component *component)
> +{
> +	struct snd_soc_component *pos;
> +	int count = 0;
> +	char *name, *unique;
> +
> +	name = fmt_single_name(dev, &component->id);
> +	if (!name)
> +		return name;
> +
> +	/* Count the number of components registred by the device */
> +	for_each_component(pos) {
> +		if (dev == pos->dev)
> +			count++;
> +	}
> +
> +	/* Keep naming as it is for the 1st component */
> +	if (!count)
> +		return name;
> +
> +	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
> +	devm_kfree(dev, name);
> +
> +	return unique;
> +}
> +
>  static int snd_soc_component_initialize(struct snd_soc_component *component,
>  	const struct snd_soc_component_driver *driver, struct device *dev)
>  {
> @@ -2454,7 +2481,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>  	INIT_LIST_HEAD(&component->card_list);
>  	mutex_init(&component->io_mutex);
>  
> -	component->name = fmt_single_name(dev, &component->id);
> +	component->name = snd_soc_component_unique_name(dev, component);
>  	if (!component->name) {
>  		dev_err(dev, "ASoC: Failed to allocate name\n");
>  		return -ENOMEM;

