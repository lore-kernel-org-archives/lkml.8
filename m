Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9899DC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F6024125
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqgm/L6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgAXEZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:25:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40241 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbgAXEZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:25:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so289119lfi.7;
        Thu, 23 Jan 2020 20:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqvrrfgH50F3heDUQV2TPxvyGIm9jjs0IGrVe+RwimE=;
        b=Yqgm/L6R0clKVYrscixlwYJrmLydO6eTZXRSwbpSsJkZRcKp28C3d7HqPnhXE8vqbH
         9VdqiMw/4NEz4lxzg9g1A42L97lUsDUtkTs++ZjGiv/9mjFmGPsmezm7L5YrcZ7J7zNi
         SNZQwMmcFdpRp9XNelnkzmBRgDQU3K10FIKouhjNx01IweB+AvH7YZGLomp67wp5V5KR
         V1o9EcoAUzA28Q+wzAt43MypyA3faknk8Lp9HDE0raVbiy/DqAzutS+E/Cdm5LhWucoB
         5AZ2SuyKr+7/6x+uDIg6v3vszDyYk8tq1/kw86qyWf/5VrEDXmifItnWblE2nraMF4ii
         pkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqvrrfgH50F3heDUQV2TPxvyGIm9jjs0IGrVe+RwimE=;
        b=pWp2svEHcSJ7jtDuslQCy9tbBz5Md+XLabCWhL3rIC4EF4CiCxOpPR2jlomPZ+g01+
         S3ppLxEAbw+MLAUXoneqeb0U8TTtE/esJjodav6OO8Zx/bVk2CqJ4/QbIBvEfqUvDam8
         lJ+/VWs2AwDMOJVd8vK61yCNEyGiebf4uaiha8RhxPZt61XIaq+nLC8nIPHq3h/liomW
         DPJ5TpMJES3GrN60vzv1g85gA8MN2gxJBmLJ28zm5B15gh6ICkesbEp9lXapRGLNCIjN
         aeZVuq1xrXJ1q1/X1LVhOfVAr9OuSROZgiwb4Nl+Hw6/cau/RWsN8x/sLIPwNXw8DRHh
         7SHA==
X-Gm-Message-State: APjAAAWjCFnDP85/eT2q9/SF9HB1tdqlb3tzIlK4rgihvxQ0i8mmpoGu
        MG3Iwv3xskW60NIzioHD4nFAoMwN
X-Google-Smtp-Source: APXvYqz9HRXIowhnShk3uHeDO/07QPAIONMd8ODEb7ccArNqgO+S9/aB3Jd/HegdKDhotT/9ZK1LTw==
X-Received: by 2002:ac2:523c:: with SMTP id i28mr487778lfl.104.1579839912004;
        Thu, 23 Jan 2020 20:25:12 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f30sm2282977ljp.31.2020.01.23.20.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:25:11 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 7/9] ASoC: tegra: add Tegra210 based ADMAIF
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
 <1579530198-13431-8-git-send-email-spujar@nvidia.com>
 <743d6d7d-f29c-191a-853b-414250ca38df@gmail.com>
 <3759aa0b-9e56-0fb4-27b7-4f98898d4e22@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8a3259b7-6875-236a-b16c-cd8e023cc8b2@gmail.com>
Date:   Fri, 24 Jan 2020 07:25:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3759aa0b-9e56-0fb4-27b7-4f98898d4e22@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.01.2020 06:27, Sameer Pujar пишет:
> 
> 
> On 1/24/2020 6:58 AM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 20.01.2020 17:23, Sameer Pujar пишет:
>> [snip]
>>> +static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)
>>> +{
>>> +     struct tegra_admaif *admaif = dev_get_drvdata(dev);
>>> +     unsigned int ch_stride = TEGRA_ADMAIF_CHANNEL_REG_STRIDE;
>>> +     unsigned int num_ch = admaif->soc_data->num_ch;
>>> +     unsigned int rx_base = admaif->soc_data->rx_base;
>>> +     unsigned int tx_base = admaif->soc_data->tx_base;
>>> +     unsigned int global_base = admaif->soc_data->global_base;
>>> +     unsigned int reg_max =
>>> admaif->soc_data->regmap_conf->max_register;
>>> +     unsigned int rx_max = rx_base + (num_ch * ch_stride);
>>> +     unsigned int tx_max = tx_base + (num_ch * ch_stride);
>>> +
>>> +     if ((reg >= rx_base) && (reg < rx_max)) {
>> The braces are not needed around the comparisons because they precede
>> the AND. Same for all other similar occurrences in the code.
> 
> While that is true, some prefer to use explicit braces to make it more
> readable.
> In the past I was told to use explicitly in such cases.

At least most of code in kernel (I've seen) doesn't have superfluous
parens (the curvy thingies actually should be the braces). Readability
is arguable in this case, I'm finding such code a bit more difficult to
read, although in some cases parens and spacing may help to read more
complex constructions.
