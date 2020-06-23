Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43384C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69382168B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944798;
	bh=tBwLZeFFDSLN54QKqv1zpl5gDlR13lI/B5RF+LRFrr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahC1m+ZOEADkmcCB2iONUqg3I2FCuyByXEdhhQ6GR3miHohjpmRtV14VG3qtUMgr/
	 DR8kPTfIyPSaz+jtfpwNb+xX3QmsZ3cv4eZwHPHSZh/pva/IIh3tvrZ3LkxRvPu4GH
	 6bfD+apVnOkxeNt9eGo/3eh7cQKnzRLx0FIXW5mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbgFWUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390650AbgFWUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:39:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B7E6217D9;
        Tue, 23 Jun 2020 20:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944789;
        bh=tBwLZeFFDSLN54QKqv1zpl5gDlR13lI/B5RF+LRFrr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjGkOc8j5bAF2JzZeR4SCwM8gCIeQCX378lXZE0tbCCC/RXYKys0MSkSlrMCttLBi
         NEiNBC0/2NZn8MaoqUmRIuGUCdclWyYXEf7KLQHPHpsgBg146C/emkp7xVAqTtoeeT
         xQy6Uxb1G/54dapT6ipryAF0fI0mEJ7rwqdtAtgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/206] ASoC: fsl_asrc_dma: Fix dma_chan leak when config DMA channel failed
Date:   Tue, 23 Jun 2020 21:57:32 +0200
Message-Id: <20200623195323.071717775@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 1033ac6631b08..b9ac448989ed9 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -241,6 +241,7 @@ static int fsl_asrc_dma_hw_params(struct snd_pcm_substream *substream,
 	ret = dmaengine_slave_config(pair->dma_chan[dir], &config_be);
 	if (ret) {
 		dev_err(dev, "failed to config DMA channel for Back-End\n");
+		dma_release_channel(pair->dma_chan[dir]);
 		return ret;
 	}
 
-- 
2.25.1



