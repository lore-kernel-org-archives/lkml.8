Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8710AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D902206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="WiYbM4h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgEZAt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 20:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbgEZAt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:49:27 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AFAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:49:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d5so10739625ios.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RHJSEQQqFmacVkUUYEKAcfpyXdL48BU5I7X+E5oQabw=;
        b=WiYbM4h6yCu60pRN6wUHwSZWynJZnYM5H1Let/yPVswblYW+HIc/1D7uBKxjczuVaZ
         D8K0Ijafy6HQ65tDfzxAXdR+V02Uaw2liDGZXN4ViJrREKKHnXFCUhfBpQzAVersnAsR
         J8tlPmVq+onTrtiKEM7xDZWjyj751x5VXX52Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RHJSEQQqFmacVkUUYEKAcfpyXdL48BU5I7X+E5oQabw=;
        b=gDhM1Vy8rUyPEHhjhaWMAGlg5yxBwfkCKbTp8ZoEpoPpitmJW7JTCk9RIU69/WFCKL
         abUz0DzPymoJW1lt4jCj7oaarH/EV1l3Bh7DsU6M1O75AY5PJ6zecLNxQ/hdZSzWELdx
         CtiFfCswGHZJKvGDGu5h89cJACLPg4VvNQ2bF2iocXiz4ieO4dgQI7fKYCbkvv/Om8zv
         2j55Zf+llWus++t7RXMhmw2zyfP2E7WdoMfHogZaZHOKvMJofrKvvps/y9RxAhMdqUEc
         B1T3u9jXd9hj8WKFI1V+dPVMgeIc0id6XE40skTiPM3CwImIJYodbqS3q8t1z4w1sW2O
         AjCA==
X-Gm-Message-State: AOAM530upcka8AXbnW4NHLMHlHwMXRAaBO1OHNljLKisd/LFMJcoIn4o
        HcTEWOec07kcEX6iXSTv3Qiy2g==
X-Google-Smtp-Source: ABdhPJxa21c1jpBSQzGy2G76zxrTakRZjOEyN2VaSrR8biVlpkBPhWQRd3aYx6jFhmeFbDKtp7r1xg==
X-Received: by 2002:a02:6243:: with SMTP id d64mr21068167jac.135.1590454166634;
        Mon, 25 May 2020 17:49:26 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id m5sm2588115ioj.52.2020.05.25.17.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 17:49:25 -0700 (PDT)
Subject: Re: [PATCH] drivers: ipa: print dev_err info accurately
To:     Wang Wenhu <wenhu.wang@vivo.com>, davem@davemloft.net,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200525062951.29472-1-wenhu.wang@vivo.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <75dd9de2-c8a8-945a-fb14-26c3c6044bb6@ieee.org>
Date:   Mon, 25 May 2020 19:49:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525062951.29472-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 1:29 AM, Wang Wenhu wrote:
> Print certain name string instead of hard-coded "memory" for dev_err
> output, which would be more accurate and helpful for debugging.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> Cc: Alex Elder <elder@kernel.org>

Good idea.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/net/ipa/ipa_clock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
> index ddbd687fe64b..749ff5668e37 100644
> --- a/drivers/net/ipa/ipa_clock.c
> +++ b/drivers/net/ipa/ipa_clock.c
> @@ -66,8 +66,8 @@ ipa_interconnect_init_one(struct device *dev, const char *name)
>   
>   	path = of_icc_get(dev, name);
>   	if (IS_ERR(path))
> -		dev_err(dev, "error %ld getting memory interconnect\n",
> -			PTR_ERR(path));
> +		dev_err(dev, "error %ld getting %s interconnect\n",
> +			PTR_ERR(path), name);
>   
>   	return path;
>   }
> 

