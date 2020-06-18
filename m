Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88235C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654FC20885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445321;
	bh=Bt6ZEXdLA0UnS2fNEifmKdZSL9+XTRkjajHnMGGenKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTRbR5rCXmVgg0AQDT+n8BCSy2b0SvNIHFmaIQxOWpaeJ1HJjRPvyV+drkvus/IR6
	 va74V40V4SySq4K6VG/vMvdlMRobvwb9C6LRebJITldTM8ok/QYHKdhd2ExJOW77TD
	 pT/1lZsnuIN00ycNd4Gaw30NgN83qOQQxKAkYKwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgFRBzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbgFRBZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76322088E;
        Thu, 18 Jun 2020 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443548;
        bh=Bt6ZEXdLA0UnS2fNEifmKdZSL9+XTRkjajHnMGGenKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTw7J4K1Y63ecV/Mi5hCQnKPsZpmXRGFvzO3/2vtVYHl4OvtLSCh638ZD7Oi0oXtx
         tQ50rNkbHRIx2Bv1hrpdpk5x4+wF6ijgvJXoKNTA6SS4LyLQRLN5eaKvzCrDr1iZas
         gejYXLNAEfSsE8qjlTul4WAB+TjfNc1hd486taoo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 164/172] ASoC: core: only convert non DPCM link to DPCM link
Date:   Wed, 17 Jun 2020 21:22:10 -0400
Message-Id: <20200618012218.607130-164-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 607fa205a7e4dfad28b8a67ab1c985756ddbccb0 ]

Additional checks for valid DAIs expose a corner case, where existing
BE dailinks get modified, e.g. HDMI links are tagged with
dpcm_capture=1 even if the DAIs are for playback.

This patch makes those changes conditional and flags configuration
issues when a BE dailink is has no_pcm=0 but dpcm_playback or
dpcm_capture=1 (which makes no sense).

As discussed on the alsa-devel mailing list, there are redundant flags
for dpcm_playback, dpcm_capture, playback_only, capture_only. This
will have to be cleaned-up in a future update. For now only correct
and flag problematic configurations.

Fixes: 218fe9b7ec7f3 ("ASoC: soc-core: Set dpcm_playback / dpcm_capture")
Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20200608194415.4663-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e45dfcb62b6a..595fe20bbc6d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1920,9 +1920,25 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			dai_link->platform_name = component->name;
 
 			/* convert non BE into BE */
-			dai_link->no_pcm = 1;
-			dai_link->dpcm_playback = 1;
-			dai_link->dpcm_capture = 1;
+			if (!dai_link->no_pcm) {
+				dai_link->no_pcm = 1;
+
+				if (dai_link->dpcm_playback)
+					dev_warn(card->dev,
+						 "invalid configuration, dailink %s has flags no_pcm=0 and dpcm_playback=1\n",
+						 dai_link->name);
+				if (dai_link->dpcm_capture)
+					dev_warn(card->dev,
+						 "invalid configuration, dailink %s has flags no_pcm=0 and dpcm_capture=1\n",
+						 dai_link->name);
+
+				/* convert normal link into DPCM one */
+				if (!(dai_link->dpcm_playback ||
+				      dai_link->dpcm_capture)) {
+					dai_link->dpcm_playback = !dai_link->capture_only;
+					dai_link->dpcm_capture = !dai_link->playback_only;
+				}
+			}
 
 			/* override any BE fixups */
 			dai_link->be_hw_params_fixup =
-- 
2.25.1

