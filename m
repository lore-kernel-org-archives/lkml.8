Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBECC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19F620781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgC2U1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgC2U0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVq-0001U2-20; Sun, 29 Mar 2020 22:26:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8BFCC1C07EC;
        Sun, 29 Mar 2020 22:26:20 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:20 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Probe ITS page size for all
 GITS_BASERn registers
Cc:     Marc Zyngier <maz@kernel.org>,
        Nianyao Tang <tangnianyao@huawei.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <158551358020.28353.12068573166973176178.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d5df9dc96eb7423d3f742b13d5e1e479ff795eaa
Gitweb:        https://git.kernel.org/tip/d5df9dc96eb7423d3f742b13d5e1e479ff795eaa
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 13 Mar 2020 11:01:15 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:54 

irqchip/gic-v3-its: Probe ITS page size for all GITS_BASERn registers

The GICv3 ITS driver assumes that once it has latched on a page size for
a given BASER register, it can use the same page size as the maximum
page size for all subsequent BASER registers.

Although it worked so far, nothing in the architecture guarantees this,
and Nianyao Tang hit this problem on some undisclosed implementation.

Let's bite the bullet and probe the the supported page size on all BASER
registers before starting to populate the tables. This simplifies the
setup a bit, at the expense of a few additional MMIO accesses.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Tested-by: Nianyao Tang <tangnianyao@huawei.com>
Link: https://lore.kernel.org/r/1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com
---
 drivers/irqchip/irq-gic-v3-its.c | 100 +++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6bb2bea..e207fbf 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2036,18 +2036,17 @@ static void its_write_baser(struct its_node *its, struct its_baser *baser,
 }
 
 static int its_setup_baser(struct its_node *its, struct its_baser *baser,
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
@@ -2120,25 +2119,6 @@ retry_baser:
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
@@ -2164,13 +2144,14 @@ retry_baser:
 
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
 
 	/* No need to enable Indirection if memory requirement < (psz*2)bytes */
@@ -2288,11 +2269,58 @@ static void its_free_tables(struct its_node *its)
 	}
 }
 
+static int its_probe_baser_psz(struct its_node *its, struct its_baser *baser)
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
+		gpsz >>= GITS_BASER_PAGE_SIZE_SHIFT;
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
@@ -2303,16 +2331,22 @@ static int its_alloc_tables(struct its_node *its)
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
 
@@ -2328,20 +2362,18 @@ static int its_alloc_tables(struct its_node *its)
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
