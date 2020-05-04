Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B01CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193E7206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgEDMz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728531AbgEDMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE84C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:54:17 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 189864BB; Mon,  4 May 2020 14:54:15 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4/5] iommu/amd: Update Device Table in increase_address_space()
Date:   Mon,  4 May 2020 14:54:12 +0200
Message-Id: <20200504125413.16798-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125413.16798-1-joro@8bytes.org>
References: <20200504125413.16798-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The Device Table needs to be updated before the new page-table root
can be published in domain->pt_root. Otherwise a concurrent call to
fetch_pte might fetch a PTE which is not reachable through the Device
Table Entry.

Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 49 ++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d2499c86d395..2ae1daac888a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -101,6 +101,8 @@ struct kmem_cache *amd_iommu_irq_cache;
 static void update_domain(struct protection_domain *domain);
 static int protection_domain_init(struct protection_domain *domain);
 static void detach_device(struct device *dev);
+static void update_and_flush_device_table(struct protection_domain *domain,
+					  struct domain_pgtable *pgtable);
 
 /****************************************************************************
  *
@@ -1461,8 +1463,16 @@ static bool increase_address_space(struct protection_domain *domain,
 
 	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
 
-	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode + 1);
+	pgtable.root  = pte;
+	pgtable.mode += 1;
+	update_and_flush_device_table(domain, &pgtable);
+	domain_flush_complete(domain);
 
+	/*
+	 * Device Table needs to be updated and flushed before the new root can
+	 * be published.
+	 */
+	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode);
 	atomic64_set(&domain->pt_root, root);
 
 	ret = true;
@@ -1893,19 +1903,17 @@ static bool dma_ops_domain(struct protection_domain *domain)
 }
 
 static void set_dte_entry(u16 devid, struct protection_domain *domain,
+			  struct domain_pgtable *pgtable,
 			  bool ats, bool ppr)
 {
-	struct domain_pgtable pgtable;
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable->mode != PAGE_MODE_NONE)
+		pte_root = iommu_virt_to_phys(pgtable->root);
 
-	if (pgtable.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(pgtable.root);
-
-	pte_root |= (pgtable.mode & DEV_ENTRY_MODE_MASK)
+	pte_root |= (pgtable->mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
@@ -1978,6 +1986,7 @@ static void clear_dte_entry(u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
+	struct domain_pgtable pgtable;
 	struct amd_iommu *iommu;
 	bool ats;
 
@@ -1993,7 +2002,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(dev_data->devid, domain, ats, dev_data->iommu_v2);
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	set_dte_entry(dev_data->devid, domain, &pgtable,
+		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
 
 	device_flush_dte(dev_data);
@@ -2304,22 +2315,34 @@ static int amd_iommu_domain_get_attr(struct iommu_domain *domain,
  *
  *****************************************************************************/
 
-static void update_device_table(struct protection_domain *domain)
+static void update_device_table(struct protection_domain *domain,
+				struct domain_pgtable *pgtable)
 {
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled,
-			      dev_data->iommu_v2);
+		set_dte_entry(dev_data->devid, domain, pgtable,
+			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(dev_data->pdev);
 	}
 }
 
+static void update_and_flush_device_table(struct protection_domain *domain,
+					  struct domain_pgtable *pgtable)
+{
+	update_device_table(domain, pgtable);
+	domain_flush_devices(domain);
+}
+
 static void update_domain(struct protection_domain *domain)
 {
-	update_device_table(domain);
+	struct domain_pgtable pgtable;
 
-	domain_flush_devices(domain);
+	/* Update device table */
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	update_and_flush_device_table(domain, &pgtable);
+
+	/* Flush domain TLB(s) and wait for completion */
 	domain_flush_tlb_pde(domain);
 	domain_flush_complete(domain);
 }
-- 
2.17.1

