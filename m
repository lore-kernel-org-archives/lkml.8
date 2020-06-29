Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B9AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A806F206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466791;
	bh=vAO465OpKk+SCS9PET52HZA+147K8jdSjeL8eN7Ow4U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SOwB4Sys/D+Y9rujoy7i4CLhXMBnvcRqemCfyufPywk2ppNOMSNTflqNn8LE3RbLu
	 SeQEJuB072HE8LtP1U4uI9x70q1BueeECVS6Oeub3R0h0uXq6H3scmHtOibt/s/xg1
	 PHiBK3ae+/fxIR9tjXE2Y2zyalCOIK8c5ozWQwTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgF2Vju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgF2Ska (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:30 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254F423A32;
        Mon, 29 Jun 2020 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593442246;
        bh=vAO465OpKk+SCS9PET52HZA+147K8jdSjeL8eN7Ow4U=;
        h=From:To:Cc:Subject:Date:From;
        b=nB0aBvqX5FCtYmZxYXZ1jxyYema6RWPmKMQl0LPvkPpBTMVI+xHAorVerQaIe3J9w
         m7tWtyzBTnSFO4hy3bjauGc6o94QXy/hytEyx4Xr7aPPKmu7V3uxY158fdNQqwJ6dc
         +z8oGbmJv6FZR0TkwEAPdfWP7vmXUbMPSWLe76kY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] phy: core: fix code style in devm_of_phy_provider_unregister
Date:   Mon, 29 Jun 2020 20:20:07 +0530
Message-Id: <20200629145010.122675-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/coding-style.rst says:
"functions: they have the opening brace at the beginning of the next
line"

devm_of_phy_provider_unregister() function has opening brace at same
line, so fix it up.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/phy-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a27b8d578d7f..b54522f06245 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1122,7 +1122,8 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
  * of_phy_provider_unregister to unregister the phy provider.
  */
 void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider) {
+	struct phy_provider *phy_provider)
+{
 	int r;
 
 	r = devres_destroy(dev, devm_phy_provider_release, devm_phy_match,
-- 
2.26.2

