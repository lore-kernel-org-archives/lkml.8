Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63294C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4394F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHJM46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:56:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgHJM46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:56:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40A3B26EEED119206D00;
        Mon, 10 Aug 2020 20:56:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 20:56:46 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <miaoqinglang@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: convert to use le16_add_cpu()
Date:   Mon, 10 Aug 2020 20:59:19 +0800
Message-ID: <20200810125919.185312-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert cpu_to_le16(le16_to_cpu(E1) + E2) to use le16_add_cpu().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c  | 4 +---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 5815983ca..070459e3e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1877,9 +1877,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
 			 * but it is 4 either from Edid data (spec CEA 861)
 			 * or CEA timing table.
 			 */
-			params.usV_SyncOffset =
-					cpu_to_le16(le16_to_cpu(params.usV_SyncOffset) + 1);
-
+			le16_add_cpu(&params.usV_SyncOffset, 1);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index bed91572f..e8f52eb8e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -569,10 +569,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
 			 * but it is 4 either from Edid data (spec CEA 861)
 			 * or CEA timing table.
 			 */
-			params.v_syncoffset =
-				cpu_to_le16(le16_to_cpu(params.v_syncoffset) +
-						1);
-
+			le16_add_cpu(&params.v_syncoffset, 1);
 		}
 	}
 
-- 
2.25.1

