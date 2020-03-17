Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E0FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5E420714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443569;
	bh=XSGhuHNI/VPGE2vptRiHyZduoAI3jkFtGWogOwnJSq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tP/XQjL8hSo6FXGIf7LiUg4VFVAdhlQD2F6Vg/owAZTcungTV6Mk6yHsrC5/2l0Mm
	 HQpILs3O5gLu0JfnQHdyyoR0LDKSkQhBmYm02J9lLgSAb4dSGOk2xgf7jigfi7f52X
	 AGqKKK6ZYbQlR74L1akMVLfj9UDYKaR2WDAs/TuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgCQLMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgCQLMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:12:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7529205ED;
        Tue, 17 Mar 2020 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443563;
        bh=XSGhuHNI/VPGE2vptRiHyZduoAI3jkFtGWogOwnJSq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3YDJDjS3K4uttkoifDjb0bA1r88Qkk68Uge2O+8F+agTXXJ77zt+0ohis8c/nLNj
         G5hAW6KnT1J81iX+nIexpjBccV+L8hdT8DrKaTbT/JmEaZNFaNLOCVo9xA5QJfoUBA
         WubdDhZwM63UiC+wvILFN2bxfvCJlkHU1dWSSYDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Yonghyun Hwang <yonghyun@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.5 123/151] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge page
Date:   Tue, 17 Mar 2020 11:55:33 +0100
Message-Id: <20200317103335.194886838@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghyun Hwang <yonghyun@google.com>

commit 77a1bce84bba01f3f143d77127b72e872b573795 upstream.

intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
page onto its corresponding physical address. This commit fixes the bug by
accomodating the level of page entry for the IOVA and adds IOVA's lower
address to the physical address.

Cc: <stable@vger.kernel.org>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
Fixes: 3871794642579 ("VT-d: Changes to support KVM")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5568,8 +5568,10 @@ static phys_addr_t intel_iommu_iova_to_p
 	u64 phys = 0;
 
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-	if (pte)
-		phys = dma_pte_addr(pte);
+	if (pte && dma_pte_present(pte))
+		phys = dma_pte_addr(pte) +
+			(iova & (BIT_MASK(level_to_offset_bits(level) +
+						VTD_PAGE_SHIFT) - 1));
 
 	return phys;
 }


