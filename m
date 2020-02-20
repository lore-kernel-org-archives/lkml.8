Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470DC11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC3E2071E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBS2FZQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBTLaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:30:14 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38484 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgBTLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:30:13 -0500
Received: by mail-wm1-f43.google.com with SMTP id a9so1651389wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 03:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+wRZx4HxDGTrVX8tv8l+pZ7aBqy+ZodwSNXn/rcfps=;
        b=TBS2FZQFdHQPJBKBayU/HF0d9fN58NVtxR1uvO2bBvuGfmJHWTdzf4F8/iWhU0C/M+
         qj7GLIUhnf7C6Dt0m6c6iI+cHl3kLZYOWUmzvMAJAnyvsJDkyzv0yInsSVCtM0rXYfDy
         OSUxFfQhGUluetVlrC/qNNSWkrbj2x/zQ+L05Utnguig/Sp+sVDyx9TJpPJPZvrTjV8o
         vIW4YXD6a2TATYcQ0WVoZRgvKC2v6h5MJ5ceR/BTYuVpjLWkWwa/4weTuZaRiBvP2UT0
         P3/uoYWu7xJDl0Twd9SrPjMxNgiOAWDCTBLeZAl9EPFCZtkVWnKsJkMAqKaqX1FDutev
         sAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+wRZx4HxDGTrVX8tv8l+pZ7aBqy+ZodwSNXn/rcfps=;
        b=h1YJx38ylmF+FHgDvll4MweTHfDSA/XiseaG9vy7Sepz/UMcJ6NBzuvP0cj2QTv1dA
         2SsG3lbigbcaS4kZK94FzihWRcc6JtxR1gZXs1EDBbjujVdr/vmCXcrkzUhQ3180WXl0
         /Y4FDvjQUq/YjbPM3c65lx7jOr+TV0EpElD7vfblezyMo2B7GnIrIFMw9AbuIb1oAcMj
         B7qa5W/wnrTq2mCqQpR0xn8uqmvcsGU89yRSKg8QTsaAL+KJW7uH17JjqNY06RcirPUv
         RSxeJ7G2O5Vcm6ngE9dUrKt3oVqNwB/3K84S5+zoGfC3x3uKi4ny0WQq2WjNh54DnVXW
         zhOQ==
X-Gm-Message-State: APjAAAUsCqrV3MBu4t9qQKA8z/PjtXXRQwFZacsPnB3UqRVi/Ezz3FHk
        0n/isC69VOMUtQMXqrnXT3mXIA==
X-Google-Smtp-Source: APXvYqy9H3lwec8NoP9aUfbOc8xjm7ISPsnPY/kONVwgoe/MCMLyW08pjlXYrLYRa2DBeQz1u+A1lw==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr3937616wma.24.1582198211821;
        Thu, 20 Feb 2020 03:30:11 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a9sm3997907wmm.15.2020.02.20.03.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 03:30:10 -0800 (PST)
Subject: Re: [PATCH v4 1/4] nvmem: fix memory leak in error path
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200220100141.5905-1-brgl@bgdev.pl>
 <20200220100141.5905-2-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <965f715c-a714-00df-b496-a586969dd086@linaro.org>
Date:   Thu, 20 Feb 2020 11:30:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200220100141.5905-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2020 10:01, Bartosz Golaszewski wrote:
> -	if (IS_ERR(nvmem->wp_gpio))
> +	if (IS_ERR(nvmem->wp_gpio)) {
> +		ida_simple_remove(&nvmem_ida, nvmem->id);
> +		kfree(nvmem);
>   		return ERR_CAST(nvmem->wp_gpio);
You freed nvmem just before this statement, how can nvmem->wp_gpio be 
still be valid?

Are you able to test this changes at your end?
Or
these are just compile tested?


--srini


> +	}
>   
