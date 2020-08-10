Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F22F206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHJCIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:08:22 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:43134 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgHJCIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:08:22 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-03 (Coremail) with SMTP id rQCowAB3fxsIrDBfy_pnAQ--.21942S2;
        Mon, 10 Aug 2020 10:08:08 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        stern@rowland.harvard.edu, johan@kernel.org, vulab@iscas.ac.cn,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] yurex: remove needless check before usb_free_coherent()
Date:   Mon, 10 Aug 2020 02:08:02 +0000
Message-Id: <20200810020802.9082-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAB3fxsIrDBfy_pnAQ--.21942S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrZw4UGr47GFWDJw48Crg_yoWDCFgE93
        95Zr93X3s0vF13AF1qg3yUZrZ0v34jgr1vgrsFqrW5XFWjkw15tr17Jr98tr45uas3WFs8
        Awn2grWrKr4rZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JjUUUUUUU
        UU=
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiAwgEA13qZSbaIQAAsD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_free_coherent() is safe with NULL addr and this check is
not required.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/usb/misc/yurex.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 6e7d34e7fec4..2063ef071393 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -96,15 +96,13 @@ static void yurex_delete(struct kref *kref)
 	if (dev->cntl_urb) {
 		usb_kill_urb(dev->cntl_urb);
 		kfree(dev->cntl_req);
-		if (dev->cntl_buffer)
-			usb_free_coherent(dev->udev, YUREX_BUF_SIZE,
+		usb_free_coherent(dev->udev, YUREX_BUF_SIZE,
 				dev->cntl_buffer, dev->cntl_urb->transfer_dma);
 		usb_free_urb(dev->cntl_urb);
 	}
 	if (dev->urb) {
 		usb_kill_urb(dev->urb);
-		if (dev->int_buffer)
-			usb_free_coherent(dev->udev, YUREX_BUF_SIZE,
+		usb_free_coherent(dev->udev, YUREX_BUF_SIZE,
 				dev->int_buffer, dev->urb->transfer_dma);
 		usb_free_urb(dev->urb);
 	}
-- 
2.17.1

