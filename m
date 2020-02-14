Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B95C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DB72187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698573;
	bh=Bi9cwXXimFbWNix7aSP9cjB9eNvaXUe5lQELcxB3Lbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2JUXdpQHNGHT/MXMsSsFQ+o2zVc008idBlvX7VnuxBxig/cgXkLLJQCvPbrJTWfW
	 Z14z5X/b1D2VsQDbY87qfFZk0QhOq9h7oM0+dry4/BBuEuNGQkvnGu8pwqeel+3WrF
	 9Hz9ndW/LxVyjBS2lXKLfnoe+RhQ/G6ntPcejrvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394003AbgBNQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405405AbgBNQWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:22:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA934246DC;
        Fri, 14 Feb 2020 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697334;
        bh=Bi9cwXXimFbWNix7aSP9cjB9eNvaXUe5lQELcxB3Lbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQnB1P87KLzLLxGGuS1SoqD/id2D9IpfQZLFZJqp4VC2+PLACDaO9Esfo2JKZVYsc
         70zgiOmFltAq/3c9f1fCnj8q+nFnsUdNWriE0DO+8fMBjtwcdtYu+7RQ9cglft77Yg
         n6WORklmKWUsV9qLMF/ctXOQMHP5oq+xITgslLUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 041/141] drm/gma500: remove set but not used variable 'channel_eq'
Date:   Fri, 14 Feb 2020 11:19:41 -0500
Message-Id: <20200214162122.19794-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit a7adabeece570b8a566dd592219410456676796e ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/gma500/cdv_intel_dp.c: In function cdv_intel_dp_complete_link_train:
drivers/gpu/drm/gma500/cdv_intel_dp.c:1596:7: warning: variable channel_eq set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1573902268-117518-1-git-send-email-zhengbin13@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index c52f9adf5e04c..af2cc63f3dcce 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1593,7 +1593,6 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
 {
 	struct drm_device *dev = encoder->base.dev;
 	struct cdv_intel_dp *intel_dp = encoder->dev_priv;
-	bool channel_eq = false;
 	int tries, cr_tries;
 	u32 reg;
 	uint32_t DP = intel_dp->DP;
@@ -1601,7 +1600,6 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
 	/* channel equalization */
 	tries = 0;
 	cr_tries = 0;
-	channel_eq = false;
 
 	DRM_DEBUG_KMS("\n");
 		reg = DP | DP_LINK_TRAIN_PAT_2;
@@ -1647,7 +1645,6 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
 
 		if (cdv_intel_channel_eq_ok(encoder)) {
 			DRM_DEBUG_KMS("PT2 train is done\n");
-			channel_eq = true;
 			break;
 		}
 
-- 
2.20.1

