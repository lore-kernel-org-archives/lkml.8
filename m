Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3DC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5468520722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623168;
	bh=bdEXXqS0SfsFFqlsqir0mBfb/VHPc3nYHPdaexKlG58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAWg3QvCc21g/TxT/UYvRwauSR3BffanjG+YM5LMBzGi0BYsuUd9jHxPBpcSN2wVe
	 T4O7q5SD9YUwBZQR8EMB2gzNnVzEdwSfy0TvHVy5Wrm4xPaq7ONmyR+8Q140SWupmk
	 5CBvui5aaBhZPRRm6cV6NN6Mxc4M8f1ffs2s8HY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgCSNGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgCSNGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0761220722;
        Thu, 19 Mar 2020 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623163;
        bh=bdEXXqS0SfsFFqlsqir0mBfb/VHPc3nYHPdaexKlG58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9MHy+iG65fJ49on7E3gWAHJ+1haVYLWtRBRS/HJ1q8FpgHMRszlMtqfZLcNFUp/4
         ONzJ16/j1GoqB5coEndZT7vgklm+TFNj9XJ8EesKWBVxskelmfeTDZjShccBX3mglt
         NmhbS5OJoxhsaLdApUAD9DvSGqnqlZ1nb6msaoqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Yonghyun Hwang <yonghyun@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.4 29/93] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge page
Date:   Thu, 19 Mar 2020 13:59:33 +0100
Message-Id: <20200319123934.335068780@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
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
@@ -5017,8 +5017,10 @@ static phys_addr_t intel_iommu_iova_to_p
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


