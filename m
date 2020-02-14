Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA29C3B1A5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE8B24682
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698805;
	bh=WejT3Jlm73icaZYufA+h2E/dA+9hbApxdmiA8FvbewE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfGMptsc69k2moQwbEDelVzPOZtqchx3i5neCqN0LdkPE0g6Tx19RtAsN/C3/PFgB
	 L8EaLqzN6ndRo4XvnuruNShW8pSBPiZd2ENhlBQamyb6UdxMirXWkX3Bug2g14a0H5
	 GvM3nVfrnGJOvqMAB5vGv3tYpNzTg+nNbiVtXsmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405365AbgBNQVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405109AbgBNQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:20:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E5F2472C;
        Fri, 14 Feb 2020 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697204;
        bh=WejT3Jlm73icaZYufA+h2E/dA+9hbApxdmiA8FvbewE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18LPU1mTGvyoZmVX6Y9BlIaffz0Sg0hn1y/GAq8Q2ih/QDMi0N10lljAYoOQI3UxP
         LMC0nWFFTWweZoCRR+lBdXJg7hyYWZpJIBUOrJzcDFDJ5fGKCEgcAK/VStyLSO7CQn
         nZysXUNce0oFiDwwDNf1gPaWv84UZgTjg41tk+f8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 131/186] iommu/arm-smmu-v3: Use WRITE_ONCE() when changing validity of an STE
Date:   Fri, 14 Feb 2020 11:16:20 -0500
Message-Id: <20200214161715.18113-131-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit d71e01716b3606a6648df7e5646ae12c75babde4 ]

If, for some bizarre reason, the compiler decided to split up the write
of STE DWORD 0, we could end up making a partial structure valid.

Although this probably won't happen, follow the example of the
context-descriptor code and use WRITE_ONCE() to ensure atomicity of the
write.

Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 09eb258a9a7de..29feafa8007fb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1145,7 +1145,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	arm_smmu_sync_ste_for_sid(smmu, sid);
-	dst[0] = cpu_to_le64(val);
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(dst[0], cpu_to_le64(val));
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 
 	/* It's likely that we'll want to use the new STE soon */
-- 
2.20.1

