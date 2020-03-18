Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730AB20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0abISc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgCRQDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:03:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40433 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:03:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id z12so3967563wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NBpTb0vw99e5S/IoMj3BB65KCm2t/wKof5fD6aPsMYM=;
        b=u0abISc1Df5MhDyW8KEO42x/KCYMmTKfDc8BS/ayA+W6nEhRCNqtr8oV5oR4XRWRDS
         mgR4WUxae29gsY4cmH5mTdL7eNo3P6V6lJOGMmAz3ktoS/HKhhGFMQfcMynma7MOCsP7
         qHPhrBkIIeNADiVr2xnapnqQY95LCxDassg1c2jwjDvhNlgbNbG73TB1x9xvIY+LADb9
         9Donw4KTpVfKRSpBX5RpG8EbxMmGmfkmqFcIf9OT4BodqaceriCFriKCXg1+RgQtLXte
         y0AtZ1GMovRoZS5OVcZrAs5rlP6kNrbg8opOC57T3WGRvEMwzriJwHeCiWVjVNAcvn1N
         lecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NBpTb0vw99e5S/IoMj3BB65KCm2t/wKof5fD6aPsMYM=;
        b=DofySMQOcM653hH11fMXL/WmFCPpof713g8wQzyp2bsbk9QGE/PTd9cjO8/vJZSe3a
         SJMhGJLYpfAlRf2allmddP4t1MywMcziwd0OGkfm0yVtkF2WwP29zG7RgJXRaUHIlCKb
         ZnQVAkF6F9memgRMyjX4FDkGxyScdVrftcQt30h3qIwNWxUA+UekRG5lS9QbTdBcgX4B
         lqgDG1k94QtKxQpcrIljvl6zCPVhC1OT9Nr0LnMXsvp+CXZcUC0dFJyedLT8SyVx1Yr0
         H4JfVEYsw78CsAMug8v1oos5UTiSEhB/A953YjVX/uBNNBxK/k5taF6wv5Ll5mr9trLo
         PW0w==
X-Gm-Message-State: ANhLgQ1jHLBDeg5j3i0ykbkaG1Pkb09QgF3Xjy6B9SkNh4+CbTm+4iqA
        VTesg9FOEdBQu22jqmxtfoE=
X-Google-Smtp-Source: ADFU+vtUqqUm4YdPYcnPQhh4IIRuEnyKOGNipbJYU5eMGp48eguBm4WwXJVNvzdurXNHq0TP9bM3BQ==
X-Received: by 2002:a1c:9dc6:: with SMTP id g189mr6112861wme.91.1584547385078;
        Wed, 18 Mar 2020 09:03:05 -0700 (PDT)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id r18sm10097934wro.13.2020.03.18.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:03:04 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Wed, 18 Mar 2020 19:02:47 +0300 (EAT)
To:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
cc:     daniel@ffwll.ch
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make drm_vram_mm_debugfs_init()
 return 0
In-Reply-To: <20200318152627.GY2363188@phenom.ffwll.local>
Message-ID: <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui>
References: <20200310133121.27913-1-wambui.karugax@gmail.com> <20200310133121.27913-11-wambui.karugax@gmail.com> <20200318152627.GY2363188@phenom.ffwll.local>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Mar 2020, Daniel Vetter wrote:

> On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
>> Since 987d65d01356 (drm: debugfs: make
>> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
>> fails and should return void. Therefore, remove its use as the
>> return value of drm_vram_mm_debugfs_init(), and have the function
>> return 0 directly.
>>
>> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
>> introducing build issues and build breakage.
>>
>> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
>> index 92a11bb42365..c8bcc8609650 100644
>> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
>> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
>>   */
>>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
>>  {
>> -	int ret = 0;
>> -
>>  #if defined(CONFIG_DEBUG_FS)
>
> Just noticed that this #if here is not needed, we already have a dummy
> function for that case. Care to write a quick patch to remove it? On top
> of this patch series here ofc, I'm in the processing of merging the entire
> pile.
>
> Thanks, Daniel
Hi Daniel,
Without this check here, and compiling without CONFIG_DEBUG_FS, this 
function is run and the drm_debugfs_create_files() does not have access to 
the parameters also protected by an #if above this function. So the change 
throws an error for me. Is that correct?

Thanks,
wambui karuga

>> -	ret = drm_debugfs_create_files(drm_vram_mm_debugfs_list,
>> -				       ARRAY_SIZE(drm_vram_mm_debugfs_list),
>> -				       minor->debugfs_root, minor);
>> +	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
>> +				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
>> +				 minor->debugfs_root, minor);
>>  #endif
>> -	return ret;
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
>>
>> --
>> 2.25.1
>>
>
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>
