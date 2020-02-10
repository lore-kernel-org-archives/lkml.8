Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E43CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549672082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBJOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:40:51 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:41528 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:40:51 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j1AEy-0004Yi-HX; Mon, 10 Feb 2020 14:40:48 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j1AEw-00017J-5Z; Mon, 10 Feb 2020 14:40:48 +0000
Subject: Re: [PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200130192226.2776-1-krzk@kernel.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6e686a54-2e1c-b690-d465-369e0d712bba@cambridgegreys.com>
Date:   Mon, 10 Feb 2020 14:40:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130192226.2776-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2020 19:22, Krzysztof Kozlowski wrote:
> CONFIG_IOSCHED_CFQ is since commit f382fb0bcef4 ("block: remove legacy
> IO schedulers").
> 
> The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
> previously choosing the latter.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/um/configs/i386_defconfig   | 2 +-
>   arch/um/configs/x86_64_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> index 73e98bb57bf5..fb51bd206dbe 100644
> --- a/arch/um/configs/i386_defconfig
> +++ b/arch/um/configs/i386_defconfig
> @@ -26,7 +26,7 @@ CONFIG_SLAB=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
> -CONFIG_IOSCHED_CFQ=m
> +CONFIG_IOSCHED_BFQ=m
>   CONFIG_SSL=y
>   CONFIG_NULL_CHAN=y
>   CONFIG_PORT_CHAN=y
> diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> index 3281d7600225..477b87317424 100644
> --- a/arch/um/configs/x86_64_defconfig
> +++ b/arch/um/configs/x86_64_defconfig
> @@ -24,7 +24,7 @@ CONFIG_SLAB=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
> -CONFIG_IOSCHED_CFQ=m
> +CONFIG_IOSCHED_BFQ=m
>   CONFIG_SSL=y
>   CONFIG_NULL_CHAN=y
>   CONFIG_PORT_CHAN=y
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
