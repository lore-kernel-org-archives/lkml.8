Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB62C3B1B4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF47520873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703219;
	bh=cBFPbr8CVvdMgTjBagQOmxmbeGJeF3llcrP0PGr67TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PIGNuJIqR7Ezfav6S38v+no1vY0fmtoq5y2rzLL6LzMBGB31HLBdglzRiafjv9er5
	 N0mvAp1xraHqLN/hN3SpEnUZw78GJLmvvaz49DfLrTjcwVU+8JvVJ9A0Dn314X2HFL
	 cYNv7FzlrMqkHzrB869+aeHrgTySVb7oG4wM16N0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgBNP4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387779AbgBNP4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9312082F;
        Fri, 14 Feb 2020 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695784;
        bh=cBFPbr8CVvdMgTjBagQOmxmbeGJeF3llcrP0PGr67TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tv+FnrA7Iaj9m0LNlO0UH+q17RzMRLX8VJ5uquS68rvOGdfMEeSoTn55fyfy0cpK5
         aPzxiGih0+tsvuCPNm6PL8077e32fRAot2tqR01Tdi44vLOYv74RvO7hwzdkDRM+Qh
         z//8I4mK1VvpU9XEB1Teb3EzVS2JDCHfsZjXE1Ek=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.5 348/542] ASoC: SOF: Intel: hda-dai: fix compilation warning in pcm_prepare
Date:   Fri, 14 Feb 2020 10:45:40 -0500
Message-Id: <20200214154854.6746-348-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit d873997192ddcacb5333575502be2f91ea4b47b8 ]

Fix GCC warning with W=1, previous cleanup did not remove unnecessary
variable.

sound/soc/sof/intel/hda-dai.c: In function ‘hda_link_pcm_prepare’:

sound/soc/sof/intel/hda-dai.c:265:31: warning: variable ‘hda_stream’
set but not used [-Wunused-but-set-variable]
  265 |  struct sof_intel_hda_stream *hda_stream;
      |                               ^~~~~~~~~~

Fixes: a3ebccb52efdf ("ASoC: SOF: Intel: hda: reset link DMA state in prepare")
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200113205620.27285-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 896d21984b735..1923b0c36bcef 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -261,14 +261,11 @@ static int hda_link_pcm_prepare(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
-	struct sof_intel_hda_stream *hda_stream;
 	struct snd_sof_dev *sdev =
 				snd_soc_component_get_drvdata(dai->component);
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	int stream = substream->stream;
 
-	hda_stream = hstream_to_sof_hda_stream(link_dev);
-
 	if (link_dev->link_prepared)
 		return 0;
 
-- 
2.20.1

