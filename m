Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE67208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGTV1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:27:09 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:47398 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgGTV1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:27:09 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 97B68BC19F;
        Mon, 20 Jul 2020 21:27:03 +0000 (UTC)
Subject: Re: [PATCH] firmware: ti_sci: Replace HTTP links with HTTPS ones
To:     Tero Kristo <t-kristo@ti.com>, nm@ti.com, ssantosh@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200718105538.9542-1-grandmaster@al2klimov.de>
 <7b6caa87-8672-b5d5-ef8d-2fd38a4b53e6@ti.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <03ad792e-a345-ee3d-02e5-19e489e25787@al2klimov.de>
Date:   Mon, 20 Jul 2020 23:27:02 +0200
MIME-Version: 1.0
In-Reply-To: <7b6caa87-8672-b5d5-ef8d-2fd38a4b53e6@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.07.20 um 09:32 schrieb Tero Kristo:
> Hi Alexander,
Hi,

> 
> One comment below.
> 
> On 18/07/2020 13:55, Alexander A. Klimov wrote:
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>       If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>              If both the HTTP and HTTPS versions
>>              return 200 OK and serve the same content:
>>                Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   Continuing my work started at 93431e0607e5.
>>   See also: git log --oneline '--author=Alexander A. Klimov 
>> <grandmaster@al2klimov.de>' v5.7..master
>>
>>   If there are any URLs to be removed completely
>>   or at least not (just) HTTPSified:
>>   Just clearly say so and I'll *undo my change*.
>>   See also: https://lkml.org/lkml/2020/6/27/64
>>
>>   If there are any valid, but yet not changed URLs:
>>   See: https://lkml.org/lkml/2020/6/26/837
>>
>>   If you apply the patch, please let me know.
>>
>>
>>   .../devicetree/bindings/interrupt-controller/ti,sci-intr.txt    | 2 +-
>>   drivers/firmware/ti_sci.c                                       | 2 +-
>>   drivers/firmware/ti_sci.h                                       | 2 +-
>>   drivers/irqchip/irq-ti-sci-inta.c                               | 2 +-
>>   drivers/irqchip/irq-ti-sci-intr.c                               | 2 +-
>>   drivers/reset/reset-ti-sci.c                                    | 2 +-
>>   include/linux/soc/ti/ti_sci_inta_msi.h                          | 2 +-
>>   include/linux/soc/ti/ti_sci_protocol.h                          | 2 +-
>>   8 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt 
>> b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> index 1a8718f8855d..178fca08278f 100644
>> --- 
>> a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> +++ 
>> b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -55,7 +55,7 @@ Required Properties:
>>               corresponds to a range of host irqs.
>>   For more details on TISCI IRQ resource management refer:
>> -http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
>> +https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
>>   Example:
>>   --------
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 4126be9e3216..53cee17d0115 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Texas Instruments System Control Interface Protocol Driver
>>    *
>> - * Copyright (C) 2015-2016 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    *    Nishanth Menon
>>    */
>> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
>> index f0d068c03944..57cd04062994 100644
>> --- a/drivers/firmware/ti_sci.h
>> +++ b/drivers/firmware/ti_sci.h
>> @@ -6,7 +6,7 @@
>>    * The system works in a message response protocol
>>    * See: http://processors.wiki.ti.com/index.php/TISCI for details
> 
> ^^^^
> 
> You should probably replace that one as well to be https while doing the 
> rest of the changes, even though the wiki is being deprecated during 
> this year.
Don't worry, I'll run another scan anyway to cover newly added URLs.
Do you require this additional change for applying this patch?

> 
> -Tero
> 
>>    *
>> - * Copyright (C)  2015-2016 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C)  2015-2016 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    */
>>   #ifndef __TI_SCI_H
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c 
>> b/drivers/irqchip/irq-ti-sci-inta.c
>> index 7e3ebf6ed2cd..85de19fe9b6e 100644
>> --- a/drivers/irqchip/irq-ti-sci-inta.c
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Texas Instruments' K3 Interrupt Aggregator irqchip driver
>>    *
>> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    *    Lokesh Vutla <lokeshvutla@ti.com>
>>    */
>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c 
>> b/drivers/irqchip/irq-ti-sci-intr.c
>> index 59d51a20bbd8..5ea148faf2ab 100644
>> --- a/drivers/irqchip/irq-ti-sci-intr.c
>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Texas Instruments' K3 Interrupt Router irqchip driver
>>    *
>> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    *    Lokesh Vutla <lokeshvutla@ti.com>
>>    */
>> diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
>> index bf68729ab729..b799aefad547 100644
>> --- a/drivers/reset/reset-ti-sci.c
>> +++ b/drivers/reset/reset-ti-sci.c
>> @@ -1,7 +1,7 @@
>>   /*
>>    * Texas Instrument's System Control Interface (TI-SCI) reset driver
>>    *
>> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    *    Andrew F. Davis <afd@ti.com>
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>> diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h 
>> b/include/linux/soc/ti/ti_sci_inta_msi.h
>> index 11fb5048f5f6..e3aa8b14612e 100644
>> --- a/include/linux/soc/ti/ti_sci_inta_msi.h
>> +++ b/include/linux/soc/ti/ti_sci_inta_msi.h
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Texas Instruments' K3 TI SCI INTA MSI helper
>>    *
>> - * Copyright (C) 2018-2019 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    *    Lokesh Vutla <lokeshvutla@ti.com>
>>    */
>> diff --git a/include/linux/soc/ti/ti_sci_protocol.h 
>> b/include/linux/soc/ti/ti_sci_protocol.h
>> index 9531ec823298..0fc452dd96d4 100644
>> --- a/include/linux/soc/ti/ti_sci_protocol.h
>> +++ b/include/linux/soc/ti/ti_sci_protocol.h
>> @@ -2,7 +2,7 @@
>>   /*
>>    * Texas Instruments System Control Interface Protocol
>>    *
>> - * Copyright (C) 2015-2016 Texas Instruments Incorporated - 
>> http://www.ti.com/
>> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - 
>> https://www.ti.com/
>>    *    Nishanth Menon
>>    */
>>
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
