Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A6CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4818208A7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="vr25gmg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbgEYON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:13:56 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:42035 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388825AbgEYONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=jjl3+oli5pGJqLVTivxSZM0ZQQ2sMqgs051h5Kwq758=; b=v
        r25gmg4PpwrSFeC1XnleuloZOVBgVYTxlt4gM7dwkz+JPXVDOoT+TfmnSEv+r+J2
        iNisbQi218odFdWFe5VxJcnwRoEP3+kz4eyPg5AcwC+qo2I01+L7DQQIkSPCgb6e
        MIiL+Le0e/zN2HuIEfUNAMTCpKEs2UaJPtHxpLQ/90=
Received: from localhost.localdomain (unknown [223.73.184.21])
        by app2 (Coremail) with SMTP id XQUFCgCHjPyJ0steaA6pAg--.26484S3;
        Mon, 25 May 2020 22:13:30 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] ASoC: fsl_asrc_dma: Fix dma_chan leak when config DMA channel failed
Date:   Mon, 25 May 2020 22:12:46 +0800
Message-Id: <1590415966-52416-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgCHjPyJ0steaA6pAg--.26484S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45trW7uw1UZF1kXF17GFg_yoW8JFy3p3
        ykJrWqgryYyF43GFsxJws5Xr1UXrWakr4ft3y0kay3Z3s8Jr93CF1aqw109FyjvrW8Ar10
        gFWYqF1F93W3GrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU189N7UUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl_asrc_dma_hw_params() invokes dma_request_channel() or
fsl_asrc_get_dma_channel(), which returns a reference of the specified
dma_chan object to "pair->dma_chan[dir]" with increased refcnt.

The reference counting issue happens in one exception handling path of
fsl_asrc_dma_hw_params(). When config DMA channel failed for Back-End,
the function forgets to decrease the refcnt increased by
dma_request_channel() or fsl_asrc_get_dma_channel(), causing a refcnt
leak.

Fix this issue by calling dma_release_channel() when config DMA channel
failed.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index e7178817d7a7..1ee10eafe3e6 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -252,6 +252,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	ret = dmaengine_slave_config(pair->dma_chan[dir], &config_be);
 	if (ret) {
 		dev_err(dev, "failed to config DMA channel for Back-End\n");
+		dma_release_channel(pair->dma_chan[dir]);
 		return ret;
 	}
 
-- 
2.7.4

