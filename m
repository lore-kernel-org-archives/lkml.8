Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D794D21D82
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443138;
	bh=gXL3bSVpz6/25LWNlUTD5b7GAglv32K1RsVfRFyM3L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppJSjq03Bd2FYeP4NxUdV6HSbFTSE9fvj6UQ/8//PPRYVec++1GfXqR7eu0U5Ip/W
	 91om0ozOUR2sI90oUFsFzeSUzmOMx/Dw2u1XnVVUsJobFyjzEOTSmJumKgHqyv0Igx
	 AeP3OUD8D9aU81f9q25ulwnpk38ltYrh5ttYmQ4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgFRBS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbgFRBP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B514206F1;
        Thu, 18 Jun 2020 01:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442955;
        bh=gXL3bSVpz6/25LWNlUTD5b7GAglv32K1RsVfRFyM3L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K33EsTmqZe2Dlv/D6EEOBUdWdgH32kSA8n21dB+UYbOPmXjXMktGuzKIH5CHMSu2R
         2UOCOVpWxAVY2dyeIPtT+IQYtieRWpFBTgewHM2OleQV6QOgAh3+W5nUZzmzpS1Tut
         P7CjcX9VbyTAKoSKiPk5ArEknSgr1bR8St5B6EAo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.7 363/388] ASoC: core: only convert non DPCM link to DPCM link
Date:   Wed, 17 Jun 2020 21:07:40 -0400
Message-Id: <20200618010805.600873-363-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
index 843b8b1c89d4..e5433e8fcf19 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1720,9 +1720,25 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			dai_link->platforms->name = component->name;
 
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

