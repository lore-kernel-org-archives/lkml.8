Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ABC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0154920B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDILVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:21:30 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:58406 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgDILVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:21:30 -0400
Received: from ubuntu.localdomain (unknown [111.198.228.245])
        by APP-05 (Coremail) with SMTP id zQCowACXn5sVBY9eVbUUAQ--.40637S2;
        Thu, 09 Apr 2020 19:20:54 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     perex@perex.cz, tiwai@suse.com, tglx@linutronix.de,
        allison@lohutok.net
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ctxfi: Remove unnecessary cast in kfree
Date:   Thu,  9 Apr 2020 19:20:52 +0800
Message-Id: <20200409112052.13402-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowACXn5sVBY9eVbUUAQ--.40637S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DZrW3Ww48tr1DCFWDCFg_yoW8ArWfpF
        48GrsxWrW7JFWqywn5trs8XasxCanrCr4xC340kw4fCa45JF18XFn3uFWUKr47ua4fGF1F
        k3yjkFy5Cr90yrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5r7UUUUU==
X-Originating-IP: [111.198.228.245]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEBA10Teu1UpQAAst
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecassary casts in the argument to kfree.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/pci/ctxfi/cthw20k1.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 6e3177bcc709..015c0d676897 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -168,7 +168,7 @@ static int src_get_rsc_ctrl_blk(void **rblk)
 
 static int src_put_rsc_ctrl_blk(void *blk)
 {
-	kfree((struct src_rsc_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
@@ -494,7 +494,7 @@ static int src_mgr_get_ctrl_blk(void **rblk)
 
 static int src_mgr_put_ctrl_blk(void *blk)
 {
-	kfree((struct src_mgr_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
@@ -515,7 +515,7 @@ static int srcimp_mgr_get_ctrl_blk(void **rblk)
 
 static int srcimp_mgr_put_ctrl_blk(void *blk)
 {
-	kfree((struct srcimp_mgr_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
@@ -702,7 +702,7 @@ static int amixer_rsc_get_ctrl_blk(void **rblk)
 
 static int amixer_rsc_put_ctrl_blk(void *blk)
 {
-	kfree((struct amixer_rsc_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
@@ -909,7 +909,7 @@ static int dai_get_ctrl_blk(void **rblk)
 
 static int dai_put_ctrl_blk(void *blk)
 {
-	kfree((struct dai_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
@@ -958,7 +958,7 @@ static int dao_get_ctrl_blk(void **rblk)
 
 static int dao_put_ctrl_blk(void *blk)
 {
-	kfree((struct dao_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
@@ -1156,7 +1156,7 @@ static int daio_mgr_get_ctrl_blk(struct hw *hw, void **rblk)
 
 static int daio_mgr_put_ctrl_blk(void *blk)
 {
-	kfree((struct daio_mgr_ctrl_blk *)blk);
+	kfree(blk);
 
 	return 0;
 }
-- 
2.17.1

