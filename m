Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941242087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJEFGVhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgIDLH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:07:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33785C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:07:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so5686039wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YAvy/uLp7+cWVzWcV7xfgGlutHlCEWW9xHSoG33J/ZM=;
        b=hJEFGVhkBiKv0X9JtFq+P0TptyE7m8g1Hv8atN9oETRU18f720U2R9pjRGxc5WE6ru
         MNpnlEYeH/pHp8cQ+akgH7rNybAHXwbEE76XXgOVzriCuj7sPzPlpti/J8l3vVQRevS7
         RfOcFLZwsntcuwTRyQBOUkFdiT4bWpJRnvp2DC7DgoH5dlmXOynRNqMa6jslNPT8KVGf
         nVTsCyg+8M3HcXYFG6OZnj7KyAQzUjDCe3QMDnSFPRNEOfhaYdA1sn+CTb0P7/qePNCP
         fZTULBhyBnts/A40ISXfeNiv7ykKaZXJVjdM5V1DBIgkr05EKWAWo0wuF8hPowIm5weK
         kPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YAvy/uLp7+cWVzWcV7xfgGlutHlCEWW9xHSoG33J/ZM=;
        b=hj3VzqJeXtLR9EFzian6G30XPwhYN0VayZs9hTn4vT51bJP6ja9/21qXmtLMUrpN4S
         BNSP0KzivYLAKwGiXlTwQaQtVSQ+t7yhOeE7Yi6ocy0tKkh15jd4+WSmqALuzlcBd+7H
         /6gm+PZmdX/DpTHHxV4kWWF9325LddNN/E23iAwCXbl6LVSrP3LYnGCusG9offVjeSKu
         5nhbaZsvYumqKXaySiVs2A//7bBxuLloBnbYRogn03jt6JY7030Hjas1MzNF8nbaJl14
         +NmHWICLyA4jBm8ezYz8NailfeYrMFyD1mYfuzisorC85UktJMFawhEapSJYsNj0VWh5
         JRUQ==
X-Gm-Message-State: AOAM531XFuOZ/cbssK/IMVy871uQSU69QZtjRpGUg+oM8495wTHTRFrr
        N6gLnrW7hCeLlCIW/SfLsb3lkg==
X-Google-Smtp-Source: ABdhPJyJMFbpGk2JfuZru3rTIMQyff/CzsQ264cZGW7mm28Ks3LDPLGUswtRAjDnUTNZ6YAtlD43aQ==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr7028460wmc.35.1599217667800;
        Fri, 04 Sep 2020 04:07:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q186sm11566637wma.45.2020.09.04.04.07.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:07:47 -0700 (PDT)
Subject: Re: [PATCH v3] nvmem: mtk-efuse: Remove EFUSE register write support
To:     Chih-En Hsu <chih-en.hsu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Andrew-CT.Chen@mediatek.com,
        Michael.Mei@mediatek.com
References: <20200826083943.810-1-chih-en.hsu@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <21d857b5-9b6a-7e77-a725-18a1adf3e92a@linaro.org>
Date:   Fri, 4 Sep 2020 12:07:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200826083943.810-1-chih-en.hsu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2020 09:39, Chih-En Hsu wrote:
> This patch is to remove function "mtk_reg_write" since
> Mediatek EFUSE hardware only supports read functionality
> for NVMEM consumers.
> 
> Fixes: ba360fd040e3 ("nvmem: mtk-efuse: remove nvmem regmap dependency")
> Signed-off-by: Chih-En Hsu <chih-en.hsu@mediatek.com>
> ---
>   drivers/nvmem/mtk-efuse.c | 14 --------------
>   1 file changed, 14 deletions(-)


Applied thanks!

--srini

> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 856d9c3fc38e..6a537d959f14 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -28,19 +28,6 @@ static int mtk_reg_read(void *context,
>   	return 0;
>   }
>   
> -static int mtk_reg_write(void *context,
> -			 unsigned int reg, void *_val, size_t bytes)
> -{
> -	struct mtk_efuse_priv *priv = context;
> -	u32 *val = _val;
> -	int i = 0, words = bytes / 4;
> -
> -	while (words--)
> -		writel(*val++, priv->base + reg + (i++ * 4));
> -
> -	return 0;
> -}
> -
>   static int mtk_efuse_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -61,7 +48,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	econfig.stride = 4;
>   	econfig.word_size = 4;
>   	econfig.reg_read = mtk_reg_read;
> -	econfig.reg_write = mtk_reg_write;
>   	econfig.size = resource_size(res);
>   	econfig.priv = priv;
>   	econfig.dev = dev;
> 
