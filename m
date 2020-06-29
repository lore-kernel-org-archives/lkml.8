Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ECBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394A720672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbgF2UhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:37:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbgF2TVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C82DB12D;
        Mon, 29 Jun 2020 15:10:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 45/47] staging: vchiq: Use vchiq.h as the main header file for services
Date:   Mon, 29 Jun 2020 17:09:43 +0200
Message-Id: <20200629150945.10720-46-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This used to be vchiq_if.h but vchiq.h is more concise for an include
file that will hopefully be in the future in the includes directory.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835.h     |   2 +-
 .../vc04_services/interface/vchiq_arm/vchiq.h | 107 ++++++++++++++++-
 .../interface/vchiq_arm/vchiq_if.h            | 109 ------------------
 .../interface/vchiq_arm/vchiq_ioctl.h         |   2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |   2 +-
 5 files changed, 106 insertions(+), 116 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index a15f251033ac..ca220f5230ec 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -9,7 +9,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
-#include "interface/vchiq_arm/vchiq_if.h"
+#include "interface/vchiq_arm/vchiq.h"
 
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 57fe7d5e9a85..04b7ff41a025 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -1,9 +1,108 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
 
-#ifndef VCHIQ_VCHIQ_H
-#define VCHIQ_VCHIQ_H
+#ifndef VCHIQ_H
+#define VCHIQ_H
 
-#include "vchiq_if.h"
+#define VCHIQ_SERVICE_HANDLE_INVALID 0
 
-#endif
+#define VCHIQ_SLOT_SIZE     4096
+#define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
+
+#define VCHIQ_MAKE_FOURCC(x0, x1, x2, x3) \
+			(((x0) << 24) | ((x1) << 16) | ((x2) << 8) | (x3))
+
+enum vchiq_reason {
+	VCHIQ_SERVICE_OPENED,         /* service, -, -             */
+	VCHIQ_SERVICE_CLOSED,         /* service, -, -             */
+	VCHIQ_MESSAGE_AVAILABLE,      /* service, header, -        */
+	VCHIQ_BULK_TRANSMIT_DONE,     /* service, -, bulk_userdata */
+	VCHIQ_BULK_RECEIVE_DONE,      /* service, -, bulk_userdata */
+	VCHIQ_BULK_TRANSMIT_ABORTED,  /* service, -, bulk_userdata */
+	VCHIQ_BULK_RECEIVE_ABORTED    /* service, -, bulk_userdata */
+};
+
+enum vchiq_status {
+	VCHIQ_ERROR   = -1,
+	VCHIQ_SUCCESS = 0,
+	VCHIQ_RETRY   = 1
+};
+
+enum vchiq_bulk_mode {
+	VCHIQ_BULK_MODE_CALLBACK,
+	VCHIQ_BULK_MODE_BLOCKING,
+	VCHIQ_BULK_MODE_NOCALLBACK,
+	VCHIQ_BULK_MODE_WAITING		/* Reserved for internal use */
+};
+
+enum vchiq_service_option {
+	VCHIQ_SERVICE_OPTION_AUTOCLOSE,
+	VCHIQ_SERVICE_OPTION_SLOT_QUOTA,
+	VCHIQ_SERVICE_OPTION_MESSAGE_QUOTA,
+	VCHIQ_SERVICE_OPTION_SYNCHRONOUS,
+	VCHIQ_SERVICE_OPTION_TRACE
+};
+
+struct vchiq_header {
+	/* The message identifier - opaque to applications. */
+	int msgid;
+
+	/* Size of message data. */
+	unsigned int size;
+
+	char data[0];           /* message */
+};
+
+struct vchiq_element {
+	const void __user *data;
+	unsigned int size;
+};
+
+struct vchiq_service_base {
+	int fourcc;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
+	void *userdata;
+};
+
+struct vchiq_service_params {
+	int fourcc;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
+	void *userdata;
+	short version;       /* Increment for non-trivial changes */
+	short version_min;   /* Update for incompatible changes */
+};
+
+struct vchiq_instance;
+
+extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
+extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
+extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
+extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
+	const struct vchiq_service_params *params,
+	unsigned int *pservice);
+extern enum vchiq_status vchiq_close_service(unsigned int service);
+extern enum vchiq_status vchiq_use_service(unsigned int service);
+extern enum vchiq_status vchiq_release_service(unsigned int service);
+extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
+extern void           vchiq_release_message(unsigned int service,
+	struct vchiq_header *header);
+extern int vchiq_queue_kernel_message(unsigned handle, void *data,
+				      unsigned size);
+extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
+	const void *data, unsigned int size, void *userdata,
+	enum vchiq_bulk_mode mode);
+extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
+	void *data, unsigned int size, void *userdata,
+	enum vchiq_bulk_mode mode);
+extern void *vchiq_get_service_userdata(unsigned int service);
+extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
+      short *peer_version);
+extern struct vchiq_header *vchiq_msg_hold(unsigned handle);
+
+#endif /* VCHIQ_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
deleted file mode 100644
index 6374eda4ea0c..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
-
-#ifndef VCHIQ_IF_H
-#define VCHIQ_IF_H
-
-#define VCHIQ_SERVICE_HANDLE_INVALID 0
-
-#define VCHIQ_SLOT_SIZE     4096
-#define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
-
-#define VCHIQ_MAKE_FOURCC(x0, x1, x2, x3) \
-			(((x0) << 24) | ((x1) << 16) | ((x2) << 8) | (x3))
-
-enum vchiq_reason {
-	VCHIQ_SERVICE_OPENED,         /* service, -, -             */
-	VCHIQ_SERVICE_CLOSED,         /* service, -, -             */
-	VCHIQ_MESSAGE_AVAILABLE,      /* service, header, -        */
-	VCHIQ_BULK_TRANSMIT_DONE,     /* service, -, bulk_userdata */
-	VCHIQ_BULK_RECEIVE_DONE,      /* service, -, bulk_userdata */
-	VCHIQ_BULK_TRANSMIT_ABORTED,  /* service, -, bulk_userdata */
-	VCHIQ_BULK_RECEIVE_ABORTED    /* service, -, bulk_userdata */
-};
-
-enum vchiq_status {
-	VCHIQ_ERROR   = -1,
-	VCHIQ_SUCCESS = 0,
-	VCHIQ_RETRY   = 1
-};
-
-enum vchiq_bulk_mode {
-	VCHIQ_BULK_MODE_CALLBACK,
-	VCHIQ_BULK_MODE_BLOCKING,
-	VCHIQ_BULK_MODE_NOCALLBACK,
-	VCHIQ_BULK_MODE_WAITING		/* Reserved for internal use */
-};
-
-enum vchiq_service_option {
-	VCHIQ_SERVICE_OPTION_AUTOCLOSE,
-	VCHIQ_SERVICE_OPTION_SLOT_QUOTA,
-	VCHIQ_SERVICE_OPTION_MESSAGE_QUOTA,
-	VCHIQ_SERVICE_OPTION_SYNCHRONOUS,
-	VCHIQ_SERVICE_OPTION_TRACE
-};
-
-struct vchiq_header {
-	/* The message identifier - opaque to applications. */
-	int msgid;
-
-	/* Size of message data. */
-	unsigned int size;
-
-	char data[0];           /* message */
-};
-
-struct vchiq_element {
-	const void __user *data;
-	unsigned int size;
-};
-
-struct vchiq_service_base {
-	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
-	void *userdata;
-};
-
-struct vchiq_service_params {
-	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
-	void *userdata;
-	short version;       /* Increment for non-trivial changes */
-	short version_min;   /* Update for incompatible changes */
-};
-
-struct vchiq_instance;
-
-extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
-extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
-	const struct vchiq_service_params *params,
-	unsigned int *pservice);
-extern enum vchiq_status vchiq_close_service(unsigned int service);
-extern enum vchiq_status vchiq_use_service(unsigned int service);
-extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern int vchiq_queue_kernel_message(unsigned handle, void *data,
-				      unsigned size);
-extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
-extern void           vchiq_release_message(unsigned int service,
-	struct vchiq_header *header);
-extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
-	const void *data, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
-extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
-	void *data, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
-extern void *vchiq_get_service_userdata(unsigned int service);
-extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
-      short *peer_version);
-extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
-extern struct vchiq_header *vchiq_msg_hold(unsigned handle);
-
-#endif /* VCHIQ_IF_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 202889b3774f..f285d754ad28 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -5,7 +5,7 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
-#include "vchiq_if.h"
+#include "vchiq.h"
 
 #define VCHIQ_IOC_MAGIC 0xc4
 #define VCHIQ_INVALID_HANDLE (~0)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index a18cc9c9811b..7da9a4c1ac03 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -29,7 +29,7 @@
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
 
-#include "interface/vchiq_arm/vchiq_if.h"
+#include "interface/vchiq_arm/vchiq.h"
 
 /*
  * maximum number of components supported.
-- 
2.27.0

