Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBAEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B12C206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgF2TWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:22:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732210AbgF2TVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CAC9BAF5B;
        Mon, 29 Jun 2020 15:09:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Naushir Patuck <naush@raspberrypi.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 07/47] staging: mmal-vchiq: Fix formatting errors in mmal_parameters.h
Date:   Mon, 29 Jun 2020 17:09:05 +0200
Message-Id: <20200629150945.10720-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naushir Patuck <naush@raspberrypi.com>

No functional changes in this commit.

- Remove erroneous whitespace.
- Remove _t postfix label on structs and enums.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-camera/bcm2835-camera.c           |  2 +-
 .../vchiq-mmal/mmal-parameters.h              | 32 +++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 73b2354a6bb7..df90c1f9d148 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1497,7 +1497,7 @@ static int get_num_cameras(struct vchiq_mmal_instance *instance,
 {
 	int ret;
 	struct vchiq_mmal_component  *cam_info_component;
-	struct mmal_parameter_camera_info_t cam_info = {0};
+	struct mmal_parameter_camera_info cam_info = {0};
 	u32 param_size = sizeof(cam_info);
 	int i;
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
index f4ac5a6149ea..a1e39b1b1701 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
@@ -23,21 +23,21 @@
 #define MMAL_PARAMETERS_H
 
 /** Common parameter ID group, used with many types of component. */
-#define MMAL_PARAMETER_GROUP_COMMON            (0 << 16)
+#define MMAL_PARAMETER_GROUP_COMMON		(0 << 16)
 /** Camera-specific parameter ID group. */
-#define MMAL_PARAMETER_GROUP_CAMERA            (1 << 16)
+#define MMAL_PARAMETER_GROUP_CAMERA		(1 << 16)
 /** Video-specific parameter ID group. */
-#define MMAL_PARAMETER_GROUP_VIDEO             (2 << 16)
+#define MMAL_PARAMETER_GROUP_VIDEO		(2 << 16)
 /** Audio-specific parameter ID group. */
-#define MMAL_PARAMETER_GROUP_AUDIO             (3 << 16)
+#define MMAL_PARAMETER_GROUP_AUDIO		(3 << 16)
 /** Clock-specific parameter ID group. */
-#define MMAL_PARAMETER_GROUP_CLOCK             (4 << 16)
+#define MMAL_PARAMETER_GROUP_CLOCK		(4 << 16)
 /** Miracast-specific parameter ID group. */
-#define MMAL_PARAMETER_GROUP_MIRACAST       (5 << 16)
+#define MMAL_PARAMETER_GROUP_MIRACAST		(5 << 16)
 
 /* Common parameters */
 enum mmal_parameter_common_type {
-		/**< Never a valid parameter ID */
+	/**< Never a valid parameter ID */
 	MMAL_PARAMETER_UNUSED = MMAL_PARAMETER_GROUP_COMMON,
 
 		/**< MMAL_PARAMETER_ENCODING_T */
@@ -341,7 +341,7 @@ enum mmal_parameter_imagefx {
 	MMAL_PARAM_IMAGEFX_CARTOON,
 };
 
-enum MMAL_PARAM_FLICKERAVOID_T {
+enum MMAL_PARAM_FLICKERAVOID {
 	MMAL_PARAM_FLICKERAVOID_OFF,
 	MMAL_PARAM_FLICKERAVOID_AUTO,
 	MMAL_PARAM_FLICKERAVOID_50HZ,
@@ -723,7 +723,7 @@ struct mmal_parameter_imagefx_parameters {
 #define MMAL_PARAMETER_CAMERA_INFO_MAX_FLASHES 2
 #define MMAL_PARAMETER_CAMERA_INFO_MAX_STR_LEN 16
 
-struct mmal_parameter_camera_info_camera_t {
+struct mmal_parameter_camera_info_camera {
 	u32 port_id;
 	u32 max_width;
 	u32 max_height;
@@ -731,7 +731,7 @@ struct mmal_parameter_camera_info_camera_t {
 	u8 camera_name[MMAL_PARAMETER_CAMERA_INFO_MAX_STR_LEN];
 };
 
-enum mmal_parameter_camera_info_flash_type_t {
+enum mmal_parameter_camera_info_flash_type {
 	/* Make values explicit to ensure they match values in config ini */
 	MMAL_PARAMETER_CAMERA_INFO_FLASH_TYPE_XENON = 0,
 	MMAL_PARAMETER_CAMERA_INFO_FLASH_TYPE_LED   = 1,
@@ -739,16 +739,16 @@ enum mmal_parameter_camera_info_flash_type_t {
 	MMAL_PARAMETER_CAMERA_INFO_FLASH_TYPE_MAX = 0x7FFFFFFF
 };
 
-struct mmal_parameter_camera_info_flash_t {
-	enum mmal_parameter_camera_info_flash_type_t flash_type;
+struct mmal_parameter_camera_info_flash {
+	enum mmal_parameter_camera_info_flash_type flash_type;
 };
 
-struct mmal_parameter_camera_info_t {
+struct mmal_parameter_camera_info {
 	u32 num_cameras;
 	u32 num_flashes;
-	struct mmal_parameter_camera_info_camera_t
-				cameras[MMAL_PARAMETER_CAMERA_INFO_MAX_CAMERAS];
-	struct mmal_parameter_camera_info_flash_t
+	struct mmal_parameter_camera_info_camera
+		cameras[MMAL_PARAMETER_CAMERA_INFO_MAX_CAMERAS];
+	struct mmal_parameter_camera_info_flash
 				flashes[MMAL_PARAMETER_CAMERA_INFO_MAX_FLASHES];
 };
 
-- 
2.27.0

