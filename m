Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22995C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B4520791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:47:38 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:21106 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbgHMHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:47:37 -0400
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgCHj+fd7zRfB4jOAQ--.60727S4;
        Thu, 13 Aug 2020 15:46:41 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Hills <mark@xwax.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Giuliano Pochini <pochini@shiny.it>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ALSA: echoaudio: Fix potential Oops in snd_echo_resume()
Date:   Thu, 13 Aug 2020 15:46:30 +0800
Message-Id: <20200813074632.17022-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCHj+fd7zRfB4jOAQ--.60727S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWDuw4rArWkZF45tr4xWFg_yoWkWrX_Gw
        48urn5Cay5tr95C34DJrW8WryDJ3Za9r1xA39xtF47JasxJas2qr97Xrs3AryxurW09r98
        KrWrXryjkrn0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoLBlZdtPic1gABsJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freeing chip on error may lead to an Oops at the next time
the system goes to resume. Fix this by removing all
snd_echo_free() calls on error.

Fixes: 47b5d028fdce8 ("ALSA: Echoaudio - Add suspend support #2")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Remove snd_echo_free() calls in all error paths.
---
 sound/pci/echoaudio/echoaudio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 6aeb99aa2414..868f1dcd27d6 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2213,7 +2213,6 @@ static int snd_echo_resume(struct device *dev)
 	if (err < 0) {
 		kfree(commpage_bak);
 		dev_err(dev, "resume init_hw err=%d\n", err);
-		snd_echo_free(chip);
 		return err;
 	}
 
@@ -2240,7 +2239,6 @@ static int snd_echo_resume(struct device *dev)
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "cannot grab irq\n");
-		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-- 
2.17.1

