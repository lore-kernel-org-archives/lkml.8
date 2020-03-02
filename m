Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545DD217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IP8CqWll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:55:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54967 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:55:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id z12so11785967wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJNCFnFx75P4PmGSwBJn8FFP/mBUf8whYY9xEyY9kl4=;
        b=IP8CqWll/Znb5Z4OyMw1XQLoWy9UTYCxFID1QGp417UWkkYSjz8F0WB409mkwq7XH9
         PkQ6l2vDZMHOkjGyoMdy+LAVp+dZyXYSu5eq+0nlAxiqWXl/geWsVB+O+7xzhv88n74M
         jE2jExW548WZ1fMRJfWwVBBY0OooEvuAixNGLv2ALvid2XxiuSJ4idZw5GRXqy1vsnUQ
         cscvJyzse8PMRTJoCklIFD4pAOrxF2Etq5k+wZfDBimEfO3hdeysDIDnoiMXKscXqiNp
         Z3VGWg0luw5/Fd+mNnGjhXXdv4des+Simsby4oPcnzQp3aa/3f2PAghfnd2TKtXBKjuI
         U1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oJNCFnFx75P4PmGSwBJn8FFP/mBUf8whYY9xEyY9kl4=;
        b=LqHSLq+SyXgk09ZB05ClAtMmByfat9g7PDsKKZ4uICccsxlxZpRaRosFtOGVJtUo6o
         fmN5VtI1H0Zl3jp2TQVClM1bDRSPci+F4kSt3NHS+GnKnhl4uLL8ScrRnU19rxlKcO1I
         b4AGH0DceQ54DSdPCQpRdxmt7t9LeZi8V+8Z9zmxzRJPxXtiL/aFOLgKumRxUKDQuBP6
         n1U1dP/XPcckgIWXWQ14loBVhjmLJIrWsaVppFLXJYTniyKnj2L/9w0BoVO7wubYKjmo
         pATLA9NYbK5JFRaPJ7HqmxSnf0ngamEB+sYyDxomvRPn1sOgPDcSSrf+Fy8edrFKrmdZ
         XUKg==
X-Gm-Message-State: ANhLgQ1TPjdUwq09QBsMsOXqxyDWSrk5iT4Qp08qrzQRljeSg50DSmS9
        fO11HruKWY8TuK/zNTZqGxDh9w==
X-Google-Smtp-Source: ADFU+vtfL1A+tLoqufxEudSmCG7N8M+9lw4QmtwvS2TSlV0UP83Rz3UrCVjL2ufzUIU5hEpeAJkSWA==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr86848wml.129.1583164538850;
        Mon, 02 Mar 2020 07:55:38 -0800 (PST)
Received: from [10.1.3.173] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n3sm1106457wrv.91.2020.03.02.07.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 07:55:38 -0800 (PST)
Subject: Re: [PATCH v4 02/11] drm/bridge: dw-hdmi: add max bpc connector
 property
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        a.hajda@samsung.com, jonas@kwiboo.se,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <20200206191834.6125-3-narmstrong@baylibre.com>
 <11463907.O9o76ZdvQC@jernej-laptop>
 <09d315b8-22f3-a25a-1aea-9c5d50c634d6@baylibre.com>
 <20200302091818.GC11960@pendragon.ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <6eede520-cbd8-51e5-6b56-afd727d50ab0@baylibre.com>
Date:   Mon, 2 Mar 2020 16:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302091818.GC11960@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2020 10:18, Laurent Pinchart wrote:
> Hi Neil and Jonas,
> 
> (CC'ing Daniel for a framework question)
> 
> Thank you for the patch.
> 
> On Fri, Feb 21, 2020 at 09:50:18AM +0100, Neil Armstrong wrote:
>> On 17/02/2020 07:38, Jernej Škrabec wrote:
>>> Dne četrtek, 06. februar 2020 ob 20:18:25 CET je Neil Armstrong napisal(a):
>>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>>
>>>> Add the max_bpc property to the dw-hdmi connector to prepare support
>>>> for 10, 12 & 16bit output support.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>>>> 9e0927d22db6..051001f77dd4 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> @@ -2406,6 +2406,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
>>>> *bridge) DRM_MODE_CONNECTOR_HDMIA,
>>>>  				    hdmi->ddc);
>>>>
>>>> +	drm_atomic_helper_connector_reset(connector);
>>>
>>> Why is this reset needed?
>>
>> I assume it's to allocate a new connector state to attach a the bpc propery.
>>
>> But indeed, this helper is never used here, but only as callback to the drm_connector_funcs->reset.
>>
>> But, amdgpu calls :
>> 	/*
>> 	 * Some of the properties below require access to state, like bpc.
>> 	 * Allocate some default initial connector state with our reset helper.
>> 	 */
>> 	if (aconnector->base.funcs->reset)
>> 		aconnector->base.funcs->reset(&aconnector->base);
>>
>> which is the same.
> 
> A comment would be useful:
> 
> 	/*
> 	 * drm_connector_attach_max_bpc_property() requires the
> 	 * connector to have a state.
> 	 */
> 	drm_atomic_helper_connector_reset(connector);
> 
> 	drm_connector_attach_max_bpc_property(connector, 8, 16);
> 

Done

> I don't like this much though, it feels like the initial reset performed
> by drm_mode_config_reset() should set default values for all state
> members that are related to properties. Daniel, what's the rationale
> behind the current implementation ?
> 
> This is a DRM core issue that shouldn't block this patch though, so

I'll investigate why, but I haven't found out how the intel driver got the
connector state initialized since they don't use the atomic helpers....

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>>>> +
>>>> +	drm_connector_attach_max_bpc_property(connector, 8, 16);
>>>> +
>>>>  	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
>>>>  		drm_object_attach_property(&connector->base,
>>>>  			connector->dev-
>>>> mode_config.hdr_output_metadata_property, 0);
> 

