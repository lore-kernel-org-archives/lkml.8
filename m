Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD93FC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B180420737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGQIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:17:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726113AbgGQIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:17:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 811CDCCE162726C141B8;
        Fri, 17 Jul 2020 16:17:39 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 16:17:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <anarsoul@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: line6: Use kmemdup in podhd_set_monitor_level()
Date:   Fri, 17 Jul 2020 16:17:10 +0800
Message-ID: <20200717081710.39180-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/usb/line6/podhd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 1557483ec657..eef45f7fef0d 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -293,12 +293,10 @@ static void podhd_set_monitor_level(struct usb_line6_podhd *podhd, int value)
 	};
 	unsigned char *buf;
 
-	buf = kmalloc(sizeof(msg), GFP_KERNEL);
+	buf = kmemdup(msg, sizeof(msg), GFP_KERNEL);
 	if (!buf)
 		return;
 
-	memcpy(buf, msg, sizeof(msg));
-
 	if (value < 0)
 		value = 0;
 
-- 
2.17.1


