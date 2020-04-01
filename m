Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E4BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B2B20719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbgDAVht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:37:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34568 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbgDAVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:37:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BA6642976A2
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 3/3] rkisp1: Fix wrong PHY config dependency
Date:   Wed,  1 Apr 2020 18:37:21 -0300
Message-Id: <20200401213721.24173-4-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200401213721.24173-1-ezequiel@collabora.com>
References: <20200401213721.24173-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of depending on the Rockchip PHY driver the ISP driver
should really depend on CONFIG_GENERIC_PHY_MIPI_DPHY,
given all it needs is the phy_mipi_dphy_get_default_config() symbol.

Fix it.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/rkisp1/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/rkisp1/Kconfig b/drivers/staging/media/rkisp1/Kconfig
index b859a493caba..e3ba6826fbb0 100644
--- a/drivers/staging/media/rkisp1/Kconfig
+++ b/drivers/staging/media/rkisp1/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_ROCKCHIP_ISP1
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_VMALLOC
 	select V4L2_FWNODE
-	select PHY_ROCKCHIP_DPHY_RX0
+	select GENERIC_PHY_MIPI_DPHY
 	default n
 	help
 	  Enable this to support the Image Signal Processing (ISP) module
-- 
2.26.0.rc2

