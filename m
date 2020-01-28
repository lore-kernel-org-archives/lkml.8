Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3708C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DC124690
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221206;
	bh=nSP8sb8U6UsTtSCBrxZasHOtuaL9If0F0xYS33SxkBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ucbr/xcjimh4dCCrEGx2M+XFQW25C4fNLHqXirwZtAfwsroRt9dgDR65nt017q1lT
	 f7hsi30VC39a2BwzlibqWb3xpY6oCv6ssU9vzEGlPN9IBBQbs3PbcnWahzD12xAoWW
	 G/RjHqhAD7po7mqjyqhjfn6XLVfmd3n5EsC5wvYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgA1OUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgA1OT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB5C2071E;
        Tue, 28 Jan 2020 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221198;
        bh=nSP8sb8U6UsTtSCBrxZasHOtuaL9If0F0xYS33SxkBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXBI2FeTYxfpyM6ozK+u16T/nyBPlgNrNj01l+kBvnGsfREVToHj2YATT8OXOFF2N
         Vh445j4HeLAaEAEWJnA37xKcyeFy3JWnJoc4QtErRb9XkK6ihjnKVicYr/+7XMm7LV
         /jA3+NzRDaTV8FaGKmHNjN1HaQqoK+4UFFHSuNBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 128/271] iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU
Date:   Tue, 28 Jan 2020 15:04:37 +0100
Message-Id: <20200128135902.127906391@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 25cc6ae87039d..5c6e0a9fd2f36 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3345,9 +3345,12 @@ static int __init init_dmars(void)
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



