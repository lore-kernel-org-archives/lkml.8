Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F336C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFB120704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864765;
	bh=vz2OTQwUDciEzjhTFliF4TOLbUaJjLaPiYKntIht4+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9O3m0kiM5PMUkPAXLOYK+koOelfwtIQTQW+ybkN938XiPJoW0RolA3pQxvokXAcq
	 bkvd44dWWHcn5OQkgqPHta9LoIeLw8bajbldf6K4jG1j9jULZehTt3jnLeWlk2YW20
	 E7XwklHQ95+PWCGWKnDbMsoCgQRvvFpDGZyYXqDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbgAXLTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390763AbgAXLTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:19:16 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E70B20704;
        Fri, 24 Jan 2020 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864756;
        bh=vz2OTQwUDciEzjhTFliF4TOLbUaJjLaPiYKntIht4+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MF35OD0uSAMaNAD4m8hvm4yAUX+vwpyQZY1An3IgnOyk/II6/IEjxFb2XJ+l6cz+n
         W1pNveVbM4o94B44mhuqri8zOqjo5XhJf3pkG5OfSWu0pNB63ymXI9xz6eHU1JgQA1
         OBqaVte35sD1sTtYlyLdM/DClLqoFt3j+Ek3pyLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 344/639] iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU
Date:   Fri, 24 Jan 2020 10:28:34 +0100
Message-Id: <20200124093130.217168640@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 5daab58043ee2bca861068e2595564828f3bc663 ]

The kernel parameter igfx_off is used by users to disable
DMA remapping for the Intel integrated graphic device. It
was designed for bare metal cases where a dedicated IOMMU
is used for graphic. This doesn't apply to virtual IOMMU
case where an include-all IOMMU is used.  This makes the
kernel parameter work with virtual IOMMU as well.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Fixes: c0771df8d5297 ("intel-iommu: Export a flag indicating that the IOMMU is used for iGFX.")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b9af2419006f8..abbbc614c5225 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3387,9 +3387,12 @@ static int __init init_dmars(void)
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
 #ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
-	iommu_identity_mapping |= IDENTMAP_GFX;
+	dmar_map_gfx = 0;
 #endif
 
+	if (!dmar_map_gfx)
+		iommu_identity_mapping |= IDENTMAP_GFX;
+
 	check_tylersburg_isoch();
 
 	if (iommu_identity_mapping) {
-- 
2.20.1



