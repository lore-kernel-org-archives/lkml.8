Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B87C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A5C206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975134;
	bh=DL6TgYqI0mVLUzh493KSi5lEYVXC4F0BfeYNs/e9TSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mS+O5/xUrxpXErZPGmfDOyaw3UUTI8D9EdrpnzKeAynL9lver3M5FdnNfu9tuCRxs
	 n+rw7XogXOXsHbt5l3TQu7N856PhvIdVSs4gHW3cMLbg9ViJ5ln29cBbUb4WaqHkO5
	 RYoBam/jm7mcGlTj/BA0/e1IufYKuSn8ehAGMftw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgIAPpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731598AbgIAPmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:42:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E5D2064B;
        Tue,  1 Sep 2020 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974965;
        bh=DL6TgYqI0mVLUzh493KSi5lEYVXC4F0BfeYNs/e9TSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T90H7k+tH42ihP44gQd499LhUrFli6PKACYPOob5Bk3e+GkRi0baY8hzlOzliERwk
         Bqy8aCkuak86UPnUcfDmUc+3M9haoY4SqlrgAjV6h76Jxge6h+W1vi7ZL6WPDBk25d
         yMFa4HyQ7QAS80Kh+GrDR8cZm/NXhQpUVFl1AQQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 158/255] drm/amdkfd: fix the wrong sdma instance query for renoir
Date:   Tue,  1 Sep 2020 17:10:14 +0200
Message-Id: <20200901151008.261580895@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Rui <ray.huang@amd.com>

[ Upstream commit 34174b89bfa495bed9cddcc504fb38feca90fab7 ]

Renoir only has one sdma instance, it will get failed once query the
sdma1 registers. So use switch-case instead of static register array.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index c7fd0c47b2545..1102de76d8767 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -195,19 +195,32 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				unsigned int engine_id,
 				unsigned int queue_id)
 {
-	uint32_t sdma_engine_reg_base[2] = {
-		SOC15_REG_OFFSET(SDMA0, 0,
-				 mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL,
-		SOC15_REG_OFFSET(SDMA1, 0,
-				 mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL
-	};
-	uint32_t retval = sdma_engine_reg_base[engine_id]
+	uint32_t sdma_engine_reg_base = 0;
+	uint32_t sdma_rlc_reg_offset;
+
+	switch (engine_id) {
+	default:
+		dev_warn(adev->dev,
+			 "Invalid sdma engine id (%d), using engine id 0\n",
+			 engine_id);
+		fallthrough;
+	case 0:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
+		break;
+	case 1:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+				mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
+		break;
+	}
+
+	sdma_rlc_reg_offset = sdma_engine_reg_base
 		+ queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL);
 
 	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
-			queue_id, retval);
+		 queue_id, sdma_rlc_reg_offset);
 
-	return retval;
+	return sdma_rlc_reg_offset;
 }
 
 static inline struct v9_mqd *get_mqd(void *mqd)
-- 
2.25.1



