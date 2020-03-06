Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14150C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7F0206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziG/FPpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgCFChG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:37:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32844 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgCFChG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:37:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so236240plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2QSQagBk8OSnwRoBTGse7P63wd/qKZn7zPPbs//Oq18=;
        b=ziG/FPpCvypm9vY7+OruvzJjZaHOkQ6Eqw6zf29DKAe7vl+dxC6DjySoy81waLuRgU
         F8/iWLM1GOUxPpQwuSubo32CEJ3sNddl+YfG9Cnh6fjJZ9HaJ0y/dvI7+TAMlfsfaRwf
         /0aO9rXEtpaSWFhT8O+mZdaUQ3vsSlsSQhd/HH5z9n46t0cIgcIItD/lfkrJmxK3s0TY
         eblmwLLXevrdSYrh8nc9NZIcwkfJprINCsY+mB7oYDUPkhjv1zh5sOB8VBtbkGe5l5/F
         ReNuico5Mb5TXINCKnMB5CJVvh0dEUAHsDx/iDxV89jpXeeAUPlsB+Sx+nPUqpFHXzhe
         a1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2QSQagBk8OSnwRoBTGse7P63wd/qKZn7zPPbs//Oq18=;
        b=celHfu/ymOf831ICJ0sbIBKe3E/JVyWC8T4MpKCGUP3QKqehWI9hT7bq6YTqQyDcBL
         5Ke7MLaczpV/SDlVo6cSAYCIRSF4Gk31ziE8TFDbg92w/cnxDRjEp2VkPW0cbU2WVOmS
         1VaVm3cIOkTFqjVGx8f2RGMmT7pADYaetLIJW/jQPxUFA/MGL4XdnYDKUGthBC4jgTLc
         OPwTFgjq6A+/zhXaNQ8j4hALDuhsqBBPvh4GnAvdWs4kqTEDHm3/Yll8r1Yeqi/Utdos
         gE2kb+GhDvwCJBjrsPsN3jmuUWzHfGpPk9kgMPqox9VKToQ0J6svmU4IGQQJ5xpOcnZI
         uXCw==
X-Gm-Message-State: ANhLgQ0CqfsRdo0rGXq2CIUGZKIRGzl2Jj7S8YPm4kMFfMP2xl4wdQTK
        Mvz0ZhaSNzGaKRAPGiB4KM/wPg==
X-Google-Smtp-Source: ADFU+vubEpW42LJ68zq8890hphioBy3lQwPFQH72OCR1cxYvfmto8q1733nBuyqMtZUKUkcvRrJWQQ==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr827724pla.17.1583462225267;
        Thu, 05 Mar 2020 18:37:05 -0800 (PST)
Received: from [10.191.0.78] ([45.135.186.118])
        by smtp.gmail.com with ESMTPSA id f127sm34474687pfa.112.2020.03.05.18.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 18:37:04 -0800 (PST)
Subject: Re: [PATCH v2] uacce: unmap remaining mmapping from user space
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        dave.jiang@intel.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <1582701126-5312-1-git-send-email-zhangfei.gao@linaro.org>
 <20200306015121.GH30653@gondor.apana.org.au>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <a8beaf1f-a510-7fca-d048-1327c87226fa@linaro.org>
Date:   Fri, 6 Mar 2020 10:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306015121.GH30653@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/6 上午9:51, Herbert Xu wrote:
> On Wed, Feb 26, 2020 at 03:12:06PM +0800, Zhangfei Gao wrote:
>> When uacce parent device module is removed, user app may
>> still keep the mmaped area, which can be accessed unsafely.
>> When rmmod, Parent device driver will call uacce_remove,
>> which unmap all remaining mapping from user space for safety.
>> VM_FAULT_SIGBUS is also reported to user space accordingly.
>>
>> Suggested-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   v2: Unmap before put_queue, where memory is freed, commented from Zaibo.
>>
>>   drivers/misc/uacce/uacce.c | 16 ++++++++++++++++
>>   include/linux/uacce.h      |  2 ++
>>   2 files changed, 18 insertions(+)
> Patch applied.  Thanks.
Thanks Herbert for the help.
