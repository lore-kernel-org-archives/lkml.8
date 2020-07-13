Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C8C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391A320758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="PtgkL3+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgGMSzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:55:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:55:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so12151395iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XP/PixppecPyJeek74vVeXNv27GEoFsZpYZck+u8ljI=;
        b=PtgkL3+JYH7+vY8lGekTR7/pacCYHGwLyTJZMyI9rsFk4j2tKX9G+bdKkplfI2iSGG
         CMxgX1mdmZmhyPhJB9vcZfBBUq0xHj0xRMroXfhsVhnV5kjEouJMEbmFgYwQB6zyUM1U
         oNIutMLpw8Yb6gADT0GnvW3rpPhrK55AHsW5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XP/PixppecPyJeek74vVeXNv27GEoFsZpYZck+u8ljI=;
        b=I/ZoRpRGhQ33GH4PgW19u8J4j9EBOx/HrCIAfj9Psx2qc5WVPemUhqzfyKtxH9JLJf
         kg8CuQLC/BstaEkYsogx6UJrnmPlvAaH2fZfy6VHz8VXwk7Zb1bkue4IdqKjQIXlmAH7
         0VXxOBAmdeFwrYqRGX0GWBnZ0KcoWElobRWha2slldrUPoiw3K//er03gDQVvh61jUTY
         53GDwcSKA/JA+I01wWMx+Aut7gOHV5XFp3EfJFqdiG/ZmPMxpsTIVsxKtsD8/KRuwTv/
         O/ltEtpw0eOILrZyluw0d6RFa2/CW6SIq9Yfg7B9QlIVJ78Tqb2gs565qZbFyl48vKsZ
         JuvQ==
X-Gm-Message-State: AOAM533L4CN47HWwPME3t6UfDXJzAvwDbhegq7ydenMHmUtBG4WjcChB
        8bjMQ1MP5U+X1nEQdApy8PbOLwL7aqI=
X-Google-Smtp-Source: ABdhPJz5rYET9xdYZ11Fp4bKSMiHgHPuc7LkmFRIqrstQwCpKXO0XspSoREBkjI3IW7rPC8sO6jKqg==
X-Received: by 2002:a05:6e02:f42:: with SMTP id y2mr1188594ilj.264.1594666541707;
        Mon, 13 Jul 2020 11:55:41 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 13sm8805387ilj.81.2020.07.13.11.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 11:55:40 -0700 (PDT)
Subject: Re: [PATCH -next] remoteproc: qcom: Add missing slab.h
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200713020003.134039-1-wangkefeng.wang@huawei.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <1c40a878-bd3b-8364-3bc4-ef3f2b75edbf@ieee.org>
Date:   Mon, 13 Jul 2020 13:55:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713020003.134039-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 9:00 PM, Kefeng Wang wrote:
> drivers/remoteproc/qcom_common.c: In function ‘qcom_ssr_get_subsys’:
> drivers/remoteproc/qcom_common.c:210:9: error: implicit declaration of function ‘kzalloc’; did you mean ‘vzalloc’?
> [-Werror=implicit-function-declaration]
>   info = kzalloc(sizeof(*info), GFP_KERNEL);
>          ^~~~~~~
>          vzalloc
> 
> kzalloc() is declared in linux/slab.h, add include to fix build issue.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/remoteproc/qcom_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 2f45f0c79914e..085fd73fa23ae 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -15,6 +15,7 @@
>  #include <linux/remoteproc/qcom_rproc.h>
>  #include <linux/rpmsg/qcom_glink.h>
>  #include <linux/rpmsg/qcom_smd.h>
> +#include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  
>  #include "remoteproc_internal.h"

You beat me to it.  I just build-tested this fix on linux-next/master
and can confirm the build fails without it, succeeds with it.

					-Alex

