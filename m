Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E6C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EC324954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340243;
	bh=GZCl39VIH5zDp0nkCodPTNaCNT1yMG52x4YMPziwtFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dsFg76HjG/AeTK51msSPXTE8IOccn1JkLOBU8VZaETxUAcT2lxaOXjh0MepumJu1c
	 DwjBNdmfMzGsftNVXGFNOdyKrQVq6swsBTgG/TIFXRSj8G6ngmYTJI7ZFSOatxmPuT
	 LXxcN0MZRhkRI2XWE9TTSuCvsFBTSlnbtmbd3CDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgEANhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbgEANhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8192173E;
        Fri,  1 May 2020 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340232;
        bh=GZCl39VIH5zDp0nkCodPTNaCNT1yMG52x4YMPziwtFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzZ5RzRnNahSawy7uphFwacxRbxRfO0hVrOk0szcTajZk9vpa8/gx73FXd7hNfHo6
         2PmTRYKebLhrfSzZzpH5qImTY3Uqbea996s8BAWgjlz8qf16/na8sOwsqdRmhTWXZ0
         6Y7HQNjwNXF1DECqo47VjgjHGR9xASD+x8B9Sy0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roy Spliet <nouveau@spliet.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 31/46] ALSA: hda: Keep the controller initialization even if no codecs found
Date:   Fri,  1 May 2020 15:22:56 +0200
Message-Id: <20200501131509.715298157@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0502042c16163..72c268e887e55 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2054,7 +2054,7 @@ static int azx_first_init(struct azx *chip)
 	/* codec detection */
 	if (!azx_bus(chip)->codec_mask) {
 		dev_err(card->dev, "no codecs found!\n");
-		return -ENODEV;
+		/* keep running the rest for the runtime PM */
 	}
 
 	if (azx_acquire_irq(chip, 0) < 0)
@@ -2440,9 +2440,11 @@ static int azx_probe_continue(struct azx *chip)
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
@@ -2456,7 +2458,7 @@ static int azx_probe_continue(struct azx *chip)
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



