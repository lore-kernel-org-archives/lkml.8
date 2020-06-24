Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33603C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9472088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgFXIrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:47:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728732AbgFXIrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:47:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5AA6310B2CB85E73627C;
        Wed, 24 Jun 2020 16:47:45 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.204) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 24 Jun 2020
 16:47:42 +0800
Subject: Re: [PATCH] ARM: socfpga: add missing put_device() call in
 socfpga_setup_ocram_self_refresh()
To:     <dinguyen@kernel.org>, <linux@armlinux.org.uk>,
        <khilman@linaro.org>, <atull@opensource.altera.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200604131042.3926006-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c5a504d7-db2b-914b-89cd-2b46602bd93e@huawei.com>
Date:   Wed, 24 Jun 2020 16:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200604131042.3926006-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.204]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 2020/6/4 21:10, yu kuai wrote:
> if of_find_device_by_node() succeed, socfpga_setup_ocram_self_refresh()
> doesn't have a corresponding put_device(). Thus add a jump target to fix
> the exception handling for this function implementation.
> 
> Fixes: 44fd8c7d4005 ("ARM: socfpga: support suspend to ram")
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>   arch/arm/mach-socfpga/pm.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
> index 6ed887cf8dc9..7267f5da15a4 100644
> --- a/arch/arm/mach-socfpga/pm.c
> +++ b/arch/arm/mach-socfpga/pm.c
> @@ -49,14 +49,14 @@ static int socfpga_setup_ocram_self_refresh(void)
>   	if (!ocram_pool) {
>   		pr_warn("%s: ocram pool unavailable!\n", __func__);
>   		ret = -ENODEV;
> -		goto put_node;
> +		goto put_device;
>   	}
>   
>   	ocram_base = gen_pool_alloc(ocram_pool, socfpga_sdram_self_refresh_sz);
>   	if (!ocram_base) {
>   		pr_warn("%s: unable to alloc ocram!\n", __func__);
>   		ret = -ENOMEM;
> -		goto put_node;
> +		goto put_device;
>   	}
>   
>   	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
> @@ -67,7 +67,7 @@ static int socfpga_setup_ocram_self_refresh(void)
>   	if (!suspend_ocram_base) {
>   		pr_warn("%s: __arm_ioremap_exec failed!\n", __func__);
>   		ret = -ENOMEM;
> -		goto put_node;
> +		goto put_device;
>   	}
>   
>   	/* Copy the code that puts DDR in self refresh to ocram */
> @@ -80,7 +80,12 @@ static int socfpga_setup_ocram_self_refresh(void)
>   	     "could not copy function to ocram");
>   	if (!socfpga_sdram_self_refresh_in_ocram)
>   		ret = -EFAULT;
> +
> +	if (!ret)
> +		goto put_node;
>   
> +put_device:
> +	put_device(&pdev->dev);
>   put_node:
>   	of_node_put(np);
>   
> 

