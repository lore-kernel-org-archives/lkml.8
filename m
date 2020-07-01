Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B04C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776D52077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgGAOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:10:20 -0400
Received: from sym2.noone.org ([178.63.92.236]:34644 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgGAOKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:10:19 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49xjmV0ZnNzvjc1; Wed,  1 Jul 2020 16:10:17 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] phy: zynqmp: Fix unused-function compiler warning
Date:   Wed,  1 Jul 2020 16:10:17 +0200
Message-Id: <20200701141017.26931-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200701090438.21224-1-tklauser@distanz.ch>
References: <20200701090438.21224-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark xpsgtr_suspend and xpsgtr_resume as __maybe_unused to fix the
following compiler warning when building with !CONFIG_PM_SLEEP:

drivers/phy/xilinx/phy-zynqmp.c:830:12: warning: ‘xpsgtr_resume’ defined but not used [-Wunused-function]
  830 | static int xpsgtr_resume(struct device *dev)
      |            ^~~~~~~~~~~~~
drivers/phy/xilinx/phy-zynqmp.c:819:12: warning: ‘xpsgtr_suspend’ defined but not used [-Wunused-function]
  819 | static int xpsgtr_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~

Also drop the existing #ifdef CONFIG_PM so the functions are always
compile-checked regardless of CONFIG_PM and/or CONFIG_PM_SLEEP being
set.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/phy/xilinx/phy-zynqmp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 8babee2ce9ec..2b0f921b6ee3 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -815,8 +815,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
  * Power Management
  */
 
-#ifdef CONFIG_PM
-static int xpsgtr_suspend(struct device *dev)
+static int __maybe_unused xpsgtr_suspend(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
 
@@ -827,7 +826,7 @@ static int xpsgtr_suspend(struct device *dev)
 	return 0;
 }
 
-static int xpsgtr_resume(struct device *dev)
+static int __maybe_unused xpsgtr_resume(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
 	unsigned int icm_cfg0, icm_cfg1;
@@ -854,7 +853,6 @@ static int xpsgtr_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops xpsgtr_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xpsgtr_suspend, xpsgtr_resume)
-- 
2.27.0

