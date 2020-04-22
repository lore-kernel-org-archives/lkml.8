Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBE7C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8C42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Msi2hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDVS2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgDVS2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:28:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870BAC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:28:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so3613818wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0tlyk2uniOQ7hNjY6as+wntcWMQo2HCI80sdZEQDd3g=;
        b=f6Msi2hf+rqfeBb8OaBCctiUVe6KpLx3zYGANKDJ4o0h4xKRVVzy1RjdDrtNoYqOUZ
         ZivypzjFqrahjChsmyh/7K6Fts600oggJUTQezINwbVmxpYgajgaUYdEloZUXfDJ1G1Z
         D2/p4m271tRSyN9CBsIQchnxdDFR/cfDYIj39gfk40CMrt3doOiPU3SR3J2sUQHivtzM
         WcINzLu15t250eGBI9+yqxjB+/A5xWH85a2daH5azcf6dO0D9xwtQWrCkonRQhDhYpCX
         dN6LnLkabhOXyCjNriJdQrUyo586iCQr6kxigSsqoFQ2qKYbcxT8R0mMX+jTvlilYNlW
         xPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=0tlyk2uniOQ7hNjY6as+wntcWMQo2HCI80sdZEQDd3g=;
        b=n+irMk/Rd4FezRrh2rlf7nzp7Sud+wJ9iVp6OSUD13dLshfsbUtGLC6W7v2czdfVtc
         3HIAkQ/BEO3mCK1opiGuG7x1gN4oW++bLFJlAhmidY+YVXOq/Na6VAu+U76a/7I/oGxQ
         4+tT6YuurU3dI6432g0JK3c3W3Vut6TvguGr9Yp/BYcJvmuIleUPUovIcd5gaAn5/0Sv
         GN2PYa/WRpDTaLFXGapbK6ldTpiLXHcJ2w8qCoqezZvwuu7n9GpQjvHy8Dwt0qdW3o5k
         cnqC0apMM4yNte7wO79xwFGqNcFi4sqMWqFv1dwiyz/30QnPaKhIIO0ShTmVUgBMATxS
         VhZw==
X-Gm-Message-State: AGi0PuZtAUV/C42Jsp5zLNYvQdh5z4bX+tYYKGh7x0sng/Jn+VGMxqHY
        FGcsGrzvi1h2QPbU2XX0Z6c=
X-Google-Smtp-Source: APiQypJvkVOjEtvzY+6jXDqxtreoyefr10gKKT7OmtuCna524jgl5Rt40TWMEHc0iMW9Co+wasJbOQ==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr12114002wma.89.1587580109179;
        Wed, 22 Apr 2020 11:28:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id p16sm55977wro.21.2020.04.22.11.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 11:28:25 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] amdgpu: fixes memleak issue when init failed
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Ori Messinger <Ori.Messinger@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
References: <20200421111715.1231-1-bernard@vivo.com>
 <14063C7AD467DE4B82DEDB5C278E8663010212C230@FMSMSX108.amr.corp.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8a6899eb-2078-51a4-9b14-b2f47c35f221@gmail.com>
Date:   Wed, 22 Apr 2020 20:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663010212C230@FMSMSX108.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.04.20 um 17:51 schrieb Ruhl, Michael J:
>> -----Original Message-----
>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>> Bernard Zhao
>> Sent: Tuesday, April 21, 2020 7:17 AM
>> To: Alex Deucher <alexander.deucher@amd.com>; Christian König
>> <christian.koenig@amd.com>; David (ChunMing) Zhou
>> <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
>> <daniel@ffwll.ch>; Tom St Denis <tom.stdenis@amd.com>; Ori Messinger
>> <Ori.Messinger@amd.com>; Sam Ravnborg <sam@ravnborg.org>; Bernard
>> Zhao <bernard@vivo.com>; amd-gfx@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
>> Cc: opensource.kernel@vivo.com
>> Subject: [PATCH] amdgpu: fixes memleak issue when init failed
>>
>> VRAM manager and DRM MM when init failed, there is no operaction
>> to free kzalloc memory & remove device file.
>> This will lead to memleak & cause stability issue.
>>
>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 24
>> ++++++++++++++++----
>> 1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 82a3299e53c0..4c5fb153e6b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -175,30 +175,44 @@ static int amdgpu_vram_mgr_init(struct
>> ttm_mem_type_manager *man,
>> 	ret = device_create_file(adev->dev,
>> &dev_attr_mem_info_vram_total);
>> 	if (ret) {
>> 		DRM_ERROR("Failed to create device file
>> mem_info_vram_total\n");
>> -		return ret;
>> +		goto VRAM_TOTAL_FAIL;
>> 	}
>> 	ret = device_create_file(adev->dev,
>> &dev_attr_mem_info_vis_vram_total);
> Have you looked at the DEVICE_ATTR mechanism?

Yeah, I've thought about that as well. But didn't had time to look into 
detail if that could be applied here or not.

Regards,
Christian.

>
> It is set up to add device files.  You won't get the granularity of each file,
> but it has a lot more automatic-ness to setting this stuff up.
>
> Mike
>
>> 	if (ret) {
>> 		DRM_ERROR("Failed to create device file
>> mem_info_vis_vram_total\n");
>> -		return ret;
>> +		goto VIS_VRAM_TOTA_FAIL;
>> 	}
>> 	ret = device_create_file(adev->dev,
>> &dev_attr_mem_info_vram_used);
>> 	if (ret) {
>> 		DRM_ERROR("Failed to create device file
>> mem_info_vram_used\n");
>> -		return ret;
>> +		goto VRAM_USED_FAIL;
>> 	}
>> 	ret = device_create_file(adev->dev,
>> &dev_attr_mem_info_vis_vram_used);
>> 	if (ret) {
>> 		DRM_ERROR("Failed to create device file
>> mem_info_vis_vram_used\n");
>> -		return ret;
>> +		goto VIS_VRAM_USED_FAIL;
>> 	}
>> 	ret = device_create_file(adev->dev,
>> &dev_attr_mem_info_vram_vendor);
>> 	if (ret) {
>> 		DRM_ERROR("Failed to create device file
>> mem_info_vram_vendor\n");
>> -		return ret;
>> +		goto VRAM_VERDOR_FAIL;
>> 	}
>>
>> 	return 0;
>> +
>> +VRAM_VERDOR_FAIL:
>> +	device_remove_file(adev->dev,
>> &dev_attr_mem_info_vis_vram_used);
>> +VIS_VRAM_USED_FAIL:
>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
>> +RVAM_USED_FAIL:
>> +	device_remove_file(adev->dev,
>> &dev_attr_mem_info_vis_vram_total);
>> +VIS_VRAM_TOTA_FAIL:
>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
>> +VRAM_TOTAL_FAIL:
>> +	kfree(mgr);
>> +	man->priv = NULL;
>> +
>> +	return ret;
>> }
>>
>> /**
>> --
>> 2.26.2
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

