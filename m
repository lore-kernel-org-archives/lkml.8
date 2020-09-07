Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8355C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8942C207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497466;
	bh=WrnlAqu4pYVCGlc1rGq/4Sm+z4IbESJor4R40Xlh220=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2B5D4U6nIbtEbgI9sEKwqfgZgIfo5wqy5t3Q1fOWkwG9Xiq2t+/g3vEQ0VP7HWgcO
	 9+CiUGxzrVzxCU0hLyqrLNxXNbJkH3rKpb2loqP2E0K90BZvPrN3azXasa7gzA655N
	 Vm5cSfG6hPcGpZCrHEhsAS1DnXgq0kNya3yeoUvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgIGQvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbgIGQe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3233921D82;
        Mon,  7 Sep 2020 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496498;
        bh=WrnlAqu4pYVCGlc1rGq/4Sm+z4IbESJor4R40Xlh220=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVGkQKgh5+KAjcvo1nYsaUnddblDg2/2nhNN2jO1EQWiQaBVszLKczR5GH9twPo95
         ZIMRG3/rR/diIlqiAaKWOyQmlorJCuqWPjerabcVHUxBQjf6gy2+doOEJhuNbcWFAb
         dzL3hQiiVvJoywddVs5N54grrK8OUj+VdXN0f2Xw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 25/26] iommu/amd: Do not use IOMMUv2 functionality when SME is active
Date:   Mon,  7 Sep 2020 12:34:25 -0400
Message-Id: <20200907163426.1281284-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163426.1281284-1-sashal@kernel.org>
References: <20200907163426.1281284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 2822e582501b65707089b097e773e6fd70774841 ]

When memory encryption is active the device is likely not in a direct
mapped domain. Forbid using IOMMUv2 functionality for now until finer
grained checks for this have been implemented.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200824105415.21000-3-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_v2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 58da65df03f5e..7a59a8ebac108 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -776,6 +776,13 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	might_sleep();
 
+	/*
+	 * When memory encryption is active the device is likely not in a
+	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
+	 */
+	if (mem_encrypt_active())
+		return -ENODEV;
+
 	if (!amd_iommu_v2_supported())
 		return -ENODEV;
 
-- 
2.25.1

