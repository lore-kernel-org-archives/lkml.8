Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE6FC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A210206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgAaKjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:57018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgAaKjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3F4BAF2D;
        Fri, 31 Jan 2020 10:39:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 01/21] staging: vc04_services: Remove unused variables in struct vchiq_arm_state
Date:   Fri, 31 Jan 2020 11:38:17 +0100
Message-Id: <20200131103836.14312-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131103836.14312-1-nsaenzjulienne@suse.de>
References: <20200131103836.14312-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are not being used, so we're better off without them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h      | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 19d2a2eefb6a..f0044289b6bc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -53,8 +53,6 @@ struct vchiq_arm_state {
 	enum vc_suspend_status vc_suspend_state;
 	enum vc_resume_status vc_resume_state;
 
-	unsigned int wake_address;
-
 	struct vchiq_state *state;
 	struct timer_list suspend_timer;
 	int suspend_timer_timeout;
@@ -80,19 +78,11 @@ struct vchiq_arm_state {
 	struct completion blocked_blocker;
 	int blocked_count;
 
-	int autosuspend_override;
-
 	/* Flag to indicate that the first vchiq connect has made it through.
 	** This means that both sides should be fully ready, and we should
 	** be able to suspend after this point.
 	*/
 	int first_connect;
-
-	unsigned long long suspend_start_time;
-	unsigned long long sleep_start_time;
-	unsigned long long resume_start_time;
-	unsigned long long last_wake_time;
-
 };
 
 struct vchiq_drvdata {
-- 
2.25.0

