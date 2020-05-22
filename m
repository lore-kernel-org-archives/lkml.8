Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DE6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDED206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgEVLHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:07:47 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:63376 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728281AbgEVLHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:07:45 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app2 (Coremail) with SMTP id by_KCgCHLzh0ssdetmytAQ--.15534S4;
        Fri, 22 May 2020 19:07:36 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: arizona: Fix runtime PM imbalance on error
Date:   Fri, 22 May 2020 19:07:31 +0800
Message-Id: <20200522110732.874-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCHLzh0ssdetmytAQ--.15534S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr18ZFyfAw4UGFyDtF1fWFg_yoWfJFX_Cw
        45urZ3ur4fKryxtwsFv39Iv3ySkFnFqFn5Wr1vvr4fWa4UZa1kWrWkZr98Ar43Z39YqF1q
        kFn8ZF4fAryxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VU13rc3UUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoIBlZdtOQpEAAAsk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When arizona_request_irq() returns an error code, a
pairing runtime PM usage counter decrement is needed
to keep the counter balanced. For error paths after
this function, things are the same.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/extcon/extcon-arizona.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 7401733db08b..470bbc8e5089 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1744,6 +1744,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 err_rise:
 	arizona_free_irq(arizona, jack_irq_rise, info);
 err_gpio:
+	pm_runtime_put(&pdev->dev);
 	gpiod_put(info->micd_pol_gpio);
 err_register:
 	pm_runtime_disable(&pdev->dev);
-- 
2.17.1

