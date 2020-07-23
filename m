Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19455C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A6820781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgGWD0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:26:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733229AbgGWD0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:26:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 70B83B62C633E077C39E;
        Thu, 23 Jul 2020 11:26:14 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 11:26:10 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/2] drm: Remove redundant NULL check
Date:   Thu, 23 Jul 2020 11:27:43 +0800
Message-ID: <1595474863-33112-2-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
References: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:557:2-7: WARNING: NULL check before some freeing functions is not needed.

Fixes: 4d55b0dd1cdd ("drm/amd/display: Add DCN3 CLK_MGR")
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index d94fdc5..d8af56a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -553,8 +553,7 @@ void dcn3_clk_mgr_construct(
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
 {
-	if (clk_mgr->base.bw_params)
-		kfree(clk_mgr->base.bw_params);
+	kfree(clk_mgr->base.bw_params);
 
 	if (clk_mgr->wm_range_table)
 		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
-- 
2.7.4

