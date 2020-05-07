Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6408C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21E820753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg/8Weta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgEGGmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGGmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:42:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965AC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 23:42:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so5392415wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u9x5CxPuUX9KvELHPIEAEoDfCQa03ODaNOa1+2QT5/Y=;
        b=Jg/8Weta4UEn+UaAsuYfsWcL1WXFxhUUbzx32Wng0weqzZVChYoliVf2Dsbab7b/C0
         W6KUk8QGFnu5KOXA/Be5pqeb7TjNTrzbp6vX/dt8j20PeV2aIBV+6olcpYubdxE/Db3J
         C/sFMOhCAxNPRpHjouJt1eY/ipGii6NtklkePn5KEbCIwb9ff7585NWCyJJSGeBk2aQb
         cf+XAJVC0YwTWYp0ZoJSqb8nfiGM0W0uc/5Dky7UCBR4mjQwBJHtHpCIyTEJRVDmmn8k
         9U0XpRh7SQ4Bhe/acqZtzzlsMDv+Ny90GzU5uCgog0nlhLPEZqbQBYSHZBMmK3CFea1C
         bhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=u9x5CxPuUX9KvELHPIEAEoDfCQa03ODaNOa1+2QT5/Y=;
        b=hF3TYerhIfJOCLLw3/O1LeVvAGstes8MRDxu6y+wdryfPz5+NbleDS7QZAkqcST3I2
         L4yh6Y9N1SdJQzUKOGwWbWyhDVeQA1rZpEseKIizF2oU2OE7ZjutOowrCUQOaWBtxK6o
         A3k2kzRdkq6gg/zVH5512YJv7OlAS5p8SHJcaAjiEHDjxbh9wzveGyxHCPmCRVwD0myz
         Tzq8xbVYUp0U0NV12fzYnvsYSrZW20h2DY8xQ77T4hB3uHguGhXw4ajUxGAlqquXTPuR
         TtQYbcSdSwc84Aj3lMsmoN4vyFJxHZNjP5Um+oUo1wXyva7PhxyI3H66MTzCi/clIM+T
         /HNw==
X-Gm-Message-State: AGi0PuZJ0lZLiYhJN6u+LaLPxf6Nzaf2NHM45IQV+nrigQq6iFTsAyj+
        RqqphchGSEQMZ1L5qDbZexE=
X-Google-Smtp-Source: APiQypKQFRvND9YMQALXyd7xMrHaeY3PO4dhEInignttoGdFAGtl2qTWrdddrR/9c7FbdjaLg2sRrg==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr8755266wmc.67.1588833773329;
        Wed, 06 May 2020 23:42:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id w6sm6674286wrt.39.2020.05.06.23.42.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 23:42:52 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>
Cc:     Guchun Chen <guchun.chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Dennis Li <Dennis.Li@amd.com>
References: <20200505140208.284473-1-arnd@arndb.de>
 <006e29037a9314fb286a5d6d84905bce99cef6c7.camel@perches.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <845a2e12-538c-fb6d-db80-78e8adf1413f@gmail.com>
Date:   Thu, 7 May 2020 08:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <006e29037a9314fb286a5d6d84905bce99cef6c7.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.05.20 um 21:01 schrieb Joe Perches:
> On Tue, 2020-05-05 at 16:01 +0200, Arnd Bergmann wrote:
>> After the structure was padded to 1024 bytes, it is no longer
>> suitable for being a local variable, as the function surpasses
>> the warning limit for 32-bit architectures:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:587:5: error: stack frame size of 1072 bytes in function 'amdgpu_ras_feature_enable' [-Werror,-Wframe-larger-than=]
>> int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>>      ^
>>
>> Use kzalloc() instead to get it from the heap.
> []
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> []
>> @@ -588,19 +588,23 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>>   		struct ras_common_if *head, bool enable)
>>   {
>>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>> -	union ta_ras_cmd_input info;
>> +	union ta_ras_cmd_input *info;
>>   	int ret;
>>   
>>   	if (!con)
>>   		return -EINVAL;
>>   
>> +        info = kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);
> Spaces were used for indentation here not a tab.
> It might be useful to run your proposed patches through checkpatch
>
> Is this an actual bug fix as the previous use didn't
> zero unused info members?
>
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>>   	if (!enable) {
>> -		info.disable_features = (struct ta_ras_disable_features_input) {
>> +		info->disable_features = (struct ta_ras_disable_features_input) {
>>   			.block_id =  amdgpu_ras_block_to_ta(head->block),
>>   			.error_type = amdgpu_ras_error_to_ta(head->type),
>>   		};
>>   	} else {
>> -		info.enable_features = (struct ta_ras_enable_features_input) {
>> +		info->enable_features = (struct ta_ras_enable_features_input) {
>>   			.block_id =  amdgpu_ras_block_to_ta(head->block),
>>   			.error_type = amdgpu_ras_error_to_ta(head->type),
>>   		};
>> @@ -609,26 +613,33 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>>   	/* Do not enable if it is not allowed. */
>>   	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
>>   	/* Are we alerady in that state we are going to set? */
>> -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
>> -		return 0;
>> +	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head))) {
> And trivia:
>
> The !! uses with bool seem unnecessary and it's probably better
> to make amdgpu_ras_is_feature_enabled to return bool.
>
> Maybe something like:
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 538895cfd862..05c4eaf0ddfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -526,16 +526,16 @@ void amdgpu_ras_parse_status_code(struct amdgpu_device* adev,
>   }
>   
>   /* feature ctl begin */
> -static int amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
> -		struct ras_common_if *head)
> +static bool amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
> +					  struct ras_common_if *head)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   
>   	return con->hw_supported & BIT(head->block);
>   }
>   
> -static int amdgpu_ras_is_feature_enabled(struct amdgpu_device *adev,
> -		struct ras_common_if *head)
> +static bool amdgpu_ras_is_feature_enabled(struct amdgpu_device *adev,
> +					  struct ras_common_if *head)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   
> @@ -560,7 +560,7 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>   	 */
>   	if (!amdgpu_ras_is_feature_allowed(adev, head))
>   		return 0;
> -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> +	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))

And while we are at improving coding style I think that writing this as 
"if (enabled == amdgpu_ras_is_feature_enabled(adev, head))" would be 
much more readable.

Christian.

>   		return 0;
>   
>   	if (enable) {
> @@ -609,7 +609,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>   	/* Do not enable if it is not allowed. */
>   	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
>   	/* Are we alerady in that state we are going to set? */
> -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> +	if (!(enable ^ amdgpu_ras_is_feature_enabled(adev, head)))
>   		return 0;
>   
>   	if (!amdgpu_ras_intr_triggered()) {
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

