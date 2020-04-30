Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B408C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E00420784
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMMsSbBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3Fwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3Fwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:52:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF892C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:52:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e25so5133706ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RwmYZ3E2Cn3/mLXJyzZsWl6huqbPer1PdGV+pzidiwA=;
        b=JMMsSbBY9Xotty3p1/IOhmUfb1M9vDuomzbNVK9plmB1y+RJx7utPY0/QRdMvEelOt
         Xmr5Von19/WQmSodxjguM171c5DhGOJUwydRla7c3M8bFbTCtYkxg4q2V0wBtk2ywXJl
         4l1V1aBV2Gi9GOTd+e7FfmarOp83wiRuR5oOzpNagGS4VZjFFBwBl7KcN/WBXrgOieTH
         YvgptMgduY0xTTXiFTE1bOqfrVsnVTTQ2tPw1XAkALs/EhJKQoicrWIPpjsab6B1/nG1
         F/aa+7aPppsp5La/NvyuejWJOFIocwkPO807G/dXNYJYlVDzA4tGcBI6XIy0Uh784SRp
         w8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwmYZ3E2Cn3/mLXJyzZsWl6huqbPer1PdGV+pzidiwA=;
        b=XBQzDd3/H8ugg76T6RsC5uuFw1RHsYD3x4brmchad3nEjZMK6epc0L9Z+QEhd/zV+B
         +G2r7xuLxYivPJbJAONKh05xqRJsoMGj386qEyww7OOSOua1Yp0LXiUXzSE1i7cj8gXw
         s/OTcus3d3LBtHU3TZjks2xs4mnmOyWvbeHBxj8/5B95DSF/q7U+eRUsQTnixf39eIbY
         cR95uInq45k1JkmUBIDwgeZ9RqfkSs2y9I9dCIrytvUq8gRrZxlaVp7vZuYkeMwSoBz8
         wSA82nrHD5kpjMW2vYHNDwlKU4mN9GXhTOPIGoizUXSPq98WHnnBVvNJ9OQV1OMcpO9K
         ta9Q==
X-Gm-Message-State: AGi0PuYr+m5vzJAU/Os6mcCLFm/wSaZSGho79splMdQSKE6r1d4z894H
        kCm8m7/LqdfplkzYJKVcfsE=
X-Google-Smtp-Source: APiQypLutdv0RfgCbbx60i8SZmUJ4DmZhZ2I+iHcCi1c66UJa9V3ha0BZI7e3IXSOgpcMDklzORucQ==
X-Received: by 2002:a2e:9084:: with SMTP id l4mr1157836ljg.132.1588225969010;
        Wed, 29 Apr 2020 22:52:49 -0700 (PDT)
Received: from [192.168.0.103] (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id k18sm4836849lfg.81.2020.04.29.22.52.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 22:52:48 -0700 (PDT)
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
 <875zdiacv2.fsf@intel.com>
From:   =?UTF-8?B?TWljaGHFgiBPcnplxYI=?= <michalorzel.eng@gmail.com>
Message-ID: <dab8f564-d2b3-de19-f56d-f741046c39c6@gmail.com>
Date:   Thu, 30 Apr 2020 07:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <875zdiacv2.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.04.2020 10:57, Jani Nikula wrote:
> On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
>> As suggested by the TODO list for the kernel DRM subsystem, replace
>> the deprecated functions that take/drop modeset locks with new helpers.
>>
>> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
>> ---
>>  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
>> index 35c2719..901b078 100644
>> --- a/drivers/gpu/drm/drm_mode_object.c
>> +++ b/drivers/gpu/drm/drm_mode_object.c
>> @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>>  {
>>  	struct drm_mode_obj_get_properties *arg = data;
>>  	struct drm_mode_object *obj;
>> +	struct drm_modeset_acquire_ctx ctx;
>>  	int ret = 0;
>>  
>>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>>  		return -EOPNOTSUPP;
>>  
>> -	drm_modeset_lock_all(dev);
>> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> 
> I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
> DRM_MODESET_LOCK_ALL_END macros. :(
> 
> Currently only six users... but there are ~60 calls to
> drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
> if this will come back and haunt us.
> 
> BR,
> Jani.

Hm, so we can either replace all of these calls(I think it's a better option) or abandon the idea of removing this deprecated function.
In the latter scenario, it'd be beneficial to remove this from TODO.

Best regards
Michal

> 
> 
>>  
>>  	obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
>>  	if (!obj) {
>> @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>>  out_unref:
>>  	drm_mode_object_put(obj);
>>  out:
>> -	drm_modeset_unlock_all(dev);
>> +	DRM_MODESET_LOCK_ALL_END(ctx, ret);
>>  	return ret;
>>  }
>>  
>> @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
>>  {
>>  	struct drm_device *dev = prop->dev;
>>  	struct drm_mode_object *ref;
>> +	struct drm_modeset_acquire_ctx ctx;
>>  	int ret = -EINVAL;
>>  
>>  	if (!drm_property_change_valid_get(prop, prop_value, &ref))
>>  		return -EINVAL;
>>  
>> -	drm_modeset_lock_all(dev);
>> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>>  	switch (obj->type) {
>>  	case DRM_MODE_OBJECT_CONNECTOR:
>>  		ret = drm_connector_set_obj_prop(obj, prop, prop_value);
>> @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
>>  		break;
>>  	}
>>  	drm_property_change_valid_put(prop, ref);
>> -	drm_modeset_unlock_all(dev);
>> +	DRM_MODESET_LOCK_ALL_END(ctx, ret);
>>  
>>  	return ret;
>>  }
> 
