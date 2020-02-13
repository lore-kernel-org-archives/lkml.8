Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24395C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE8A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581604070;
	bh=6VfGSAC1HNOSPZvAehIj0dyrn4ZvRctoIk3FH92JPYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zQ6LAAnH/EJbQ8QHISA9ojtH8IGdQoTeGgyERSGvxaGJuUbuRfHIQlbhdSeGOcKH2
	 kbezG4hpyquohc+YfZw51WReUub7iTjM5jR4QHFhAGoWXg5JCEzw0wwulX3tlxEV3A
	 Y9BSjdqjMuiAxK//ucmXC+AzgALav9iYN57evFU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBMO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMO1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:27:48 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A312F222C2;
        Thu, 13 Feb 2020 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581603729;
        bh=6VfGSAC1HNOSPZvAehIj0dyrn4ZvRctoIk3FH92JPYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSeAbcjQ8QOxAe4QgIbYkEwyQm3vrPqRAkJtjE0GbKOtRmcwL4e4Um3YxtPHyFnrh
         sMbizg7K02UaBIu2Fg5l9afFMJ+YXwXAZ+pOfkgKZPgX3I8z6mAeRgXjKDavzXGviQ
         cFL3ig+yq/2tfGch9ygjX6/xRILMKkgI2klDov8I=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j2FNX-004qXJ-U9; Thu, 13 Feb 2020 14:22:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Feb 2020 14:22:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2 3/6] irqchip/gic-v4.1: Ensure L2 vPE table is allocated
 at RD level
In-Reply-To: <20200206075711.1275-4-yuzenghui@huawei.com>
References: <20200206075711.1275-1-yuzenghui@huawei.com>
 <20200206075711.1275-4-yuzenghui@huawei.com>
Message-ID: <2f6a27ac57aef9b948952c210c9a5882@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-02-06 07:57, Zenghui Yu wrote:
> In GICv4, we will ensure that level2 vPE table memory is allocated
> for the specified vpe_id on all v4 ITS, in its_alloc_vpe_table().
> This still works well for the typical GICv4.1 implementation, where
> the new vPE table is shared between the ITSs and the RDs.
> 
> To make it explicit, let us introduce allocate_vpe_l2_table() to
> make sure that the L2 tables are allocated on all v4.1 RDs. We're
> likely not need to allocate memory in it because the vPE table is
> shared and (L2 table is) already allocated at ITS level, except
> for the case where the ITS doesn't share anything (say SVPET == 0,
> practically unlikely but architecturally allowed).
> 
> The implementation of allocate_vpe_l2_table() is mostly copied from
> its_alloc_table_entry().
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 80 ++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 0f1fe56ce0af..ae4e7b355b46 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2443,6 +2443,72 @@ static u64 
> inherit_vpe_l1_table_from_rd(cpumask_t **mask)
>  	return 0;
>  }
> 
> +static bool allocate_vpe_l2_table(int cpu, u32 id)
> +{
> +	void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
> +	u64 val, gpsz, npg;
> +	unsigned int psz, esz, idx;
> +	struct page *page;
> +	__le64 *table;
> +
> +	if (!gic_rdists->has_rvpeid)
> +		return true;
> +
> +	val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);

Having rebased the rest of the GICv4.1 series on top of -rc1, I've hit a 
small
issue right here. I run a FVP model that only spawns 4 CPUs, while the 
DT has
8 of them. This means that online_cpus = 4, and possible_cpus = 8.

So in my case, half of the RDs have base == NULL, and things stop 
quickly.

I plan to queue the following:

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index d85dc8dcb0ad..7656b353a95f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2526,6 +2526,10 @@ static bool allocate_vpe_l2_table(int cpu, u32 
id)
  	if (!gic_rdists->has_rvpeid)
  		return true;

+	/* Skip non-present CPUs */
+	if (!base)
+		return true;
+
  	val  = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);

  	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;


Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
