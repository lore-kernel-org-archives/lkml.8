Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5393120722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgCZVLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:11:25 -0400
Received: from sauhun.de ([88.99.104.3]:54372 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgCZVKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:09 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 296522C1F87;
        Thu, 26 Mar 2020 22:10:08 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] drm/nouveau/therm: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:10:03 +0100
Message-Id: <20200326211005.13301-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c
index 03b355dabab3..abf3eda683f0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c
@@ -36,8 +36,8 @@ probe_monitoring_device(struct nvkm_i2c_bus *bus,
 
 	request_module("%s%s", I2C_MODULE_PREFIX, info->type);
 
-	client = i2c_new_device(&bus->i2c, info);
-	if (!client)
+	client = i2c_new_client_device(&bus->i2c, info);
+	if (IS_ERR(client))
 		return false;
 
 	if (!client->dev.driver ||
-- 
2.20.1

