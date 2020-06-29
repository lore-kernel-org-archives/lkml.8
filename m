Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C555C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6456420759
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgF2UgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgF2TVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8C62AF44;
        Mon, 29 Jun 2020 15:09:53 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 03/47] staging: mmal-vchiq: Fixup vchiq-mmal include ordering
Date:   Mon, 29 Jun 2020 17:09:01 +0200
Message-Id: <20200629150945.10720-4-nsaenzjulienne@suse.de>
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

There were dependencies on including the headers in the correct
order. Fix up the headers so that they include the other
headers that they depend on themselves.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h   | 1 +
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
index 43cc59316f90..91f9b400d8dc 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg.h
@@ -38,6 +38,7 @@
 #include "mmal-msg-common.h"
 #include "mmal-msg-format.h"
 #include "mmal-msg-port.h"
+#include "mmal-vchiq.h"
 
 enum mmal_msg_type {
 	MMAL_MSG_TYPE_QUIT = 1,
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index cca7289761c2..df608585063b 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -16,6 +16,7 @@
 #ifndef MMAL_VCHIQ_H
 #define MMAL_VCHIQ_H
 
+#include "mmal-common.h"
 #include "mmal-msg-format.h"
 
 #define MAX_PORT_COUNT 4
-- 
2.27.0

