Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A80C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42DE20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgDQI4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:56:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2345 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729784AbgDQI4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:56:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E6BB1BA9E54F3CB3E3A9;
        Fri, 17 Apr 2020 16:56:39 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 16:56:31 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <b.zolnierkie@samsung.com>,
        <yanaijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] backlight: lms501kf03: remove unused 'seq_sleep_in' and 'seq_up_dn'
Date:   Fri, 17 Apr 2020 17:22:57 +0800
Message-ID: <20200417092257.13694-1-yanaijie@huawei.com>
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

drivers/video/backlight/lms501kf03.c:96:28: warning: ‘seq_sleep_in’
defined but not used [-Wunused-const-variable=]
 static const unsigned char seq_sleep_in[] = {
                            ^~~~~~~~~~~~
drivers/video/backlight/lms501kf03.c:92:28: warning: ‘seq_up_dn’ defined
but not used [-Wunused-const-variable=]
 static const unsigned char seq_up_dn[] = {
                            ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/backlight/lms501kf03.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
index 8ae32e3573c1..c1bd02bb8b2e 100644
--- a/drivers/video/backlight/lms501kf03.c
+++ b/drivers/video/backlight/lms501kf03.c
@@ -89,14 +89,6 @@ static const unsigned char seq_rgb_gamma[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const unsigned char seq_up_dn[] = {
-	0x36, 0x10,
-};
-
-static const unsigned char seq_sleep_in[] = {
-	0x10,
-};
-
 static const unsigned char seq_sleep_out[] = {
 	0x11,
 };
-- 
2.21.1

