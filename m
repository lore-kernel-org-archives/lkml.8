Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB714C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989892053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200832;
	bh=Cbm9NWmK9mpFfahIoT9+kEcREyTJA5wATb0Y07W3Zkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NuhYidC8waFZngzt0blzM4RcMsFZYR17kNqo3qGUySJjuLJ+S2kBr+rxOQX6y9lfQ
	 N8mYXTlHOcQUcvNWbb36apQhlgje/NpT3lLdN4Lm9q6OUgsurTQcAmh63vJiGVXDhI
	 L3O8lqFnvsjuZV0fj71CGZhp9wt9IIorg9ZGJYm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgAPRIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388450AbgAPRIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6508320730;
        Thu, 16 Jan 2020 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194480;
        bh=Cbm9NWmK9mpFfahIoT9+kEcREyTJA5wATb0Y07W3Zkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1amk1Up1ZlD5lGMay8KOGF7FaTOYx/oWRtCCUDs6qXxEy0JxLoE5WafijHyv3Xj36
         o5/Sc0XfRuhSYNJUh84geaGxugZl98PkwBS2UQE6j1eSLh+o07BcoQCnFMCuEdLD1V
         trFq2ihjnhg2PtiomnEXO7WdIFRN2BuQ7HDL28OQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 382/671] iommu: Use right function to get group for device
Date:   Thu, 16 Jan 2020 12:00:20 -0500
Message-Id: <20200116170509.12787-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 57274ea25736496ee019a5c40479855b21888839 ]

The iommu_group_get_for_dev() will allocate a group for a
device if it isn't in any group. This isn't the use case
in iommu_request_dm_for_dev(). Let's use iommu_group_get()
instead.

Fixes: d290f1e70d85a ("iommu: Introduce iommu_request_dm_for_dev()")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d588b6844f5f..3d69c8205c52 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1899,9 +1899,9 @@ int iommu_request_dm_for_dev(struct device *dev)
 	int ret;
 
 	/* Device must already be in a group before calling this function */
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+	group = iommu_group_get(dev);
+	if (!group)
+		return -EINVAL;
 
 	mutex_lock(&group->mutex);
 
-- 
2.20.1

