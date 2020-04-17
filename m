Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE6C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5A120857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgDQI5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:57:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729889AbgDQI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:57:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94EE9152C75F57358E36;
        Fri, 17 Apr 2020 16:57:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 16:56:52 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <paulus@samba.org>, <b.zolnierkie@samsung.com>,
        <daniel.vetter@ffwll.ch>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] video: fbdev: aty128fb: remove unused 'sdr_64'
Date:   Fri, 17 Apr 2020 17:23:18 +0800
Message-ID: <20200417092318.13978-1-yanaijie@huawei.com>
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

drivers/video/fbdev/aty/aty128fb.c:337:36: warning: ‘sdr_64’ defined but
not used [-Wunused-const-variable=]
 static const struct aty128_meminfo sdr_64 = {
                                    ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index d7e41c8dd533..d05d4195acad 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -334,20 +334,6 @@ static const struct aty128_meminfo sdr_128 = {
 	.name = "128-bit SDR SGRAM (1:1)",
 };
 
-static const struct aty128_meminfo sdr_64 = {
-	.ML = 4,
-	.MB = 8,
-	.Trcd = 3,
-	.Trp = 3,
-	.Twr = 1,
-	.CL = 3,
-	.Tr2w = 1,
-	.LoopLatency = 17,
-	.DspOn = 46,
-	.Rloop = 17,
-	.name = "64-bit SDR SGRAM (1:1)",
-};
-
 static const struct aty128_meminfo sdr_sgram = {
 	.ML = 4,
 	.MB = 4,
-- 
2.21.1

