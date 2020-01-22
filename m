Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF4EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1812467F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAVMUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:20:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgAVMUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:20:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB71328;
        Wed, 22 Jan 2020 04:20:03 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5EA33F52E;
        Wed, 22 Jan 2020 04:20:01 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, vincenzo.frascino@arm.com
Subject: [PATCH] drm: tegra: Fix warning in PM ops
Date:   Wed, 22 Jan 2020 12:19:51 +0000
Message-Id: <20200122121951.52639-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra driver can be compiled without CONFIG_PM_SLEEP enabled.
In this case the compilation triggers the warning below:

drivers/gpu/drm/tegra/sor.c:3984:12: warning: ‘tegra_sor_resume’
defined but not used [-Wunused-function]
 3984 | static int tegra_sor_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~
drivers/gpu/drm/tegra/sor.c:3970:12: warning: ‘tegra_sor_suspend’
defined but not used [-Wunused-function]
 3970 | static int tegra_sor_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~

Fix the warning adding __maybe_unused to the PM functions.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/gpu/drm/tegra/sor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index a68d3b36b972..69b9ebee7486 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3912,7 +3912,7 @@ static int tegra_sor_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_sor_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_sor_runtime_suspend(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
@@ -3934,7 +3934,7 @@ static int tegra_sor_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_sor_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_sor_runtime_resume(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
@@ -3967,7 +3967,7 @@ static int tegra_sor_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int tegra_sor_suspend(struct device *dev)
+static int __maybe_unused tegra_sor_suspend(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
@@ -3981,7 +3981,7 @@ static int tegra_sor_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_sor_resume(struct device *dev)
+static int __maybe_unused tegra_sor_resume(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
-- 
2.25.0

