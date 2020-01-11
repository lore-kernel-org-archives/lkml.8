Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BEC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86751205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738546;
	bh=AmGBZyT8XJdRFB65XWPynXoNdICUXgYW4Lpwz75Yc38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hd6oRwd91RNXqbMTqE1IZW5jgoBEf+PKYTtV+XC8JXYCJbF69FMHY5ddcOR2iCRrA
	 NyXsRrEztqgBaf7K8Z4DWDstur75yE6Xd3uu7NUnGjU9qn1EOk7O+XgFd+6nguDYK9
	 TKbtvZvZqItrUOTSYK6JXxQU/QXiSseq89Hapm/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgAKK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbgAKK3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:29:00 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707B820842;
        Sat, 11 Jan 2020 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738539;
        bh=AmGBZyT8XJdRFB65XWPynXoNdICUXgYW4Lpwz75Yc38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcKYx43aDbJsw0ABOuWLCtt0aKrjqcUNDddDkKyS/x2AdnYkKTx8sOyHFqbvCQsq4
         Lo/oa18eatrKmoK8oqnhQKoBHiy/yKJ0Xo5o6F0+DokglXYopKZyRp+zF5ot11i9tf
         fxtllde3Jl6+iXf5g0exECuFOtg4cz5dN+fKvvno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 107/165] iommu/dma: Relax locking in iommu_dma_prepare_msi()
Date:   Sat, 11 Jan 2020 10:50:26 +0100
Message-Id: <20200111094931.051741936@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit c18647900ec864d401ba09b3bbd5b34f331f8d26 ]

Since commit ece6e6f0218b ("iommu/dma-iommu: Split iommu_dma_map_msi_msg()
in two parts"), iommu_dma_prepare_msi() should no longer have to worry
about preempting itself, nor being called in atomic context at all. Thus
we can downgrade the IRQ-safe locking to a simple mutex to avoid angering
the new might_sleep() check in iommu_map().

Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dma-iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f321279baf9e..51456e7f264f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -43,7 +44,6 @@ struct iommu_dma_cookie {
 		dma_addr_t		msi_iova;
 	};
 	struct list_head		msi_page_list;
-	spinlock_t			msi_lock;
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
@@ -62,7 +62,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 
 	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
 	if (cookie) {
-		spin_lock_init(&cookie->msi_lock);
 		INIT_LIST_HEAD(&cookie->msi_page_list);
 		cookie->type = type;
 	}
@@ -1150,7 +1149,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		if (msi_page->phys == msi_addr)
 			return msi_page;
 
-	msi_page = kzalloc(sizeof(*msi_page), GFP_ATOMIC);
+	msi_page = kzalloc(sizeof(*msi_page), GFP_KERNEL);
 	if (!msi_page)
 		return NULL;
 
@@ -1180,7 +1179,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie;
 	struct iommu_dma_msi_page *msi_page;
-	unsigned long flags;
+	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
 	if (!domain || !domain->iova_cookie) {
 		desc->iommu_cookie = NULL;
@@ -1190,13 +1189,13 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	cookie = domain->iova_cookie;
 
 	/*
-	 * We disable IRQs to rule out a possible inversion against
-	 * irq_desc_lock if, say, someone tries to retarget the affinity
-	 * of an MSI from within an IPI handler.
+	 * In fact the whole prepare operation should already be serialised by
+	 * irq_domain_mutex further up the callchain, but that's pretty subtle
+	 * on its own, so consider this locking as failsafe documentation...
 	 */
-	spin_lock_irqsave(&cookie->msi_lock, flags);
+	mutex_lock(&msi_prepare_lock);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
-	spin_unlock_irqrestore(&cookie->msi_lock, flags);
+	mutex_unlock(&msi_prepare_lock);
 
 	msi_desc_set_iommu_cookie(desc, msi_page);
 
-- 
2.20.1



