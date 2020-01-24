Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D66C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C34206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQvil3S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgAXBSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:18:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32938 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbgAXBSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:18:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so130320lfl.0;
        Thu, 23 Jan 2020 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qa1ZeKIxwMxhhVXWx6jah5pzEB39RZ2UXKKeVBvARPU=;
        b=gQvil3S7iFbcn3Zs8yz7OmBRM/dDoATirdGEZo2VCbmL8OTLPt7/ozLpiNQZdpg+WT
         7fNM9+G1SywrHuqMmvNR4XL1FL0+A0/Qt0t1CPFRe8FBJHZu42bClhUubNNvVZgtH2GP
         kM3eg7TYMuQyPL4o0asf3vO55XaTS0yJb6XO5spInitlXvOGtydV1rc6ebnTH6BprioC
         8H98izxEKeAdjG8oPxARdM8rk88hJ+J36UE3ZH99G3M+CtF7v9zW7a9YGacuHPRgUwfE
         uR7owsNEdBpOk91HfdXy5LmGWQdnFO+QnYALvsQz0P6QbRKCJwkmZSvX80FkdPwGGSzb
         6ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qa1ZeKIxwMxhhVXWx6jah5pzEB39RZ2UXKKeVBvARPU=;
        b=huX1pbGXt+9aXBqosDL88+S8IXue165QQsJRGDgcOPzcpKpQoLxj7/z4xqoA0ridPr
         c9pcRZ4BAmiNUIdDJ0vHnCrxhH6r8t1FCt4ZkY4Oc1iu3wIEoBFxSvmPsZJI1nZFsAd/
         +00L+0+j8AkXXAaOwD1c/m0SZOen/Q3o8oZ6ZnrJtYn5tJqschTLUBYYv3hLuJFub6ZB
         yC6oOQc9XQphQBBQrsMd95/gzfTztDV2il5aZoG4lHm32W3pwtCZncvgkYXL7gqty5XF
         z/19RwsUQRhoC9pHZGeevuJhiFHgWzywxxFBPjMoRtdLsd/KDUp9pt6nXD+cJVtZWEvx
         x12A==
X-Gm-Message-State: APjAAAXziToYs4m1gwq1P6dblGNAVyIQFAF9kN9YsNqhr6RYkp5/qD++
        tKHW/6LZEIsB0q9iY3kJ2gQ=
X-Google-Smtp-Source: APXvYqxECFw30QnabkPguwcGpQ2JKwDUyv9e9T2Ryy+nL3W+5b0VqO7G9uYOHFCPG8/lASm/uehVZw==
X-Received: by 2002:a19:4ad0:: with SMTP id x199mr241966lfa.13.1579828719604;
        Thu, 23 Jan 2020 17:18:39 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id k24sm2503908ljj.27.2020.01.23.17.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 17:18:38 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: tegra: add Tegra210 based AHUB
 driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-6-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5ed7482e-e874-9e11-c84e-7418e4b5162e@gmail.com>
Date:   Fri, 24 Jan 2020 04:18:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1579530198-13431-6-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.01.2020 17:23, Sameer Pujar пишет:
[snip]
> +static int tegra_ahub_get_value_enum(struct snd_kcontrol *kctl,
> +				     struct snd_ctl_elem_value *uctl)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_kcontrol_component(kctl);
> +	struct tegra_ahub *ahub = snd_soc_component_get_drvdata(cmpnt);
> +	struct soc_enum *e = (struct soc_enum *)kctl->private_value;
> +	unsigned int reg, i, bit_pos = 0;
> +
> +	/*
> +	 * Find the bit position of current MUX input.
> +	 * If nothing is set, position would be 0 and it corresponds to 'None'.
> +	 */
> +	for (i = 0; i < ahub->soc_data->reg_count; i++) {
> +		unsigned int reg_val;
> +
> +		reg = e->reg + (TEGRA210_XBAR_PART1_RX * i);
> +		snd_soc_component_read(cmpnt, reg, &reg_val);
> +		reg_val &= ahub->soc_data->mask[i];
> +
> +		if (reg_val) {
> +			bit_pos = ffs(reg_val) +
> +				  (8 * cmpnt->val_bytes * i);

Multiplication takes precedence, braces are not needed. Same for all
other occurrences in the code.

[snip]
> +			break;
> +		}
> +	}
> +
> +	/* Find index related to the item in array *_ahub_mux_texts[] */
> +	for (i = 0; i < e->items; i++) {
> +		if (bit_pos == e->values[i]) {
> +			uctl->value.enumerated.item[0] = i;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_ahub_put_value_enum(struct snd_kcontrol *kctl,
> +				     struct snd_ctl_elem_value *uctl)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_kcontrol_component(kctl);
> +	struct tegra_ahub *ahub = snd_soc_component_get_drvdata(cmpnt);
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctl);
> +	struct soc_enum *e = (struct soc_enum *)kctl->private_value;
> +	struct snd_soc_dapm_update update[TEGRA_XBAR_UPDATE_MAX_REG] = { };

Shouldn't this be {0} to make array zero'ed?

[snip]
> +static int tegra_ahub_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct tegra_ahub *ahub;
> +	struct tegra_ahub_soc_data *soc_data;
> +	void __iomem *regs;
> +	struct resource *res;
> +	int ret;
> +
> +	match = of_match_device(tegra_ahub_of_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "error: no device match found\n");
> +		return -ENODEV;
> +	}
> +
> +	soc_data = (struct tegra_ahub_soc_data *)match->data;

soc_data = device_get_match_data(&pdev->dev);

> +	ahub = devm_kcalloc(&pdev->dev, 1, sizeof(*ahub), GFP_KERNEL);
> +	if (!ahub)
> +		return -ENOMEM;
> +
> +	ahub->soc_data = soc_data;
> +
> +	platform_set_drvdata(pdev, ahub);
> +
> +	ahub->clk = devm_clk_get(&pdev->dev, "ahub");
> +	if (IS_ERR(ahub->clk)) {
> +		dev_err(&pdev->dev, "can't retrieve AHUB clock\n");
> +		return PTR_ERR(ahub->clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);

regs = devm_platform_ioremap_resource(pdev, 0);
