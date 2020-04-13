Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC0C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:56:30 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40E920656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40E920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgDMH43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgDMH43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:56:29 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA8C00860A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:56:28 -0700 (PDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED46456310CE144570DA;
        Mon, 13 Apr 2020 15:56:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 15:56:20 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Tony.Cheng@amd.com>, <Anthony.Koo@amd.com>, <yanaijie@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/amd/display: code clean up in dce80_hw_sequencer.c
Date:   Mon, 13 Apr 2020 16:22:49 +0800
Message-ID: <20200413082249.23271-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_hw_sequencer.c:43:46:
warning: ‘reg_offsets’ defined but not used [-Wunused-const-variable=]
 static const struct dce80_hw_seq_reg_offsets reg_offsets[] = {
                                              ^~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 .../amd/display/dc/dce80/dce80_hw_sequencer.c | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
index 893261c81854..d2ceebdbdf51 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
@@ -36,34 +36,6 @@
 #include "dce/dce_8_0_d.h"
 #include "dce/dce_8_0_sh_mask.h"
 
-struct dce80_hw_seq_reg_offsets {
-	uint32_t crtc;
-};
-
-static const struct dce80_hw_seq_reg_offsets reg_offsets[] = {
-{
-	.crtc = (mmCRTC0_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
-},
-{
-	.crtc = (mmCRTC1_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
-},
-{
-	.crtc = (mmCRTC2_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
-},
-{
-	.crtc = (mmCRTC3_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
-},
-{
-	.crtc = (mmCRTC4_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
-},
-{
-	.crtc = (mmCRTC5_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
-}
-};
-
-#define HW_REG_CRTC(reg, id)\
-	(reg + reg_offsets[id].crtc)
-
 /*******************************************************************************
  * Private definitions
  ******************************************************************************/
-- 
2.21.1

