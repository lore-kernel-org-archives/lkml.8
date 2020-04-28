Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CD2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0584E206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgD1MCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:02:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgD1MCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:02:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E64020B5D08FD27AD28;
        Tue, 28 Apr 2020 20:02:00 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 20:01:54 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] media: cx231xx: Remove unneeded semicolon
Date:   Tue, 28 Apr 2020 20:08:09 +0800
Message-ID: <1588075689-73680-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warnings:

drivers/media/usb/cx231xx/cx231xx-avcore.c:610:3-4: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/media/usb/cx231xx/cx231xx-avcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-avcore.c b/drivers/media/usb/cx231xx/cx231xx-avcore.c
index d611709..3d3c881 100644
--- a/drivers/media/usb/cx231xx/cx231xx-avcore.c
+++ b/drivers/media/usb/cx231xx/cx231xx-avcore.c
@@ -607,7 +607,7 @@ int cx231xx_set_video_input_mux(struct cx231xx *dev, u8 input)
 							CX231XX_VMUX_COMPOSITE1,
 							INPUT(input)->vmux);
 			break;
-		};
+		}
 
 		break;
 	default:
-- 
2.6.2

