Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2879C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985D820780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbgFWQqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:46:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733145AbgFWQpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0536B03C;
        Tue, 23 Jun 2020 16:45:34 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 47/50] staging: vchiq: Move conditional barrier definition into vchiq_core.h
Date:   Tue, 23 Jun 2020 18:42:33 +0200
Message-Id: <20200623164235.29566-48-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barrier is only used by core code. So keep the barrier definition in
the core header.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq.h        | 11 -----------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 211b20705e36..57fe7d5e9a85 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -6,15 +6,4 @@
 
 #include "vchiq_if.h"
 
-/* Do this so that we can test-build the code on non-rpi systems */
-#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
-
-#else
-
-#ifndef dsb
-#define dsb(a)
-#endif
-
-#endif	/* IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE) */
-
 #endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index ff91c04ba6b9..15e9867f78f4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -15,6 +15,18 @@
 
 #include "vchiq.h"
 
+/* Do this so that we can test-build the code on non-rpi systems */
+#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
+
+#else
+
+#ifndef dsb
+#define dsb(a)
+#endif
+
+#endif	/* IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE) */
+
+
 /* Run time control of log level, based on KERN_XXX level. */
 #define VCHIQ_LOG_DEFAULT  4
 #define VCHIQ_LOG_ERROR    3
-- 
2.27.0

