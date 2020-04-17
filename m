Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4808DC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2753A221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgDQI5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:57:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729889AbgDQI5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:57:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A22E5D4279283938D6F;
        Fri, 17 Apr 2020 16:57:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 16:57:08 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <b.zolnierkie@samsung.com>,
        <kgunda@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] backlight: qcom-wled: remove 'wled4_string_cfg' and 'wled3_string_cfg'
Date:   Fri, 17 Apr 2020 17:23:35 +0800
Message-ID: <20200417092335.14163-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/video/backlight/qcom-wled.c:939:34: warning: ‘wled4_string_cfg’
defined but not used [-Wunused-const-variable=]
 static const struct wled_var_cfg wled4_string_cfg = {
                                  ^~~~~~~~~~~~~~~~
drivers/video/backlight/qcom-wled.c:935:34: warning: ‘wled3_string_cfg’
defined but not used [-Wunused-const-variable=]
 static const struct wled_var_cfg wled3_string_cfg = {
                                  ^~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/backlight/qcom-wled.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 3d276b30a78c..df53fbd5cd03 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -932,14 +932,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
 	.size = ARRAY_SIZE(wled4_string_i_limit_values),
 };
 
-static const struct wled_var_cfg wled3_string_cfg = {
-	.size = 8,
-};
-
-static const struct wled_var_cfg wled4_string_cfg = {
-	.size = 16,
-};
-
 static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
 {
 	if (idx >= cfg->size)
-- 
2.21.1

