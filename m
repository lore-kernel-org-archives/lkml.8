Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907EEC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6780F2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888174;
	bh=lzqFYgyy6yoRheHZxmpz751cu+IUQsJHL+zTbnPYkUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CEQoE00O0+RbcbgMV689uoTRBo5rmyuzK5L9IwLDiXb04riXPUdGEFT84bwDJ8TNF
	 qm5G266QSAjAepyiUgiZ/YWTo3II0o7REIUeN8/Qfm2Kh2piVn111RC/kV+2k98u3E
	 Zsm2PlIeIMTjnFH/w8LSYVMEkEiPQ7cOfCbCe+L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgHaPgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbgHaPav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A9E207EA;
        Mon, 31 Aug 2020 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887850;
        bh=lzqFYgyy6yoRheHZxmpz751cu+IUQsJHL+zTbnPYkUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/oDLGUhLGLdDs0WwbWxpTEozah4VA+iWT5QVJDwhb3RzQPtHKbCPtF1GzecsuJqG
         vmtXucc4Fnkg9DgOJchB4IyDcbdbnonSVqOvfuEhzpdOrXoNgWI2oeEamjeTKM2MFk
         QWGaXYeAfdYJx4Yyt8qxXIP6AOEnK7lhzI4y5X1k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krishna Manikandan <mkrishn@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 06/23] drm/msm: add shutdown support for display platform_driver
Date:   Mon, 31 Aug 2020 11:30:22 -0400
Message-Id: <20200831153039.1024302-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153039.1024302-1-sashal@kernel.org>
References: <20200831153039.1024302-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krishna Manikandan <mkrishn@codeaurora.org>

[ Upstream commit 9d5cbf5fe46e350715389d89d0c350d83289a102 ]

Define shutdown callback for display drm driver,
so as to disable all the CRTCS when shutdown
notification is received by the driver.

This change will turn off the timing engine so
that no display transactions are requested
while mmu translations are getting disabled
during reboot sequence.

Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>

Changes in v2:
	- Remove NULL check from msm_pdev_shutdown (Stephen Boyd)
	- Change commit text to reflect when this issue
	  was uncovered (Sai Prakash Ranjan)

Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index b73fbb65e14b2..4558d66761b3c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1321,6 +1321,13 @@ static int msm_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void msm_pdev_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	drm_atomic_helper_shutdown(drm);
+}
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
 	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
@@ -1332,6 +1339,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 static struct platform_driver msm_platform_driver = {
 	.probe      = msm_pdev_probe,
 	.remove     = msm_pdev_remove,
+	.shutdown   = msm_pdev_shutdown,
 	.driver     = {
 		.name   = "msm",
 		.of_match_table = dt_match,
-- 
2.25.1

