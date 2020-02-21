Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FFC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88B2208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmK1U1D9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBUGIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:08:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:08:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so632033lfc.1;
        Thu, 20 Feb 2020 22:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1vjAsiVJu0Xf8moFlCsGCMAJaKUjfw7ZDgAxe/OTIBI=;
        b=bmK1U1D9Co0bNdjfb+Z8qyJSGQPOYJ/YlJsmmQjLdyG+mc3GEI8QcnmDPDClvjSrlV
         qIWAZdaZF9lG5TNbsWT2bUyhgKw03sCn86fEovTL6AO3LS25lrytfgvN1zI8vyn0kOPb
         F8IDkLuzkoq82LcLcxsx2xVx+xR+cGhfPIfNtErtqS1DAQP3ZPS7bkMiVK/sJ0IdsE3R
         ZZWOWzcyi73Wrv6dC1C/aJ7D+J/C9dy7sXF2KgZymprTP95BFiXvVGsUUPa5dcf1AhHR
         Yvo8pvgGZ4VmWvRRHjEtHKND73qL9kig8EMj8GZ6KWa4ra1qyQILj/zoueL3KoKwMuHN
         EZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1vjAsiVJu0Xf8moFlCsGCMAJaKUjfw7ZDgAxe/OTIBI=;
        b=F7Yp6VjP6rY+A5YXTcCoqs7ZCB10AqxSttEJtpw+z1WgtG3Y9Vu/xJJafpCt8wj66D
         znGTd2jFhGSV4bhW7aLlUSqGX3TnWLZtelo69gaP0wS+736KKiHkjDGs3K+DshwnTc7e
         0uGQOcGOJ8tFmy33/jHw1SiC5pkpYHl+KpijskBU0YRBwo1ixLbhqwROEge3bpmQnVh6
         h0MY6Vn7f3SXmIMj7Wl9kHMLyJKFTYQFdzO8ORbGFKdtEEueWgkxLgQzXKzEdYtIPLqZ
         IpO5JznVhyO1eIsrdBq3je7HVXxd8gTTuee94GQumCrNvIkhcGQDNFyg7nTqPgiqjhIs
         OWCg==
X-Gm-Message-State: APjAAAXaLUXVyBElW4RLg+tTCN9YyhoNoE5uuCnx5ol7m02VvE7p4kkc
        0nVRgPRaxkJguFVn6jIa6Jg=
X-Google-Smtp-Source: APXvYqzDj/Q/sNBvdjs+fIyINcfoBTt6Aby1wfLyTGnlgZfFHhDa0HRT97+rsnLll7pN6lDNn26++Q==
X-Received: by 2002:a19:6509:: with SMTP id z9mr18447794lfb.97.1582265326236;
        Thu, 20 Feb 2020 22:08:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a10sm970539lfr.94.2020.02.20.22.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 22:08:45 -0800 (PST)
Subject: Re: [PATCH v3 07/10] ASoC: tegra: add Tegra210 based ADMAIF driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-8-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e6114203-57d1-bc74-f786-c2246ccb4341@gmail.com>
Date:   Fri, 21 Feb 2020 09:08:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-8-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2020 09:34, Sameer Pujar пишет:
> ADMAIF is the interface between ADMA and AHUB. Each ADMA channel that
> sends/receives data to/from AHUB must intreface through an ADMAIF channel.
> ADMA channel sending data to AHUB pairs with an ADMAIF Tx channel and
> similarly ADMA channel receiving data from AHUB pairs with an ADMAIF Rx
> channel. Buffer size is configuranle for each ADMAIF channel, but currently
> SW uses default values.
> 
> This patch registers ADMAIF driver with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes ADMAIF interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The ADMAIF device can be enabled in the DT via
> "nvidia,tegra210-admaif" compatible binding.
> 
> Tegra PCM driver is updated to expose required PCM interfaces and
> snd_pcm_ops callbacks.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
...
> +int tegra_pcm_construct(struct snd_soc_component *component,
> +			struct snd_soc_pcm_runtime *rtd);
> +void tegra_pcm_destruct(struct snd_soc_component *component,
> +			struct snd_pcm *pcm);
> +int tegra_pcm_open(struct snd_soc_component *component,
> +		   struct snd_pcm_substream *substream);
> +int tegra_pcm_close(struct snd_soc_component *component,
> +		    struct snd_pcm_substream *substream);
> +int tegra_pcm_hw_params(struct snd_soc_component *component,
> +			struct snd_pcm_substream *substream,
> +			struct snd_pcm_hw_params *params);
> +int tegra_pcm_hw_free(struct snd_soc_component *component,
> +		      struct snd_pcm_substream *substream);
> +int tegra_pcm_mmap(struct snd_soc_component *component,
> +		   struct snd_pcm_substream *substream,
> +		   struct vm_area_struct *vma);

> +int tegra_pcm_trigger(struct snd_soc_component *component,
> +		      struct snd_pcm_substream *substream, int cmd);

Looks like this function doesn't exist.
