Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453CE20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbgDBTrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:47:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46432 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:47:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 2E33B28A9AD
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] cedrus: Drop unneeded CONFIG_OF dependency
Date:   Thu,  2 Apr 2020 16:46:53 -0300
Message-Id: <20200402194653.13535-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is perfectly capable of being built without CONFIG_OF.
Remove this dependency, which is useful for compile-only tests.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/sunxi/cedrus/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/Kconfig b/drivers/staging/media/sunxi/cedrus/Kconfig
index 17733e9a088f..59b8d1b29865 100644
--- a/drivers/staging/media/sunxi/cedrus/Kconfig
+++ b/drivers/staging/media/sunxi/cedrus/Kconfig
@@ -3,7 +3,6 @@ config VIDEO_SUNXI_CEDRUS
 	tristate "Allwinner Cedrus VPU driver"
 	depends on VIDEO_DEV && VIDEO_V4L2 && MEDIA_CONTROLLER
 	depends on HAS_DMA
-	depends on OF
 	depends on MEDIA_CONTROLLER_REQUEST_API
 	select SUNXI_SRAM
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.26.0.rc2

