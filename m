Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA598C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E9124650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701244;
	bh=B4hsJd84MGsALojLjJWgnNZLBKF6xB1oL1k8gRdTYlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igzTwh5DJtPXDQVsoDgfbEKc2uLIR0TJEMk1aeubfZinODFudVWkfKJVjzZ+VJvxg
	 5fZ1/5en0hLN19tPBQmVOrX/5718VL6q6bhPs0EbrMrplX2kVMbHDkh1s5MR4rKd7S
	 Qki/ljx4fgyZG3Z4UqsdBwNnOCJfIOE6+z8sNUS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbgBNQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390727AbgBNQHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:07:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61021206D7;
        Fri, 14 Feb 2020 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696460;
        bh=B4hsJd84MGsALojLjJWgnNZLBKF6xB1oL1k8gRdTYlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8fELqIbOqfsWeLmyu6/ZDrlA+5x70TiaLSo2hWaSmuyu7QZymXQTjSGVMRJqJbCY
         kzIQuBpSi2pkRe0+kGELxp7DvV353TV/zQb4Fm5791KAsLRrXwmQrk+bW1HbC7TX+f
         tHQdMzfs6RaFed/jUwAaHkFlVIHH2eokOeSG0FkY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 271/459] iommu/arm-smmu-v3: Populate VMID field for CMDQ_OP_TLBI_NH_VA
Date:   Fri, 14 Feb 2020 10:58:41 -0500
Message-Id: <20200214160149.11681-271-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[ Upstream commit 935d43ba272e0001f8ef446a3eff15d8175cb11b ]

CMDQ_OP_TLBI_NH_VA requires VMID and this was missing since
commit 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask
for CMD_TLBI_S2_IPA"). Add it back.

Fixes: 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ed90361b84dc7..ee8d48d863e16 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -856,6 +856,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
-- 
2.20.1

