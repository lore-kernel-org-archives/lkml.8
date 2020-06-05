Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BC62075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hb1FEGJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFEP0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgFEP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:26:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F7C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 08:26:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so5236101pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AqjUdAV0eSeVgzmdoBhAtl0I2tJh0EYeJ8Lxk1njxlE=;
        b=Hb1FEGJcGKGXT6cLEc5+mKoFByGI75v/JS3V5JnikKJzHQfGRL5LNFK/kRVwPeymzn
         KLM6YgOaeQE1m6PhzzmrTyyrAyS6WLwbbfCVeFHF+ZmJIsx/7IaWhORJ+fGcarvE+Pwz
         FC64vYpIXt58BXX+h27dWOxjbSiAPbfJBW4OQEAxOB8Tbx7oJY40zWDwQpsA0bBYk1nn
         rT8VvP9eaV83x6AYoNPwr7pom9jUbFBi7yFKiTZPvCQmawfR1rSd/JLpKQwCf3fy3ElS
         wwHMz/JFa1OGLr53eTVb1c6QyBtqfw9NSI79OqnQqtR0VdkZlH/gKUGVXJyVrjn9SqDY
         qdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AqjUdAV0eSeVgzmdoBhAtl0I2tJh0EYeJ8Lxk1njxlE=;
        b=J0IvEGYxj5wPzg2T8IguOjxAu43zDIQfUuRpgi/FZYrs7etPbcTvXn95xT7jKTHNA8
         6c+in0P5DSnvOGajrn6ED8NLQNEmPLc9H6qR3qsd1vxF50KG2nZgzY4ob4+SKDjf5LgI
         E42/0fMhFmo+wlsaGyR2kkqKzg5KYRvuGH5m9SSKEcXACKscULT+zEQqje1cMfJssFEb
         f4qP+43JBF4nOWc8wEQDgAXM+rQqw7SJRctwTTItg0apHA+S9U5N2UUkFClZAAvpkULJ
         MEoYpfIr238GmKeEdnDOU6ZS3CEESrG/unJuwgSHwTji/NSHd4iijsOmazQrIMj0E/nA
         LiUQ==
X-Gm-Message-State: AOAM530vS+thZA2ckAAR0GpR7SAbmnIJsTmGZSLNdx0dNuWJQoECkdO2
        jW1Wzxa1+hd6OMJaTpne97THKg==
X-Google-Smtp-Source: ABdhPJyobG69F9I2fWtiHr9xUh0TsIYXcAcsxJ2A10JAWpRfQlUUMqaD6EgpE9W1LELyCy7x6htK7Q==
X-Received: by 2002:a65:6810:: with SMTP id l16mr9525777pgt.390.1591370800353;
        Fri, 05 Jun 2020 08:26:40 -0700 (PDT)
Received: from [10.110.1.78] ([45.135.186.59])
        by smtp.gmail.com with ESMTPSA id s197sm8002426pfc.188.2020.06.05.08.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 08:26:39 -0700 (PDT)
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
 <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
 <20200604061811.GA28759@gondor.apana.org.au>
 <b23433f8-d95d-8142-c830-fb92e5ccd4a1@linaro.org>
 <20200604065009.GA29822@gondor.apana.org.au>
 <f8dceec5-6835-c064-bb43-fd12668c2dbb@linaro.org>
 <20200605121703.GA3792@gondor.apana.org.au>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <47b747d2-3b27-4f39-85c9-204c2b8a92e1@linaro.org>
Date:   Fri, 5 Jun 2020 23:26:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200605121703.GA3792@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/6/5 下午8:17, Herbert Xu wrote:
> On Fri, Jun 05, 2020 at 05:34:32PM +0800, Zhangfei Gao wrote:
>> Will add a check after the copy.
>>
>>          strlcpy(interface.name, pdev->driver->name, sizeof(interface.name));
>>          if (strlen(pdev->driver->name) != strlen(interface.name))
>>                  return -EINVAL;
> You don't need to do strlen.  The function strlcpy returns the
> length of the source string.
>
> Better yet use strscpy which will even return an error for you.
>
>
Yes, good idea, we can use strscpy.

+       int ret;

-       strncpy(interface.name, pdev->driver->name, sizeof(interface.name));
+       ret = strscpy(interface.name, pdev->driver->name, 
sizeof(interface.name));
+       if (ret < 0)
+               return ret;

Will resend later, thanks Herbert.


