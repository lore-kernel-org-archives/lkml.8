Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0793C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DF621D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219060;
	bh=TxGvwKirdzeH0HzqPaUcNdhQgOWVsAZkw7r9reHCr2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=io3WPmXx2zAbYAp1A+9HEbUjlnspORt8vRmzjGsWqEKH8mwpMOlGQhBqKZOI6c91K
	 1LMMl82kABsSyQs/KTX3Fa/QiN1+q9u1LOjw7e2yqNxgYttdRa28DNumCopm+ImDws
	 hVQ4yQ98ze7E1qM3Ip3sMkInEJqMWZU/fB8p/xq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgDROKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgDROKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E07121D6C;
        Sat, 18 Apr 2020 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219036;
        bh=TxGvwKirdzeH0HzqPaUcNdhQgOWVsAZkw7r9reHCr2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYm6q5Iu4kLKtFBiWgK5bRAXcyGiFF18Fts59Kresfg+YwjIB1fF3PAJDNAuNX0DK
         htdqtyYl1wmZj77y08rACp4jMFy3I/MncrhS9AnM6ojvvbruCJ4db2CR7VuaDpOJNt
         f47gNXft1+kydGg1virsGyd5a/EHL+dkKzdnYxFA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.5 70/75] ASoC: SOF: trace: fix unconditional free in trace release
Date:   Sat, 18 Apr 2020 10:09:05 -0400
Message-Id: <20200418140910.8280-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
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
index b0e4556c8536a..5bf63fa67fb09 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -343,7 +343,10 @@ void snd_sof_free_trace(struct snd_sof_dev *sdev)
 
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

