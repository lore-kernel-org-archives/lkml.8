Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF9522B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1f2itQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH0IPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0IPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:15:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA9C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:15:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so4088640wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CRrN+bnESVw3xySjOS/D2tb7BK/BCO+kOmldSTBWoSw=;
        b=r1f2itQK1htdCqLiCgehW3FWfm1h4HuAWXjYf8QoF8itADn/zs0+iM7JnI+bUKhjDJ
         9q8o8tM/h9KIjAJkmPiIY1u5I0e69YY+7WLAVZ1dgv8rA19u7Tuejto8giSdCdATv9eR
         JNVx8tO2iR+tY5RTIyFUv3gV2EOBhgVxJADAAPZ3Fi4YAOqSAH+tGalZkeXB/ZFUG9kg
         YWIXLhpzgMWL3ZAx8la+eNzkPRwKgJ+NsD+k915EacOLtW/fpaUrFdKk0w71ynmWZt0R
         lsi84YQMYM+vOrGJFjE9IAj2tEwp5yODvRG8OJpFCr48Jz4HZ+vfM4MzR07CqATUcVok
         c4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CRrN+bnESVw3xySjOS/D2tb7BK/BCO+kOmldSTBWoSw=;
        b=msTCA849S7yusw19H7qZRmXgLEA4eVC0r1VpFohmoaRvEOvbeExhuKEgHZ6pZjBVoX
         xYrk9S0xB5bM5PSalx08BBknpOzUtRrm+kYYGpocDQs5CT1l1JL6DTMFeQO4FPumT+WC
         +Fw/cpUsW6TQpM+lHVCDFK6rwPKBoCGUkgHdZOSgif674MmwNKDM0GnNm7TEws4p/AE7
         aCGInyIZfLrAkG8nmfV1fxQdP6iayrKqINn6ALISkgRsduUFT8qNpFjXTtXFDCNG7g6T
         RuRbNvPDHelXe+ILssyyuB+OI42La0PdAdUDJzgqI9vcTqLp16yg18arpVz2jsRN6TZy
         M0qQ==
X-Gm-Message-State: AOAM530jC4f8JXi+prtJLrWZh5cofheYSBapt1HhtAq/EqvENjp3/6JU
        YIB/7IC9WEXzF/VelAS8hIQ=
X-Google-Smtp-Source: ABdhPJxAzbZ/JUyfG5E0ziVgDM2CoiNZGp8g0x4g8d4WyFCF1tmqYS4Y/5PBF0el+XD/ICqZ0ubpXA==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr10335779wma.126.1598516148283;
        Thu, 27 Aug 2020 01:15:48 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
        by smtp.gmail.com with ESMTPSA id c8sm4252871wrm.62.2020.08.27.01.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:15:47 -0700 (PDT)
Subject: Re: Aw: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
To:     Frank Wunderlich <frank-w@public-files.de>,
        Frank Wunderlich <linux@fw-web.de>,
        chunkuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
 <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com>
Date:   Thu, 27 Aug 2020 10:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/2020 09:17, Frank Wunderlich wrote:
>> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
>> index 5223498502c4..edadb7a700f1 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
>> @@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>>   		return PTR_ERR(phy_provider);
>>   	}
>>
>> +	if (hdmi_phy->conf->pll_default_off)
>> +		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
>> +
>>   	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>>   				   hdmi_phy->pll);
>>   }
> 
> tried modifying mtk_hdmi_phy_power_on using the new flag to not enable tmds instead of enabling and later disabling it, but this does not work...
> 
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -62,7 +62,8 @@ static int mtk_hdmi_phy_power_on(struct phy *phy)
>          if (ret < 0)
>                  return ret;
> 
> -       hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
> +       if (!hdmi_phy->conf->pll_default_off)
> +               hdmi_phy->conf->hdmi_phy_enable_tmds(hdmi_phy);
>          return 0;
>   }
> 
> @@ -184,8 +185,8 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>                  return PTR_ERR(phy_provider);
>          }
> 
> -       if (hdmi_phy->conf->pll_default_off)
> -               hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
> +       //if (hdmi_phy->conf->pll_default_off)
> +       //      hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
> 
>          return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>                                     hdmi_phy->pll);
> 
> 
> same problem as without this Patch (horizontally distorted image flickering on 1280x1024)
> 
> any idea CK Hu?
> 

I'll leave it to CK to decide how to go forward with this. Would be interesting 
to understand why we need to disable the phy. Someone would need to verify that 
this holds for mt2701 as well, and not only for mt7623, otherwise we would break 
mt2701.

Regards,
Matthias
