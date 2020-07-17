Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B39C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054BD20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9+uP7hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGQHL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:11:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53764 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGQHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:11:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7Bd2o007320;
        Fri, 17 Jul 2020 02:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594969899;
        bh=vo6heXoi//rglwj0GO050CqpfzdLaYknyrgpXtBn908=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=D9+uP7hsF/EDnkz3YLRkJhlmB+GfGkGxh71dk9Xv3M7no2qwb55A/tegvs4qzH6RE
         Ebb30Qzv0mf3wFm6oNPe6/G5s5Qy75/nGyZ0zjBy+1AGhxhp7voSuj6BQwsWpqsyCj
         uKpRl23myDMzxhM+ugCHE3lN6Y3Dd1KAdm2bwXE4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06H7Bd9G009430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 02:11:39 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:11:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:11:39 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7BZta098297;
        Fri, 17 Jul 2020 02:11:36 -0500
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: TI KEYSTONE MULTICORE
 NAVIGATOR DRIVERS
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        <ssantosh@kernel.org>, <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200708181937.16369-1-grandmaster@al2klimov.de>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <accb715a-3d87-d973-de4f-61fb74c30b1c@ti.com>
Date:   Fri, 17 Jul 2020 10:11:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708181937.16369-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 21:19, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>              If both the HTTP and HTTPS versions
>              return 200 OK and serve the same content:
>                Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Tero Kristo <t-kristo@ti.com>

Santosh, are you going to pick this up?

-Tero

> ---
>   Continuing my work started at 93431e0607e5.
>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>   (Actually letting a shell for loop submit all this stuff for me.)
> 
>   If there are any URLs to be removed completely or at least not HTTPSified:
>   Just clearly say so and I'll *undo my change*.
>   See also: https://lkml.org/lkml/2020/6/27/64
> 
>   If there are any valid, but yet not changed URLs:
>   See: https://lkml.org/lkml/2020/6/26/837
> 
>   If you apply the patch, please let me know.
> 
> 
>   drivers/soc/ti/k3-ringacc.c        | 2 +-
>   drivers/soc/ti/knav_qmss.h         | 2 +-
>   drivers/soc/ti/knav_qmss_acc.c     | 2 +-
>   drivers/soc/ti/knav_qmss_queue.c   | 2 +-
>   drivers/soc/ti/omap_prm.c          | 2 +-
>   drivers/soc/ti/pm33xx.c            | 2 +-
>   drivers/soc/ti/ti_sci_inta_msi.c   | 2 +-
>   drivers/soc/ti/ti_sci_pm_domains.c | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 5fb2ee2ac978..036d89aa3e2b 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -2,7 +2,7 @@
>   /*
>    * TI K3 NAVSS Ring Accelerator subsystem driver
>    *
> - * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
>    */
>   
>   #include <linux/dma-mapping.h>
> diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
> index a01eda720bf6..b815aed8f365 100644
> --- a/drivers/soc/ti/knav_qmss.h
> +++ b/drivers/soc/ti/knav_qmss.h
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone Navigator QMSS driver internal header
>    *
> - * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
>    * Author:	Sandeep Nair <sandeep_n@ti.com>
>    *		Cyril Chemparathy <cyril@ti.com>
>    *		Santosh Shilimkar <santosh.shilimkar@ti.com>
> diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
> index 1762d89fc05d..29670d47cdfd 100644
> --- a/drivers/soc/ti/knav_qmss_acc.c
> +++ b/drivers/soc/ti/knav_qmss_acc.c
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone accumulator queue manager
>    *
> - * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
>    * Author:	Sandeep Nair <sandeep_n@ti.com>
>    *		Cyril Chemparathy <cyril@ti.com>
>    *		Santosh Shilimkar <santosh.shilimkar@ti.com>
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index aa071d96ef36..feaead96ff93 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -2,7 +2,7 @@
>   /*
>    * Keystone Queue Manager subsystem driver
>    *
> - * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
>    * Authors:	Sandeep Nair <sandeep_n@ti.com>
>    *		Cyril Chemparathy <cyril@ti.com>
>    *		Santosh Shilimkar <santosh.shilimkar@ti.com>
> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
> index c9b3f9ebf0bb..06e9d59e75bf 100644
> --- a/drivers/soc/ti/omap_prm.c
> +++ b/drivers/soc/ti/omap_prm.c
> @@ -2,7 +2,7 @@
>   /*
>    * OMAP2+ PRM driver
>    *
> - * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
>    *	Tero Kristo <t-kristo@ti.com>
>    */
>   
> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> index de0123ec8ad6..9bd2da2758f4 100644
> --- a/drivers/soc/ti/pm33xx.c
> +++ b/drivers/soc/ti/pm33xx.c
> @@ -2,7 +2,7 @@
>   /*
>    * AM33XX Power Management Routines
>    *
> - * Copyright (C) 2012-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2012-2018 Texas Instruments Incorporated - https://www.ti.com/
>    *	Vaibhav Bedia, Dave Gerlach
>    */
>   
> diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
> index 0eb9462f609e..8e439759b451 100644
> --- a/drivers/soc/ti/ti_sci_inta_msi.c
> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
> @@ -2,7 +2,7 @@
>   /*
>    * Texas Instruments' K3 Interrupt Aggregator MSI bus
>    *
> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
>    *	Lokesh Vutla <lokeshvutla@ti.com>
>    */
>   
> diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
> index 8c2a2f23982c..771b0ab51872 100644
> --- a/drivers/soc/ti/ti_sci_pm_domains.c
> +++ b/drivers/soc/ti/ti_sci_pm_domains.c
> @@ -2,7 +2,7 @@
>   /*
>    * TI SCI Generic Power Domain Driver
>    *
> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
>    *	J Keerthy <j-keerthy@ti.com>
>    *	Dave Gerlach <d-gerlach@ti.com>
>    */
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
