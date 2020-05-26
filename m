Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B537C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1816A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ln9sdbUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbgEZLr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388554AbgEZLrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:47:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F39C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:47:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so7631121ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hJWyNDI0dfOMiXPBsmO+dJ6NmJrMxzXQ5Ah4k+Qs48w=;
        b=Ln9sdbULjWwPzlacZB8rZ6PRBCoMN35xWcPIhFiVHRN+l+p5kz033Lg4NZbcE9qlSC
         8/8I1bJPinluxO1gQSp4mVEi7GJeMgX6NS8doJOdA/HFrCChbWzfg0DDlLAFYo19MK2T
         oQ71pbogTkXQvYihDrqpUBUsdiI8WTR+CTNfdY2BCdZQxYRGic3AAf/GBLVJ4kWXSXzP
         mv+Q1/lQ778qIFZm7oL7XykcUCYX0NONhMYNIKn924VyhMy8e3N0kXZdQxaz71qslH/8
         G6g79t7cfjrCF9Z3AZUsup+qMxxavvIC19G/oIMhkgEj4J8fUkleuEd29ZVR0Ui2ImWu
         wfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hJWyNDI0dfOMiXPBsmO+dJ6NmJrMxzXQ5Ah4k+Qs48w=;
        b=G5Raq6LmhygDu+Gc2qXULOz/X7iiw/sloqMCMJPNdbLjER0E3/gxDEUD287RGGtUv/
         iztxcZH6jzQI50grB+cq+tHozj8SMcNv6zO9WRu0vlKoQemcJNg/y0jJ4XoCfZgWIgdr
         YwK2Xkep/UfCQFJjnIFaDy6aoGhZe0zab3SIlcza9OXfXktn90Z1llbyXgyxc1BpGS82
         Up7pJGJkpbIPCW/CeYRqn8VLtyF58wcxZRaMVWPxCtFq3RLboYLlZB4k368mLLmq0iK2
         gd0Bb3vP3BWCUdpdHLZZkaaFKarZJPMUt55F1GG6fTjZHyaICwD77Wx/hnB4PZLo4lZi
         cU9g==
X-Gm-Message-State: AOAM533zGQ9FZWGK4ahycc9T+BT3MdZZxzgVm+LOSychYGZUbdLENm+N
        ZVyjMXcBF3eJ1Y330wgjvVkRkA==
X-Google-Smtp-Source: ABdhPJy0M+WccaWArZBw7Fw3A9iFpuwKZUZ+p5F5jSHlp7eANhyKNnAqMHBtfFpufyqF/l/67UYxdg==
X-Received: by 2002:a02:948e:: with SMTP id x14mr557913jah.3.1590493663850;
        Tue, 26 May 2020 04:47:43 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v76sm11165378ill.73.2020.05.26.04.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 04:47:43 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] staging: greybus: loopback: fix a spelling
 error.
To:     Till Varoquaux <till.varoquaux@gmail.com>,
        kernel-janitors@vger.kernel.org, pure.logic@nexus-software.ie
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        trivial@kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20200518051314.1785567-1-till.varoquaux@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <3f610a0c-fb15-e929-0f94-447f732659a0@linaro.org>
Date:   Tue, 26 May 2020 06:47:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518051314.1785567-1-till.varoquaux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 1:10 AM, Till Varoquaux wrote:
> Successed -> succeeded.
> 
> Signed-off-by: Till Varoquaux <till.varoquaux@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/loopback.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 583d9708a191..2471448ba42a 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -135,7 +135,7 @@ static ssize_t name##_##field##_show(struct device *dev,	\
>   			    char *buf)					\
>   {									\
>   	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	/* Report 0 for min and max if no transfer successed */		\
> +	/* Report 0 for min and max if no transfer succeeded */		\
>   	if (!gb->requests_completed)					\
>   		return sprintf(buf, "0\n");				\
>   	return sprintf(buf, "%" #type "\n", gb->name.field);		\
> 

