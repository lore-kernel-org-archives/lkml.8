Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E20120825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHVI1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:27:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56890 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbgHVI1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:27:45 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9_r1kBfbIIMAA--.1301S2;
        Sat, 22 Aug 2020 16:27:24 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: amd: Remove duplicate semicolons at the end of line
Date:   Sat, 22 Aug 2020 16:27:23 +0800
Message-Id: <1598084843-32270-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxn9_r1kBfbIIMAA--.1301S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DuF1fKF1kCr1fKry7Awb_yoW8Cr48pw
        45JryF93y5AFZYqa97AFyUWFWDAa4qqFWxKryUCasa93Z8AryDtr1rG3y2krWUKFW7Cw1S
        qFn7uFWUWF92yr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxU4kucDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate semicolons at the end of line.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                 | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index e99bef6..8603a26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1108,7 +1108,7 @@ static int vcn_v2_5_mmsch_start(struct amdgpu_device *adev,
 {
 	uint32_t data = 0, loop = 0, size = 0;
 	uint64_t addr = table->gpu_addr;
-	struct mmsch_v1_1_init_header *header = NULL;;
+	struct mmsch_v1_1_init_header *header = NULL;
 
 	header = (struct mmsch_v1_1_init_header *)table->cpu_addr;
 	size = header->total_size;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index afdd4f0..b320931 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -467,7 +467,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.AudioSampleLayout[mode_lib->vba.NumberOfActivePlanes] =
 			1;
 		mode_lib->vba.DRAMClockChangeLatencyOverride = 0.0;
-		mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;;
+		mode_lib->vba.DSCEnabled[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
 		mode_lib->vba.DSCEnable[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
 		mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] =
 				dout->dsc_slices;
-- 
2.1.0

