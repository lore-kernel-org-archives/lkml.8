Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD6B20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgFWQsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:48:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733054AbgFWQpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6114DB077;
        Tue, 23 Jun 2020 16:45:16 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 16/50] staging: vc04_services: bcm2835-audio: Use vchi_msg_hold()
Date:   Tue, 23 Jun 2020 18:42:02 +0200
Message-Id: <20200623164235.29566-17-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchi_msg_dequeue() provides the same functionality as vchi_msg_hold()
except it copies the message data as opposed to the later which provides
the data in place.

The copying is done on a local variable, so there is no need to keep the
message out the function's bounds, so use vchi_msg_hold() instead.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 62eef233275f..5018b5baa009 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -94,31 +94,34 @@ static void audio_vchi_callback(void *param,
 				void *msg_handle)
 {
 	struct bcm2835_audio_instance *instance = param;
-	struct vc_audio_msg m;
-	int msg_len;
+	struct vchi_held_msg handle;
+	struct vc_audio_msg *m;
+	unsigned size;
 	int status;
 
 	if (reason != VCHI_CALLBACK_MSG_AVAILABLE)
 		return;
 
-	status = vchi_msg_dequeue(instance->service,
-				  &m, sizeof(m), &msg_len, VCHI_FLAGS_NONE);
+	status = vchi_msg_hold(instance->service, (void **)&m, &size,
+			       VCHI_FLAGS_NONE, &handle);
 	if (status)
 		return;
 
-	if (m.type == VC_AUDIO_MSG_TYPE_RESULT) {
-		instance->result = m.result.success;
+	if (m->type == VC_AUDIO_MSG_TYPE_RESULT) {
+		instance->result = m->result.success;
 		complete(&instance->msg_avail_comp);
-	} else if (m.type == VC_AUDIO_MSG_TYPE_COMPLETE) {
-		if (m.complete.cookie1 != VC_AUDIO_WRITE_COOKIE1 ||
-		    m.complete.cookie2 != VC_AUDIO_WRITE_COOKIE2)
+	} else if (m->type == VC_AUDIO_MSG_TYPE_COMPLETE) {
+		if (m->complete.cookie1 != VC_AUDIO_WRITE_COOKIE1 ||
+		    m->complete.cookie2 != VC_AUDIO_WRITE_COOKIE2)
 			dev_err(instance->dev, "invalid cookie\n");
 		else
 			bcm2835_playback_fifo(instance->alsa_stream,
-					      m.complete.count);
+					      m->complete.count);
 	} else {
-		dev_err(instance->dev, "unexpected callback type=%d\n", m.type);
+		dev_err(instance->dev, "unexpected callback type=%d\n", m->type);
 	}
+
+	vchi_held_msg_release(&handle);
 }
 
 static int
-- 
2.27.0

