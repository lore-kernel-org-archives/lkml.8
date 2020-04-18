Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C8FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6544622250
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587217768;
	bh=VyeAYrSuj5Nu9IZdaUdo5Y5eQ7ucFMmf8JRnu3917n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NOuXFpCVt/Qf/G2JW7x0+0U316i9QdhiTaxunYel6NkTXIeLDIzRegu8dVDJvbkNo
	 Zt/A7/7JY5G43ruKmjSagnOZali4W6fZiypZplD1Gsrj7V6RVPQtR2NhGmUIEa90CE
	 mbPCuBilw5iN7v2jEXlSUKchAin+pLZ9tzhpsy48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgDRNt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgDRNtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:49:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165A92224E;
        Sat, 18 Apr 2020 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217757;
        bh=VyeAYrSuj5Nu9IZdaUdo5Y5eQ7ucFMmf8JRnu3917n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhmnsGoViz2uWAloF47qt3HIV1Tuzk1GvxwY6Gio9bGHQ67KIRgTcabVLUPW4QgLM
         zcbSSlaZr3GBTelbwbnlpb5mSIL2wrAyWkdwt3O8DODymsDo30ctqZ9pgdecrrwgB4
         Id74zt0qkzqYzOwQSo6XY2nub8USDC6IMgHCECKw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.6 48/73] iommu/virtio: Fix freeing of incomplete domains
Date:   Sat, 18 Apr 2020 09:47:50 -0400
Message-Id: <20200418134815.6519-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit 7062af3ed2ba451029e3733d9f677c68f5ea9e77 ]

Calling viommu_domain_free() on a domain that hasn't been finalised (not
attached to any device, for example) can currently cause an Oops,
because we attempt to call ida_free() on ID 0, which may either be
unallocated or used by another domain.

Only initialise the vdomain->viommu pointer, which denotes a finalised
domain, at the end of a successful viommu_domain_finalise().

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20200326093558.2641019-3-jean-philippe@linaro.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index cce329d71fbad..5eed75cd121f1 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -613,18 +613,20 @@ static int viommu_domain_finalise(struct viommu_dev *viommu,
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	vdomain->viommu		= viommu;
-	vdomain->map_flags	= viommu->map_flags;
+	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
+			      viommu->last_domain, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	vdomain->id		= (unsigned int)ret;
 
 	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
 	domain->geometry	= viommu->geometry;
 
-	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
-			      viommu->last_domain, GFP_KERNEL);
-	if (ret >= 0)
-		vdomain->id = (unsigned int)ret;
+	vdomain->map_flags	= viommu->map_flags;
+	vdomain->viommu		= viommu;
 
-	return ret > 0 ? 0 : ret;
+	return 0;
 }
 
 static void viommu_domain_free(struct iommu_domain *domain)
-- 
2.20.1

