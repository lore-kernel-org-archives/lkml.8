Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71EBC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0416214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tucuECGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGNgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:36:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44605 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBGNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:36:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so2683038wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvaYHykaUdRelzapg39ecdG9VP1FN9Q9ntd1Gm4hUXs=;
        b=tucuECGIaSCoOYAKUzlbcrdQsOi4kg1p9sbj/cyPF/FfYyKS+szp0IF6VjfSdZJKz2
         C3R8u7MC6mL3SKxSau2TtMMZZkouKzvMMqmpzWpMuHE9nFoUE9ECVg1E0ytNFbBWCuRc
         sRbdaVxC/NoHy2HmtOIfT5lLbQ9+H1ejTrJpULNAeFpSZcAevwbpM/UiKOKriiP8bi3h
         BQIBTDGKzj3wLuW+8PnLZPZQDuDBZTu2IndhEysrk6Jt6ufjjTik5JqhihyNIT/t59sE
         D2La1KFTW7dHAo+etjFKgCJrI+S6p5NT9OmWjjYRxGkmjavzfIQNwlmLr+s1fT6u+GD3
         gk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RvaYHykaUdRelzapg39ecdG9VP1FN9Q9ntd1Gm4hUXs=;
        b=oxMarUbkrJRDjr5h89xO3SieFqTf5Jjeg4vt6VF2r8vR9dlcnxZmTcXZEZFSiANiVK
         KweIEfR0DmOSSQT4tIEumTrIPBLw5xCtOpECan3LfpyJZEWJLxpq4aQzptxOaCCurOf2
         G7IDnrPHeUI2Xjmqka3dC1WwyMao4HZfb1OcbFvcAPbsCjKmWHn/lsGapz0aqhgVMZTv
         NA8dGtW8YFopPDDObb+C9iz9wSKKnQilQ+XJCgPZD3NbIrGAzknYtIStVx4Pik1+Xxmo
         b0C/HbdMg255UftJm6IIOXaTY8ZqpDSt1thvwoEFebnipVegUY015vSYT2BPCf25XKpv
         2PjQ==
X-Gm-Message-State: APjAAAVxHRzFnPrJysVxgBZ+P+/Eqbzo9ENFYPnZ+kipv6U8GXFoW8Ke
        /8zQMkhRGEOWwvvK9zrmhWG/NURkKKRKUQ==
X-Google-Smtp-Source: APXvYqzpbJt2+w2r2qI2IRvNdujQt1Vuq2BrVJF0v83Xed/WAirz5k06CqigYXMt7GYYMjAOBk+mdg==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr4596184wrs.270.1581082600515;
        Fri, 07 Feb 2020 05:36:40 -0800 (PST)
Received: from [10.1.3.173] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x21sm3302717wmi.30.2020.02.07.05.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 05:36:40 -0800 (PST)
Subject: Re: [PATCH v4 04/11] drm/bridge: synopsys: dw-hdmi: add bus format
 negociation
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-5-narmstrong@baylibre.com>
 <20200207120225.2ea76016@collabora.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <ed11f2a3-2cc3-9d06-fcd8-886362a5ee36@baylibre.com>
Date:   Fri, 7 Feb 2020 14:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200207120225.2ea76016@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 12:02, Boris Brezillon wrote:
> On Thu,  6 Feb 2020 20:18:27 +0100
> Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
>> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negociate
> 
> 								^ hooks?
> 
>> the possible output and input formats for the current mode and monitor,
>> and use the negotiated formats in a basic atomic_check callback.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
> 
>> +
>> +/* Can return a maximum of 4 possible input formats for an output format */
>> +#define MAX_INPUT_SEL_FORMATS	4
> 
> It seems to only be 3 in practice (based on the code) unless I missed
> something.

You're right...

> 
>> +
>> +static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>> +					struct drm_bridge_state *bridge_state,
>> +					struct drm_crtc_state *crtc_state,
>> +					struct drm_connector_state *conn_state,
>> +					u32 output_fmt,
>> +					unsigned int *num_input_fmts)
>> +{
>> +	u32 *input_fmts;
>> +	int i = 0;
>> +
>> +	*num_input_fmts = 0;
>> +
>> +	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
>> +			     GFP_KERNEL);
>> +	if (!input_fmts)
>> +		return NULL;
>> +
>> +	switch (output_fmt) {
>> +	/* 8bit */
>> +	case MEDIA_BUS_FMT_RGB888_1X24:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>> +		break;
>> +	case MEDIA_BUS_FMT_YUV8_1X24:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>> +		break;
>> +	case MEDIA_BUS_FMT_UYVY8_1X16:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>> +		break;
>> +
>> +	/* 10bit */
>> +	case MEDIA_BUS_FMT_RGB101010_1X30:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
>> +		break;
>> +	case MEDIA_BUS_FMT_YUV10_1X30:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>> +		break;
>> +	case MEDIA_BUS_FMT_UYVY10_1X20:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>> +		break;
>> +
>> +	/* 12bit */
>> +	case MEDIA_BUS_FMT_RGB121212_1X36:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
>> +		break;
>> +	case MEDIA_BUS_FMT_YUV12_1X36:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>> +		break;
>> +	case MEDIA_BUS_FMT_UYVY12_1X24:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>> +		break;
>> +
>> +	/* 16bit */
>> +	case MEDIA_BUS_FMT_RGB161616_1X48:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
>> +		break;
>> +	case MEDIA_BUS_FMT_YUV16_1X48:
>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
>> +		break;
>> +
>> +	/* 420 */
>> +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
>> +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
>> +	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
>> +	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
>> +		input_fmts[i++] = output_fmt;
>> +		break;
>> +	}
>> +
>> +	*num_input_fmts = i;
>> +
>> +	if (*num_input_fmts == 0) {
>> +		kfree(input_fmts);
>> +		input_fmts = NULL;
>> +	}
>> +
>> +	return input_fmts;
>> +}
>> +
>> +static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
>> +				       struct drm_bridge_state *bridge_state,
>> +				       struct drm_crtc_state *crtc_state,
>> +				       struct drm_connector_state *conn_state)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +
>> +	dev_dbg(hdmi->dev, "selected output format %x\n",
>> +			bridge_state->output_bus_cfg.format);
> 
> Nit: not aligned on the open parens.
> 
>> +
>> +	hdmi->hdmi_data.enc_out_bus_format =
>> +			bridge_state->output_bus_cfg.format;
>> +
>> +	dev_dbg(hdmi->dev, "selected input format %x\n",
>> +			bridge_state->input_bus_cfg.format);
>> +
>> +	hdmi->hdmi_data.enc_in_bus_format =
>> +			bridge_state->input_bus_cfg.format;
>> +
>> +	return 0;
>> +}
>> +
>>  static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>>  {
>>  	struct dw_hdmi *hdmi = bridge->driver_private;
>> @@ -2499,6 +2759,9 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>>  	.atomic_reset = drm_atomic_helper_bridge_reset,
>>  	.attach = dw_hdmi_bridge_attach,
>>  	.detach = dw_hdmi_bridge_detach,
>> +	.atomic_check = dw_hdmi_bridge_atomic_check,
>> +	.atomic_get_output_bus_fmts = dw_hdmi_bridge_atomic_get_output_bus_fmts,
>> +	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,
>>  	.enable = dw_hdmi_bridge_enable,
>>  	.disable = dw_hdmi_bridge_disable,
>>  	.mode_set = dw_hdmi_bridge_mode_set,
>> @@ -2963,6 +3226,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>  
>>  	hdmi->bridge.driver_private = hdmi;
>>  	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
>> +
> 
> Nit: not sure this has to be part of that patch.
> 
> Looks good otherwise.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>


Thanks, will fixup in a v5 or while applying.

Neil

> 
>>  #ifdef CONFIG_OF
>>  	hdmi->bridge.of_node = pdev->dev.of_node;
>>  #endif
> 

