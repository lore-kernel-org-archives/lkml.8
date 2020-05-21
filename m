Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AC2207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgEUIqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:46:53 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:53184 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgEUIqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:46:52 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app2 (Coremail) with SMTP id by_KCgB3PpDqP8ZedauaAQ--.63213S4;
        Thu, 21 May 2020 16:46:38 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ti: edma: Fix runtime PM imbalance on error
Date:   Thu, 21 May 2020 16:46:32 +0800
Message-Id: <20200521084634.31966-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgB3PpDqP8ZedauaAQ--.63213S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFW3Gr18JF1xWF4UArb_yoW3ZFg_Cw
        1rZr4xWrnIgFZFqr17Aa1YvrySgFWjqF1vgF10qw13t3y2vwn8JrW5Zrn5Aw17XrWUCr1q
        ya1vgFn7CrWUujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE
        14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
        Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4a0PUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEHBlZdtOPItAAbs5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/dma/ti/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index c4a5c170c1f9..609ce2607eb7 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2402,8 +2402,7 @@ static int edma_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		pm_runtime_disable(dev);
-		return ret;
+		goto err_disable_pm;
 	}
 
 	/* Get eDMA3 configuration from IP */
-- 
2.17.1

