Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333A6C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189E32083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgD2OK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:10:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3385 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727119AbgD2OKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:10:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3C8B6D9CB7E42972048;
        Wed, 29 Apr 2020 22:10:53 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 22:10:45 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] drm/ast: remove duplicate assignment of ast_crtc_funcs member
Date:   Wed, 29 Apr 2020 22:10:10 +0800
Message-ID: <20200429141010.8445-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct member 'set_config' was assigned twice:

static const struct drm_crtc_funcs ast_crtc_funcs = {
	.reset = ast_crtc_reset,
	.set_config = drm_crtc_helper_set_config,
	......
	.set_config = drm_atomic_helper_set_config,
	......
};

Since the second one is which we use now in fact, we can remove the
first one.

This fixes the following coccicheck warning:

drivers/gpu/drm/ast/ast_mode.c:932:50-51: set_config: first occurrence
line 934, second occurrence line 937

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d2ab81f9c498..7062bcd78740 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -931,7 +931,6 @@ static void ast_crtc_atomic_destroy_state(struct drm_crtc *crtc,
 
 static const struct drm_crtc_funcs ast_crtc_funcs = {
 	.reset = ast_crtc_reset,
-	.set_config = drm_crtc_helper_set_config,
 	.gamma_set = drm_atomic_helper_legacy_gamma_set,
 	.destroy = ast_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
-- 
2.21.1

