Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2372C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8808D20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDVLOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:14:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDVLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:14:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B6A062A1A8F
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH] media: MAINTAINERS: Fix Hantro, Rga and Rkvdec entries
Date:   Wed, 22 Apr 2020 08:14:03 -0300
Message-Id: <20200422111403.19114-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems recent merges introduced a couple issues
here, so let's fix them all. Also, reorder Rockchip
video decoder as per parse-maintainers.pl script
and add linux-rockchip mailing list.

Reported-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 MAINTAINERS | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09e0137df61d..4d5b06c6fe0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7460,7 +7460,7 @@ L:	linux-media@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
-F:	Documentation/devicetree/bindings/media/rockchip-vpu.txt
+F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
 F:	drivers/staging/media/hantro/
 
 HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
@@ -14465,13 +14465,6 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
-ROCKCHIP VIDEO DECODER DRIVER
-M:	Ezequiel Garcia <ezequiel@collabora.com>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-F:	drivers/staging/media/rkvdec/
-F:	Documentation/devicetree/bindings/media/rockchip,vdec.yaml
-
 ROCKCHIP ISP V1 DRIVER
 M:	Helen Koike <helen.koike@collabora.com>
 L:	linux-media@vger.kernel.org
@@ -14483,12 +14476,19 @@ ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
 M:	Jacob Chen <jacob-chen@iotwrt.com>
 M:	Ezequiel Garcia <ezequiel@collabora.com>
 L:	linux-media@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
 F:	Documentation/devicetree/bindings/media/rockchip-rga.yaml
-F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
 F:	drivers/media/platform/rockchip/rga/
 
+ROCKCHIP VIDEO DECODER DRIVER
+M:	Ezequiel Garcia <ezequiel@collabora.com>
+L:	linux-media@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	drivers/staging/media/rkvdec/
+F:	Documentation/devicetree/bindings/media/rockchip,vdec.yaml
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.26.0.rc2

