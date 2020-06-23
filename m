Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0739220780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbgFWQp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbgFWQpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACC4AB053;
        Tue, 23 Jun 2020 16:45:35 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 49/50] staging: vchiq: Move defines into core header
Date:   Tue, 23 Jun 2020 18:42:35 +0200
Message-Id: <20200623164235.29566-50-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are only used in the core vchiq code, while present in vchiq's
'public' API header. Move them into the right place.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h    | 5 -----
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h   | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 04b7ff41a025..cb9ef9a4150b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -4,11 +4,6 @@
 #ifndef VCHIQ_H
 #define VCHIQ_H
 
-#define VCHIQ_SERVICE_HANDLE_INVALID 0
-
-#define VCHIQ_SLOT_SIZE     4096
-#define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
-
 #define VCHIQ_MAKE_FOURCC(x0, x1, x2, x3) \
 			(((x0) << 24) | ((x1) << 16) | ((x2) << 8) | (x3))
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 15e9867f78f4..8a27f3d7217e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -26,6 +26,10 @@
 
 #endif	/* IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE) */
 
+#define VCHIQ_SERVICE_HANDLE_INVALID 0
+
+#define VCHIQ_SLOT_SIZE     4096
+#define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
 
 /* Run time control of log level, based on KERN_XXX level. */
 #define VCHIQ_LOG_DEFAULT  4
-- 
2.27.0

