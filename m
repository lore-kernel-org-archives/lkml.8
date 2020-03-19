Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A9F20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623784;
	bh=z4pFOs3pCJ7v5bqIJHEteayYnHveym/B6cPfj+vAvPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KwI04qkw70LApC7YO/hQMG2u0YnKIG2NfvexYqE09SG7lBBQ1RDyDtjzc9yH0oLr
	 ycFGXiV9LisDQuIDZGQ1lucr5t6gKY1PZ0oCBP10snvSZ0ts9j7kqWYFoGJyqVcAOr
	 E+xI0E9tukEZM2QmilTbV0fbICLIPGTWwmxAzb3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgCSNQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgCSNQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:16:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8183A2098B;
        Thu, 19 Mar 2020 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623778;
        bh=z4pFOs3pCJ7v5bqIJHEteayYnHveym/B6cPfj+vAvPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PReceiOOPGsCc7uORDT9ghr5kLlF/zIhUIys8XNSeKV4C9+vFumDIC+svpNiDMivN
         TQVT+ND3gPYjYmf0WQ9mYgHHhVuyTN+SZmnFk+OOuELslLRBFV5/iXbgSOlTgNKiRh
         wnGRhx/67GdixwhNUjCioLz7Lw+pcikqXl6WlZD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>
Subject: [PATCH 4.14 51/99] iommu/dma: Fix MSI reservation allocation
Date:   Thu, 19 Mar 2020 14:03:29 +0100
Message-Id: <20200319123957.302692071@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit 65ac74f1de3334852fb7d9b1b430fa5a06524276 upstream.

The way cookie_init_hw_msi_region() allocates the iommu_dma_msi_page
structures doesn't match the way iommu_put_dma_cookie() frees them.

The former performs a single allocation of all the required structures,
while the latter tries to free them one at a time. It doesn't quite
work for the main use case (the GICv3 ITS where the range is 64kB)
when the base granule size is 4kB.

This leads to a nice slab corruption on teardown, which is easily
observable by simply creating a VF on a SRIOV-capable device, and
tearing it down immediately (no need to even make use of it).
Fortunately, this only affects systems where the ITS isn't translated
by the SMMU, which are both rare and non-standard.

Fix it by allocating iommu_dma_msi_page structures one at a time.

Fixes: 7c1b058c8b5a3 ("iommu/dma: Handle IOMMU API reserved regions")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/dma-iommu.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -208,15 +208,15 @@ static int cookie_init_hw_msi_region(str
 	start -= iova_offset(iovad, start);
 	num_pages = iova_align(iovad, end - start) >> iova_shift(iovad);
 
-	msi_page = kcalloc(num_pages, sizeof(*msi_page), GFP_KERNEL);
-	if (!msi_page)
-		return -ENOMEM;
-
 	for (i = 0; i < num_pages; i++) {
-		msi_page[i].phys = start;
-		msi_page[i].iova = start;
-		INIT_LIST_HEAD(&msi_page[i].list);
-		list_add(&msi_page[i].list, &cookie->msi_page_list);
+		msi_page = kmalloc(sizeof(*msi_page), GFP_KERNEL);
+		if (!msi_page)
+			return -ENOMEM;
+
+		msi_page->phys = start;
+		msi_page->iova = start;
+		INIT_LIST_HEAD(&msi_page->list);
+		list_add(&msi_page->list, &cookie->msi_page_list);
 		start += iovad->granule;
 	}
 


