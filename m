Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6A22072D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391217AbgDPDgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:36:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729245AbgDPDgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:36:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 607C3F79A9EA2BBE880A;
        Thu, 16 Apr 2020 11:36:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Apr 2020
 11:36:35 +0800
Subject: Re: [PATCH 2/2] irqchip/gic-v4.1: Update effective affinity of
 virtual SGIs
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200414095013.2821418-1-maz@kernel.org>
 <20200414095013.2821418-3-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c2dc9d25-937c-a3ff-c6f1-b010f82187ed@huawei.com>
Date:   Thu, 16 Apr 2020 11:36:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200414095013.2821418-3-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/14 17:50, Marc Zyngier wrote:
> Although the vSGIs are not directly visible to the host, they still
> get moved around by the CPU hotplug, for example. This results in
> the kernel moaning on the console, such as:
> 
>    genirq: irq_chip GICv4.1-sgi did not update eff. affinity mask of irq 38
> 
> Updating the effective affinity on set_affinity() fixes it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks.

> ---
>   drivers/irqchip/irq-gic-v3-its.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e24a145f17f6..84366cc1c14f 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4054,6 +4054,7 @@ static int its_sgi_set_affinity(struct irq_data *d,
>   	 * not on the host (since they can only be targetting a vPE).
>   	 * Tell the kernel we've done whatever it asked for.
>   	 */
> +	irq_data_update_effective_affinity(d, mask_val);
>   	return IRQ_SET_MASK_OK;
>   }
>   
> 

