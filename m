Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D44C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F04720716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222648;
	bh=UwibSSP19Nk7c0068KV+c2LMs1N3jXG8jD/+vJPtPHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QC8ahNU21nRomn6LcVkOGX5HTE2f2ZoZ3uhSxYLMA+O7JIyJBDEWUXI7/lRdBHpkQ
	 /PsHau4t/wdn0BWIqnwwS0JoL3A51Y4VQDfEiQTalclPqgaQBFDb9UEXSIhRm7Hpid
	 /KNSI+9Ah1xm8mqmLEe61E9uU4AueahsSFosB0cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgA1OKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:10:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgA1OKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE8924688;
        Tue, 28 Jan 2020 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220634;
        bh=UwibSSP19Nk7c0068KV+c2LMs1N3jXG8jD/+vJPtPHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoljT13jXLu7tIpbIFLZe1B3FCmXHblUaeNcgpio3xTOUypIEZliSxA/QG7knpl/8
         bs1TK3K14SIWFUgxJSr32wHOp6q2lGCs6bFbXOd6agOAPuqeJry7ikUQHjSeWVi5A9
         Jol6bAuADcpMRpRWmlJwyo88xVW9Jx0V/l4IOFEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 086/183] iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU
Date:   Tue, 28 Jan 2020 15:05:05 +0100
Message-Id: <20200128135838.584494547@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
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
index b965561a41627..a2005b82ec8ff 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3259,9 +3259,12 @@ static int __init init_dmars(void)
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



