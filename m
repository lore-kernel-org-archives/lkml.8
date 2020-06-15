Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D43C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7459B20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgFOIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:54:12 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:17256 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgFOIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:54:11 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id B251D261613;
        Mon, 15 Jun 2020 16:54:07 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers/video/backlight: Use kobj_to_dev() instead
Date:   Mon, 15 Jun 2020 16:54:02 +0800
Message-Id: <1592211242-31683-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSkwZSU1NGU1PT01JVkpOQklJSkpJT0NJSk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PT46Ayo4Hzg5CQhOSihMSxEW
        M0kaFFZVSlVKTkJJSUpKSU9DTk1DVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKQ0NINwY+
X-HM-Tid: 0a72b72f93709375kuwsb251d261613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/backlight/lm3533_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/video/backlight/lm3533_bl.c

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index ee09d1b..0c7830f
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -235,7 +235,7 @@ static struct attribute *lm3533_bl_attributes[] = {
 static umode_t lm3533_bl_attr_is_visible(struct kobject *kobj,
 					     struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
-- 
2.7.4

