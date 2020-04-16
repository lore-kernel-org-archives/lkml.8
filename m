Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71646C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF4B2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbgDPDfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:35:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2337 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729325AbgDPDfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:35:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9F71BBB0539E77DB2ED;
        Thu, 16 Apr 2020 11:35:36 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Apr 2020
 11:35:27 +0800
Subject: Re: [PATCH 1/2] irqchip/gic-v4.1: Add support for VPENDBASER's
 Dirty+Valid signaling
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200414095013.2821418-1-maz@kernel.org>
 <20200414095013.2821418-2-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <28750658-c940-0bcb-d6c2-c4eeae4c3851@huawei.com>
Date:   Thu, 16 Apr 2020 11:35:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200414095013.2821418-2-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/4/14 17:50, Marc Zyngier wrote:
> When a vPE is made resident, the GIC starts parsing the virtual pending
> table to deliver pending interrupts. This takes place asynchronously,
> and can at times take a long while. Long enough that the vcpu enters
> the guest and hits WFI before any interrupt has been signaled yet.
> The vcpu then exits, blocks, and now gets a doorbell. Rince, repeat.
> 
> In order to avoid the above, a (optional on GICv4, mandatory on v4.1)
> feature allows the GIC to feedback to the hypervisor whether it is
> done parsing the VPT by clearing the GICR_VENPENDBASER.Dirty bit.

GICR_VPENDBASER

> The hypervisor can then wait until the GIC is ready before actually
> running the vPE.
> 
> Plug the detection code as well as polling on vPE schedule. While
> at it, tidy-up the kernel message that displays the GICv4 optional
> features.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++++
>   drivers/irqchip/irq-gic-v3.c       | 11 +++++++----
>   include/linux/irqchip/arm-gic-v3.h |  2 ++
>   3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 54d142ccc63a..e24a145f17f6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -14,6 +14,7 @@
>   #include <linux/dma-iommu.h>
>   #include <linux/efi.h>
>   #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>   #include <linux/irqdomain.h>
>   #include <linux/list.h>
>   #include <linux/log2.h>
> @@ -3672,6 +3673,20 @@ static int its_vpe_set_affinity(struct irq_data *d,
>   	return IRQ_SET_MASK_OK_DONE;
>   }
>   
> +static void its_wait_vpend_dirty_clear(void)

I'm not sure if we can give it a better name. As we will also wait the
Dirty bit to be cleared in a de-scheduling operation, while now this
function is only used in a vPE schedule. To me, it should be something
like 'its_wait_vpt_parse_complete' (but someone may argue that in a vPE
de-schedule, there is also a VPT parsing to calculate the PendingLast).

Either way,
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks.

> +{
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
> +	u64 val;
> +
> +	if (!gic_rdists->has_vpend_valid_dirty)
> +		return;
> +
> +	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
> +						val,
> +						!(val & GICR_VPENDBASER_Dirty),
> +						10, 500));
> +}
> +
>   static void its_vpe_schedule(struct its_vpe *vpe)
>   {
>   	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
> @@ -3702,6 +3717,8 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>   	val |= vpe->idai ? GICR_VPENDBASER_IDAI : 0;
>   	val |= GICR_VPENDBASER_Valid;
>   	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
> +
> +	its_wait_vpend_dirty_clear();
>   }
>   
>   static void its_vpe_deschedule(struct its_vpe *vpe)
> @@ -3910,6 +3927,8 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
>   	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
>   
>   	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
> +
> +	its_wait_vpend_dirty_clear();
>   }
>   
>   static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 9dbc81b6f62e..d7006ef18a0d 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -873,6 +873,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>   	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
>   	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
>   					   gic_data.rdists.has_rvpeid);
> +	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
>   
>   	/* Detect non-sensical configurations */
>   	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
> @@ -893,10 +894,11 @@ static void gic_update_rdist_properties(void)
>   	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
>   		gic_data.ppi_nr = 0;
>   	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
> -	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
> -		!gic_data.rdists.has_vlpis ? "no " : "",
> -		!gic_data.rdists.has_direct_lpi ? "no " : "",
> -		!gic_data.rdists.has_rvpeid ? "no " : "");
> +	if (gic_data.rdists.has_vlpis)
> +		pr_info("GICv4 features: %s%s%s\n",
> +			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
> +			gic_data.rdists.has_rvpeid ? "RVPEID " : "",
> +			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
>   }
>   
>   /* Check whether it's single security state view */
> @@ -1620,6 +1622,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>   	gic_data.rdists.has_rvpeid = true;
>   	gic_data.rdists.has_vlpis = true;
>   	gic_data.rdists.has_direct_lpi = true;
> +	gic_data.rdists.has_vpend_valid_dirty = true;
>   
>   	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
>   		err = -ENOMEM;
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 765d9b769b69..6c36b6cc3edf 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -243,6 +243,7 @@
>   
>   #define GICR_TYPER_PLPIS		(1U << 0)
>   #define GICR_TYPER_VLPIS		(1U << 1)
> +#define GICR_TYPER_DIRTY		(1U << 2)
>   #define GICR_TYPER_DirectLPIS		(1U << 3)
>   #define GICR_TYPER_LAST			(1U << 4)
>   #define GICR_TYPER_RVPEID		(1U << 7)
> @@ -686,6 +687,7 @@ struct rdists {
>   	bool			has_vlpis;
>   	bool			has_rvpeid;
>   	bool			has_direct_lpi;
> +	bool			has_vpend_valid_dirty;
>   };
>   
>   struct irq_domain;
> 

