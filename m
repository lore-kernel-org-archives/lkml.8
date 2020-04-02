Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA483C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861BD208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbgDBIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:46:47 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:41555 "EHLO
        19.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbgDBIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:46:47 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 04:46:46 EDT
Received: from player786.ha.ovh.net (unknown [10.108.54.108])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 27D6C277E79
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 10:08:29 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
        (Authenticated sender: clg@kaod.org)
        by player786.ha.ovh.net (Postfix) with ESMTPSA id 552F5113122F9;
        Thu,  2 Apr 2020 08:08:13 +0000 (UTC)
Subject: Re: [PATCH v10 03/14] powerpc/vas: Alloc and setup IRQ and trigger
 port address
To:     Haren Myneni <haren@linux.ibm.com>, mpe@ellerman.id.au
Cc:     mikey@neuling.org, srikar@linux.vnet.ibm.com,
        frederic.barrat@fr.ibm.com, ajd@linux.ibm.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com, hch@infradead.org,
        oohall@gmail.com, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, herbert@gondor.apana.org.au
References: <1585810846.2275.23.camel@hbabu-laptop>
 <1585811431.2275.39.camel@hbabu-laptop>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <99d4f018-0e2d-9ab4-b4d4-58af7e494ec3@kaod.org>
Date:   Thu, 2 Apr 2020 10:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585811431.2275.39.camel@hbabu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11347945162253044702
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 9:10 AM, Haren Myneni wrote:
> 
> Allocate a xive irq on each chip with a vas instance. The NX coprocessor
> raises a host CPU interrupt via vas if it encounters page fault on user
> space request buffer. Subsequent patches register the trigger port with
> the NX coprocessor, and create a vas fault handler for this interrupt
> mapping.

Looks good !

> Signed-off-by: Haren Myneni <haren@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  arch/powerpc/platforms/powernv/vas.c | 44 +++++++++++++++++++++++++++++++-----
>  arch/powerpc/platforms/powernv/vas.h |  2 ++
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> index ed9cc6d..3303cfe 100644
> --- a/arch/powerpc/platforms/powernv/vas.c
> +++ b/arch/powerpc/platforms/powernv/vas.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of.h>
>  #include <asm/prom.h>
> +#include <asm/xive.h>
>  
>  #include "vas.h"
>  
> @@ -25,10 +26,12 @@
>  
>  static int init_vas_instance(struct platform_device *pdev)
>  {
> -	int rc, cpu, vasid;
> -	struct resource *res;
> -	struct vas_instance *vinst;
>  	struct device_node *dn = pdev->dev.of_node;
> +	struct vas_instance *vinst;
> +	struct xive_irq_data *xd;
> +	uint32_t chipid, hwirq;
> +	struct resource *res;
> +	int rc, cpu, vasid;
>  
>  	rc = of_property_read_u32(dn, "ibm,vas-id", &vasid);
>  	if (rc) {
> @@ -36,6 +39,12 @@ static int init_vas_instance(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	rc = of_property_read_u32(dn, "ibm,chip-id", &chipid);
> +	if (rc) {
> +		pr_err("No ibm,chip-id property for %s?\n", pdev->name);
> +		return -ENODEV;
> +	}
> +
>  	if (pdev->num_resources != 4) {
>  		pr_err("Unexpected DT configuration for [%s, %d]\n",
>  				pdev->name, vasid);
> @@ -69,9 +78,32 @@ static int init_vas_instance(struct platform_device *pdev)
>  
>  	vinst->paste_win_id_shift = 63 - res->end;
>  
> -	pr_devel("Initialized instance [%s, %d], paste_base 0x%llx, "
> -			"paste_win_id_shift 0x%llx\n", pdev->name, vasid,
> -			vinst->paste_base_addr, vinst->paste_win_id_shift);
> +	hwirq = xive_native_alloc_irq_on_chip(chipid);
> +	if (!hwirq) {
> +		pr_err("Inst%d: Unable to allocate global irq for chip %d\n",
> +				vinst->vas_id, chipid);
> +		return -ENOENT;
> +	}
> +
> +	vinst->virq = irq_create_mapping(NULL, hwirq);
> +	if (!vinst->virq) {
> +		pr_err("Inst%d: Unable to map global irq %d\n",
> +				vinst->vas_id, hwirq);
> +		return -EINVAL;
> +	}
> +
> +	xd = irq_get_handler_data(vinst->virq);
> +	if (!xd) {
> +		pr_err("Inst%d: Invalid virq %d\n",
> +				vinst->vas_id, vinst->virq);
> +		return -EINVAL;
> +	}
> +
> +	vinst->irq_port = xd->trig_page;
> +	pr_devel("Initialized instance [%s, %d] paste_base 0x%llx paste_win_id_shift 0x%llx IRQ %d Port 0x%llx\n",
> +			pdev->name, vasid, vinst->paste_base_addr,
> +			vinst->paste_win_id_shift, vinst->virq,
> +			vinst->irq_port);
>  
>  	for_each_possible_cpu(cpu) {
>  		if (cpu_to_chip_id(cpu) == of_get_ibm_chip_id(dn))
> diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
> index 5574aec..598608b 100644
> --- a/arch/powerpc/platforms/powernv/vas.h
> +++ b/arch/powerpc/platforms/powernv/vas.h
> @@ -313,6 +313,8 @@ struct vas_instance {
>  	u64 paste_base_addr;
>  	u64 paste_win_id_shift;
>  
> +	u64 irq_port;
> +	int virq;
>  	struct mutex mutex;
>  	struct vas_window *rxwin[VAS_COP_TYPE_MAX];
>  	struct vas_window *windows[VAS_WINDOWS_PER_CHIP];
> 

