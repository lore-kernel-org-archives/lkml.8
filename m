Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB61FC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A225520738
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QqRL1zP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVAVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDVAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:21:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705EDC0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x8so300288qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOrXrBA8QTub/2t4P8iuXJjEm4ygMvU/FqA4XiW8uMI=;
        b=QqRL1zP89wuwpYO4tjdu5tQyhiJKZz+123CtN7/lSOHBgi0BEsWgVLQtWqFkF0Hxyv
         i3YnSB79YQLqZfUqs5VQ7ORnBAyiLhFYAln1p5Tnm/66Ok8O2embqN8L6iR1Sj0Ort0y
         NiL7//AOzryih+UFlmGnfx6bobjRIrul/aI3C+e5/SiAT+H7LGnV5wHUTpPuLEv055M1
         uMHLaK7/BuqPaleUtPgV4/1Ef1uoO3rlJPwt0B/OnMxSwsCx6SyQqweIoXubAzBYVdiU
         hAM6PcjZ4PVCa1LC7dZTxqVcSv+QUxA3OnGMRz1ddHlWleWeR0SrIXcEJ0Gh53ILWxgL
         YmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOrXrBA8QTub/2t4P8iuXJjEm4ygMvU/FqA4XiW8uMI=;
        b=jCSe538jumM+DH8OcvUS8ZMym6UOLpIOA8v5McyNR0OHpeNLI88+go+25qvQHqsE4y
         0pBqM+g8FpDxzKOBvt2Y90CldfNA7HycSNabN1/eJ+35qaDyOlVoZdnHAPAUnuRocfFC
         SranrEFSGyo0HidBX8qVUK9rbMVcLCCTL5I23QgWHH9WQI+TLHl+ANgU3UKiV8Yd3qEb
         IAGdWHpERbMGGBb3oYqXHk48CxYNN9JtGGTB8E0JDtIAWP2+Ol3KPwgE9xu/kF3v92Y2
         8JaCFgYNncj8hp8sVgG3TVW051iTlhsUwm5XQmsu34DSKZ6ORh2bW64SDiGab3W9GsyK
         0TAg==
X-Gm-Message-State: AGi0PuY4iNT6yN3+lw4lyWkYSeoeLs11RfJnmcKuZzT5TEZKqS/jMTUr
        BvXwd45N/6jc5dZmZidFbjr3yQ==
X-Google-Smtp-Source: APiQypI+VXdJnBmgFU/RD6dwwKcyUmh89IKsfPkwPYI8eruL612VHTCsM8nTWqECUcuFa61w7n1eEg==
X-Received: by 2002:ac8:31e1:: with SMTP id i30mr23775526qte.74.1587514907550;
        Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u190sm2815110qkb.102.2020.04.21.17.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 17:21:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jR398-0000As-9O; Tue, 21 Apr 2020 21:21:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org
Subject: [PATCH hmm 0/5] Adjust hmm_range_fault() API
Date:   Tue, 21 Apr 2020 21:21:41 -0300
Message-Id: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The API is a bit complicated for the uses we actually have, and
disucssions for simplifying have come up a number of times.

This small series removes the customizable pfn format and simplifies the
return code of hmm_range_fault()

All the drivers are adjusted to process in the simplified format.
I would appreciated tested-by's for the two drivers, thanks!

This passes the hmm tester with the following diff:

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index d75e18f2ffd245..a2442efa038c41 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -47,23 +47,8 @@ struct dmirror_bounce {
 	unsigned long		cpages;
 };
 
-#define DPT_SHIFT PAGE_SHIFT
-#define DPT_VALID (1UL << 0)
-#define DPT_WRITE (1UL << 1)
-
 #define DPT_XA_TAG_WRITE 3UL
 
-static const uint64_t dmirror_hmm_flags[HMM_PFN_FLAG_MAX] = {
-	[HMM_PFN_VALID] = DPT_VALID,
-	[HMM_PFN_WRITE] = DPT_WRITE,
-};
-
-static const uint64_t dmirror_hmm_values[HMM_PFN_VALUE_MAX] = {
-	[HMM_PFN_NONE]    = 0,
-	[HMM_PFN_ERROR]   = 0x10,
-	[HMM_PFN_SPECIAL] = 0x10,
-};
-
 /*
  * Data structure to track address ranges and register for mmu interval
  * notifier updates.
@@ -175,7 +160,7 @@ static inline struct dmirror_device *dmirror_page_to_device(struct page *page)
 
 static int dmirror_do_fault(struct dmirror *dmirror, struct hmm_range *range)
 {
-	uint64_t *pfns = range->pfns;
+	unsigned long *pfns = range->hmm_pfns;
 	unsigned long pfn;
 
 	for (pfn = (range->start >> PAGE_SHIFT);
@@ -188,15 +173,16 @@ static int dmirror_do_fault(struct dmirror *dmirror, struct hmm_range *range)
 		 * Since we asked for hmm_range_fault() to populate pages,
 		 * it shouldn't return an error entry on success.
 		 */
-		WARN_ON(*pfns == range->values[HMM_PFN_ERROR]);
+		WARN_ON(*pfns & HMM_PFN_ERROR);
+		WARN_ON(!(*pfns & HMM_PFN_VALID));
 
-		page = hmm_device_entry_to_page(range, *pfns);
+		page = hmm_pfn_to_page(*pfns);
 		WARN_ON(!page);
 
 		entry = page;
-		if (*pfns & range->flags[HMM_PFN_WRITE])
+		if (*pfns & HMM_PFN_WRITE)
 			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
-		else if (range->default_flags & range->flags[HMM_PFN_WRITE])
+		else if (WARN_ON(range->default_flags & HMM_PFN_WRITE))
 			return -EFAULT;
 		entry = xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
 		if (xa_is_err(entry))
@@ -260,8 +246,6 @@ static int dmirror_range_fault(struct dmirror *dmirror,
 	int ret;
 
 	while (true) {
-		long count;
-
 		if (time_after(jiffies, timeout)) {
 			ret = -EBUSY;
 			goto out;
@@ -269,12 +253,11 @@ static int dmirror_range_fault(struct dmirror *dmirror,
 
 		range->notifier_seq = mmu_interval_read_begin(range->notifier);
 		down_read(&mm->mmap_sem);
-		count = hmm_range_fault(range);
+		ret = hmm_range_fault(range);
 		up_read(&mm->mmap_sem);
-		if (count <= 0) {
-			if (count == 0 || count == -EBUSY)
+		if (ret) {
+			if (ret == -EBUSY)
 				continue;
-			ret = count;
 			goto out;
 		}
 
@@ -299,16 +282,13 @@ static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
 {
 	struct mm_struct *mm = dmirror->notifier.mm;
 	unsigned long addr;
-	uint64_t pfns[64];
+	unsigned long pfns[64];
 	struct hmm_range range = {
 		.notifier = &dmirror->notifier,
-		.pfns = pfns,
-		.flags = dmirror_hmm_flags,
-		.values = dmirror_hmm_values,
-		.pfn_shift = DPT_SHIFT,
+		.hmm_pfns = pfns,
 		.pfn_flags_mask = 0,
-		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
-				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
+		.default_flags =
+			HMM_PFN_REQ_FAULT | (write ? HMM_PFN_REQ_WRITE : 0),
 		.dev_private_owner = dmirror->mdevice,
 	};
 	int ret = 0;
@@ -754,19 +734,20 @@ static int dmirror_migrate(struct dmirror *dmirror,
 }
 
 static void dmirror_mkentry(struct dmirror *dmirror, struct hmm_range *range,
-			    unsigned char *perm, uint64_t entry)
+			    unsigned char *perm, unsigned long entry)
 {
 	struct page *page;
 
-	if (entry == range->values[HMM_PFN_ERROR]) {
+	if (entry & HMM_PFN_ERROR) {
 		*perm = HMM_DMIRROR_PROT_ERROR;
 		return;
 	}
-	page = hmm_device_entry_to_page(range, entry);
-	if (!page) {
+	if (!(entry & HMM_PFN_VALID)) {
 		*perm = HMM_DMIRROR_PROT_NONE;
 		return;
 	}
+
+	page = hmm_pfn_to_page(entry);
 	if (is_device_private_page(page)) {
 		/* Is the page migrated to this device or some other? */
 		if (dmirror->mdevice == dmirror_page_to_device(page))
@@ -777,7 +758,7 @@ static void dmirror_mkentry(struct dmirror *dmirror, struct hmm_range *range,
 		*perm = HMM_DMIRROR_PROT_ZERO;
 	else
 		*perm = HMM_DMIRROR_PROT_NONE;
-	if (entry & range->flags[HMM_PFN_WRITE])
+	if (entry & HMM_PFN_WRITE)
 		*perm |= HMM_DMIRROR_PROT_WRITE;
 	else
 		*perm |= HMM_DMIRROR_PROT_READ;
@@ -832,8 +813,6 @@ static int dmirror_range_snapshot(struct dmirror *dmirror,
 		return ret;
 
 	while (true) {
-		long count;
-
 		if (time_after(jiffies, timeout)) {
 			ret = -EBUSY;
 			goto out;
@@ -842,12 +821,11 @@ static int dmirror_range_snapshot(struct dmirror *dmirror,
 		range->notifier_seq = mmu_interval_read_begin(range->notifier);
 
 		down_read(&mm->mmap_sem);
-		count = hmm_range_fault(range);
+		ret = hmm_range_fault(range);
 		up_read(&mm->mmap_sem);
-		if (count <= 0) {
-			if (count == 0 || count == -EBUSY)
+		if (ret) {
+			if (ret == -EBUSY)
 				continue;
-			ret = count;
 			goto out;
 		}
 
@@ -862,7 +840,7 @@ static int dmirror_range_snapshot(struct dmirror *dmirror,
 
 	n = (range->end - range->start) >> PAGE_SHIFT;
 	for (i = 0; i < n; i++)
-		dmirror_mkentry(dmirror, range, perm + i, range->pfns[i]);
+		dmirror_mkentry(dmirror, range, perm + i, range->hmm_pfns[i]);
 
 	mutex_unlock(&dmirror->mutex);
 out:
@@ -878,15 +856,11 @@ static int dmirror_snapshot(struct dmirror *dmirror,
 	unsigned long size = cmd->npages << PAGE_SHIFT;
 	unsigned long addr;
 	unsigned long next;
-	uint64_t pfns[64];
+	unsigned long pfns[64];
 	unsigned char perm[64];
 	char __user *uptr;
 	struct hmm_range range = {
-		.pfns = pfns,
-		.flags = dmirror_hmm_flags,
-		.values = dmirror_hmm_values,
-		.pfn_shift = DPT_SHIFT,
-		.pfn_flags_mask = 0,
+		.hmm_pfns = pfns,
 		.dev_private_owner = dmirror->mdevice,
 	};
 	int ret = 0;
@@ -1097,6 +1071,7 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 	spin_lock_init(&mdevice->lock);
 
 	cdev_init(&mdevice->cdevice, &dmirror_fops);
+	mdevice->cdevice.owner = THIS_MODULE;
 	ret = cdev_add(&mdevice->cdevice, dev, 1);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 033a12c7ab5b6d..da15471a2bbf9a 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1274,7 +1274,7 @@ TEST_F(hmm2, snapshot)
 	/* Check what the device saw. */
 	m = buffer->mirror;
 	ASSERT_EQ(m[0], HMM_DMIRROR_PROT_ERROR);
-	ASSERT_EQ(m[1], HMM_DMIRROR_PROT_NONE);
+	ASSERT_EQ(m[1], HMM_DMIRROR_PROT_ERROR);
 	ASSERT_EQ(m[2], HMM_DMIRROR_PROT_ZERO | HMM_DMIRROR_PROT_READ);
 	ASSERT_EQ(m[3], HMM_DMIRROR_PROT_READ);
 	ASSERT_EQ(m[4], HMM_DMIRROR_PROT_WRITE);

Jason Gunthorpe (5):
  mm/hmm: make CONFIG_DEVICE_PRIVATE into a select
  mm/hmm: make hmm_range_fault return 0 or -1
  drm/amdgpu: remove dead code after hmm_range_fault()
  mm/hmm: remove HMM_PFN_SPECIAL
  mm/hmm: remove the customizable pfn format from hmm_range_fault

 Documentation/vm/hmm.rst                |  28 ++--
 arch/powerpc/Kconfig                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  56 +++----
 drivers/gpu/drm/nouveau/Kconfig         |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c  |  60 ++++++--
 drivers/gpu/drm/nouveau/nouveau_dmem.h  |   4 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  59 ++++----
 include/linux/hmm.h                     | 109 +++++---------
 mm/Kconfig                              |   7 +-
 mm/hmm.c                                | 185 +++++++++++-------------
 10 files changed, 229 insertions(+), 283 deletions(-)

-- 
2.26.0

