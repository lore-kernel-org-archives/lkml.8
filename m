Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68065C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCD1207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ihcmFw3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgEULal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:30:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21597 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgEULal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:30:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590060640; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=lhRGU6l23pWyhwgP/bWEorni345nvViGnvyOWBGS/6U=; b=ihcmFw3QJZu/H8uGaxbjrsBDwTF+YrOLx/rAou3WanQUUL/UmuNxupbXXFTmmcrATmXivp9I
 eY7Q5s+IKkHLgqZg00M+h+NSKzs06yinNhUJc+c4kXOiEcJzHepWQZdnG6JJbonfUo8rs9Qo
 0Fi4PkGO3e+DQ82CMKfUVkbtoxs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec66649.7f542eab6148-smtp-out-n01;
 Thu, 21 May 2020 11:30:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C227C433C9; Thu, 21 May 2020 11:30:17 +0000 (UTC)
Received: from guptap1-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: guptap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58119C433C6;
        Thu, 21 May 2020 11:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58119C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=guptap@codeaurora.org
From:   Prakash Gupta <guptap@codeaurora.org>
To:     akpm@linux-foundation.org, mhocko@suse.com, joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Prakash Gupta <guptap@codeaurora.org>
Subject: [PATCH] iommu/dma: limit iova free size to unmmaped iova
Date:   Thu, 21 May 2020 17:00:04 +0530
Message-Id: <20200521113004.12438-1-guptap@codeaurora.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the iova size while freeing based on unmapped size. In absence of
this even with unmap failure, invalid iova is pushed to iova rcache and
subsequently can cause panic while rcache magazine is freed.

Signed-off-by: Prakash Gupta <guptap@codeaurora.org>

:100644 100644 4959f5df21bd 098f7d377e04 M	drivers/iommu/dma-iommu.c

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..098f7d377e04 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -472,7 +472,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!cookie->fq_domain)
 		iommu_tlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size);
+	if (unmapped)
+		iommu_dma_free_iova(cookie, dma_addr, unmapped);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
