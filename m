Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D7FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D82620656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMGNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:13:09 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46636 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgHMGNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:13:08 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb93V2TRfUU0IAA--.16S2;
        Thu, 13 Aug 2020 14:12:37 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/soc/intel: Fix spelling mistake "cant" --> "can't"
Date:   Thu, 13 Aug 2020 14:12:37 +0800
Message-Id: <1597299157-32221-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb93V2TRfUU0IAA--.16S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWxtF1fGF48uF4ftw1xAFb_yoW8uw4kpa
        18GayDKFWqgF4ruFyUtw47WF10yws5Jw47Gr4aka4xJF1DJr4rCwnrtw1j9FWF9rZ3ua9x
        Za17Za48Ar1rWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GF1l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8N18PUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some spelling mistakes in a dev_err message. Fix it.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 sound/soc/intel/common/sst-firmware.c     | 4 ++--
 sound/soc/intel/haswell/sst-haswell-ipc.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 0594f89..1189ec3 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -130,7 +130,7 @@ static void block_list_remove(struct sst_dsp *dsp,
 			err = block->ops->disable(block);
 			if (err < 0)
 				dev_err(dsp->dev,
-					"error: cant disable block %d:%d\n",
+					"error: can't disable block %d:%d\n",
 					block->type, block->index);
 		}
 	}
@@ -158,7 +158,7 @@ static int block_list_prepare(struct sst_dsp *dsp,
 			ret = block->ops->enable(block);
 			if (ret < 0) {
 				dev_err(dsp->dev,
-					"error: cant disable block %d:%d\n",
+					"error: can't disable block %d:%d\n",
 					block->type, block->index);
 				goto err;
 			}
diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 0ff89ea..773688b 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -1507,7 +1507,7 @@ static int sst_hsw_dx_state_dump(struct sst_hsw *hsw)
 
 	ret = sst_dsp_dma_get_channel(sst, 0);
 	if (ret < 0) {
-		dev_err(hsw->dev, "error: cant allocate dma channel %d\n", ret);
+		dev_err(hsw->dev, "error: can't allocate dma channel %d\n", ret);
 		return ret;
 	}
 
@@ -1587,7 +1587,7 @@ int sst_hsw_dsp_load(struct sst_hsw *hsw)
 
 	ret = sst_dsp_dma_get_channel(dsp, 0);
 	if (ret < 0) {
-		dev_err(hsw->dev, "error: cant allocate dma channel %d\n", ret);
+		dev_err(hsw->dev, "error: can't allocate dma channel %d\n", ret);
 		return ret;
 	}
 
@@ -1616,7 +1616,7 @@ static int sst_hsw_dsp_restore(struct sst_hsw *hsw)
 
 	ret = sst_dsp_dma_get_channel(dsp, 0);
 	if (ret < 0) {
-		dev_err(hsw->dev, "error: cant allocate dma channel %d\n", ret);
+		dev_err(hsw->dev, "error: can't allocate dma channel %d\n", ret);
 		return ret;
 	}
 
-- 
2.1.0

