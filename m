Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E0C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 05:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E676206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 05:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgC2FpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 01:45:05 -0400
Received: from magratgarlick.emantor.de ([78.46.208.201]:41646 "EHLO
        magratgarlick.emantor.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgC2FpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 01:45:05 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 01:45:04 EDT
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id 55A1CF5D13; Sun, 29 Mar 2020 07:38:09 +0200 (CEST)
Received: from localhost (200116B828b19602BDF47B2a5Ed39330.dip.versatel-1u1.de [IPv6:2001:16b8:28b1:9602:bdf4:7b2a:5ed3:9330])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id EEF25F5D10;
        Sun, 29 Mar 2020 07:38:06 +0200 (CEST)
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Rouven Czerwinski <rouven@czerwinskis.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: default enable CA0132 DSP support
Date:   Sun, 29 Mar 2020 07:30:15 +0200
Message-Id: <20200329053710.4276-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rouven Czerwinski <rouven@czerwinskis.de>

If SND_HDA_CODEC_CA0132 is enabled, the DSP support should be enabled as
well. Disabled DSP support leads to a hanging alsa system and no sound
output on the card otherwise. Tested on:

  06:00.0 Audio device: Creative Labs Sound Core3D [Sound Blaster Recon3D / Z-Series] (rev 01)

Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
---
 sound/pci/hda/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index bd48335d09d7..e1d3082a4fe9 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -184,6 +184,7 @@ comment "Set to Y if you want auto-loading the codec driver"
 config SND_HDA_CODEC_CA0132_DSP
 	bool "Support new DSP code for CA0132 codec"
 	depends on SND_HDA_CODEC_CA0132
+	default y
 	select SND_HDA_DSP_LOADER
 	select FW_LOADER
 	help

base-commit: e595dd94515ed6bc5ba38fce0f9598db8c0ee9a9
-- 
2.25.1

