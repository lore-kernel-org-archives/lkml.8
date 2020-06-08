Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F8E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658306;
	bh=WPj0jjv6Ts+fStz7KcOL0WNWp4wINcRRJV6yd0QuEiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyQGH4CCXsxU885dJ/aDfDzoht4uoSXwB+YPScnqD9e4N8S3cwZVqwA0mPr8aIXke
	 WcBFSBA8H/Em51HKUFrqSTYYVIaFna/gd4dmtECE6LRQcy6TScGsX3Frzh/DIfiSKv
	 iyl3QaFy9OwiVT0c8oFpMhsvXdxHi/i4V1PnYi+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgFHXSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbgFHXOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFED21556;
        Mon,  8 Jun 2020 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658083;
        bh=WPj0jjv6Ts+fStz7KcOL0WNWp4wINcRRJV6yd0QuEiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzB7TxfKI9MloeHyVgxEH04y/ygCU7MEYTa5EYDiik3afwLlHKvV2cAW16hPduKOd
         uMD76W7oLHlhFDzjFm9AEsfR9CNXnNtqIfd2tzP4Y5ceBEIkgdfI+szIBhP4T5OYWw
         +MEwEagakI2rg6Ca22DEPX/q2VY/Pc5ophOYKPWY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.6 127/606] iommu/amd: Do not loop forever when trying to increase address space
Date:   Mon,  8 Jun 2020 19:04:12 -0400
Message-Id: <20200608231211.3363633-127-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 5b8a9a047b6cad361405c7900c1e1cdd378c4589 ]

When increase_address_space() fails to allocate memory, alloc_pte()
will call it again until it succeeds. Do not loop forever while trying
to increase the address space and just return an error instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/r/20200504125413.16798-3-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1d8634250afc..18c995a16d80 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1500,8 +1500,19 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
 	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
-		*updated = increase_address_space(domain, address, gfp) || *updated;
+		bool upd = increase_address_space(domain, address, gfp);
+
+		/* Read new values to check if update was successful */
 		amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+		/*
+		 * Return an error if there is no memory to update the
+		 * page-table.
+		 */
+		if (!upd && (address > PM_LEVEL_SIZE(pgtable.mode)))
+			return NULL;
+
+		*updated = *updated || upd;
 	}
 
 
-- 
2.25.1

