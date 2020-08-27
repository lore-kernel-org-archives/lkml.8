Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC47C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9997122B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgH0OxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:53:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10337 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbgH0NRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:17:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BEFD5C8985852C2DA27;
        Thu, 27 Aug 2020 21:00:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 21:00:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <b.zolnierkie@samsung.com>, <yanaijie@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] video: fbdev: remove set but not used 'ulBestVCO'
Date:   Thu, 27 Aug 2020 21:00:08 +0800
Message-ID: <20200827130008.428706-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
‘ProgramClock’:
drivers/video/fbdev/kyro/STG4000InitDevice.c:123:6: warning: variable
‘ulBestVCO’ set but not used [-Wunused-but-set-variable]
  123 |  u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
      |      ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/kyro/STG4000InitDevice.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index edaeec2d9590..21875d3c2dc2 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -120,7 +120,7 @@ u32 ProgramClock(u32 refClock,
 {
 	u32 R = 0, F = 0, OD = 0, ODIndex = 0;
 	u32 ulBestR = 0, ulBestF = 0, ulBestOD = 0;
-	u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
+	u32 ulBestClk = 0, ulBestScore = 0;
 	u32 ulScore, ulPhaseScore, ulVcoScore;
 	u32 ulTmp = 0, ulVCO;
 	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
@@ -189,7 +189,6 @@ u32 ProgramClock(u32 refClock,
 						ulScore = ulPhaseScore + ulVcoScore;
 
 						if (!ulBestScore) {
-							ulBestVCO = ulVCO;
 							ulBestOD = OD;
 							ulBestF = F;
 							ulBestR = R;
@@ -206,7 +205,6 @@ u32 ProgramClock(u32 refClock,
                           but we shall keep this code in case new restrictions come into play
                           --------------------------------------------------------------------------*/
 						if ((ulScore >= ulBestScore) && (OD > 0)) {
-							ulBestVCO = ulVCO;
 							ulBestOD = OD;
 							ulBestF = F;
 							ulBestR = R;
-- 
2.25.4

