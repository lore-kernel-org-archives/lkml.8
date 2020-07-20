Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12526C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8A82073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nq90Hzd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgGTHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:32:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55702 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:32:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06K7WI1d021738;
        Mon, 20 Jul 2020 02:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595230338;
        bh=/jWIiALzK5V8fvNl6MphNcf2kmWQpId+dgZUsAkatZo=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Nq90Hzd6Wbf2o2UFZXbEwdU6FyZSUD0LYkHs/SNRN8N1Fr4tpmG3JWlx7WzPNOPBV
         BL2lMJOvHcyjlo70f0AY/JmO0Tyrn2EDf6CScFYn/7NlexcDbVYXkaq0ZUgxT3T4TQ
         CdYcPTEZZnujGkppNZLotdZXfGglX7y8kj2SK4r8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06K7WIid074617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 02:32:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 02:32:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 02:32:18 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06K7WEUK125332;
        Mon, 20 Jul 2020 02:32:15 -0500
Subject: Re: [PATCH] firmware: ti_sci: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, <nm@ti.com>,
        <ssantosh@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200718105538.9542-1-grandmaster@al2klimov.de>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <7b6caa87-8672-b5d5-ef8d-2fd38a4b53e6@ti.com>
Date:   Mon, 20 Jul 2020 10:32:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200718105538.9542-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

One comment below.

On 18/07/2020 13:55, Alexander A. Klimov wrote:
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
> ---
>   Continuing my work started at 93431e0607e5.
>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>   If there are any URLs to be removed completely
>   or at least not (just) HTTPSified:
>   Just clearly say so and I'll *undo my change*.
>   See also: https://lkml.org/lkml/2020/6/27/64
> 
>   If there are any valid, but yet not changed URLs:
>   See: https://lkml.org/lkml/2020/6/26/837
> 
>   If you apply the patch, please let me know.
> 
> 
>   .../devicetree/bindings/interrupt-controller/ti,sci-intr.txt    | 2 +-
>   drivers/firmware/ti_sci.c                                       | 2 +-
>   drivers/firmware/ti_sci.h                                       | 2 +-
>   drivers/irqchip/irq-ti-sci-inta.c                               | 2 +-
>   drivers/irqchip/irq-ti-sci-intr.c                               | 2 +-
>   drivers/reset/reset-ti-sci.c                                    | 2 +-
>   include/linux/soc/ti/ti_sci_inta_msi.h                          | 2 +-
>   include/linux/soc/ti/ti_sci_protocol.h                          | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> index 1a8718f8855d..178fca08278f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> @@ -55,7 +55,7 @@ Required Properties:
>   			corresponds to a range of host irqs.
>   
>   For more details on TISCI IRQ resource management refer:
> -http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
> +https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
>   
>   Example:
>   --------
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 4126be9e3216..53cee17d0115 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2,7 +2,7 @@
>   /*
>    * Texas Instruments System Control Interface Protocol Driver
>    *
> - * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
>    *	Nishanth Menon
>    */
>   
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index f0d068c03944..57cd04062994 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -6,7 +6,7 @@
>    * The system works in a message response protocol
>    * See: http://processors.wiki.ti.com/index.php/TISCI for details

^^^^

You should probably replace that one as well to be https while doing the 
rest of the changes, even though the wiki is being deprecated during 
this year.

-Tero

>    *
> - * Copyright (C)  2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C)  2015-2016 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #ifndef __TI_SCI_H
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> index 7e3ebf6ed2cd..85de19fe9b6e 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -2,7 +2,7 @@
>   /*
>    * Texas Instruments' K3 Interrupt Aggregator irqchip driver
>    *
> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
>    *	Lokesh Vutla <lokeshvutla@ti.com>
>    */
>   
> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
> index 59d51a20bbd8..5ea148faf2ab 100644
> --- a/drivers/irqchip/irq-ti-sci-intr.c
> +++ b/drivers/irqchip/irq-ti-sci-intr.c
> @@ -2,7 +2,7 @@
>   /*
>    * Texas Instruments' K3 Interrupt Router irqchip driver
>    *
> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
>    *	Lokesh Vutla <lokeshvutla@ti.com>
>    */
>   
> diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
> index bf68729ab729..b799aefad547 100644
> --- a/drivers/reset/reset-ti-sci.c
> +++ b/drivers/reset/reset-ti-sci.c
> @@ -1,7 +1,7 @@
>   /*
>    * Texas Instrument's System Control Interface (TI-SCI) reset driver
>    *
> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
>    *	Andrew F. Davis <afd@ti.com>
>    *
>    * This program is free software; you can redistribute it and/or modify
> diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
> index 11fb5048f5f6..e3aa8b14612e 100644
> --- a/include/linux/soc/ti/ti_sci_inta_msi.h
> +++ b/include/linux/soc/ti/ti_sci_inta_msi.h
> @@ -2,7 +2,7 @@
>   /*
>    * Texas Instruments' K3 TI SCI INTA MSI helper
>    *
> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
>    *	Lokesh Vutla <lokeshvutla@ti.com>
>    */
>   
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 9531ec823298..0fc452dd96d4 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -2,7 +2,7 @@
>   /*
>    * Texas Instruments System Control Interface Protocol
>    *
> - * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
>    *	Nishanth Menon
>    */
>   
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
