Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF22206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbgF2Ugs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:36:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732168AbgF2TV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 728AAAF77;
        Mon, 29 Jun 2020 15:09:59 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 16/47] staging: vchi: Get rid of unnecessary defines
Date:   Mon, 29 Jun 2020 17:09:14 +0200
Message-Id: <20200629150945.10720-17-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those defines aren't used by anyone. Get rid of them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h   | 11 -----------
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index a369feb3a448..bf0c7a496f5a 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -11,21 +11,10 @@
  * Global defs
  *****************************************************************************/
 
-#define VCHI_BULK_ROUND_UP(x)     ((((unsigned long)(x)) + VCHI_BULK_ALIGN - 1) & ~(VCHI_BULK_ALIGN - 1))
-#define VCHI_BULK_ROUND_DOWN(x)   (((unsigned long)(x)) & ~(VCHI_BULK_ALIGN - 1))
-#define VCHI_BULK_ALIGN_NBYTES(x) (VCHI_BULK_ALIGNED(x) ? 0 : (VCHI_BULK_ALIGN - ((unsigned long)(x) & (VCHI_BULK_ALIGN - 1))))
-
-#ifdef USE_VCHIQ_ARM
-#define VCHI_BULK_ALIGNED(x)      1
-#else
-#define VCHI_BULK_ALIGNED(x)      (((unsigned long)(x) & (VCHI_BULK_ALIGN - 1)) == 0)
-#endif
-
 struct vchi_version {
 	uint32_t version;
 	uint32_t version_min;
 };
-#define VCHI_VERSION(v_) { v_, v_ }
 #define VCHI_VERSION_EX(v_, m_) { v_, m_ }
 
 // Macros to manipulate 'FOURCC' values
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 05ac1739db5f..075dcf4d6b3e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -29,7 +29,6 @@
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
 
-#define USE_VCHIQ_ARM
 #include "interface/vchi/vchi.h"
 
 /*
-- 
2.27.0

