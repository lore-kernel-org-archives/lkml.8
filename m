Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B4C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A2520757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:55:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIIz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:55:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B955C4D58753A801B7C1;
        Thu,  9 Apr 2020 16:55:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:55:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <nsaenzjulienne@suse.de>, <gregkh@linuxfoundation.org>,
        <marcgonzalez@google.com>, <jamal.k.shareef@gmail.com>,
        <nishkadg.linux@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] staging: vc04_services: remove set but not used 'local_entity_uc'
Date:   Thu, 9 Apr 2020 16:53:39 +0800
Message-ID: <20200409085339.47255-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2356:16:
warning: variable ‘local_entity_uc’ set but not used
[-Wunused-but-set-variable]
  int local_uc, local_entity_uc;
                ^~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a1ea9777a444..2d3e114f4a66 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2353,7 +2353,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	enum vchiq_status ret = VCHIQ_SUCCESS;
 	char entity[16];
 	int *entity_uc;
-	int local_uc, local_entity_uc;
+	int local_uc;
 
 	if (!arm_state)
 		goto out;
@@ -2377,7 +2377,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 
 	write_lock_bh(&arm_state->susp_res_lock);
 	local_uc = ++arm_state->videocore_use_count;
-	local_entity_uc = ++(*entity_uc);
+	++(*entity_uc);
 
 	vchiq_log_trace(vchiq_susp_log_level,
 		"%s %s count %d, state count %d",
-- 
2.17.2

