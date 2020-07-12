Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9732CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E23B206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAUkLktO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgGLSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbgGLSGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:06:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79653C061794;
        Sun, 12 Jul 2020 11:06:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so10767591wmf.0;
        Sun, 12 Jul 2020 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXIYGf7nKP36lUXjPoJamlUt3MsApH6KmL+wKFQttL0=;
        b=CAUkLktOBjEigcVSb5JNR+sboa7yimUHhD+N1nwWEE7TinAlC7ZJNpGfHK9TKMEE9l
         0cFr2gf3pQ/bimZ8PBmiV4spwFLh9Iw1RO9rBcG7PFxWiFLYEPaPpCXAR/N4mc2dgcWB
         tHCvoTJjzayOYqRC+WHHKpHlV4KrlUOlE88MtiGizREsb82J64QBr19uwQSN3z1M+FG/
         Y1DxrB1lza/XDpoPjGgx4mOPJo6Spw3wTZgDtkYXXk8xppsrnxOQwrrSv7ubg5G92EFa
         JRordYRXyQn25uLMcRP1ElTewWOqgggYgqRIBY6UWLtlTGtUn4j7sdy8qAdRtdv5ZVrs
         W+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXIYGf7nKP36lUXjPoJamlUt3MsApH6KmL+wKFQttL0=;
        b=iofWVueEjgXHZ8vD9f7Tk0TEKQVkosuVzekrdWyT/Vs9rmuX9YOkGUDS0+Nv25V4OV
         0ScJKD2JalS2ZqJsU1uvLGTQlUrZ/qKcPlz8DjFy5xKZb/w7rI/7HdHv3wgE191CCEO4
         UZd7aYu5og/E24Z+5MtMPe3oVdbMfbSYQHgr5rAF9zpnqymmc61F9rzrWezRG8HHg/E6
         kJ8eQksj5SH18JkQ7d+ayUdkIn/OFpw8p9guJtsxOGgTC1CMYyrh63/nKvqdg3WXtNbu
         lY4nR6I55oVk5DTHh/xzbfgHV0TPjSNw+L/GImhZI3A6eblQBn3gg8GbI5yBgohhatjf
         MbuQ==
X-Gm-Message-State: AOAM533l4aYc8HEiwgWrZhEbDdUTWmY14hKr8MsdRHz6dfaUKId6FOCd
        HoxDtcYo4EDwqQ7Ij+yJC6k=
X-Google-Smtp-Source: ABdhPJzOUmPXUmNbjdA7jZ/Qn0aHiRAOlQ80hzDT623yYWJX8GnjOzvPMH7bEVZ6XQEHalOXvPDCZg==
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr15866960wma.181.1594577180061;
        Sun, 12 Jul 2020 11:06:20 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id j6sm20823362wro.25.2020.07.12.11.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 11:06:19 -0700 (PDT)
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        ming-fan.chen@mediatek.com
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-2-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9e21288c-07da-88b0-2dbb-bd9a2a4d529b@gmail.com>
Date:   Sun, 12 Jul 2020 20:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200711064846.16007-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2020 08:48, Yong Wu wrote:
> Put all the macros about smi larb/port togethers, this is a preparing
> patch for extending LARB_NR and adding new dom-id support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
>   5 files changed, 19 insertions(+), 4 deletions(-)
>   create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> 
> diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
> index 6f9aa7349cef..b6b2c6bf4459 100644
> --- a/include/dt-bindings/memory/mt2712-larb-port.h
> +++ b/include/dt-bindings/memory/mt2712-larb-port.h
> @@ -6,7 +6,7 @@
>   #ifndef __DTS_IOMMU_PORT_MT2712_H
>   #define __DTS_IOMMU_PORT_MT2712_H
>   
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			0
>   #define M4U_LARB1_ID			1
> diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
> index 2ad0899fbf2f..60f57f54393e 100644
> --- a/include/dt-bindings/memory/mt6779-larb-port.h
> +++ b/include/dt-bindings/memory/mt6779-larb-port.h
> @@ -7,7 +7,7 @@
>   #ifndef _DTS_IOMMU_PORT_MT6779_H_
>   #define _DTS_IOMMU_PORT_MT6779_H_
>   
> -#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			 0
>   #define M4U_LARB1_ID			 1
> diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
> index 9f31ccfeca21..d8c99c946053 100644
> --- a/include/dt-bindings/memory/mt8173-larb-port.h
> +++ b/include/dt-bindings/memory/mt8173-larb-port.h
> @@ -6,7 +6,7 @@
>   #ifndef __DTS_IOMMU_PORT_MT8173_H
>   #define __DTS_IOMMU_PORT_MT8173_H
>   
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			0
>   #define M4U_LARB1_ID			1
> diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
> index 2c579f305162..275c095a6fd6 100644
> --- a/include/dt-bindings/memory/mt8183-larb-port.h
> +++ b/include/dt-bindings/memory/mt8183-larb-port.h
> @@ -6,7 +6,7 @@
>   #ifndef __DTS_IOMMU_PORT_MT8183_H
>   #define __DTS_IOMMU_PORT_MT8183_H
>   
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			0
>   #define M4U_LARB1_ID			1
> diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> new file mode 100644
> index 000000000000..2ec7fe5ce4e9
> --- /dev/null
> +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + */
> +#ifndef __DTS_MTK_IOMMU_PORT_H_
> +#define __DTS_MTK_IOMMU_PORT_H_
> +
> +#define MTK_LARB_NR_MAX			16

include/soc/mediatek/smi.h has the very same define.
Should smi.h include this file?

Regards,
Matthias

> +
> +#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
> +#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
> +
> +#endif
> 
