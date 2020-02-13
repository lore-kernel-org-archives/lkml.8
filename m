Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2CAC3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B832221734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NmwbSH48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgBMJS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:18:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39871 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgBMJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:18:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so5690779wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=7czut/f+WvTlMROMZ/cNySTRX/vHmG6GC+8NGFEVZJ4=;
        b=NmwbSH483nOZckSEz2gQdiI1ReVlsSpJctLLqG7S6qr7AG+v5FJrLC3LU4tgj6eeko
         SbMsMyw18EuWpAM2swQiCyXf8EDJ5K4n1RL400+UJ32jb1a5fWRqWmRB9OiJEAUR310P
         D2aP0N6oWZd/KLuZnGR/IV6u3NaBM9XqB1kdHZE2GKMpnj/lMhrjLJms5oehZ8pmzr9A
         DztQUby5RIxFJS0kgx4qC5D2PWAYMyz/yFnLsRN4lc8bora4NPgWs57svs1QmevcCCMv
         LwkrWFzHIEWNIBa1rz3WR/82264NT1P81QIDoQImTqZHx88s/RXdHF8XTt9kOp6lJ0mX
         +tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=7czut/f+WvTlMROMZ/cNySTRX/vHmG6GC+8NGFEVZJ4=;
        b=F4WktKYHEzw0YE0qeUt9OygRzaH5AhaksHoZPoY4RruQP55XOjJvXHARROwbTaiBj5
         fZdYqXcfLgB6jpsiUCEG5HiD1S29PFD63SnvTxPFP6rIzZOPdlYcQ6pmdmj5wtt4XcM5
         jyK3vWV2jW9OstSdFGdZ4kyfuTxPN+jI7weMCK72wQWXKcBIMVe3qWvucbpeOHoGDF66
         pu2/VR+g49p7lJyCeKhVuSXf8Bc8YTWWOn3oeGc/1IDFteGdqIn0tDn47mGtqomLFf7a
         a5O+OdACzSmwiJAQuTutnoYCkXHL8s7h7HNqtCfSS0LXAUhep0VyLFzit6WIvQoWxQi8
         LqKw==
X-Gm-Message-State: APjAAAXruymnzqKh5OlrIul/omoAfbQkS7gs2fJ7Jl6oJbCI9fj5mO4f
        WrJiWbop3lRUqLq4AEBheBfXwQ==
X-Google-Smtp-Source: APXvYqxDmr+YV4LtZoRtXU+1bcEnbJd9LFKQqknPCjnDC5IwLpyYvrgBnHfyRNAfWh8GtfECezwh4g==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr20092486wrp.236.1581585535365;
        Thu, 13 Feb 2020 01:18:55 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u23sm2171611wmu.14.2020.02.13.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:18:54 -0800 (PST)
References: <20200213061147.29386-1-samuel@sholland.org> <20200213061147.29386-5-samuel@sholland.org>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: simple-card: Add support for codec-to-codec dai_links
In-reply-to: <20200213061147.29386-5-samuel@sholland.org>
Date:   Thu, 13 Feb 2020 10:18:53 +0100
Message-ID: <1jpneialqa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 13 Feb 2020 at 07:11, Samuel Holland <samuel@sholland.org> wrote:

> For now we assume there are only a few sets of valid PCM stream
> parameters, to avoid needing to specify them in the device tree. We
> also assume they are the same in both directions. We calculate the
> common subset of parameters, and then the existing code automatically
> chooses the highest quality of the remaining values.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/simple-card.txt |  1 +
>  Documentation/sound/soc/codec-to-codec.rst    |  9 ++++-
>  include/sound/simple_card_utils.h             |  1 +
>  sound/soc/generic/simple-card-utils.c         | 39 +++++++++++++++++++
>  sound/soc/generic/simple-card.c               | 12 ++++++
>  5 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> index 79954cd6e37b..18a62e404a30 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -63,6 +63,7 @@ Optional dai-link subnode properties:
>  - mclk-fs             			: Multiplication factor between stream
>  					  rate and codec mclk, applied only for
>  					  the dai-link.
> +- codec-to-codec			: Indicates a codec-to-codec
> dai-link.

I wonder if such property could be viewed as a Linux implementation
detail ?

Similar discussion around DPCM:

* https://lore.kernel.org/linux-devicetree/20191014115635.GB4826@sirena.co.uk/#t
* https://alsa-devel.alsa-project.narkive.com/NCs4MsqL/simle-card-dt-style-for-dpcm#post4

Should the card figure out the codec-to-codec links on its own or is it
something generic enough to put in DT ?

In the Amlogic card driver, I'm using the compatible string of the
device to figure out if CPU is a CODEC.
It is ad-hoc and, to be honest, I'm not entirely happy with this
solution but I could not figure out a better one yet.

>  
>  For backward compatibility the frame-master and bitclock-master
>  properties can be used as booleans in codec subnode to indicate if the
> diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
> index 810109d7500d..efe0a8c07933 100644
> --- a/Documentation/sound/soc/codec-to-codec.rst
> +++ b/Documentation/sound/soc/codec-to-codec.rst
> @@ -104,5 +104,10 @@ Make sure to name your corresponding cpu and codec playback and capture
>  dai names ending with "Playback" and "Capture" respectively as dapm core
>  will link and power those dais based on the name.
>  
> -Note that in current device tree there is no way to mark a dai_link
> -as codec to codec. However, it may change in future.
> +A dai_link in a "simple-audio-card" can be marked as codec to codec in
> +the device tree by adding the "codec-to-codec" property. The dai_link
> +will be initialized with the subset of stream parameters (channels,
> +format, sample rate) supported by all DAIs on the link. Since there is
> +no way to provide these parameters in the device tree, this is mostly
> +useful for communication with simple fixed-function codecs, such as a
> +Bluetooth controller or cellular modem.
> diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
> index bbdd1542d6f1..80b60237b3cd 100644
> --- a/include/sound/simple_card_utils.h
> +++ b/include/sound/simple_card_utils.h
> @@ -49,6 +49,7 @@ struct asoc_simple_priv {
>  		struct asoc_simple_data adata;
>  		struct snd_soc_codec_conf *codec_conf;
>  		unsigned int mclk_fs;
> +		bool codec_to_codec;
>  	} *dai_props;
>  	struct asoc_simple_jack hp_jack;
>  	struct asoc_simple_jack mic_jack;
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 9b794775df53..2de4cfead790 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -331,6 +331,41 @@ static int asoc_simple_init_dai(struct snd_soc_dai *dai,
>  	return 0;
>  }
>  
> +static int asoc_simple_init_dai_link_params(struct snd_soc_pcm_runtime *rtd,
> +					    struct simple_dai_props *dai_props)
> +{
> +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> +	struct snd_soc_pcm_stream *params;
> +	struct snd_pcm_hardware hw;
> +	int ret;
> +
> +	if (!dai_props->codec_to_codec)
> +		return 0;
> +
> +	/* Assumes the hardware capabilities are the same in both directions */
> +	ret = snd_soc_runtime_calc_hw(rtd, &hw, SNDRV_PCM_STREAM_PLAYBACK);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "simple-card: no valid dai_link params\n");
> +		return ret;
> +	}
> +
> +	params = devm_kzalloc(rtd->dev, sizeof(*params), GFP_KERNEL);
> +	if (!params)
> +		return -ENOMEM;
> +
> +	params->formats = hw.formats;
> +	params->rates = hw.rates;
> +	params->rate_min = hw.rate_min;
> +	params->rate_max = hw.rate_max;
> +	params->channels_min = hw.channels_min;
> +	params->channels_max = hw.channels_max;
> +
> +	dai_link->params = params;
> +	dai_link->num_params = 1;
> +
> +	return 0;
> +}
> +
>  int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> @@ -347,6 +382,10 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = asoc_simple_init_dai_link_params(rtd, dai_props);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(asoc_simple_dai_init);
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index 55e9f8800b3e..179ab4482d10 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -77,6 +77,16 @@ static int asoc_simple_parse_dai(struct device_node *node,
>  	return 0;
>  }
>  
> +static void simple_parse_codec_to_codec(struct device_node *node,
> +					struct simple_dai_props *props,
> +					char *prefix)
> +{
> +	char prop[128];
> +
> +	snprintf(prop, sizeof(prop), "%scodec-to-codec", prefix);
> +	props->codec_to_codec = of_property_read_bool(node, prop);
> +}
> +
>  static void simple_parse_convert(struct device *dev,
>  				 struct device_node *np,
>  				 struct asoc_simple_data *adata)
> @@ -217,6 +227,7 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
>  					     "prefix");
>  	}
>  
> +	simple_parse_codec_to_codec(node, dai_props, prefix);
>  	simple_parse_convert(dev, np, &dai_props->adata);
>  	simple_parse_mclk_fs(top, np, codec, dai_props, prefix);
>  
> @@ -292,6 +303,7 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
>  	if (ret < 0)
>  		goto dai_link_of_err;
>  
> +	simple_parse_codec_to_codec(node, dai_props, prefix);
>  	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
>  
>  	ret = asoc_simple_parse_cpu(cpu, dai_link, &single_cpu);

