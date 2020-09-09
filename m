Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC2BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4340E2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgIIPpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:45:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729990AbgIIPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:42:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE0738C8ED968C64CCB5;
        Wed,  9 Sep 2020 21:42:08 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:42:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <thierry.reding@gmail.com>, <sam@ravnborg.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <linus.walleij@linaro.org>,
        <paul@crapouillou.net>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/panel: s6e63m0: Add missing MODULE_LICENSE
Date:   Wed, 9 Sep 2020 21:41:37 +0800
Message-ID: <20200909134137.32284-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild warns when this file is built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-samsung-s6e63m0.o

Add the missing license/author/description tags.

Fixes: b7b23e447687 ("drm/panel: s6e63m0: Break out SPI transport")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index 044294aafe27..3eee67e2d86a 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -534,3 +534,7 @@ int s6e63m0_remove(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(s6e63m0_remove);
+
+MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
+MODULE_DESCRIPTION("s6e63m0 LCD Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


