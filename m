Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5498BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BDF221E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgIJVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:22:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731096AbgIJOYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3991877720EC491B196A;
        Thu, 10 Sep 2020 22:07:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:07:08 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <hyun.kwon@xilinx.com>, <laurent.pinchart@ideasonboard.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <michal.simek@xilinx.com>,
        <yanaijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm: xlnx: remove defined but not used 'scaling_factors_666'
Date:   Thu, 10 Sep 2020 22:06:30 +0800
Message-ID: <20200910140630.1191782-1-yanaijie@huawei.com>
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

drivers/gpu/drm/xlnx/zynqmp_disp.c:245:18: warning:
‘scaling_factors_666’ defined but not used [-Wunused-const-variable=]
  245 | static const u32 scaling_factors_666[] = {
      |                  ^~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index a455cfc1bee5..98bd48f13fd1 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -242,12 +242,6 @@ static const u32 scaling_factors_565[] = {
 	ZYNQMP_DISP_AV_BUF_5BIT_SF,
 };
 
-static const u32 scaling_factors_666[] = {
-	ZYNQMP_DISP_AV_BUF_6BIT_SF,
-	ZYNQMP_DISP_AV_BUF_6BIT_SF,
-	ZYNQMP_DISP_AV_BUF_6BIT_SF,
-};
-
 static const u32 scaling_factors_888[] = {
 	ZYNQMP_DISP_AV_BUF_8BIT_SF,
 	ZYNQMP_DISP_AV_BUF_8BIT_SF,
-- 
2.25.4

