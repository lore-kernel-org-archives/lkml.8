Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3418C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12222081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM3daYK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLM20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:28:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103AC03E96F;
        Fri, 12 Jun 2020 05:28:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c14so8691348qka.11;
        Fri, 12 Jun 2020 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BwnXafa4LmXGLB71ZYrE45hOUaY6Ry8WpQioJAukJwo=;
        b=tM3daYK/gAR1iS+T2VTFj1FfUq932KVqnJEu6zoTjeHlBb3JPZ1CcFidzqtl77RZGv
         BEiKHtBWAXZYgrnE/bhoawU8XshBmXodLQdTEsyzhOsRw3gem8/WD3QneuFyIBUQJph8
         8PQ/rpLPXwZGwfULK6sgPoIP8fA6Yedb459rN/Fu1IPFVHhrK6M2L1P22gixOnVNk82f
         lqle6nhvtl3PF02YIOuXc+wGQ2gLWzRolYHdZSRg3Z8sM7bFU/rj5hSsgF9aAE0wSx0+
         Qk0nIqtodjqhYYUnriQstY8IUO3KmTjx414v3o9/RfUPWIX/goFbGcVvq7aEjnudcUOH
         7XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BwnXafa4LmXGLB71ZYrE45hOUaY6Ry8WpQioJAukJwo=;
        b=e1t25173tvSRxbZhRj3qGS6PYU3XlD9GjmbdZYjdz1qLHkb55FQwZIBeYpLRlyiWWg
         /dPU5N4uJP0Y+oV04zLBLqVYokhthffCqTO4EaWgW1aFpY1ooGt5IXSgKeRFVfgYBczG
         0DWxaYeZS2SLLNZ5BEe9FfRFHRnXDw9wR9D4ddN818jJ3hebse6K6WE3Ok3la4Pi0gN8
         6JAi6AjPRUTYqT7FDhsFkBNALV/nM+vMdlygNqrRdcP5YNuW+LgWocwx0wRYNWBSssHU
         fQiidhE5NWiZ5w+YxqtjvMblnkmtd/KNTtZVCl1ynuo3yPP2TGgszHErZ1ILMGbP03DW
         6qFw==
X-Gm-Message-State: AOAM532AfpqfXy7XLfkc7MpMhdGAA6IDKjpckj93OKm/NorpoSRlLMvp
        tnOVtBD0d15TSCHfOTt9wLgIOC82kF0=
X-Google-Smtp-Source: ABdhPJwvcSx6JECJEhRXZoRxrBOfrUTYOwVnxOlQVa6Yr+1fad4QCQlU5GdR5k5YIodWz6aXggeRlA==
X-Received: by 2002:a37:e205:: with SMTP id g5mr2713401qki.451.1591964904689;
        Fri, 12 Jun 2020 05:28:24 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id m53sm4776290qtb.64.2020.06.12.05.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 05:28:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] mfd: core: Add OF_MFD_CELL_REG() helper
To:     Lee Jones <lee.jones@linaro.org>, andy.shevchenko@gmail.com,
        michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux@roeck-us.net, andriy.shevchenko@linux.intel.com,
        robin.murphy@arm.com, gregkh@linuxfoundation.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <20200611191002.2256570-3-lee.jones@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6881d95e-c12b-8133-b27c-82c0a2842fd6@gmail.com>
Date:   Fri, 12 Jun 2020 07:28:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611191002.2256570-3-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Frank (me)

On 2020-06-11 14:10, Lee Jones wrote:
> Extend current list of helpers to provide support for parent drivers
> wishing to match specific child devices to particular OF nodes.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/core.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index ae1c6f90388ba..7ce1de99cd8b8 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -14,7 +14,7 @@
>  
>  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
>  
> -#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _match)\
> +#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg, _use_of_reg,_match) \
>  	{								\
>  		.name = (_name),					\
>  		.resources = (_res),					\
> @@ -22,24 +22,29 @@
>  		.platform_data = (_pdata),				\
>  		.pdata_size = (_pdsize),				\
>  		.of_compatible = (_compat),				\
> +		.of_reg = (_of_reg),					\
> +		.use_of_reg = (_use_of_reg),				\
>  		.acpi_match = (_match),					\
>  		.id = (_id),						\
>  	}
>  
> +#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize,_id, _compat, _of_reg) \
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg, true, NULL)
> +
>  #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat) \
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, 0, false, NULL)
>  
>  #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match) \
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, _match)
>  
>  #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id) \
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, NULL)
>  
>  #define MFD_CELL_RES(_name, _res) \
> -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)
> +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, false, NULL)
>  
>  #define MFD_CELL_NAME(_name) \
> -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)
> +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, false, NULL)
>  
>  struct irq_domain;
>  struct property_entry;
> 

