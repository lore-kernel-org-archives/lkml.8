Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7DEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D6620663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457326;
	bh=LrZXZEubYZSKqiTFZIYg7Vo/qX4plYNVGh4YOJxUS/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QRkMLM4EClLU0orEwMrNSGaMkxzAl0FP6R7IrH5QL0irh4N31A/tvpfU2wtm03hqK
	 /wlVEBfzz8O2E9hnOymmhfGevunzdQkkvQN+LLgJiOBSmTapYzbZbAbcRoWRiJQgYj
	 exCO0X3D+3OKmkjxe+7rDkH7rs21grTjkAJ7NecA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgF2TCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbgF2TAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB462254E5;
        Mon, 29 Jun 2020 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446041;
        bh=LrZXZEubYZSKqiTFZIYg7Vo/qX4plYNVGh4YOJxUS/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCd8VXDtWtnSgWd+4517JZwoxUmDJFL1VxzINTGI/eufiljAE+ewP7TLmNUCjBiSn
         8plJ4kGgnmRoHjJjOKRPG8UKFNXteanc/zRWPHzaSEqr9rael8AGQP3Vs/VIiwAg21
         nMoGahJN6hgcTnojZ7hS9vb8FxbABoI5DpKBnVhw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 046/135] ASoC: fsl_asrc_dma: Fix dma_chan leak when config DMA channel failed
Date:   Mon, 29 Jun 2020 11:51:40 -0400
Message-Id: <20200629155309.2495516-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 36124fb19f1ae68a500cd76a76d40c6e81bee346 ]

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
Link: https://lore.kernel.org/r/1590415966-52416-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_asrc_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index ffc000bc1f15b..56a873ba08e47 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -243,6 +243,7 @@ static int fsl_asrc_dma_hw_params(struct snd_pcm_substream *substream,
 	ret = dmaengine_slave_config(pair->dma_chan[dir], &config_be);
 	if (ret) {
 		dev_err(dev, "failed to config DMA channel for Back-End\n");
+		dma_release_channel(pair->dma_chan[dir]);
 		return ret;
 	}
 
-- 
2.25.1

