Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A196EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753C420720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXB05T+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGMUWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:22:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52589C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:22:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so1223674wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Un7dCCnkxcZsvwr/aTPovVdtJrLxmvJRKWCcD5TCwew=;
        b=lXB05T+wtWcVmb/ToU2CDb7Jolp2Phtrkp863Dkj50ce4afhbb2DtrWXSd5dr/XFRq
         6HlKu2bvqEwgfLU17lzzcRQTDW/YGm7udhfknmHh7XM5KM1yfQgFF7S8V4BDeVOY4rX5
         uVwyQCLgcU6NojcJ8v9hq0eljOvV6jXz9bs863Acsp/S7slXIwt17eJm4Raw0KacFweq
         t+CCbHbnXXQ9uC/a5l/Xjl6lIYAWeKgSEFwuCRIbL/l33ANQ6BFbfgqHlf0uovajE5Yk
         WhNxww3SS9gsftVAA2xX5NB3UIkh5rza4YLB0xwxKF6Fc8QYl2YHRrE09hE7tIAuEUOb
         FP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Un7dCCnkxcZsvwr/aTPovVdtJrLxmvJRKWCcD5TCwew=;
        b=P1i58UUTPgAJ66b43NhB276+gfjOODEP+F7U/oLd5oJOq09xH7xtYSNhYA/LwO8+fq
         cFK73p8DlGGBs+kOrOQ+COm1RwD7XORG0TrG5EZ4Ca7ZYMpdvBoIKXIy2YHKRwNNy3Ql
         UMcRqmnYJb3unzNTrpy9Vx77xuOsG94J3SMfCrg34/Vj1AqyXv4cvCbsSGP3KXaNvOwS
         kTorzKsochnI4goYFgAY4y0fE1ViLVzveKs0Xrck8JEu7grqX+1zMzdGw5q8lAHEsfrK
         wdfmj5JUzJtDISTKcQtIIQf9zoISGdJqgw0w5XfKlnLIhABgegdsIGbU9nARGX2q7CPm
         QHiA==
X-Gm-Message-State: AOAM531Lq0aNfhLqzV96jxFA0tw7wXD4BnpzWwMuj+1nBXCNm9Xxw5Ql
        vsS3zxiJnnJSwM/7MJg87w0=
X-Google-Smtp-Source: ABdhPJwb4tLfgGCNFfgqcCjcbJr/U2aVoM5vrdZp/oSZZm+oTjo0hS+XhLTRGDICUWQLSdI57bQ8cQ==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr1092698wmj.20.1594671733950;
        Mon, 13 Jul 2020 13:22:13 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id f17sm1076862wme.14.2020.07.13.13.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 13:22:13 -0700 (PDT)
Subject: Re: [PATCH] iommu/mediatek: Include liunx/dma-mapping.h
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
References: <20200713101648.32056-1-joro@8bytes.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <151352ff-d518-174a-9601-1cffc212d008@gmail.com>
Date:   Mon, 13 Jul 2020 22:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713101648.32056-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2020 12:16, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This fixes a compile error when cross-compiling the driver
> on x86-32.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 6ff62452bbf9..122925dbe547 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -15,6 +15,7 @@
>   #include <linux/iommu.h>
>   #include <linux/list.h>
>   #include <linux/spinlock.h>
> +#include <linux/dma-mapping.h>
>   #include <soc/mediatek/smi.h>
>   
>   #define MTK_LARB_COM_MAX	8
> 
