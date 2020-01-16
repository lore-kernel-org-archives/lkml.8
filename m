Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1DC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F592077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202583;
	bh=ViTdC+sbQT1UM8OUGMtOmel1qE2swUvEeqsuUj1+HQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKdnjN840JAJN3YjFR3sSzKki3OUWMP4bsI5411txnU8qH2S5HJKplZLi9Eb5mrzv
	 KYaNfCMsd+D3mun7rW72iNDlxirPyiSXU751cg5TxUHT/UuU+kfXJmeaOQMx5D5viO
	 IupSyRwGfFv9+rQsiRs/DC1pBrKKVu4TUXgSDkGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgAPQxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730661AbgAPQxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C5220730;
        Thu, 16 Jan 2020 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193586;
        bh=ViTdC+sbQT1UM8OUGMtOmel1qE2swUvEeqsuUj1+HQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/k1U4HzV4SlFiIAII2jp4ma78a43t45LjdFqgdjb6fu+YXBFanKKloIUFiPR3M+y
         o4Cyww2L6qSbXfn6YRKnWLqmxfXgy5dM6QxIQjX23/cyuLti2vb7sn0kgHsQ6bBEXg
         KK9bTgZbn3YOoMH9EoCL/oYDpQuZ3FmCA7rB8f4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 127/205] iommu/mediatek: Correct the flush_iotlb_all callback
Date:   Thu, 16 Jan 2020 11:41:42 -0500
Message-Id: <20200116164300.6705-127-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

[ Upstream commit 2009122f1d83dd8375572661961eab1e7e86bffe ]

Use the correct tlb_flush_all instead of the original one.

Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 67a483c1a935..76b9388cf689 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -447,7 +447,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 
 static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
-	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
+	mtk_iommu_tlb_flush_all(mtk_iommu_get_m4u_data());
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
-- 
2.20.1

