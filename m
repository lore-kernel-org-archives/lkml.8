Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A35C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818A208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBKJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:04:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgBKJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:04:31 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j1RT1-0003dt-H4; Tue, 11 Feb 2020 10:04:27 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0F8DE101115; Tue, 11 Feb 2020 10:04:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mm-commits@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
Subject: Re: + linux-next-git-rejects.patch added to -mm tree
In-Reply-To: <20200210215838.9lAjuyf-h%akpm@linux-foundation.org>
References: <20200210215838.9lAjuyf-h%akpm@linux-foundation.org>
Date:   Tue, 11 Feb 2020 10:04:27 +0100
Message-ID: <87o8u54hr8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

akpm@linux-foundation.org writes:

> The patch titled
>      Subject: linux-next-git-rejects
> has been added to the -mm tree.  Its filename is
>      linux-next-git-rejects.patch
>
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/linux-next-git-rejects.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/linux-next-git-rejects.patch
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
>
> ------------------------------------------------------
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: linux-next-git-rejects

I have no idea what this is about and the empty changelog is not really
helpful either.

> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  drivers/irqchip/irq-gic-v3-its.c |   69 -----------------------------
>  1 file changed, 69 deletions(-)
>
> --- a/drivers/irqchip/irq-gic-v3-its.c~linux-next-git-rejects
> +++ a/drivers/irqchip/irq-gic-v3-its.c
> @@ -2443,75 +2443,6 @@ static u64 inherit_vpe_l1_table_from_rd(
>  	return 0;
>  }
>  
> -<<<<<<< HEAD
> -static bool allocate_vpe_l2_table(int cpu, u32 id)
> -{
> -	void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
> -	unsigned int psz, esz, idx, npg, gpsz;
> -	u64 val;
> -	struct page *page;
> -	__le64 *table;
> -
> -	if (!gic_rdists->has_rvpeid)
> -		return true;
> -
> -	val  = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
> -
> -	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
> -	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
> -	npg  = FIELD_GET(GICR_VPROPBASER_4_1_SIZE, val) + 1;
> -
> -	switch (gpsz) {
> -	default:
> -		WARN_ON(1);
> -		/* fall through */
> -	case GIC_PAGE_SIZE_4K:
> -		psz = SZ_4K;
> -		break;
> -	case GIC_PAGE_SIZE_16K:
> -		psz = SZ_16K;
> -		break;
> -	case GIC_PAGE_SIZE_64K:
> -		psz = SZ_64K;
> -		break;
> -	}
> -
> -	/* Don't allow vpe_id that exceeds single, flat table limit */
> -	if (!(val & GICR_VPROPBASER_4_1_INDIRECT))
> -		return (id < (npg * psz / (esz * SZ_8)));
> -
> -	/* Compute 1st level table index & check if that exceeds table limit */
> -	idx = id >> ilog2(psz / (esz * SZ_8));
> -	if (idx >= (npg * psz / GITS_LVL1_ENTRY_SIZE))
> -		return false;
> -
> -	table = gic_data_rdist_cpu(cpu)->vpe_l1_base;
> -
> -	/* Allocate memory for 2nd level table */
> -	if (!table[idx]) {
> -		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
> -		if (!page)
> -			return false;
> -
> -		/* Flush Lvl2 table to PoC if hw doesn't support coherency */
> -		if (!(val & GICR_VPROPBASER_SHAREABILITY_MASK))
> -			gic_flush_dcache_to_poc(page_address(page), psz);
> -
> -		table[idx] = cpu_to_le64(page_to_phys(page) | GITS_BASER_VALID);
> -
> -		/* Flush Lvl1 entry to PoC if hw doesn't support coherency */
> -		if (!(val & GICR_VPROPBASER_SHAREABILITY_MASK))
> -			gic_flush_dcache_to_poc(table + idx, GITS_LVL1_ENTRY_SIZE);
> -
> -		/* Ensure updated table contents are visible to RD hardware */
> -		dsb(sy);
> -	}
> -
> -	return true;
> -}
> -
> -=======
> ->>>>>>> linux-next/akpm-base
>  static int allocate_vpe_l1_table(void)
>  {
>  	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
> _
>
> Patches currently in -mm which might be from akpm@linux-foundation.org are
>
> mm.patch
> linux-next-fix.patch
> drivers-tty-serial-sh-scic-suppress-warning.patch
> kernel-forkc-export-kernel_thread-to-modules.patch
> linux-next-git-rejects.patch
