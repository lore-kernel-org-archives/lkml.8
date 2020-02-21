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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4093BC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6424650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQp3/1si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBUFxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:53:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:53:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so940168ljg.3;
        Thu, 20 Feb 2020 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h4Lfa2XNuMENwuIsE1cnUCd9hGIA1qUK6OViaKh1/rk=;
        b=TQp3/1siBdgQBsWsC+eKZkO4ai9vac/fr4V2MEITo1lDdTfiK0bbz5Rku0njBz/vCQ
         Gpu7t5AxgazkNTmu9QaD5moD+YD8AeN1fWFJ6p65b7M2lpsTwPE/mCh7kMFBmin+AuRV
         juI8rVy9Ky/ZoqclpPSz7HRB9LTnlNXYq3eBuh9a7Mb5miBzr2yPN552jm9FkvS1Ei04
         nW4DdSDZyDTpF8C7VgY5zmkCsuFle/9nC28v0eJJ6iVMKbHyJWFNDUyrv7/qowaZOQhH
         oKUgperRPGVTTr4mZIPOdwtXLlG1qAhOE6Fc1EXJmdPH5Fa38akydo96BYO5QVS36NgV
         bwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h4Lfa2XNuMENwuIsE1cnUCd9hGIA1qUK6OViaKh1/rk=;
        b=EtREiTtgy9WrRiocQZuWGv0KQTtt00p9vUi+VrlY/iHIRY2f5SdPPkJWRSRVndc3xG
         0XHNpg/2Ty4Zd/oTU/Rm0d/bys8BspIPjzDHB7x1wtu7SRj6ZecLJinXR2usLl5p5vQg
         9+DShJIuK/oxe2nAeCQh4lKlV2WQY+OvIy06b5eOjPRCtRJcTmpx4siCfsBB/PH1wYGw
         JpTIF97Tm3Kx8IMOI4r3hI9r5ufzrbcdzF+fcFAbKoZj09901sXhbzLNNiVaAMI7QfGb
         MK8w5mjsH4oI614CehXbqJt/wi6ZBwH//BA3qI2iNhqh9D1q/rD/JRxz55jsVW8poQdK
         +rFA==
X-Gm-Message-State: APjAAAWZnxAfB3anohv8DnMeiYuhGkcVjbnmtmqQV3geAiy9GSXS9FEn
        1sciU5E/otvozYPJn5pgm4U=
X-Google-Smtp-Source: APXvYqzplawmCJ3CkTVkfhHWssF7iwzAh48VuAEmFC/xNi5vJyGYpTFM7GDx7Zl3kqbXCP1zCxe/tw==
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr20449132lju.117.1582264425497;
        Thu, 20 Feb 2020 21:53:45 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u7sm976142lfn.31.2020.02.20.21.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 21:53:44 -0800 (PST)
Subject: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d618182c-14a8-9143-376c-568dd7cf3bb3@gmail.com>
Date:   Fri, 21 Feb 2020 08:53:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-4-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2020 09:34, Sameer Pujar пишет:
> The Digital MIC (DMIC) Controller is used to interface with Pulse Density
> Modulation (PDM) input devices. The DMIC controller implements a converter
> to convert PDM signals to Pulse Code Modulation (PCM) signals. From signal
> flow perspective, the DMIC can be viewed as a PDM receiver.
> 
> This patch registers DMIC component with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes DMIC interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The DMIC devices can be enabled in the DT via
> "nvidia,tegra210-dmic" compatible string. This driver can be used for
> Tegra186 and Tegra194 chips as well.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---

...

> +static const struct of_device_id tegra210_dmic_of_match[] = {
> +	{ .compatible = "nvidia,tegra210-dmic" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, tegra210_dmic_of_match);

I'd move the tegra210_dmic_of_match close to tegra210_dmic_driver's
definition, like most of the other drivers do it.

...

> +static struct platform_driver tegra210_dmic_driver = {
> +	.driver = {
> +		.name = "tegra210-dmic",
> +		.of_match_table = tegra210_dmic_of_match,
> +		.pm = &tegra210_dmic_pm_ops,
> +	},
> +	.probe = tegra210_dmic_probe,
> +	.remove = tegra210_dmic_remove,
> +};
> +module_platform_driver(tegra210_dmic_driver)

Otherwise:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
