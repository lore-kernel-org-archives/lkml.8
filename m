Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4320746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584100849;
	bh=66Stu844AixOCXJdE9kC8ENCIp7M/TM/zJnzIskLlsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WXMBT6fJq5MCGQcp5DeE0Do3qBk1HHxN2YVNiBbWZbHgd7YG2CN1ZH/GE8lQ3Okdo
	 YUA1+o8xAw9TCy9EXIbE6ZAjPjW3ICUHRXkV6qGlZhyzaM1UeY0a3n+iWcH153orEg
	 sR9AqjnuAE3XqrHK6MbMtXvpiu1u0ndg7a1xpst8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMMAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMMAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:00:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6897C206FA;
        Fri, 13 Mar 2020 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584100846;
        bh=66Stu844AixOCXJdE9kC8ENCIp7M/TM/zJnzIskLlsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lw7IC2nMMXod0qIWGFkqUys5cwX45Al5aq8k25J7v1iKqA6KqG/d8esuB3DDzI93O
         nn/HIdCAbhaueSVwGXbDKdwnBGB15KJdf35nmTTaARPagQ4pi6y23hl4GCUXuZAsjb
         yyI5ioZyBgDYv8mudt1lKrqP3aHRTHY840hUYWFM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jCizc-00CTRw-G7; Fri, 13 Mar 2020 12:00:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Mar 2020 12:00:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/gic-v4: Fix non-stick page size error for setup
 GITS_BASER
In-Reply-To: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <9a00642020fe660e005045913b57fd20@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org, tangnianyao@huawei.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaokun, Nianyao,

On 2020-03-13 08:46, Shaokun Zhang wrote:
> From: Nianyao Tang <tangnianyao@huawei.com>
> 
> There is an error when ITS is probed if hw GITS_BASER<2>
> only supports psz=SZ_16K while GITS_BASER<1> only supports psz=SZ_4K.
> In its_alloc_tables, it has updated GITS_BASER<1>.psz and uses
> psz=SZ_4K for setup GITS_BASER<2>, and would fail in writing
> GITS_BASER<2>.psz=SZ_4K. 4K PAGE is the smallest and shall stop retry
> for other page sizes.
> 
> That latter GITS_BASER<n>.psz is larger than former, will lead
> to similar error.
> 
> [    0.000000] ITS@0x0000000660000000: Virtual CPUs doesn't stick:
> ba1f0824404004ff ba1f0824404005ff
> [    0.000000] ITS@0x0000000660000000: failed probing (-6)
> [    0.000000] ITS: No ITS available, not enabling LPIs
> 
> From GIC SPEC document, it's allowed for this implematation, the latter
> GITS_BASER<n>.psz is larger than the former.

I was really hoping nobody would build an ITS with disjoint sets of
page sizes. Oh well...

> Let's fix this error with following patch.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 83b1186..59bf8d6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2341,7 +2341,6 @@ static int its_alloc_tables(struct its_node *its)
>  		}
> 
>  		/* Update settings which will be used for next BASERn */
> -		psz = baser->psz;
>  		cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
>  		shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
>  	}

I think this just papers over the problem, and I'd rather tackle it 
fully
by forcing the probe of the supported page sizes for each GITS_BASERn
register. See the patch below (which I've only boot-tested once on 
pretty
standard HW as well as a guest).

This, in turn, simplifies the way we perform the allocation (no nested
retry loop). This is of course a much more patch invasive, but at least
it doesn't leave too much cruft behind.

Please let me know whether this solves your issue.

Thanks,

         M.

 From 544bf078869fe2baa788b1d3fb487f429144bd01 Mon Sep 17 00:00:00 2001
 From: Marc Zyngier <maz@kernel.org>
Date: Fri, 13 Mar 2020 11:01:15 +0000
Subject: [PATCH] irqchip/gic-v3-its: Probe ITS page size for all 
GITS_BASERn
  registers

The GICv3 ITS driver assumes that once it has latched on a page size for
a given BASER register, it can use the same page size as the maximum
page size for all subsequent BASER registers.

Although it worked so far, nothing in the architecture guarantees this,
and Nianyao Tang hit this problem on some undisclosed implementation.

Let's bite the bullet and probe the the supported page size on all BASER
registers before starting to populate the tables. This simplifies the
setup a bit, at the expense of a few additional MMIO accesses.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: 
https://lore.kernel.org/r/1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com
---
  drivers/irqchip/irq-gic-v3-its.c | 100 ++++++++++++++++++++-----------
  1 file changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index ee5568c20212..ec8c4df7ebe5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2222,18 +2222,17 @@ static void its_write_baser(struct its_node 
*its, struct its_baser *baser,
  }

  static int its_setup_baser(struct its_node *its, struct its_baser 
*baser,
-			   u64 cache, u64 shr, u32 psz, u32 order,
-			   bool indirect)
+			   u64 cache, u64 shr, u32 order, bool indirect)
  {
  	u64 val = its_read_baser(its, baser);
  	u64 esz = GITS_BASER_ENTRY_SIZE(val);
  	u64 type = GITS_BASER_TYPE(val);
  	u64 baser_phys, tmp;
-	u32 alloc_pages;
+	u32 alloc_pages, psz;
  	struct page *page;
  	void *base;

-retry_alloc_baser:
+	psz = baser->psz;
  	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
  	if (alloc_pages > GITS_BASER_PAGES_MAX) {
  		pr_warn("ITS@%pa: %s too large, reduce ITS pages %u->%u\n",
@@ -2306,25 +2305,6 @@ static int its_setup_baser(struct its_node *its, 
struct its_baser *baser,
  		goto retry_baser;
  	}

-	if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
-		/*
-		 * Page size didn't stick. Let's try a smaller
-		 * size and retry. If we reach 4K, then
-		 * something is horribly wrong...
-		 */
-		free_pages((unsigned long)base, order);
-		baser->base = NULL;
-
-		switch (psz) {
-		case SZ_16K:
-			psz = SZ_4K;
-			goto retry_alloc_baser;
-		case SZ_64K:
-			psz = SZ_16K;
-			goto retry_alloc_baser;
-		}
-	}
-
  	if (val != tmp) {
  		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
  		       &its->phys_base, its_base_type_string[type],
@@ -2350,13 +2330,14 @@ static int its_setup_baser(struct its_node *its, 
struct its_baser *baser,

  static bool its_parse_indirect_baser(struct its_node *its,
  				     struct its_baser *baser,
-				     u32 psz, u32 *order, u32 ids)
+				     u32 *order, u32 ids)
  {
  	u64 tmp = its_read_baser(its, baser);
  	u64 type = GITS_BASER_TYPE(tmp);
  	u64 esz = GITS_BASER_ENTRY_SIZE(tmp);
  	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
  	u32 new_order = *order;
+	u32 psz = baser->psz;
  	bool indirect = false;

  	/* No need to enable Indirection if memory requirement < (psz*2)bytes 
*/
@@ -2474,11 +2455,58 @@ static void its_free_tables(struct its_node 
*its)
  	}
  }

+static int its_probe_baser_psz(struct its_node *its, struct its_baser 
*baser)
+{
+	u64 psz = SZ_64K;
+
+	while (psz) {
+		u64 val, gpsz;
+
+		val = its_read_baser(its, baser);
+		val &= ~GITS_BASER_PAGE_SIZE_MASK;
+
+		switch (psz) {
+		case SZ_64K:
+			gpsz = GITS_BASER_PAGE_SIZE_64K;
+			break;
+		case SZ_16K:
+			gpsz = GITS_BASER_PAGE_SIZE_16K;
+			break;
+		case SZ_4K:
+		default:
+			gpsz = GITS_BASER_PAGE_SIZE_4K;
+			break;
+		}
+
+		gpz >>= GITS_BASER_PAGE_SIZE_SHIFT;
+
+		val |= FIELD_PREP(GITS_BASER_PAGE_SIZE_MASK, gpsz);
+		its_write_baser(its, baser, val);
+
+		if (FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser->val) == gpsz)
+			break;
+
+		switch (psz) {
+		case SZ_64K:
+			psz = SZ_16K;
+			break;
+		case SZ_16K:
+			psz = SZ_4K;
+			break;
+		case SZ_4K:
+		default:
+			return -1;
+		}
+	}
+
+	baser->psz = psz;
+	return 0;
+}
+
  static int its_alloc_tables(struct its_node *its)
  {
  	u64 shr = GITS_BASER_InnerShareable;
  	u64 cache = GITS_BASER_RaWaWb;
-	u32 psz = SZ_64K;
  	int err, i;

  	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_22375)
@@ -2489,16 +2517,22 @@ static int its_alloc_tables(struct its_node 
*its)
  		struct its_baser *baser = its->tables + i;
  		u64 val = its_read_baser(its, baser);
  		u64 type = GITS_BASER_TYPE(val);
-		u32 order = get_order(psz);
  		bool indirect = false;
+		u32 order;

-		switch (type) {
-		case GITS_BASER_TYPE_NONE:
+		if (type == GITS_BASER_TYPE_NONE)
  			continue;

+		if (its_probe_baser_psz(its, baser)) {
+			its_free_tables(its);
+			return -ENXIO;
+		}
+
+		order = get_order(baser->psz);
+
+		switch (type) {
  		case GITS_BASER_TYPE_DEVICE:
-			indirect = its_parse_indirect_baser(its, baser,
-							    psz, &order,
+			indirect = its_parse_indirect_baser(its, baser, &order,
  							    device_ids(its));
  			break;

@@ -2514,20 +2548,18 @@ static int its_alloc_tables(struct its_node 
*its)
  				}
  			}

-			indirect = its_parse_indirect_baser(its, baser,
-							    psz, &order,
+			indirect = its_parse_indirect_baser(its, baser, &order,
  							    ITS_MAX_VPEID_BITS);
  			break;
  		}

-		err = its_setup_baser(its, baser, cache, shr, psz, order, indirect);
+		err = its_setup_baser(its, baser, cache, shr, order, indirect);
  		if (err < 0) {
  			its_free_tables(its);
  			return err;
  		}

  		/* Update settings which will be used for next BASERn */
-		psz = baser->psz;
  		cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
  		shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
  	}
-- 
2.17.1


-- 
Jazz is not dead. It just smells funny...
