Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67831C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6220757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD3MHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:07:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3401 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgD3MHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:07:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7114C730B6E827FA4D2E;
        Thu, 30 Apr 2020 20:07:09 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 20:07:02 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <airlied@redhat.com>, <sean@poorly.run>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/udl: Make udl_handle_damage static
Date:   Thu, 30 Apr 2020 20:13:17 +0800
Message-ID: <1588248797-70568-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/gpu/drm/udl/udl_modeset.c:269:5: warning: symbol 'udl_handle_damage'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/udl/udl_modeset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 99518a8..fef43f4 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -266,8 +266,8 @@ static int udl_aligned_damage_clip(struct drm_rect *clip, int x, int y,
 	return 0;
 }
 
-int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
-		      int width, int height)
+static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
+			     int width, int height)
 {
 	struct drm_device *dev = fb->dev;
 	struct dma_buf_attachment *import_attach = fb->obj[0]->import_attach;
-- 
2.6.2

