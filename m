Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CFDC38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2412520753
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221568;
	bh=HodnGnuMi+LksA5uszWutSWeSnAmqU5/+qlJ4cBGPx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piwJQa6L0plTXkPftg7XGZeRkFffy5UpnY2K1P688VoFNncUYF2aoJGNwJFr4Sk8g
	 mZZaHwv1atq9h2r4sCLYdOXah9UIM0Acr2H2IvRQG+vVx+o1mLfcNPZr18vDY578km
	 DP05+wsaVLPujleyjA343yN0RS6lci3lKZDnLeug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgDROwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgDROmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:42:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3EE22244;
        Sat, 18 Apr 2020 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220932;
        bh=HodnGnuMi+LksA5uszWutSWeSnAmqU5/+qlJ4cBGPx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5LDbrPjjhSpR/mGBo2qL6CjbEeeKl3FVQOxYO9nFFqslPOIK8L61Qiylx3h3TiFW
         fTwLZJVCr204dhhiHsO85bcmSHD02v0Sp83pseyvXseozQKGHi/KhUgWcI5XnHoQSr
         Ce9v7o2EyxQoYuFV1/aSxxyQipQT59PILxV03/0M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 68/78] ASoC: SOF: trace: fix unconditional free in trace release
Date:   Sat, 18 Apr 2020 10:40:37 -0400
Message-Id: <20200418144047.9013-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit e6110114d18d330c05fd6de9f31283fd086a5a3a ]

Check if DMA pages were successfully allocated in initialization
before calling free. For many types of memory (like sgbufs)
the extra free is harmless, but not all backends track allocation
state, so add an explicit check.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200124213625.30186-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/trace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index 4c3cff031fd66..fd6f5913782bf 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -328,7 +328,10 @@ void snd_sof_free_trace(struct snd_sof_dev *sdev)
 {
 	snd_sof_release_trace(sdev);
 
-	snd_dma_free_pages(&sdev->dmatb);
-	snd_dma_free_pages(&sdev->dmatp);
+	if (sdev->dma_trace_pages) {
+		snd_dma_free_pages(&sdev->dmatb);
+		snd_dma_free_pages(&sdev->dmatp);
+		sdev->dma_trace_pages = 0;
+	}
 }
 EXPORT_SYMBOL(snd_sof_free_trace);
-- 
2.20.1

