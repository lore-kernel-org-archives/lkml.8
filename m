Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF45C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50C02067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOT8FZXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHSRMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHSRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:12:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC2EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:12:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p20so22278153wrf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P/BxB6Tk9AqvsGBqiTBEZmxawpSGqW2VpShvG8egiLE=;
        b=aOT8FZXVbYAg7wGPDj6bcP9F+iWPGFAHwmYImaZXz4dUZFvLGzdMD5+6ayifi72/FH
         21dd5Set+gYeTPzss4RyBymKDuogTsC0beZM4OvOL+ezO23pv46w1CIc/RsIQ6PMUPoL
         k1P3ymaMirYfMEx6WQ6qQv6OKryMX2mOn99eiEABq5HfSSCwULPH0sV5/UOEvfxjCdcI
         hsf5z7wcQ7vzqqZNsEj1ft73UrkozG8GecNNKYKCNl8IJU525hQnfL14HmWvmCdnCaYw
         PZqzYQ6UK5hq3eiWw6FU2yVpuc54RspJhyBq/IXuIJjyuWIy89lFl10O02gOtcOZMCd3
         +7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/BxB6Tk9AqvsGBqiTBEZmxawpSGqW2VpShvG8egiLE=;
        b=UrqObzUAcnqddoFu1qahhUS7GPOabxePOeJ9+YmN7wRxfs08mLF/4LEjD3U0j8L4mS
         QydlKQeDc4PPmGLQ+30thqT+m0BfHAtf9t3fgwNEMI6ru988VduHmCBF8Ujq0H1xYCoJ
         4oKpRJlI80hoAPIE4efo4VpBkdV50UbDWqm6srQ8Keq8D5ppn53PL99OZyuazgitIxLy
         oMRALHu7Qc6FdbKpzBAWhul8+yANU59Gt6D3VGSBYZXqKXrO+/r3mqHbP7psKdlIwpad
         oOclac+zx/OiKexVi10rSQ4/W2FiKoPIPDmxuZRtVd0Zj280t7jEWdbvqwpKirFB3iyN
         y4gg==
X-Gm-Message-State: AOAM530DkO3woaHFq9MzPpv316YPrGjYkOB5z1DtbshNRg68DYTmC+wx
        3GhpldHvpRicFuY2NQ/h5wBwSP11HFQXIg==
X-Google-Smtp-Source: ABdhPJxbMdMiABMczUJpbzVpjiKzWMQlXai3V6kLN1aQ5/US5xWa8crZteCDS1MmrXTkNtT+nkvzHQ==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr4884761wre.369.1597857151947;
        Wed, 19 Aug 2020 10:12:31 -0700 (PDT)
Received: from ziggy.stardust ([93.176.180.54])
        by smtp.gmail.com with ESMTPSA id s2sm20811016wrr.55.2020.08.19.10.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 10:12:31 -0700 (PDT)
Subject: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        chunhui dai <chunhui.dai@mediatek.com>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f68cf4c2-6c79-fe46-b7b4-bcc49e0b6b69@gmail.com>
Date:   Wed, 19 Aug 2020 19:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819081752.4805-4-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/2020 10:17, Frank Wunderlich wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> disable tmds on phy on mt2701 to support other resolutions like 1280x1024
> 

Isn't that worth a Fixes tag?

Regards,
Matthias

> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 3 +++
>   drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        | 1 +
>   drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 1 +
>   3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index 5223498502c4..edadb7a700f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -184,6 +184,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>   		return PTR_ERR(phy_provider);
>   	}
>   
> +	if (hdmi_phy->conf->pll_default_off)
> +		hdmi_phy->conf->hdmi_phy_disable_tmds(hdmi_phy);
> +
>   	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
>   				   hdmi_phy->pll);
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index 2d8b3182470d..f472fdeb63dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -22,6 +22,7 @@ struct mtk_hdmi_phy;
>   struct mtk_hdmi_phy_conf {
>   	bool tz_disabled;
>   	unsigned long flags;
> +	bool pll_default_off;
>   	const struct clk_ops *hdmi_phy_clk_ops;
>   	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>   	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index d3cc4022e988..6fbedacfc1e8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -239,6 +239,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
>   struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
>   	.tz_disabled = true,
>   	.flags = CLK_SET_RATE_GATE,
> +	.pll_default_off = true,
>   	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
>   	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
>   	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> 
