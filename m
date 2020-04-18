Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51ACC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75CB221F4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218960;
	bh=gNEqwMIk6W4ZqVW7sBL8/0aKuAMn8CjvIZXrWp1EKoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FuB214w36OAd8XIAGZ9eJeioSmpwi+4jRvmHAPaEkCxP3jrvW2kxhXe9198nPZLYs
	 M8jQBXS+Yv3S0AmwckIV5hZovMEkycVvkUe3/SONIi5jAFO5tCRuZuj2y74bLV3hNH
	 0KnuJNlE2F958DeVmL6gYotCRQa4wUSUZFyDse5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDROJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgDROJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040B92220A;
        Sat, 18 Apr 2020 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218956;
        bh=gNEqwMIk6W4ZqVW7sBL8/0aKuAMn8CjvIZXrWp1EKoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBVoqO4f4J0IyqPuXmA0NCcYE7O1T6SXlCRcP9yLfTW+fVMY+KtLhECfAIgY533U6
         x4WEDgDo4Kj/CwjSzRImvRgH/p8WKMKIsOLB1A9WmhOeKLpdgRNdkSTm4y/UZNybBC
         S5jEN4Degc4PdVyisUwowAiO7udwTMGE2b8ijHPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.5 05/75] iommu/vt-d: Fix page request descriptor size
Date:   Sat, 18 Apr 2020 10:08:00 -0400
Message-Id: <20200418140910.8280-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit 52355fb1919ef7ed9a38e0f3de6e928de1f57217 ]

Intel VT-d might support PRS (Page Reqest Support) when it's
running in the scalable mode. Each page request descriptor
occupies 32 bytes and is 32-bytes aligned. The page request
descriptor offset mask should be 32-bytes aligned.

Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 518d0b2d12afd..5313d043a6cf2 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -502,7 +502,7 @@ struct page_req_dsc {
 	u64 priv_data[2];
 };
 
-#define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
 static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 {
-- 
2.20.1

