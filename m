Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB7C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72583206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgBRCgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:36:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgBRCgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:36:39 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8648E11E7F6A8CFFD36;
        Tue, 18 Feb 2020 10:36:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Feb 2020
 10:36:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <light.hsieh@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@listd.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pinctrl: mediatek: remove set but not used variable 'e'
Date:   Tue, 18 Feb 2020 10:36:25 +0800
Message-ID: <20200218023625.14324-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c: In function mtk_hw_pin_field_lookup:
drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c:70:39: warning:
 variable e set but not used [-Wunused-but-set-variable]

Since commit 3de7deefce69 ("pinctrl: mediatek: Check gpio pin
number and use binary search in mtk_hw_pin_field_lookup()"),
it is not used any more, so remove it, also remove redundant
assignment to variable c, it will be assigned a new value later
before used.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 1da9425..d3169a8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -67,7 +67,7 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 				   const struct mtk_pin_desc *desc,
 				   int field, struct mtk_pin_field *pfd)
 {
-	const struct mtk_pin_field_calc *c, *e;
+	const struct mtk_pin_field_calc *c;
 	const struct mtk_pin_reg_calc *rc;
 	int start = 0, end, check;
 	bool found = false;
@@ -82,8 +82,6 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 	}
 
 	end = rc->nranges - 1;
-	c = rc->range;
-	e = c + rc->nranges;
 
 	while (start <= end) {
 		check = (start + end) >> 1;
-- 
2.7.4


