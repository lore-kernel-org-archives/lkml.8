Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD8020738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSIXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:23:10 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:23364 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgHSIXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:23:09 -0400
Received: from localhost.localdomain (unknown [210.32.144.184])
        by mail-app2 (Coremail) with SMTP id by_KCgA3OZxE4TxfMwMBAg--.43217S4;
        Wed, 19 Aug 2020 16:22:32 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/crc-debugfs: Fix memleak in crc_control_write
Date:   Wed, 19 Aug 2020 16:22:28 +0800
Message-Id: <20200819082228.26847-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgA3OZxE4TxfMwMBAg--.43217S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4xJr13Gry5Kr1fury7trb_yoWfWFb_Ka
        1fXrZrXrZFk34qv347Ca13ZFWS9an8XF4rXr1SkaySka17tr17WrW2gry5Xw13XF4UGryD
        CasrXasxZrn7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
        6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhdbbUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcLBlZdtPihowAesT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When verify_crc_source() fails, source needs to be freed.
However, current code is returning directly and ends up
leaking memory.

Fixes: c0811a7d5befe ("drm/crc: Cleanup crtc_crc_open function")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 5d67a41f7c3a..3dd70d813f69 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -144,8 +144,10 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
 		source[len - 1] = '\0';
 
 	ret = crtc->funcs->verify_crc_source(crtc, source, &values_cnt);
-	if (ret)
+	if (ret) {
+		kfree(source);
 		return ret;
+	}
 
 	spin_lock_irq(&crc->lock);
 
-- 
2.17.1

