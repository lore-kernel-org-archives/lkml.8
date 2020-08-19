Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E705C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2EE2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHSGse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:48:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6791 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgHSGsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:48:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWddn6Dxpz9tx2t;
        Wed, 19 Aug 2020 08:48:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sLh0Bt0UnGdV; Wed, 19 Aug 2020 08:48:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWddn5CFsz9tx2s;
        Wed, 19 Aug 2020 08:48:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B40318B7F3;
        Wed, 19 Aug 2020 08:48:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qM2bDxTqw8S9; Wed, 19 Aug 2020 08:48:14 +0200 (CEST)
Received: from [172.25.230.104] (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 86F238B767;
        Wed, 19 Aug 2020 08:48:14 +0200 (CEST)
Subject: Re: [PATCH v3] soc: fsl: enable acpi support
To:     Ran Wang <ran.wang_1@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Peng Ma <peng.ma@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200819040031.40204-1-ran.wang_1@nxp.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <02fa05ad-6d39-e16d-ad02-7472d28b6627@csgroup.eu>
Date:   Wed, 19 Aug 2020 08:48:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819040031.40204-1-ran.wang_1@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/08/2020 à 06:00, Ran Wang a écrit :
> From: Peng Ma <peng.ma@nxp.com>
> 
> This patch enables ACPI support in RCPM driver.

Can you change the subject to "soc: fsl: enable acpi support in RCPM 
driver" ?

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v3:
>   - Add #ifdef CONFIG_ACPI for acpi_device_id
>   - Rename rcpm_acpi_imx_ids to rcpm_acpi_ids
> 
> Change in v2:
>   - Update acpi_device_id to fix conflict with other driver
> 
>   drivers/soc/fsl/rcpm.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index a093dbe..55d1d73 100644
> --- a/drivers/soc/fsl/rcpm.c
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -2,7 +2,7 @@
>   //
>   // rcpm.c - Freescale QorIQ RCPM driver
>   //
> -// Copyright 2019 NXP
> +// Copyright 2019-2020 NXP
>   //
>   // Author: Ran Wang <ran.wang_1@nxp.com>
>   
> @@ -13,6 +13,7 @@
>   #include <linux/slab.h>
>   #include <linux/suspend.h>
>   #include <linux/kernel.h>
> +#include <linux/acpi.h>
>   
>   #define RCPM_WAKEUP_CELL_MAX_SIZE	7
>   
> @@ -125,6 +126,7 @@ static int rcpm_probe(struct platform_device *pdev)
>   
>   	ret = device_property_read_u32(&pdev->dev,
>   			"#fsl,rcpm-wakeup-cells", &rcpm->wakeup_cells);
> +

This blank line addition is unrelated to the patch and shouldn't be there.

Christophe

>   	if (ret)
>   		return ret;
>   
> @@ -139,10 +141,19 @@ static const struct of_device_id rcpm_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, rcpm_of_match);
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id rcpm_acpi_ids[] = {
> +	{"NXP0015",},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, rcpm_acpi_ids);
> +#endif
> +
>   static struct platform_driver rcpm_driver = {
>   	.driver = {
>   		.name = "rcpm",
>   		.of_match_table = rcpm_of_match,
> +		.acpi_match_table = ACPI_PTR(rcpm_acpi_ids),
>   		.pm	= &rcpm_pm_ops,
>   	},
>   	.probe = rcpm_probe,
> 
