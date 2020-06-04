Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FDCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1429B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFwmskb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFDGKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgFDGKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:10:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D1C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:10:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg4so1779877plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Sw/822Lzx4gGPvnJW8ZhfnQxJ/CLse2iXnOnbBACWxs=;
        b=qFwmskb7rZ/DVhuRWSdVuv4TylJZJF1ESC/hegc9sCDe7xqo+CNcCH3w6h3JZRcLZ0
         ZaRkLrM4SzA6w7mDJBtYOUB9/JPdIcH/l443Zbw8Dyuzm7/vjI3Tw7ZO1qZb91VaOB4P
         e6BxIXf4Xqdn7sl9xJPrqPfPeO0i9qZYGEN9zoEj58k8WXLB1S/rxp+gwTuvrNnh1rfJ
         sILXhHzv9jB0kyCAd+/rvQsZWj0CMi+cdXh1W25JQEn6cmeq37sYNJql1E/7FQrMCMNo
         3rgC3HhEJPNsRpoCqGu+0WvJJlNhuPbN9zx0Ov/0LRZlaLUW2pmnawv0TmK6OBuiATy4
         pxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Sw/822Lzx4gGPvnJW8ZhfnQxJ/CLse2iXnOnbBACWxs=;
        b=KRla/cX6u+fQ25BiUUL9rPaaqf9Dbrj6ia3mNDCptN4modjjGGss/DM1nFw6gqwqIO
         qsu9SziVywULFkhaCk0uHlDTmXi4E1iqvF1Bex8TPM7kyXetbKlFZ1fmPGfUWu3bM3mY
         ES0J/aqJ88fe84GVm+sG5brJkxQBMO33KxV4SGTOT0Wv2KEQsxXelHfIL80sHFci/uU9
         um+yF2+XAabpYAq70jXAPxd2MIcZQ7YEJW5L+2Fx2DyEOmk5pGYc57vkofNy1RIsMapC
         g0OJCop8BpK3Pr8FcbwWu2LL7DCdUV2mkOU2y/4MEHVPzTXXY1soJS4hJ0Mp6CKmUGmF
         fgWQ==
X-Gm-Message-State: AOAM533yniZw5J44SSvfMTt7rYgfNhmNFhe0BbfEbA6G17qbICg6Nvmx
        UP/osxpvqRMk10qbqI+lu7wVrg==
X-Google-Smtp-Source: ABdhPJwa34gJbrecNcEPGbDakofpI2pLoPnPba+wpgdfTvMMSVdHY38aLuZ2GCjwbwL60zBe/z5cYQ==
X-Received: by 2002:a65:6694:: with SMTP id b20mr2910101pgw.303.1591251051118;
        Wed, 03 Jun 2020 23:10:51 -0700 (PDT)
Received: from [10.15.5.98] ([45.135.186.21])
        by smtp.gmail.com with ESMTPSA id b1sm4604480pjc.33.2020.06.03.23.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 23:10:50 -0700 (PDT)
Subject: Re: [PATCH] crypto: hisilicon - fix strncpy warning with strlcpy
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wangzhou1 <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kbuild-all@lists.01.org
References: <202006032110.BEbKqovX%lkp@intel.com>
 <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
 <20200604033918.GA2286@gondor.apana.org.au>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
Date:   Thu, 4 Jun 2020 14:10:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200604033918.GA2286@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/6/4 上午11:39, Herbert Xu wrote:
> On Thu, Jun 04, 2020 at 11:32:04AM +0800, Zhangfei Gao wrote:
>> Use strlcpy to fix the warning
>> warning: 'strncpy' specified bound 64 equals destination size
>>           [-Wstringop-truncation]
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/crypto/hisilicon/qm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
>> index f795fb5..224f3e2 100644
>> --- a/drivers/crypto/hisilicon/qm.c
>> +++ b/drivers/crypto/hisilicon/qm.c
>> @@ -1574,7 +1574,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
>>   		.ops = &uacce_qm_ops,
>>   	};
>>   
>> -	strncpy(interface.name, pdev->driver->name, sizeof(interface.name));
>> +	strlcpy(interface.name, pdev->driver->name, sizeof(interface.name));
> Should this even allow truncation? Perhaps it'd be better to fail
> in case of an overrun?
I think we do not need consider overrun, since it at most copy size-1 
bytes to dest.
 From the manual: strlcpy()
        This  function  is  similar  to  strncpy(), but it copies at 
most size-1 bytes to dest, always adds a terminating null
        byte,
And simple tested with smaller SIZE of interface.name,  only SIZE-1 is 
copied, so it is safe.
-#define UACCE_MAX_NAME_SIZE    64
+#define UACCE_MAX_NAME_SIZE    4

Thanks
