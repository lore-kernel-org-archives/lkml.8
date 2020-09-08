Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E2FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FD32080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588393;
	bh=CyQWGRvj67cqowJfDn4vuv/txn4szGizTTVBdxHOyvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yE3QSF5TRH4ffGW2liUpEt3zUFRCiJoK+kzYvvirgAejVnxvxIlnw56uG5WclrDar
	 kVOWmvrasrKlTvz80Senzp4+qJyWk5avLUX8KOIOUVpfR3azwDfL+WR6euRFfIiRb1
	 LiIZ5FazyNu/BDZ4AQ3aIx2yqasfHNOyW0r40Rck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbgIHSGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbgIHQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215A3247C4;
        Tue,  8 Sep 2020 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580286;
        bh=CyQWGRvj67cqowJfDn4vuv/txn4szGizTTVBdxHOyvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th7dMz3k+8IOuzYO4UfKrHwcC1mNucMnaoxwDr/2cz1xmGbz3xqd/+CMU1Mx2i4gm
         RrL+knsh7U7V6u1TJwZIQfmpeDYDO8HvJUIhOzrL9cGg33JCOyPVzKAOfgw4M0/mW5
         dm7rhqNW415HPIR42eXlV/CJqAlpaIuutIB2CvsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/65] drm/msm: add shutdown support for display platform_driver
Date:   Tue,  8 Sep 2020 17:25:49 +0200
Message-Id: <20200908152217.254848720@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d9c0687435a05..c59240b566d83 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1134,6 +1134,13 @@ static int msm_pdev_remove(struct platform_device *pdev)
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
 	{ .compatible = "qcom,mdp4", .data = (void *)4 },	/* MDP4 */
 	{ .compatible = "qcom,mdss", .data = (void *)5 },	/* MDP5 MDSS */
@@ -1144,6 +1151,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 static struct platform_driver msm_platform_driver = {
 	.probe      = msm_pdev_probe,
 	.remove     = msm_pdev_remove,
+	.shutdown   = msm_pdev_shutdown,
 	.driver     = {
 		.name   = "msm",
 		.of_match_table = dt_match,
-- 
2.25.1



