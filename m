Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB41FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BAB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHJM5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:57:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgHJM5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:57:12 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0586456B329F9446570C;
        Mon, 10 Aug 2020 20:57:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 20:56:56 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <miaoqinglang@huawei.com>
Subject: [PATCH] drm/v3d: convert to use module_platform_driver
Date:   Mon, 10 Aug 2020 20:59:31 +0800
Message-ID: <20200810125931.186456-1-miaoqinglang@huawei.com>
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

Get rid of boilerplate code by using module_platform_driver macro
for v3d_drm.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 82a7dfdd1..9f7c26193 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -358,18 +358,7 @@ static struct platform_driver v3d_platform_driver = {
 	},
 };
 
-static int __init v3d_drm_register(void)
-{
-	return platform_driver_register(&v3d_platform_driver);
-}
-
-static void __exit v3d_drm_unregister(void)
-{
-	platform_driver_unregister(&v3d_platform_driver);
-}
-
-module_init(v3d_drm_register);
-module_exit(v3d_drm_unregister);
+module_platform_driver(v3d_platform_driver);
 
 MODULE_ALIAS("platform:v3d-drm");
 MODULE_DESCRIPTION("Broadcom V3D DRM Driver");
-- 
2.25.1

