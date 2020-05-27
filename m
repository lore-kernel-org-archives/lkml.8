Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E57206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgE0Iqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:46:49 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:42250 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388107AbgE0Iqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:46:48 -0400
Received: from localhost.localdomain (unknown [222.205.60.151])
        by mail-app2 (Coremail) with SMTP id by_KCgCH_5bSKM5eQWchAA--.7710S4;
        Wed, 27 May 2020 16:46:13 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: img-spdif-out: Fix runtime PM imbalance on error
Date:   Wed, 27 May 2020 16:46:08 +0800
Message-Id: <20200527084610.4790-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCH_5bSKM5eQWchAA--.7710S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWrZF15CFyUGr4xXF1UKFg_yoWfAFg_uw
        4kGws3W3yfGws2qrW7Ja1Yv397Wrn7K3WUGr10vr15K34YyFZ8W3y8Xr98Cr18Xa1kZry0
        q3yDuryxAryqvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
        XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE
        14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
        Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x0JUP-B_UUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0MBlZdtOUT6wAPso
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a pairing decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 sound/soc/img/img-spdif-out.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 456c462d52fb..b1d8e4535726 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -370,8 +370,10 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_suspend;
+	}
 
 	img_spdif_out_writel(spdif, IMG_SPDIF_OUT_CTL_FS_MASK,
 			     IMG_SPDIF_OUT_CTL);
-- 
2.17.1

