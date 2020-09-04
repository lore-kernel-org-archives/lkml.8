Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA601C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7BE208B3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZd50ylc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgIDLFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgIDLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:02:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB97C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:02:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so5672903wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NfwkNFk09ZusBLOpLBTzQZi+H+vFvkYJED/TT3XgJYw=;
        b=JZd50ylcdwr2PHwgwiiaZbZPtEwrGD9obMYXTwpZhmQPv/Lx0wB5KCsEfKIKGKv7ni
         S0TL0ck/MMQKYiuWElIRT0D4FGT8AJ6zDeu2mMpdm1mzf3FKDmAceMkHYdmQSn8OZkVU
         WYCL/bNmxjKSpU0YjiDiqFJzwHDIW/8oA5YwGb35qTuWFWL3pnnL8DMK/lfPXFqmR8VS
         Ge1jpfi/BDhBGpau/jZqgYHFBjpUo9RWBh3BL2x+X46DPjOzmrYEWUWRK0GxHH6Ms5W7
         XFO5XIpa4Y+4vtV2ytbTIiJKpkEbXF5SWJIeHjMpt7rIXEPmKV+g5tU55WRpK3AT+OZV
         cDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NfwkNFk09ZusBLOpLBTzQZi+H+vFvkYJED/TT3XgJYw=;
        b=cQciu1Pry6FwnRNGd9qF7/SstbZpISgHe82aPMOgksPZ+APGXYRa8tdv1E1rhN6pTj
         GptSV4YF6BOvvldy9rNUVQD5qtSP84ptR4AAyLChM51HzSWzkAat1T2Vc+b5RvruhZCN
         S1rQwE0VXZ4mhd4lIyqTAAjgkyhzcwIPb8W5wH4CSmDcBWIPEIm/tv2FGv47pD4dhTmQ
         FPPSZHk7Bs3JQyb3ScxnJVUL5jRkaWFGBiV2qD4UYQC+WdYhjNSjNybmfGBM12Yb6byy
         QCdsZJxGx2Dgp6gRFouv/vuUtvArSWGMSnpXEacH6qWsSQGk85xcRSgNS1tIQ74KWaHG
         T9Hg==
X-Gm-Message-State: AOAM533PDGldxdVIg4o4lzqllZBibQFrQ+F5B8AbeprLB830vMIVXbRe
        wzP36ipwI7nlHC1is5ux9FFligiFlCBYLA==
X-Google-Smtp-Source: ABdhPJyDXc07W9KvlQK9EHpFRFv+t6KZPHfDW0yXqRKut/IryH4+skf+lxaDkSbM+QVtkaGdqqxNog==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr7475012wmf.26.1599217362207;
        Fri, 04 Sep 2020 04:02:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id a127sm10514447wmh.34.2020.09.04.04.02.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:02:41 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] nvmem: core: allow to register cells during nvmem
 registration
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200831015539.26811-1-vadym.kochan@plvision.eu>
 <20200831015539.26811-2-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6ab47f55-af66-f035-d8d9-82d0c831b5b8@linaro.org>
Date:   Fri, 4 Sep 2020 12:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200831015539.26811-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

Thanks for the patch,
On 31/08/2020 02:55, Vadym Kochan wrote:
> Add NVMEM_PRE_ADD notification step which is called before any cells
> binding - from lookup table or config, this allows to register cells
> in some specific layout (tlv) which should be parsed first and then
> registered. So there might be a cell parser driver which can register
> lookup table during this notification step.
> 
This is going in right direction but totally not correct way to do it.

1> this is not scalable as any consumer that will register for this even 
will have no idea of which what kind of parsing that provider needs.
It can work in your case but not really useful.

2> this is a consumer API, not the provider api.

How about adding a "parse_cells" callback in struct nvmem_config along 
with encoding type.


thanks,
srini

> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v3:
>      1) Update core.c changes by extending notification mechanism
>         by adding new NVMEM_PRE_ADD event id which is called before lookup
>         table cells binding, this allows for notification handler to
>         register cells which require nvmem parsing.
> 
>   drivers/nvmem/core.c           | 2 ++
>   include/linux/nvmem-consumer.h | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..c48a69e0ebbe 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -668,6 +668,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   			goto err_device_del;
>   	}
>   
> +	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_PRE_ADD, nvmem);
> +
>   	if (config->cells) {
>   		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
>   		if (rval)
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 052293f4cbdb..0f7107276756 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -50,6 +50,7 @@ enum {
>   	NVMEM_REMOVE,
>   	NVMEM_CELL_ADD,
>   	NVMEM_CELL_REMOVE,
> +	NVMEM_PRE_ADD,
>   };
>   
>   #if IS_ENABLED(CONFIG_NVMEM)
> 
