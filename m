Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59973204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHUPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:00:37 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40807 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgHUPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:00:27 -0400
Received: from lhopital-XPS-13-9360.home (lfbn-tou-1-1372-bdcst.w90-89.abo.wanadoo.fr [90.89.180.255])
        (Authenticated sender: kevin.lhopital@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPA id 0D0D010000F;
        Fri, 21 Aug 2020 15:00:23 +0000 (UTC)
From:   =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, wens@csie.org, yong.deng@magewell.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com,
        =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
Subject: [PATCH 1/7] media: sun6i-csi: Fix the bpp for 10-bit bayer formats
Date:   Fri, 21 Aug 2020 16:59:29 +0200
Message-Id: <20200821145935.20346-2-kevin.lhopital@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821145935.20346-1-kevin.lhopital@bootlin.com>
References: <20200821145935.20346-1-kevin.lhopital@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10-bit bayer formats are aligned to 16 bits in memory, so this is what
needs to be used as bpp for calculating the size of the buffers to
allocate.

Signed-off-by: Kévin L'hôpital <kevin.lhopital@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index c626821aaedb..8b83d15de0d0 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -100,7 +100,7 @@ static inline int sun6i_csi_get_bpp(unsigned int pixformat)
 	case V4L2_PIX_FMT_SGBRG10:
 	case V4L2_PIX_FMT_SGRBG10:
 	case V4L2_PIX_FMT_SRGGB10:
-		return 10;
+		return 16;
 	case V4L2_PIX_FMT_SBGGR12:
 	case V4L2_PIX_FMT_SGBRG12:
 	case V4L2_PIX_FMT_SGRBG12:
-- 
2.17.1

