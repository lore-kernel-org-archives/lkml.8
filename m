Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFD520707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nl69M5Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHZD6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:58:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47846 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHZD6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:58:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07Q3vZcV023938;
        Tue, 25 Aug 2020 22:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598414255;
        bh=vpmC2SSdjp01UpLKdQULx3dEtc7bmVUrLjpEQaUBafo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nl69M5QgngAP7dI6Df8k1bcvSCyWp8zg/3/nB/n/w6tBW3p6SzKkxDguWTi/oRnM1
         AaNzaEjWVr7QWFci0eitCplR4DdQ3bb0B/rFSC6RPB/a4mFf1PHbNiw2+kR0za+nFW
         SSpvRbz84gDpOGFbpRcCte5wXJkgONCrJpLbtYec=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07Q3vZYD091581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 22:57:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 22:57:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 22:57:34 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07Q3vSUq121538;
        Tue, 25 Aug 2020 22:57:31 -0500
Subject: Re: [PATCH -next] irqchip/ti-sci-intr: Fix unsigned comparison to
 zero
To:     YueHaibing <yuehaibing@huawei.com>, <nm@ti.com>, <t-kristo@ti.com>,
        <ssantosh@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200826035321.18620-1-yuehaibing@huawei.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <899af272-8255-9302-c3dd-c632d258f0b9@ti.com>
Date:   Wed, 26 Aug 2020 09:27:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200826035321.18620-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/20 9:23 am, YueHaibing wrote:
> ti_sci_intr_xlate_irq() return -ENOENT on fail, p_hwirq
> should be int type.
> 
> Fixes: a5b659bd4bc7 ("irqchip/ti-sci-intr: Add support for INTR being a parent to INTR")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the patch.

Acked-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> ---
>  drivers/irqchip/irq-ti-sci-intr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
> index cbc1758228d9..85a72b56177c 100644
> --- a/drivers/irqchip/irq-ti-sci-intr.c
> +++ b/drivers/irqchip/irq-ti-sci-intr.c
> @@ -137,8 +137,8 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
>  	struct ti_sci_intr_irq_domain *intr = domain->host_data;
>  	struct device_node *parent_node;
>  	struct irq_fwspec fwspec;
> -	u16 out_irq, p_hwirq;
> -	int err = 0;
> +	int p_hwirq, err = 0;
> +	u16 out_irq;
>  
>  	out_irq = ti_sci_get_free_resource(intr->out_irqs);
>  	if (out_irq == TI_SCI_RESOURCE_NULL)
> 
