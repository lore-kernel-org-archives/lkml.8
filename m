Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF33C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E82208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498176;
	bh=cKkhVZVcMcX9KzrcnCMkq38mF8puxm9XVcCbDDzK8Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oc1pDaflZCZBO05QUQBLfOjQ5ACQUB8h3V4n0ghPni3ZB3RlM52QqrfhG05L+kU5p
	 +7NGp8EX5HloX3pztsl0H69+WosVQ4PjiA54CR/yeNgitLWqY3ksYdj9Kibms9NVjT
	 Z6xtOFqt+En3vmfpNKs07YSIqIqToXXbMao3ctN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgIGRCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgIGQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443A621941;
        Mon,  7 Sep 2020 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496405;
        bh=cKkhVZVcMcX9KzrcnCMkq38mF8puxm9XVcCbDDzK8Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kii9zdSEBVgF/F/Vwt4FEb/8REJzyL5l694rFqOk+jaZJmrKkuk8rl9DrOf/m1gYy
         L75pVoM60W7jYCT89AViNrykzPNROVj6B9HObmzAJ6KQer/BbzPVaWiebLQxcdUGXm
         5CU01kh/Q8/p16/31Kf+bqA9CgHksvHIvBpEL7iE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.8 51/53] iommu/amd: Do not force direct mapping when SME is active
Date:   Mon,  7 Sep 2020 12:32:17 -0400
Message-Id: <20200907163220.1280412-51-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 7cad554887f1c5fd77e57e6bf4be38370c2160cb ]

Do not force devices supporting IOMMUv2 to be direct mapped when memory
encryption is active. This might cause them to be unusable because their
DMA mask does not include the encryption bit.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200824105415.21000-2-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2f22326ee4dfe..547b41e376574 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2650,7 +2650,12 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
-	if (dev_data->iommu_v2)
+	/*
+	 * Do not identity map IOMMUv2 capable devices when memory encryption is
+	 * active, because some of those devices (AMD GPUs) don't have the
+	 * encryption bit in their DMA-mask and require remapping.
+	 */
+	if (!mem_encrypt_active() && dev_data->iommu_v2)
 		return IOMMU_DOMAIN_IDENTITY;
 
 	return 0;
-- 
2.25.1

