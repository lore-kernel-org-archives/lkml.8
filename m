Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE7C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C4D20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCXAKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:10:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:21904 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgCXAKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:10:44 -0400
IronPort-SDR: VJEW3RSXZTYhUkfmEDSUH4axO4NmiTuuVVUJZ8nvuZ+uKF4nnggilwA67jNHtVpr+sIL38/8I9
 GEoZBURiAP5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:10:44 -0700
IronPort-SDR: FXlZeJCeC8XzZ3K98a5LQIxztMUNO9atLkmlVAgtVKu97Fkyytph/17UqZ0ET8vqCXr+/RFVHV
 0IbaGsOux5KA==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="447678501"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:10:43 -0700
Subject: [PATCH 01/12] device-dax: Drop the dax_region.pfn_flags attribute
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     vishal.l.verma@intel.com, dave.hansen@linux.intel.com, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        jmoyer@redhat.com
Date:   Mon, 23 Mar 2020 16:54:36 -0700
Message-ID: <158500767684.2088294.8691316958585274856.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers specify the same flags to alloc_dax_region(), so there is no
need to allow for anything other than PFN_DEV|PFN_MAP, or carry a
->pfn_flags around on the region. Device-dax instances are always page
backed.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |    4 +---
 drivers/dax/bus.h         |    3 +--
 drivers/dax/dax-private.h |    2 --
 drivers/dax/device.c      |   26 +++-----------------------
 drivers/dax/hmem/hmem.c   |    2 +-
 drivers/dax/pmem/core.c   |    3 +--
 6 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 46e46047a1f7..5301c294e861 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -226,8 +226,7 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align,
-		unsigned long long pfn_flags)
+		struct resource *res, int target_node, unsigned int align)
 {
 	struct dax_region *dax_region;
 
@@ -251,7 +250,6 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 
 	dev_set_drvdata(parent, dax_region);
 	memcpy(&dax_region->res, res, sizeof(*res));
-	dax_region->pfn_flags = pfn_flags;
 	kref_init(&dax_region->kref);
 	dax_region->id = region_id;
 	dax_region->align = align;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 9e4eba67e8b9..55577e9791da 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -10,8 +10,7 @@ struct dax_device;
 struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align,
-		unsigned long long flags);
+		struct resource *res, int target_node, unsigned int align);
 
 enum dev_dax_subsys {
 	DEV_DAX_BUS,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 3107ce80e809..28767dc3ec13 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -23,7 +23,6 @@ void dax_bus_exit(void);
  * @dev: parent device backing this region
  * @align: allocation and mapping alignment for child dax devices
  * @res: physical address range of the region
- * @pfn_flags: identify whether the pfns are paged back or not
  */
 struct dax_region {
 	int id;
@@ -32,7 +31,6 @@ struct dax_region {
 	struct device *dev;
 	unsigned int align;
 	struct resource res;
-	unsigned long long pfn_flags;
 };
 
 /**
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 1af823b2fe6b..eaa651ddeccd 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -41,14 +41,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -EINVAL;
 	}
 
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV
-			&& (vma->vm_flags & VM_DONTCOPY) == 0) {
-		dev_info_ratelimited(dev,
-				"%s: %s: fail, dax range requires MADV_DONTFORK\n",
-				current->comm, func);
-		return -EINVAL;
-	}
-
 	if (!vma_is_dax(vma)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, vma is not DAX capable\n",
@@ -102,7 +94,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
 	return vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
 }
@@ -127,12 +119,6 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	/* dax pmd mappings require pfn_t_devmap() */
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) != (PFN_DEV|PFN_MAP)) {
-		dev_dbg(dev, "region lacks devmap flags\n");
-		return VM_FAULT_SIGBUS;
-	}
-
 	if (fault_size < dax_region->align)
 		return VM_FAULT_SIGBUS;
 	else if (fault_size > dax_region->align)
@@ -150,7 +136,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
 	return vmf_insert_pfn_pmd(vmf, *pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
@@ -177,12 +163,6 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	/* dax pud mappings require pfn_t_devmap() */
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) != (PFN_DEV|PFN_MAP)) {
-		dev_dbg(dev, "region lacks devmap flags\n");
-		return VM_FAULT_SIGBUS;
-	}
-
 	if (fault_size < dax_region->align)
 		return VM_FAULT_SIGBUS;
 	else if (fault_size > dax_region->align)
@@ -200,7 +180,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
 	return vmf_insert_pfn_pud(vmf, *pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 29ceb5795297..506893861253 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -22,7 +22,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	memcpy(&pgmap.res, res, sizeof(*res));
 
 	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
-			PMD_SIZE, PFN_DEV|PFN_MAP);
+			PMD_SIZE);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 2bedf8414fff..ea52bb77a294 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -53,8 +53,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	memcpy(&res, &pgmap.res, sizeof(res));
 	res.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &res,
-			nd_region->target_node, le32_to_cpu(pfn_sb->align),
-			PFN_DEV|PFN_MAP);
+			nd_region->target_node, le32_to_cpu(pfn_sb->align));
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 

