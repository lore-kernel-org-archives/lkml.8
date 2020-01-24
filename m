Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F76C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44953207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWhyOeQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgAXB2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:28:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45879 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAXB2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:28:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so526308ljc.12;
        Thu, 23 Jan 2020 17:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WI+Ptr4jWGvf9sG0CsP+d/rPdqVcRiXjBDng4X6qfAo=;
        b=IWhyOeQUSmo3xu9H4u2oZLkCl+B28KSQ//kzmtueEdrjJiCkgUjc7xObfFUYgg/3Jt
         WN6L5BVjS+aylpgwq+HKPF6cSQGg2SpcNPPqkpyNtIijZZWdxhJceRTrR0bGrlLxcPDk
         ZQcuU4cVj9OwzCr0XvpZUQSIasa3gbZUYiBewpoDd+cDqe6z0Dl8/isN64cRDYqFaZX2
         1I50PCGlrYq8sBgAMOJKGS+QhZPiC4lyjXWNtp+pw3giQ027CEr6U1bMUTkndSUP7cuK
         bE4SsWAHFJ90iDLnniZGCZ3IfhKuWbiQQIwshPTNGUrrTjYFhFk7kSkAZm7ErxlcB6Mv
         Hlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WI+Ptr4jWGvf9sG0CsP+d/rPdqVcRiXjBDng4X6qfAo=;
        b=JmGaLPmBw0NTs9Qi4ZpLV8BNQSbayEM4XauM3Dm6L75IyExcbByPkSemAmFwLC7rao
         IuCbekaI616cxTWaRtLMi9w6bB2FRlgCo6Y5zGNHd8iK3oq5P0axUAfWqWuu4myCsD/h
         A0WpmupPylFJO04lCyJnmZHE46oXv2g5Q4LthtI4IXAMCLJXhX/hZh/nSX8Q0Yeyg5Sb
         5GJjd7z058I+eg1N+3Q+p8oou+zLhr8CjuGqVyC264Vm8K7d4QR0aip43rce9n9nuRTV
         bZfyDp6ioNTPhya7G0BtV2p5juq88zXxkTdBo/x4OCGMbSNjqN52LdivMIW5srUbG68E
         XD6g==
X-Gm-Message-State: APjAAAXuLtpRr1IdTLC2sMq6Q7Alld/NSICuTKz4zyBd4iJ5OantKuGN
        WkC0e2sm4XZanUuXItpx7J4=
X-Google-Smtp-Source: APXvYqwGOnXwDuyIxTBQaJTSzHJLm33JXg0GYndn6ydyGv3O+5zNh+qRhrfYF9Q5iyLM8WQFQtOLfQ==
X-Received: by 2002:a2e:9592:: with SMTP id w18mr711637ljh.98.1579829309536;
        Thu, 23 Jan 2020 17:28:29 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l28sm1886927lfk.21.2020.01.23.17.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 17:28:28 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <743d6d7d-f29c-191a-853b-414250ca38df@gmail.com>
Date:   Fri, 24 Jan 2020 04:28:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1579530198-13431-8-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.01.2020 17:23, Sameer Pujar пишет:
[snip]
> +static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)
> +{
> +	struct tegra_admaif *admaif = dev_get_drvdata(dev);
> +	unsigned int ch_stride = TEGRA_ADMAIF_CHANNEL_REG_STRIDE;
> +	unsigned int num_ch = admaif->soc_data->num_ch;
> +	unsigned int rx_base = admaif->soc_data->rx_base;
> +	unsigned int tx_base = admaif->soc_data->tx_base;
> +	unsigned int global_base = admaif->soc_data->global_base;
> +	unsigned int reg_max = admaif->soc_data->regmap_conf->max_register;
> +	unsigned int rx_max = rx_base + (num_ch * ch_stride);
> +	unsigned int tx_max = tx_base + (num_ch * ch_stride);
> +
> +	if ((reg >= rx_base) && (reg < rx_max)) {

The braces are not needed around the comparisons because they precede
the AND. Same for all other similar occurrences in the code.
