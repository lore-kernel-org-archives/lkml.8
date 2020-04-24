Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CFC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AF821775
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731095;
	bh=kmelNa/WUeSvKwE5V7Lp6PzWwjudjJxBSZmBMHF3McA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ie79vNKpgOrljE0RaGpxVB81K9Fx7kfOJw+9D3QVhsFmmnJhmkvvy19imuV3h7coX
	 SpcSGQYhhST1W5OOlwTU2Xrp9v5roiTDXgdQw+HWVvaYMm1o9ZnRfsOeWT9MhKoMma
	 h/tltFRMjRfIJ/HAJaP37j1E/e+Tkcp4DOELjJV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgDXMYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgDXMYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E3620700;
        Fri, 24 Apr 2020 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731090;
        bh=kmelNa/WUeSvKwE5V7Lp6PzWwjudjJxBSZmBMHF3McA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0q2eqFMikSA7T8QhXPks/0cXLuGyaP4M92fTSZz8FQ4Ccpfe9mGUrYN6+LyZYpR+
         EmB+che0wTsjKrURKfVSUjhckblXF1DX6qvvuL6HPqhqA4gsE3BnvR6FhojLKqtxUB
         lrY5Ne8YprcDdvvvUk5maHajroXK4CRsi5PzG5dI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Roy Spliet <nouveau@spliet.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 03/13] ALSA: hda: Keep the controller initialization even if no codecs found
Date:   Fri, 24 Apr 2020 08:24:36 -0400
Message-Id: <20200424122447.10882-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122447.10882-1-sashal@kernel.org>
References: <20200424122447.10882-1-sashal@kernel.org>
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
index 5a578ebca1055..8b9d1c6574e43 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1806,7 +1806,7 @@ static int azx_first_init(struct azx *chip)
 	/* codec detection */
 	if (!azx_bus(chip)->codec_mask) {
 		dev_err(card->dev, "no codecs found!\n");
-		return -ENODEV;
+		/* keep running the rest for the runtime PM */
 	}
 
 	if (azx_acquire_irq(chip, 0) < 0)
@@ -2129,9 +2129,11 @@ static int azx_probe_continue(struct azx *chip)
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
@@ -2145,7 +2147,7 @@ static int azx_probe_continue(struct azx *chip)
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

