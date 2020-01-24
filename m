Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC36D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863632;
	bh=f65VTPO8u6bQ5GHMkJCZvDMOveFCx/y9+niTtYoiPO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l0fcEMFazmnEGrxizZCf9L6UUfrtU55OjrhLQq6OV1kw4eoS/Ugne9/UC8SZtvet3
	 mORbKUNe11IYl8w6Gvw/Fl5UT/r4OTABs4rZ98fvoBcmxPiVJhCAW3rR33ZMb2oCpF
	 JHGPD5mvFFN7BeLqRlN5uGpWBWdg+4OeU3m54NqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbgAXLAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733185AbgAXLA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:28 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC822075D;
        Fri, 24 Jan 2020 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863628;
        bh=f65VTPO8u6bQ5GHMkJCZvDMOveFCx/y9+niTtYoiPO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhNagVxlH+1PZF7ffhy/RLbGec5S+zWzlpIP/Um0+M6QtNwD4nVbHhRMto3uh+QYo
         3iGGm3k7kv9F/QM3MqjNTgIPSJ5rzmXKqKd40xGtCNL5Bmrgqx2AUFRCniNVfTLRgX
         dj05rGU/kR3OR3xLlVUVBdYcmI2ohZZtagjtyWyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/639] drm/msm: fix unsigned comparison with less than zero
Date:   Fri, 24 Jan 2020 10:23:34 +0100
Message-Id: <20200124093052.956743211@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit dfdb3be43ef1195c491e6c3760b922acb52e3575 ]

The return from the call to _mixer_stages can be a negative error
code however this is being assigned to an unsigned variable 'stages'
hence the check is always false. Fix this by making 'stages' an
int.

Detected by Coccinelle ("Unsigned expression compared with zero:
stages < 0")

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 06be7cf7ce505..79bafea663542 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -310,7 +310,7 @@ static void dpu_hw_ctl_setup_blendstage(struct dpu_hw_ctl *ctx,
 	u32 mixercfg = 0, mixercfg_ext = 0, mix, ext;
 	u32 mixercfg_ext2 = 0, mixercfg_ext3 = 0;
 	int i, j;
-	u8 stages;
+	int stages;
 	int pipes_per_stage;
 
 	stages = _mixer_stages(ctx->mixer_hw_caps, ctx->mixer_count, lm);
-- 
2.20.1



