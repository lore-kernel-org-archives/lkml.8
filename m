Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65287C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A520663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193418;
	bh=01ET8Gg7lfZIhp7HRE9ih7YqKpGc66ZmobZq3MFHQ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lB+qnzBzchPIgSmVnuNGnW6HwwzY0dDPj7J/Wv678+nveqxSN5o233+EdOjQS0ESq
	 H89J2MZWCwZQZg5KR0dqn+CRtS5v0zaKBQb0jV4WtKGxa1u8uh17GXHdns7gO5yKPd
	 f01sXL2mHEzcAQvqpZagCt6kBlY5tHsq99ZGWv38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgAPQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbgAPQrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:47:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F21D214AF;
        Thu, 16 Jan 2020 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193266;
        bh=01ET8Gg7lfZIhp7HRE9ih7YqKpGc66ZmobZq3MFHQ+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMQRVr3amkEVSQtT6CM7WfuvAuvmZkdhY/2PYTraeu65qPB7Zm5zgAiXZXyv+RVku
         9UNvv4ktMFKmFTMdB+1LAAHqnugBcKEZ2FvviuiVk/MB98cQddj1Gf/ssfX8klVVBv
         eXJSmUV9cIAONI4eDTKhkaLJQYm9My0ote2ejVnw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 060/205] drm/tegra: Fix ordering of cleanup code
Date:   Thu, 16 Jan 2020 11:40:35 -0500
Message-Id: <20200116164300.6705-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 051172e8c1ceef8749f19faacc1d3bef65d20d8d ]

Commit Fixes: b9f8b09ce256 ("drm/tegra: Setup shared IOMMU domain after
initialization") changed the initialization order of the IOMMU related
bits but didn't update the cleanup path accordingly. This asymmetry can
cause failures during error recovery.

Fixes: b9f8b09ce256 ("drm/tegra: Setup shared IOMMU domain after initialization")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/drm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 6fb7d74ff553..bc7cc32140f8 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -201,19 +201,19 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 	if (tegra->hub)
 		tegra_display_hub_cleanup(tegra->hub);
 device:
-	host1x_device_exit(device);
-fbdev:
-	drm_kms_helper_poll_fini(drm);
-	tegra_drm_fb_free(drm);
-config:
-	drm_mode_config_cleanup(drm);
-
 	if (tegra->domain) {
 		mutex_destroy(&tegra->mm_lock);
 		drm_mm_takedown(&tegra->mm);
 		put_iova_domain(&tegra->carveout.domain);
 		iova_cache_put();
 	}
+
+	host1x_device_exit(device);
+fbdev:
+	drm_kms_helper_poll_fini(drm);
+	tegra_drm_fb_free(drm);
+config:
+	drm_mode_config_cleanup(drm);
 domain:
 	if (tegra->domain)
 		iommu_domain_free(tegra->domain);
-- 
2.20.1

