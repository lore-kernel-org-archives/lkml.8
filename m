Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6A20702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgF2TWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:22:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732197AbgF2TVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EB98AF2C;
        Mon, 29 Jun 2020 15:09:54 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 04/47] staging: mmal-vchiq: Fix client_component for 64 bit kernel
Date:   Mon, 29 Jun 2020 17:09:02 +0200
Message-Id: <20200629150945.10720-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The MMAL client_component field is used with the event
mechanism to allow the client to identify the component for
which the event is generated.
The field is only 32bits in size, therefore we can't use a
pointer to the component in a 64 bit kernel.

Component handles are already held in an array per VCHI
instance, so use the array index as the client_component handle
to avoid having to create a new IDR for this purpose.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 8 +++++++-
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 6404d4e60350..3bc04f2ea53a 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -943,7 +943,7 @@ static int create_component(struct vchiq_mmal_instance *instance,
 
 	/* build component create message */
 	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
-	m.u.component_create.client_component = (u32)(unsigned long)component;
+	m.u.component_create.client_component = component->client_component;
 	strncpy(m.u.component_create.name, name,
 		sizeof(m.u.component_create.name));
 
@@ -1662,6 +1662,12 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 		goto unlock;
 	}
 
+	/* We need a handle to reference back to our component structure.
+	 * Use the array index in instance->component rather than rolling
+	 * another IDR.
+	 */
+	component->client_component = idx;
+
 	ret = create_component(instance, component, name);
 	if (ret < 0) {
 		pr_err("%s: failed to create component %d (Not enough GPU mem?)\n",
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index df608585063b..1dc81ecf9268 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -92,6 +92,7 @@ struct vchiq_mmal_component {
 	struct vchiq_mmal_port input[MAX_PORT_COUNT]; /* input ports */
 	struct vchiq_mmal_port output[MAX_PORT_COUNT]; /* output ports */
 	struct vchiq_mmal_port clock[MAX_PORT_COUNT]; /* clock ports */
+	u32 client_component;	/* Used to ref back to client struct */
 };
 
 int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance);
-- 
2.27.0

