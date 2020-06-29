Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5054C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC00206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbgF2Ufw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:35:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbgF2TVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7F48B02B;
        Mon, 29 Jun 2020 15:10:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 34/47] staging: vchiq: Unify fourcc definition mechanisms
Date:   Mon, 29 Jun 2020 17:09:32 +0200
Message-Id: <20200629150945.10720-35-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already enough duplication with regard to fourcc generation in
the kernel. Let's at least use the same macro all over the vchiq
ecosystem.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c  | 2 +-
 .../vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h     | 5 ++---
 drivers/staging/vc04_services/interface/vchi/vchi.h          | 3 ---
 drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h          | 1 -
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c        | 2 +-
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 18309578e9a2..55f1e684eef1 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -125,7 +125,7 @@ vc_vchi_audio_init(struct vchiq_instance *vchiq_instance,
 	struct vchiq_service_params params = {
 		.version		= VC_AUDIOSERV_VER,
 		.version_min		= VC_AUDIOSERV_MIN_VER,
-		.fourcc			= VC_AUDIO_SERVER_NAME,
+		.fourcc			= VCHIQ_MAKE_FOURCC('A', 'U', 'D', 'S'),
 		.callback		= audio_vchi_callback,
 		.userdata		= instance,
 	};
diff --git a/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h b/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h
index d6401e914ac9..b4fa239c5ebe 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h
@@ -8,9 +8,8 @@
 #define VC_AUDIOSERV_VER 2
 
 /* FourCC codes used for VCHI communication */
-#define VC_AUDIO_SERVER_NAME  MAKE_FOURCC("AUDS")
-#define VC_AUDIO_WRITE_COOKIE1 MAKE_FOURCC("BCMA")
-#define VC_AUDIO_WRITE_COOKIE2 MAKE_FOURCC("DATA")
+#define VC_AUDIO_WRITE_COOKIE1 VCHIQ_MAKE_FOURCC('B', 'C', 'M', 'A')
+#define VC_AUDIO_WRITE_COOKIE2 VCHIQ_MAKE_FOURCC('D', 'A', 'T', 'A')
 
 /*
  *  List of screens that are currently supported
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 59559d4cd5f1..7108c254a38a 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -8,9 +8,6 @@
  * Global defs
  *****************************************************************************/
 
-// Macros to manipulate 'FOURCC' values
-#define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-
 // Opaque handle for a VCHIQ instance
 struct vchiq_instance;
 
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
index 91f9b400d8dc..b636e889c8a1 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
@@ -28,7 +28,6 @@
 
 #define VC_MMAL_VER 15
 #define VC_MMAL_MIN_VER 10
-#define VC_MMAL_SERVER_NAME  MAKE_FOURCC("mmal")
 
 /* max total message size is 512 bytes */
 #define MMAL_MSG_MAX_SIZE 512
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index c960fb7ec890..2c5027c1f0bb 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1863,7 +1863,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	struct vchiq_service_params params = {
 		.version		= VC_MMAL_VER,
 		.version_min		= VC_MMAL_MIN_VER,
-		.fourcc			= VC_MMAL_SERVER_NAME,
+		.fourcc			= VCHIQ_MAKE_FOURCC('m', 'm', 'a', 'l'),
 		.callback		= service_callback,
 		.userdata		= NULL,
 	};
-- 
2.27.0

