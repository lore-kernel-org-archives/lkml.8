Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3FC34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62E820656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgBQTjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:39:14 -0500
Received: from 8bytes.org ([81.169.241.247]:54540 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgBQTjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:10 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C2AD60E; Mon, 17 Feb 2020 20:39:07 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu/vt-d: Simplify check in identity_mapping()
Date:   Mon, 17 Feb 2020 20:38:58 +0100
Message-Id: <20200217193858.26990-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217193858.26990-1-joro@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function only has one call-site and there it is never called with
dummy or deferred devices. Simplify the check in the function to
account for that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 16e47ca505eb..0b5a0fadbc0c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2916,7 +2916,7 @@ static int identity_mapping(struct device *dev)
 	struct device_domain_info *info;
 
 	info = dev->archdata.iommu;
-	if (info && info != DUMMY_DEVICE_DOMAIN_INFO && info != DEFER_DEVICE_DOMAIN_INFO)
+	if (info)
 		return (info->domain == si_domain);
 
 	return 0;
-- 
2.17.1

