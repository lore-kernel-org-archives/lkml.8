Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4190FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4153F22B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bv+t10uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgHDKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHDKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:03:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BECC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 03:03:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i6so3773493edy.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzbKl+uUFfh9XAYP8GcmWr39WT1Cz06a6UbBamDt1vA=;
        b=Bv+t10ukpzqXnpeDVdA/0sv/wrBsyyxnYg5VPqUER0eYAtKneX2hO/6XQEfibbkG9T
         y1kp0dJ56fgFTc95lTehXdAZoCKO1Ov1uanAKP+EwnwBcDOEbWpseIdcJ73EMOie2zTr
         rz71UFOrnNQO86pLgSrLiBIqbDJbya9mLMRKWSl95K/f0Pv2u7f9eGCuRDmZk3ba/Uns
         E4MPruV0OWTaG2M2pZU3nwSs5KKXf4KaLncmKLeYtZJ8ObGLVLZI/jOzMvCoUHx3bgc8
         YoVlJZ3NK8rjkr2aYSxGMMGwqtzSGzcsoO4uoAgLsVKQ4WbckQHa0iokZBwhdIodABny
         LYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzbKl+uUFfh9XAYP8GcmWr39WT1Cz06a6UbBamDt1vA=;
        b=JnUAdtbai2CFVKxqJo4wLnMzx5dYk02zR20S4vOqSht8RB0w076pid1zjek/8QaLEa
         l7JNEp9ztVbTcvkyukLz+3X/TdEQ7vzmrlvxLiAnv4NSo+Q4jw7u/cPfmOuV9/aTgMso
         oawk7+c45YGneX87oqU7FPdFERt3qGslk4cDghGYINyPYhUqSWsX8xPNRctgXw91Unmb
         TPnj9mSmSHGhqYlvbiwXCJy3Ntlaw44T+pUHw+NHeEVfftR6qW3UiAaW5H+zf3ivTIp5
         R5q5bRHz92sWT5H9PK/C5tWnmx4WdK+bQAqdOMJ94UtARGFxfjQRwFF1Kc1t2amJ6Gxq
         49ww==
X-Gm-Message-State: AOAM531tLCAPeZWXcXunqf33vL7jYYZU11TV0pa0zMMr3uYJoWuhjdV3
        4tImacOfb+Kg7NYR3S2NltoXCA==
X-Google-Smtp-Source: ABdhPJwkqwGNIrlBXNgqTBNF0wy5hG7hlAvjdLuUgpzyb6rY5azLKrAv4SDjn7ITK9wQaqBBYaGrbw==
X-Received: by 2002:aa7:d6c2:: with SMTP id x2mr15912050edr.332.1596535407703;
        Tue, 04 Aug 2020 03:03:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id bt20sm18481153edb.62.2020.08.04.03.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 03:03:27 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: add sanity check in nvmem_device_read()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
References: <1596532436-19073-1-git-send-email-bingbu.cao@intel.com>
 <20200804095815.GF13316@paasikivi.fi.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0e8d60cf-7f8b-c6ab-4184-b869c16b603e@linaro.org>
Date:   Tue, 4 Aug 2020 11:03:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200804095815.GF13316@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2020 10:58, Sakari Ailus wrote:
> Hi Bingbu,
> 
> Thank you for the patch.
> 
> On Tue, Aug 04, 2020 at 05:13:56PM +0800, Bingbu Cao wrote:
>> nvmem_device_read() could be called directly once nvmem device
>> registered, the sanity check should be done before call
>> nvmem_reg_read() as cell and sysfs read did now.
>>
>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
>> ---
>>   drivers/nvmem/core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 927eb5f6003f..c9a77993f008 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -1491,6 +1491,13 @@ int nvmem_device_read(struct nvmem_device *nvmem,
>>   	if (!nvmem)
>>   		return -EINVAL;
>>   
>> +	if (offset >= nvmem->size || bytes < nvmem->word_size)
>> +		return 0;
>> +
>> +	if (bytes + offset > nvmem->size)
>> +		bytes = nvmem->size - offset;
> 
> The check is relevant for nvmem_device_write(), too.
> 
> There are also other ways to access nvmem devices such as nvmem_cell_read
> and others alike. Should they be considered as well?

We should probably move these sanity checks to a common place like 
nvmem_reg_read() and nvmem_reg_write(), so the callers need not 
duplicate the same!

--srini

> 
>> +
>> +	bytes = round_down(bytes, nvmem->word_size);
>>   	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
>>   
>>   	if (rc)
> 
