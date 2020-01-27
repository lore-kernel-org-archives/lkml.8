Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20791C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FD82071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAfCmObL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgA0OJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:09:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53718 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbgA0OJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580134159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0tWyHYw98UjELXx0eG2rBwfSBPRrMQ58+BFQIrIctE=;
        b=MAfCmObLREFeUWQ58a7yHZ2t1RnNL9DcZAWrDHMCe8NCJbWM3P2p9raSXgVSIp7rCyfEcs
        Jtp7RKZ0dkaHXzrRLLz/BbbK4TXdgsxruKUXnmpCTI8EEuZtGgeDuqWiFzykL1XNe6x0VC
        /kFdsRYAuf/R4UU7N5wy8MiUoFWVI8E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-XxCQfPQ_Pbi78YV_NY45Ig-1; Mon, 27 Jan 2020 09:09:17 -0500
X-MC-Unique: XxCQfPQ_Pbi78YV_NY45Ig-1
Received: by mail-wr1-f71.google.com with SMTP id z15so6171858wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0tWyHYw98UjELXx0eG2rBwfSBPRrMQ58+BFQIrIctE=;
        b=rdLr36tNOCRmIN6P8XVFa0rUAZQcXg/9HvRiQPyBC6TGbG2GcAOD6QjrMDu0jquz2S
         GbJla+hP4h1T6Slv8s6opX6XcxhirF+AYys3psLd1zpzHy0b3RvQ27b8VUvD9oiLicJi
         gU6y9ApwnLaclX7uGbmdJiMmrqhUV2kBGQMuH+dJM5Qq4lQVNqwH74shW3V0E96EGJPM
         ug6tk0CRGoNLAPcTExttw/rItmtI+yz3TLdj04vD0gD2gulWwxvAtt0/G1593QEW2AXU
         0frNoX3HttN8555m3fnYAi0ivB/TG0vKloPATIeh6QQbMdix2w/L9/aDl7bmBLbF7K3J
         0Lpg==
X-Gm-Message-State: APjAAAXFw+8+vfW0p3ezbrIko2iaCD+7lWlwQ3UA/uNs6MouGey5l92m
        Sds0nBkTYOQXwZUCCAdBZWySW5Fjp4kRGHYO9zX0gqqbMhLrHH3LUUMUl9bdv4tS81cAmYaE15n
        1gPUu7BJo7TWWLxf41l5ncUpb
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr13430013wme.141.1580134155794;
        Mon, 27 Jan 2020 06:09:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxL1mkRTXScdallzJa6atatfMWFPsRST+u2+CId8f49QKDBROlfW8LGzAMTi5X6FzaKHo4AVQ==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr13430001wme.141.1580134155613;
        Mon, 27 Jan 2020 06:09:15 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x11sm19143881wmg.46.2020.01.27.06.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 06:09:15 -0800 (PST)
Subject: Re: [PATCH] staging: rtl8723bs: fix copy of overlapping memory
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200126220549.9849-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <32254b45-be59-a83b-0036-6a6d9fe86379@redhat.com>
Date:   Mon, 27 Jan 2020 15:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126220549.9849-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 26-01-2020 23:05, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the rtw_sprintf prints the contents of thread_name
> onto thread_name and this can lead to a potential copy of a
> string over itself. Avoid this by printing the literal string RTWHALXT
> instread of the contents of thread_name.
> 
> Addresses-Coverity: ("copy of overlapping memory")
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index b44e902ed338..890e0ecbeb2e 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -476,14 +476,13 @@ int rtl8723bs_xmit_thread(void *context)
>   	s32 ret;
>   	struct adapter *padapter;
>   	struct xmit_priv *pxmitpriv;
> -	u8 thread_name[20] = "RTWHALXT";
> -
> +	u8 thread_name[20];
>   
>   	ret = _SUCCESS;
>   	padapter = context;
>   	pxmitpriv = &padapter->xmitpriv;
>   
> -	rtw_sprintf(thread_name, 20, "%s-"ADPT_FMT, thread_name, ADPT_ARG(padapter));
> +	rtw_sprintf(thread_name, 20, "RTWHALXT-" ADPT_FMT, ADPT_ARG(padapter));
>   	thread_enter(thread_name);
>   
>   	DBG_871X("start "FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
> 

