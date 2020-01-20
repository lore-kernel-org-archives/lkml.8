Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE021D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgATODw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:03:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbgATODw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:03:52 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B98CDA86436E8D119C3C;
        Mon, 20 Jan 2020 22:03:49 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 22:03:42 +0800
Subject: Re: [PATCH v3 05/32] irqchip/gic-v4.1: VPE table (aka
 GICR_VPROPBASER) allocation
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Robert Richter <rrichter@marvell.com>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-6-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <b4a78cea-4ba3-58fb-4121-44508e7ae384@huawei.com>
Date:   Mon, 20 Jan 2020 22:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191224111055.11836-6-maz@kernel.org>
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

On 2019/12/24 19:10, Marc Zyngier wrote:
> GICv4.1 defines a new VPE table that is potentially shared between
> both the ITSs and the redistributors, following complicated affinity
> rules.
> 
> To make things more confusing, the programming of this table at
> the redistributor level is reusing the GICv4.0 GICR_VPROPBASER register
> for something completely different.
> 
> The code flow is somewhat complexified by the need to respect the
> affinities required by the HW, meaning that tables can either be
> inherited from a previously discovered ITS or redistributor.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

With two very minor concerns below.

[...]

> +static int allocate_vpe_l1_table(void)
> +{
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
> +	u64 val, gpsz, npg, pa;
> +	unsigned int psz = SZ_64K;
> +	unsigned int np, epp, esz;
> +	struct page *page;
> +
> +	if (!gic_rdists->has_rvpeid)
> +		return 0;
> +
> +	/*
> +	 * if VPENDBASER.Valid is set, disable any previously programmed
> +	 * VPE by setting PendingLast while clearing Valid. This has the
> +	 * effect of making sure no doorbell will be generated and we can
> +	 * then safely clear VPROPBASER.Valid.
> +	 */
> +	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
> +		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
> +				      vlpi_base + GICR_VPENDBASER);

I'm confused here.  The Valid field resets to 0.  Under which scenario
will the Valid==1 while we're doing initialization for this RD?

> +
> +	/*
> +	 * If we can inherit the configuration from another RD, let's do
> +	 * so. Otherwise, we have to go through the allocation process. We
> +	 * assume that all RDs have the exact same requirements, as
> +	 * nothing will work otherwise.
> +	 */
> +	val = inherit_vpe_l1_table_from_rd(&gic_data_rdist()->vpe_table_mask);
> +	if (val & GICR_VPROPBASER_4_1_VALID)
> +		goto out;
> +
> +	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_KERNEL);
> +	if (!gic_data_rdist()->vpe_table_mask)
> +		return -ENOMEM;
> +
> +	val = inherit_vpe_l1_table_from_its();
> +	if (val & GICR_VPROPBASER_4_1_VALID)
> +		goto out;
> +
> +	/* First probe the page size */
> +	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
> +	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
> +	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
> +	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
> +	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
> +
> +	switch (gpsz) {
> +	default:
> +		gpsz = GIC_PAGE_SIZE_4K;
> +		/* fall through */
> +	case GIC_PAGE_SIZE_4K:
> +		psz = SZ_4K;
> +		break;
> +	case GIC_PAGE_SIZE_16K:
> +		psz = SZ_16K;
> +		break;
> +	case GIC_PAGE_SIZE_64K:
> +		psz = SZ_64K;
> +		break;
> +	}
> +
> +	/*
> +	 * Start populating the register from scratch, including RO fields
> +	 * (which we want to print in debug cases...)
> +	 */
> +	val = 0;
> +	val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, gpsz);
> +	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ENTRY_SIZE, esz);
> +
> +	/* How many entries per GIC page? */
> +	esz++;
> +	epp = psz / (esz * SZ_8);
> +
> +	/*
> +	 * If we need more than just a single L1 page, flag the table
> +	 * as indirect and compute the number of required L1 pages.
> +	 */
> +	if (epp < ITS_MAX_VPEID) {
> +		int nl2;
> +
> +		gic_rdists->flags |= RDIST_FLAGS_VPE_INDIRECT;

This flag is set but not used, can we just drop it?


Thanks,
Zenghui

