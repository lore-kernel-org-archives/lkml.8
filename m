Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03FE20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgC3KAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:00:55 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3985 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgC3KAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:00:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e81c332c5a-0ec9f; Mon, 30 Mar 2020 18:00:19 +0800 (CST)
X-RM-TRANSID: 2ee55e81c332c5a-0ec9f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e81c331142-d1ef4;
        Mon, 30 Mar 2020 18:00:19 +0800 (CST)
X-RM-TRANSID: 2ee35e81c331142-d1ef4
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     oleksandr_andrushchenko@epam.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xen: fix passing zero to 'PTR_ERR' warning
Date:   Mon, 30 Mar 2020 17:59:07 +0800
Message-Id: <1585562347-30214-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
    drivers/gpu/drm/xen/xen_drm_front.c:404 xen_drm_drv_dumb_create()
    warn: passing zero to 'PTR_ERR'

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/gpu/drm/xen/xen_drm_front.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 4be49c1..3741420 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -401,7 +401,7 @@ static int xen_drm_drv_dumb_create(struct drm_file *filp,
 
 	obj = xen_drm_front_gem_create(dev, args->size);
 	if (IS_ERR_OR_NULL(obj)) {
-		ret = PTR_ERR(obj);
+		ret = PTR_ERR_OR_ZERO(obj);
 		goto fail;
 	}
 
-- 
1.9.1



