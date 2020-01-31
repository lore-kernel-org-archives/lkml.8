Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF2C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1736F20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgAaGiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgAaGiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 01:38:54 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08DF2082E;
        Fri, 31 Jan 2020 06:38:51 +0000 (UTC)
Subject: Re: [PATCH] m68k: configs: Cleanup old Kconfig IO scheduler options
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20200130192520.3202-1-krzk@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <1c7ff9f2-f3fe-ad04-e660-c0e1796280a1@linux-m68k.org>
Date:   Fri, 31 Jan 2020 16:38:49 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130192520.3202-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 31/1/20 5:25 am, Krzysztof Kozlowski wrote:
> CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
> commit f382fb0bcef4 ("block: remove legacy IO schedulers").
> 
> The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
> now enabled by default (along with MQ_IOSCHED_KYBER).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, I will apply to the m68knommu git tree (for-next branch).

Regards
Greg


> ---
>   arch/m68k/configs/amcore_defconfig   | 1 -
>   arch/m68k/configs/m5208evb_defconfig | 2 --
>   arch/m68k/configs/m5249evb_defconfig | 2 --
>   arch/m68k/configs/m5272c3_defconfig  | 2 --
>   arch/m68k/configs/m5275evb_defconfig | 2 --
>   arch/m68k/configs/m5307c3_defconfig  | 2 --
>   arch/m68k/configs/m5407c3_defconfig  | 2 --
>   arch/m68k/configs/m5475evb_defconfig | 2 --
>   8 files changed, 15 deletions(-)
> 
> diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
> index d5e683dd885d..3a84f24d41c8 100644
> --- a/arch/m68k/configs/amcore_defconfig
> +++ b/arch/m68k/configs/amcore_defconfig
> @@ -13,7 +13,6 @@ CONFIG_EMBEDDED=y
>   # CONFIG_SLUB_DEBUG is not set
>   # CONFIG_COMPAT_BRK is not set
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   CONFIG_M5307=y
>   CONFIG_AMCORE=y
> diff --git a/arch/m68k/configs/m5208evb_defconfig b/arch/m68k/configs/m5208evb_defconfig
> index a3102ff7e5ed..0ee3079f6ca9 100644
> --- a/arch/m68k/configs/m5208evb_defconfig
> +++ b/arch/m68k/configs/m5208evb_defconfig
> @@ -10,8 +10,6 @@ CONFIG_EXPERT=y
>   # CONFIG_VM_EVENT_COUNTERS is not set
>   # CONFIG_COMPAT_BRK is not set
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   # CONFIG_4KSTACKS is not set
>   CONFIG_RAMBASE=0x40000000
> diff --git a/arch/m68k/configs/m5249evb_defconfig b/arch/m68k/configs/m5249evb_defconfig
> index f7bb9ed3efa8..f84f68c04065 100644
> --- a/arch/m68k/configs/m5249evb_defconfig
> +++ b/arch/m68k/configs/m5249evb_defconfig
> @@ -10,8 +10,6 @@ CONFIG_EXPERT=y
>   # CONFIG_VM_EVENT_COUNTERS is not set
>   # CONFIG_SLUB_DEBUG is not set
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   CONFIG_M5249=y
>   CONFIG_M5249C3=y
> diff --git a/arch/m68k/configs/m5272c3_defconfig b/arch/m68k/configs/m5272c3_defconfig
> index 1e679f6a400f..eca65020aae3 100644
> --- a/arch/m68k/configs/m5272c3_defconfig
> +++ b/arch/m68k/configs/m5272c3_defconfig
> @@ -10,8 +10,6 @@ CONFIG_EXPERT=y
>   # CONFIG_VM_EVENT_COUNTERS is not set
>   # CONFIG_SLUB_DEBUG is not set
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   CONFIG_M5272=y
>   CONFIG_M5272C3=y
> diff --git a/arch/m68k/configs/m5275evb_defconfig b/arch/m68k/configs/m5275evb_defconfig
> index d2987b40423e..9402c7a3e9c7 100644
> --- a/arch/m68k/configs/m5275evb_defconfig
> +++ b/arch/m68k/configs/m5275evb_defconfig
> @@ -10,8 +10,6 @@ CONFIG_EXPERT=y
>   # CONFIG_VM_EVENT_COUNTERS is not set
>   # CONFIG_SLUB_DEBUG is not set
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   CONFIG_M5275=y
>   # CONFIG_4KSTACKS is not set
> diff --git a/arch/m68k/configs/m5307c3_defconfig b/arch/m68k/configs/m5307c3_defconfig
> index 97a78c99eeee..bb8b0eb4bdfc 100644
> --- a/arch/m68k/configs/m5307c3_defconfig
> +++ b/arch/m68k/configs/m5307c3_defconfig
> @@ -10,8 +10,6 @@ CONFIG_EXPERT=y
>   # CONFIG_VM_EVENT_COUNTERS is not set
>   # CONFIG_SLUB_DEBUG is not set
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   CONFIG_M5307=y
>   CONFIG_M5307C3=y
> diff --git a/arch/m68k/configs/m5407c3_defconfig b/arch/m68k/configs/m5407c3_defconfig
> index 766a97f39a3a..ce9ccf13c7c0 100644
> --- a/arch/m68k/configs/m5407c3_defconfig
> +++ b/arch/m68k/configs/m5407c3_defconfig
> @@ -11,8 +11,6 @@ CONFIG_EXPERT=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   # CONFIG_MMU is not set
>   CONFIG_M5407=y
>   CONFIG_M5407C3=y
> diff --git a/arch/m68k/configs/m5475evb_defconfig b/arch/m68k/configs/m5475evb_defconfig
> index 579fd98afed6..93f7c7a07553 100644
> --- a/arch/m68k/configs/m5475evb_defconfig
> +++ b/arch/m68k/configs/m5475evb_defconfig
> @@ -11,8 +11,6 @@ CONFIG_LOG_BUF_SHIFT=14
>   CONFIG_EMBEDDED=y
>   CONFIG_MODULES=y
>   # CONFIG_BLK_DEV_BSG is not set
> -# CONFIG_IOSCHED_DEADLINE is not set
> -# CONFIG_IOSCHED_CFQ is not set
>   CONFIG_COLDFIRE=y
>   # CONFIG_4KSTACKS is not set
>   CONFIG_RAMBASE=0x0
> 
