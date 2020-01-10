Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD6C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AA12072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAJJTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:19:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbgAJJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:19:45 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D171E1CCB194AE3BA2B3;
        Fri, 10 Jan 2020 17:19:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 17:19:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <yuehaibing@huawei.com>,
        <alexander.deucher@amd.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/ch7006: Use match_string() helper to simplify the code
Date:   Fri, 10 Jan 2020 17:19:26 +0800
Message-ID: <20200110091926.48380-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the array index of a matching string.
Use it instead of the open-coded implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i2c/ch7006_drv.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index b91e48d..f9a46b5 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -464,16 +464,13 @@ static int ch7006_encoder_init(struct i2c_client *client,
 	priv->chip_version = ch7006_read(client, CH7006_VERSION_ID);
 
 	if (ch7006_tv_norm) {
-		for (i = 0; i < NUM_TV_NORMS; i++) {
-			if (!strcmp(ch7006_tv_norm_names[i], ch7006_tv_norm)) {
-				priv->norm = i;
-				break;
-			}
-		}
-
-		if (i == NUM_TV_NORMS)
+		i = match_string(ch7006_tv_norm_names, NUM_TV_NORMS,
+				 ch7006_tv_norm);
+		if (i < 0)
 			ch7006_err(client, "Invalid TV norm setting \"%s\".\n",
 				   ch7006_tv_norm);
+		else
+			priv->norm = i;
 	}
 
 	if (ch7006_scale >= 0 && ch7006_scale <= 2)
-- 
2.7.4


