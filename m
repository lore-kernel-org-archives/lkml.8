Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378522080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcbiaOAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGTJFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:05:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:05:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so17069843wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lbt2NZjVgJVbHyKKlO7Y0VLphzLwIFCRX5v5V2YxWak=;
        b=GcbiaOAeBe2tPvviFsXR8H7kc2sKKC2sByRKGmzpKpbaNeTqrWq32Rr8wArek+2iDk
         la+0PONHXk5//Se4I35qyfV9AutlwpTNgxNaDYZM7CQNFu9tThP1OtuMJ5Qog1fkqmR8
         spg5cOgGvNjotGhBN5/mf+RSFOe9G9ix87MXOXZx1QG3Q9QgeTQ6j2Scuxs2/bosx6G1
         JbzHbMFCr3lLz34arqsGcHcYIzrsENRpJPrqGPtADvVUBDp13mOaxB97Fr0aTJ3ZLnRK
         eo/xTr2KyMWi5I6vL/FYy28MCCD4PgdHd9XT17E8maWZ0fNrhdGaWBqh+yN5JtyMQRQX
         Wzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lbt2NZjVgJVbHyKKlO7Y0VLphzLwIFCRX5v5V2YxWak=;
        b=LkXohKeOarke2jMrKcT9wYdBXJRI+gIFs0FAl7ypX+eaFVZmUFqvN9TPJYlcyxABnM
         4alsF5O1SOkl5TyQKlXvf6+Vg+jCdjizdIQy98AmEIh6+AZFJidTTMzklAOE+8fAHSXM
         4SH0aWh7bFsJO0wcLe/dYLTEiT3z42rnBSTAgCI1ePWQJXmFVsIp/nhT3epyfKIJANMz
         q4mlZBXYV42HgK03Fga/O+XW9IqXUSLYbPJ14OrBApgV9QlNFUSdgQNlgOW/IpnHMQev
         awb5A5Ce0DKuYDCNIAc7v2C0UyJ/42z9mGK5jrZCkfxDS4IKV2iQueD6Qkzp3DQACV1M
         8Hxg==
X-Gm-Message-State: AOAM532sOT/YJKYtLedW9CjDMr4SiSkkB4FW7XhlMeO3TqEBfEjvhul8
        kyqs/rJT/VUuJT61tbLeZbdDBE21Qrc=
X-Google-Smtp-Source: ABdhPJxgK5q+APJlgm/OA/uKJaq+smok1QGy1u0RKZZbMaozV0iP2lnDgDAuO9QMgCyBwZ0kv1osag==
X-Received: by 2002:adf:82b2:: with SMTP id 47mr4940896wrc.17.1595235950876;
        Mon, 20 Jul 2020 02:05:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s203sm32961639wms.32.2020.07.20.02.05.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 02:05:50 -0700 (PDT)
Subject: Re: [PATCH] nvmem: update Kconfig description
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
References: <20200717123527.26291-1-mcroce@linux.microsoft.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <59f157d5-1978-6309-37f1-99e9e79c7672@linaro.org>
Date:   Mon, 20 Jul 2020 10:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200717123527.26291-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/2020 13:35, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> nvmem can't be built as module anymore, update its Kconfig description.
> 
> Fixes: 2a37ce25d9f2 ("nvmem: disallow modular CONFIG_NVMEM")
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Applied

thanks,
srini

> ---
>   drivers/nvmem/Kconfig | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d7b7f6d688e7..954d3b4a52ab 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -7,9 +7,6 @@ menuconfig NVMEM
>   	  This framework is designed to provide a generic interface to NVMEM
>   	  from both the Linux Kernel and the userspace.
>   
> -	  This driver can also be built as a module. If so, the module
> -	  will be called nvmem_core.
> -
>   	  If unsure, say no.
>   
>   if NVMEM
> 
