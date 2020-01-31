Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06FAC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DABC206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgAaKjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:57070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgAaKjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6DE1CAFFC;
        Fri, 31 Jan 2020 10:39:12 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 10/21] staging: vc04_services: Get rid of vchiq_platform_handle_timeout()
Date:   Fri, 31 Jan 2020 11:38:26 +0100
Message-Id: <20200131103836.14312-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function does nothing.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c       | 5 -----
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 5 -----
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h   | 3 ---
 3 files changed, 13 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index a7f72dba2e20..c18c6ca0b6c0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -257,11 +257,6 @@ int vchiq_dump_platform_state(void *dump_context)
 	return vchiq_dump(dump_context, buf, len + 1);
 }
 
-void
-vchiq_platform_handle_timeout(struct vchiq_state *state)
-{
-	(void)state;
-}
 /*
  * Local functions
  */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ef8340ab8a52..f135d55b29e5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1911,11 +1911,6 @@ slot_handler_func(void *v)
 						"message");
 				}
 				break;
-
-			case VCHIQ_CONNSTATE_PAUSE_TIMEOUT:
-			case VCHIQ_CONNSTATE_RESUME_TIMEOUT:
-				vchiq_platform_handle_timeout(state);
-				break;
 			default:
 				break;
 			}
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 535a67cc68ed..11037a499408 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -638,9 +638,6 @@ vchiq_platform_conn_state_changed(struct vchiq_state *state,
 				  enum vchiq_connstate oldstate,
 				  enum vchiq_connstate newstate);
 
-extern void
-vchiq_platform_handle_timeout(struct vchiq_state *state);
-
 extern void
 vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
 
-- 
2.25.0

