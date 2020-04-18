Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA18C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5951E221E9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgDRSee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 14:34:34 -0400
Received: from 8bytes.org ([81.169.241.247]:36404 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:34:34 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2382D2E7; Sat, 18 Apr 2020 20:34:31 +0200 (CEST)
Date:   Sat, 18 Apr 2020 20:34:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200418183429.GH21900@8bytes.org>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 09:01:35AM -0400, Qian Cai wrote:
> Hard to tell without testing further. I’ll leave that optimization in
> the future, and focus on fixing those races first.

Yeah right, we should fix the existing races first before introducing
new ones ;)

Btw, THANKS A LOT for tracking down all these race condition bugs, I am
not even remotely able to trigger them with the hardware I have around.

I did some hacking and the attached diff shows how I think this race
condition needs to be fixed. I boot-tested this fix on-top of v5.7-rc1,
but did no further testing. Can you test it please?

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20cce366e951..28229a38af4d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -151,6 +151,26 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
+static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
+					 struct domain_pgtable *pgtable)
+{
+	u64 pt_root = atomic64_read(&domain->pt_root);
+
+	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
+	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
+}
+
+static u64 amd_iommu_domain_encode_pgtable(u64 *root, int mode)
+{
+	u64 pt_root;
+
+	/* lowest 3 bits encode pgtable mode */
+	pt_root = mode & 7;
+	pt_root |= (u64)root;
+
+	return pt_root;
+}
+
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -1397,13 +1417,18 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 
 static void free_pagetable(struct protection_domain *domain)
 {
-	unsigned long root = (unsigned long)domain->pt_root;
+	struct domain_pgtable pgtable;
 	struct page *freelist = NULL;
+	unsigned long root;
+
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	atomic64_set(&domain->pt_root, 0);
 
-	BUG_ON(domain->mode < PAGE_MODE_NONE ||
-	       domain->mode > PAGE_MODE_6_LEVEL);
+	BUG_ON(pgtable.mode < PAGE_MODE_NONE ||
+	       pgtable.mode > PAGE_MODE_6_LEVEL);
 
-	freelist = free_sub_pt(root, domain->mode, freelist);
+	root = (unsigned long)pgtable.root;
+	freelist = free_sub_pt(root, pgtable.mode, freelist);
 
 	free_page_list(freelist);
 }
@@ -1417,24 +1442,28 @@ static bool increase_address_space(struct protection_domain *domain,
 				   unsigned long address,
 				   gfp_t gfp)
 {
+	struct domain_pgtable pgtable;
 	unsigned long flags;
 	bool ret = false;
-	u64 *pte;
+	u64 *pte, root;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	if (address <= PM_LEVEL_SIZE(domain->mode) ||
-	    WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	if (address <= PM_LEVEL_SIZE(pgtable.mode) ||
+	    WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
 		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
 		goto out;
 
-	*pte             = PM_LEVEL_PDE(domain->mode,
-					iommu_virt_to_phys(domain->pt_root));
-	domain->pt_root  = pte;
-	domain->mode    += 1;
+	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
+
+	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode + 1);
+
+	atomic64_set(&domain->pt_root, root);
 
 	ret = true;
 
@@ -1451,16 +1480,22 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		      gfp_t gfp,
 		      bool *updated)
 {
+	struct domain_pgtable pgtable;
 	int level, end_lvl;
 	u64 *pte, *page;
 
 	BUG_ON(!is_power_of_2(page_size));
 
-	while (address > PM_LEVEL_SIZE(domain->mode))
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
 		*updated = increase_address_space(domain, address, gfp) || *updated;
+		amd_iommu_domain_get_pgtable(domain, &pgtable);
+	}
+
 
-	level   = domain->mode - 1;
-	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
+	level   = pgtable.mode - 1;
+	pte     = &pgtable.root[PM_LEVEL_INDEX(level, address)];
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -1536,16 +1571,19 @@ static u64 *fetch_pte(struct protection_domain *domain,
 		      unsigned long address,
 		      unsigned long *page_size)
 {
+	struct domain_pgtable pgtable;
 	int level;
 	u64 *pte;
 
 	*page_size = 0;
 
-	if (address > PM_LEVEL_SIZE(domain->mode))
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	if (address > PM_LEVEL_SIZE(pgtable.mode))
 		return NULL;
 
-	level	   =  domain->mode - 1;
-	pte	   = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
+	level	   =  pgtable.mode - 1;
+	pte	   = &pgtable.root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -1806,6 +1844,7 @@ static void dma_ops_domain_free(struct protection_domain *domain)
 static struct protection_domain *dma_ops_domain_alloc(void)
 {
 	struct protection_domain *domain;
+	u64 *pt_root, root;
 
 	domain = kzalloc(sizeof(struct protection_domain), GFP_KERNEL);
 	if (!domain)
@@ -1814,12 +1853,14 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (protection_domain_init(domain))
 		goto free_domain;
 
-	domain->mode = PAGE_MODE_3_LEVEL;
-	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-	domain->flags = PD_DMA_OPS_MASK;
-	if (!domain->pt_root)
+	pt_root = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!pt_root)
 		goto free_domain;
 
+	root = amd_iommu_domain_encode_pgtable(pt_root, PAGE_MODE_3_LEVEL);
+	atomic64_set(&domain->pt_root, root);
+	domain->flags = PD_DMA_OPS_MASK;
+
 	if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
 		goto free_domain;
 
@@ -1843,14 +1884,17 @@ static bool dma_ops_domain(struct protection_domain *domain)
 static void set_dte_entry(u16 devid, struct protection_domain *domain,
 			  bool ats, bool ppr)
 {
+	struct domain_pgtable pgtable;
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
 
-	if (domain->mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->pt_root);
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	if (pgtable.mode != PAGE_MODE_NONE)
+		pte_root = iommu_virt_to_phys(pgtable.root);
 
-	pte_root |= (domain->mode & DEV_ENTRY_MODE_MASK)
+	pte_root |= (pgtable.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
@@ -2375,6 +2419,7 @@ static struct protection_domain *protection_domain_alloc(void)
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *pdomain;
+	u64 *pt_root, root;
 
 	switch (type) {
 	case IOMMU_DOMAIN_UNMANAGED:
@@ -2382,13 +2427,15 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		if (!pdomain)
 			return NULL;
 
-		pdomain->mode    = PAGE_MODE_3_LEVEL;
-		pdomain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!pdomain->pt_root) {
+		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!pt_root) {
 			protection_domain_free(pdomain);
 			return NULL;
 		}
 
+		root = amd_iommu_domain_encode_pgtable(pt_root, PAGE_MODE_3_LEVEL);
+		atomic64_set(&pdomain->pt_root, root);
+
 		pdomain->domain.geometry.aperture_start = 0;
 		pdomain->domain.geometry.aperture_end   = ~0ULL;
 		pdomain->domain.geometry.force_aperture = true;
@@ -2406,7 +2453,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 		if (!pdomain)
 			return NULL;
 
-		pdomain->mode = PAGE_MODE_NONE;
+		atomic64_set(&pdomain->pt_root, PAGE_MODE_NONE);
 		break;
 	default:
 		return NULL;
@@ -2418,6 +2465,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
+	struct domain_pgtable pgtable;
 
 	domain = to_pdomain(dom);
 
@@ -2435,7 +2483,9 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 		dma_ops_domain_free(domain);
 		break;
 	default:
-		if (domain->mode != PAGE_MODE_NONE)
+		amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+		if (pgtable.mode != PAGE_MODE_NONE)
 			free_pagetable(domain);
 
 		if (domain->flags & PD_IOMMUV2_MASK)
@@ -2518,10 +2568,12 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct domain_pgtable pgtable;
 	int prot = 0;
 	int ret;
 
-	if (domain->mode == PAGE_MODE_NONE)
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable.mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
 	if (iommu_prot & IOMMU_READ)
@@ -2541,8 +2593,10 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct domain_pgtable pgtable;
 
-	if (domain->mode == PAGE_MODE_NONE)
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable.mode == PAGE_MODE_NONE)
 		return 0;
 
 	return iommu_unmap_page(domain, iova, page_size);
@@ -2553,9 +2607,11 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long offset_mask, pte_pgsize;
+	struct domain_pgtable pgtable;
 	u64 *pte, __pte;
 
-	if (domain->mode == PAGE_MODE_NONE)
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable.mode == PAGE_MODE_NONE)
 		return iova;
 
 	pte = fetch_pte(domain, iova, &pte_pgsize);
@@ -2708,16 +2764,26 @@ EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct domain_pgtable pgtable;
 	unsigned long flags;
+	u64 pt_root;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
+	/* First save pgtable configuration*/
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
 	/* Update data structure */
-	domain->mode    = PAGE_MODE_NONE;
+	pt_root = amd_iommu_domain_encode_pgtable(NULL, PAGE_MODE_NONE);
+	atomic64_set(&domain->pt_root, pt_root);
 
 	/* Make changes visible to IOMMUs */
 	update_domain(domain);
 
+	/* Restore old pgtable in domain->ptroot to free page-table */
+	pt_root = amd_iommu_domain_encode_pgtable(pgtable.root, pgtable.mode);
+	atomic64_set(&domain->pt_root, pt_root);
+
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	free_pagetable(domain);
 
@@ -2908,9 +2974,11 @@ static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
 static int __set_gcr3(struct protection_domain *domain, int pasid,
 		      unsigned long cr3)
 {
+	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	if (domain->mode != PAGE_MODE_NONE)
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
@@ -2924,9 +2992,11 @@ static int __set_gcr3(struct protection_domain *domain, int pasid,
 
 static int __clear_gcr3(struct protection_domain *domain, int pasid)
 {
+	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	if (domain->mode != PAGE_MODE_NONE)
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+	if (pgtable.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, false);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index ca8c4522045b..7a8fdec138bd 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -468,8 +468,7 @@ struct protection_domain {
 				       iommu core code */
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	int mode;		/* paging mode (0-6 levels) */
-	u64 *pt_root;		/* page table root pointer */
+	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 	int glx;		/* Number of levels for GCR3 table */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
@@ -477,6 +476,12 @@ struct protection_domain {
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
 
+/* For decocded pt_root */
+struct domain_pgtable {
+	int mode;
+	u64 *root;
+};
+
 /*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
