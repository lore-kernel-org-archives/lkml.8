Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07446C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A6E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272175;
	bh=h5EqkVv0DO84hWwSL2dDOcUgBtNX3MwH2uaDNvbe5qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=juA+G/vjnoM4enszbHpIc8atrj23kbQYuztdIvoqwYvv9gzEAG65S4sUi20maT9I/
	 9g4DIJZcjIQiSS/CSwjWzkW/iaJqswrYI4cJVDR5RVH+W8Cy5uL9zHZUj5AlkZiBPc
	 K0/BM4wrfjHVEj/63604ClBmG/qYFoSer2Eut30s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgBUICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730143AbgBUICw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:02:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22AFB2073A;
        Fri, 21 Feb 2020 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272171;
        bh=h5EqkVv0DO84hWwSL2dDOcUgBtNX3MwH2uaDNvbe5qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRDimnuZKx6OPk8C+H5UrI/L6KaK+E+8CjHoMaMMt4gntylcqdHDqa4Pqf7ie/5vs
         byWRR4jf672oMGOaTo3nOuonkYpbTYPLs3JOOlKD5968X+KQwH1Itoe7J6AlI5zE2C
         w+xmbowaqDesXxSTMAztVn6s+yZu4hm8yRXjA+zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/344] iommu/vt-d: Fix off-by-one in PASID allocation
Date:   Fri, 21 Feb 2020 08:37:22 +0100
Message-Id: <20200221072353.034323020@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit 39d630e332144028f56abba83d94291978e72df1 ]

PASID allocator uses IDR which is exclusive for the end of the
allocation range. There is no need to decrement pasid_max.

Fixes: af39507305fb ("iommu/vt-d: Apply global PASID in SVA")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index dca88f9fdf29a..ff7a3f9add325 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -317,7 +317,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
 		ret = intel_pasid_alloc_id(svm,
 					   !!cap_caching_mode(iommu->cap),
-					   pasid_max - 1, GFP_KERNEL);
+					   pasid_max, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
 			kfree(sdev);
-- 
2.20.1



