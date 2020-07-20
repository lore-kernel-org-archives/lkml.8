Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09893C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4E72176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPlOgRs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGTItc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGTItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:49:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12591C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:49:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so2116237wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8ClyyvUS1HGIuXRSrIiq2ku06WP9e6Tf1QIkjSm0IU=;
        b=rPlOgRs8A1cyffmJ8kUeZfYxDEGcx+y7fbFetyvIiM0TAkm7guBou08bpgMq+AoLBl
         3Bk5ilX5FXideru3zmSJYZPeMyUz1eOnVHNca001lMBaSPvl+4i5HiZXPb82VCKf9VCF
         w1IHGbe1tK5Z5D1ZJHsGtVen5r+YAtiqGXEDXRxg2n8dqJsD3XPGc2lZnRNfJXimLxRL
         1OQqA1uZEQ6/vSytNMxirgxqlXrXL2YNDo4UIAE5CF+4M6WF/6nYKKwVEH+0feIwAPHY
         5iD1WuLWSCYDwT9Sms510fic8owjy8QVdgg3vgDCIZYT1bCNpuX2hLc7pern0iDH54Q/
         ggGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8ClyyvUS1HGIuXRSrIiq2ku06WP9e6Tf1QIkjSm0IU=;
        b=JDNYBgkimQDw+S8MbBY+zJv2lKIccOMTx8F9zUHo2TXdpLmSiJ3tOpUIwkaFASUdRj
         rRJLEYy9ShGYpOhTp7JXmJ7/AxVMDrZeA5KD3HadpNI7+szxUfk7Iat51n++gd4B2cSk
         ZxNNSos0BOSIWYJVcMAFVPWNjGroslYg/cqGRAbGkTcaZUYx+17Ep21oaJeBsefIQ3dX
         kdG6RM032M5l4ODvu0zUW3LoQhkqJ1Xcse69dqaKBsyujgPmhw9FL2PYEW67WXP8FmrK
         kq6QescMIegnDkjxtVHPD7YDrSGfpPF3Zii42yWacEsRJTMLJmX5z3TpwfwlGfrqOR7c
         TBGg==
X-Gm-Message-State: AOAM531i7pL+K2tQXFa+gxp2N0lWw/025USmD+5ZRw0F+ElHxxB9H+ek
        bfB1ympDmI80EBPhusAHgpOyR+iJi/Y=
X-Google-Smtp-Source: ABdhPJwHNLzn6zy7vKBKFGBocNEVPI4flam0qLvEZ5TaQYlW7qhPWytYzRY1XBWZI2LRGjd2jl24bQ==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr20741378wrs.84.1595234969543;
        Mon, 20 Jul 2020 01:49:29 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k18sm31892822wrx.34.2020.07.20.01.49.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 01:49:28 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] nvmem: qcom-spmi-sdam: Enable multiple devices
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <1594684888-19090-1-git-send-email-gurus@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b6f5edf4-2b1c-349c-d070-ac7bc76af42d@linaro.org>
Date:   Mon, 20 Jul 2020 09:49:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1594684888-19090-1-git-send-email-gurus@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2020 01:01, Guru Das Srinagesh wrote:
> Specifying the name of the nvmem device while registering it with the
> nvmem framework has the side effect of causing the second instance of a
> device using this driver to fail probe with the following error message:
> 
>    sysfs: cannot create duplicate filename '/bus/nvmem/devices/spmi_sdam'
> 
> Removing the name allows the nvmem framework to assign a monotonically
> increasing integer id to each instance of this driver automatically,
> like so:
> 
>    /sys/bus/nvmem/devices # ls
>    nvmem0  nvmem1  nvmem2
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>   drivers/nvmem/qcom-spmi-sdam.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
> index 8682cda..6275f14 100644
> --- a/drivers/nvmem/qcom-spmi-sdam.c
> +++ b/drivers/nvmem/qcom-spmi-sdam.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (c) 2017 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2017, 2020 The Linux Foundation. All rights reserved.
>    */
>   
>   #include <linux/device.h>
> @@ -140,8 +140,6 @@ static int sdam_probe(struct platform_device *pdev)
>   	sdam->size = val * 32;
>   
>   	sdam->sdam_config.dev = &pdev->dev;
> -	sdam->sdam_config.name = "spmi_sdam";
> -	sdam->sdam_config.id = pdev->id;

Please use new flag NVMEM_DEVID_AUTO introduced in 
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/commit/?h=for-next&id=93ac5fdba1eddc679e9694b64f2fa321317df988 
  instead of pdev->id, which should fix the issue.

--srini

>   	sdam->sdam_config.owner = THIS_MODULE,
>   	sdam->sdam_config.stride = 1;
>   	sdam->sdam_config.word_size = 1;
> 
