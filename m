Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E3C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F4420736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731570;
	bh=+IpdCvSrrMlIO5bYtEAPQGW5UebOGBJelOOYntb8ZG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yfDlp+4awJfJqqMULt3hnihpu56bFLAe5Lt7asJfhYw5tZ7VSnY8upI5iiU6bQwza
	 yyUP2VedBRznTW9XmHVjVU/9qXYV1hqxE4DJjhiFPUAOxj+VtYWdNeKvVozLgKGFTA
	 ReqX43COeojfP0xQ4YHSVev3Mq/hf/mhdpXLO6Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgDXMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgDXMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:22:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5836421582;
        Fri, 24 Apr 2020 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730970;
        bh=+IpdCvSrrMlIO5bYtEAPQGW5UebOGBJelOOYntb8ZG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSWxtVEG7qZcO/I3BM6QjAfS39u/mRBWuk31DOEBQsjGlxdWXjtRZ20AIY6tO+7Ww
         qrrQammUPbCau6q6IGrPPkGkpDUiyMh5A47y0w646IVyzE0DGAnSVRSxop8kka6vrn
         hLchslAos0go7E8iiU9hWMdT/L18ontwLVx4YyZ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Roy Spliet <nouveau@spliet.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 11/38] ALSA: hda: Keep the controller initialization even if no codecs found
Date:   Fri, 24 Apr 2020 08:22:09 -0400
Message-Id: <20200424122237.9831-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 9479e75fca370a5220784f7596bf598c4dad0b9b ]

Currently, when the HD-audio controller driver doesn't detect any
codecs, it tries to abort the probe.  But this abort happens at the
delayed probe, i.e. the primary probe call already returned success,
hence the driver is never unbound until user does so explicitly.
As a result, it may leave the HD-audio device in the running state
without the runtime PM.  More badly, if the device is a HD-audio bus
that is tied with a GPU, GPU cannot reach to the full power down and
consumes unnecessarily much power.

This patch changes the logic after no-codec situation; it continues
probing without the further codec initialization but keep the
controller driver running normally.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Tested-by: Roy Spliet <nouveau@spliet.org>
Link: https://lore.kernel.org/r/20200413082034.25166-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 692857904d49e..aa0be85614b6c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2009,7 +2009,7 @@ static int azx_first_init(struct azx *chip)
 	/* codec detection */
 	if (!azx_bus(chip)->codec_mask) {
 		dev_err(card->dev, "no codecs found!\n");
-		return -ENODEV;
+		/* keep running the rest for the runtime PM */
 	}
 
 	if (azx_acquire_irq(chip, 0) < 0)
@@ -2303,9 +2303,11 @@ static int azx_probe_continue(struct azx *chip)
 #endif
 
 	/* create codec instances */
-	err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
-	if (err < 0)
-		goto out_free;
+	if (bus->codec_mask) {
+		err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
+		if (err < 0)
+			goto out_free;
+	}
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	if (chip->fw) {
@@ -2319,7 +2321,7 @@ static int azx_probe_continue(struct azx *chip)
 #endif
 	}
 #endif
-	if ((probe_only[dev] & 1) == 0) {
+	if (bus->codec_mask && !(probe_only[dev] & 1)) {
 		err = azx_codec_configure(chip);
 		if (err < 0)
 			goto out_free;
-- 
2.20.1

