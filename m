Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9409C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BEF20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731207;
	bh=bNANKviVquGroUDmFUbv1Ylh8FSezjVIPwlM6upjf6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZPDmYAfCPWkwOPvcumpecz30eJJdd2+VZXRwJT/E0MKTOM5inNDXEqBMn66mUwa+j
	 +xm4KFddhcESK+KY7sX1N50VycCiyJE0Jg6XIOCTNagBTMRj8kafA1yah3GwlEEqdJ
	 PhpAAZ9RlShYrekbip4oAli0Z7Cctk66PCyrMlAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgDXM0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgDXMYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C5621775;
        Fri, 24 Apr 2020 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731089;
        bh=bNANKviVquGroUDmFUbv1Ylh8FSezjVIPwlM6upjf6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgoBncAnyjsxVQqNoW1r2AUU9g7tqAiv7dxhY746W2MiGC2Z0sIuXNHYTYAZuM2ew
         qYVFaHHdbQwjNUas0a1xEnhOXcuSb9PF8HRtBH3XAwoobZKkGa+ai+Ln+ATSatIjzT
         gVUKVrL/AN9XCiQ44MuOGZBuJqtworFRZck5vgGU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 02/13] ALSA: hda: Don't release card at firmware loading error
Date:   Fri, 24 Apr 2020 08:24:35 -0400
Message-Id: <20200424122447.10882-2-sashal@kernel.org>
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

[ Upstream commit 25faa4bd37c10f19e4b848b9032a17a3d44c6f09 ]

At the error path of the firmware loading error, the driver tries to
release the card object and set NULL to drvdata.  This may be referred
badly at the possible PM action, as the driver itself is still bound
and the PM callbacks read the card object.

Instead, we continue the probing as if it were no option set.  This is
often a better choice than the forced abort, too.

Fixes: 5cb543dba986 ("ALSA: hda - Deferred probing with request_firmware_nowait()")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Link: https://lore.kernel.org/r/20200413082034.25166-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3234e9ca02cec..5a578ebca1055 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1828,24 +1828,15 @@ static void azx_firmware_cb(const struct firmware *fw, void *context)
 {
 	struct snd_card *card = context;
 	struct azx *chip = card->private_data;
-	struct pci_dev *pci = chip->pci;
-
-	if (!fw) {
-		dev_err(card->dev, "Cannot load firmware, aborting\n");
-		goto error;
-	}
 
-	chip->fw = fw;
+	if (fw)
+		chip->fw = fw;
+	else
+		dev_err(card->dev, "Cannot load firmware, continue without patching\n");
 	if (!chip->disabled) {
 		/* continue probing */
-		if (azx_probe_continue(chip))
-			goto error;
+		azx_probe_continue(chip);
 	}
-	return; /* OK */
-
- error:
-	snd_card_free(card);
-	pci_set_drvdata(pci, NULL);
 }
 #endif
 
-- 
2.20.1

