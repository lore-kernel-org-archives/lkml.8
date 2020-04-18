Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A95214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587217827;
	bh=B4bMlNkd5p86XZw4dYVYeRK/tVq+Bue8h8ry5C9RHwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n313H00dBYhD4nx/e/hi4dnAOK7C9V0HLY1d/fNMYGqmSilTCsownjfBs3DNnHbc+
	 AoSJbjVkEssjHj89NOi/HKGIsArHNLj5PEq67+m5TPkRqeAtfpPRNytD+j0O6kPcMG
	 /poEfFMGkOo2G7MUCRrWBUaOf6yx1eRJ8/smPUOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDRNu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgDRNtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:49:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4D821BE5;
        Sat, 18 Apr 2020 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217773;
        bh=B4bMlNkd5p86XZw4dYVYeRK/tVq+Bue8h8ry5C9RHwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLyRygJk7YH/gE3zacWF8ZWE0IAgqtJGgMH6fVttcnzZ5UlreWa8aVbjZ59owQchf
         I0tbptovC0DAPeNzP+mmTe8wqLVW3p6AeAamaOPDZ1mTAs0gns0vT9NwqzqaIVZrLp
         v7mkXL/IU8T+sXgmNY7l9kS9R8QHV/04qs1T1kIw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 62/73] ALSA: ice1724: Fix invalid access for enumerated ctl items
Date:   Sat, 18 Apr 2020 09:48:04 -0400
Message-Id: <20200418134815.6519-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c47914c00be346bc5b48c48de7b0da5c2d1a296c ]

The access to Analog Capture Source control value implemented in
prodigy_hifi.c is wrong, as caught by the recently introduced sanity
check; it should be accessing value.enumerated.item[] instead of
value.integer.value[].  This patch corrects the wrong access pattern.

Fixes: 6b8d6e5518e2 ("[ALSA] ICE1724: Added support for Audiotrak Prodigy 7.1 HiFi & HD2, Hercules Fortissimo IV")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207139
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200407084402.25589-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/ice1712/prodigy_hifi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 91f83cef0e56c..9aa12a67d3705 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -536,7 +536,7 @@ static int wm_adc_mux_enum_get(struct snd_kcontrol *kcontrol,
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
 	mutex_lock(&ice->gpio_mutex);
-	ucontrol->value.integer.value[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
+	ucontrol->value.enumerated.item[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
@@ -550,7 +550,7 @@ static int wm_adc_mux_enum_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&ice->gpio_mutex);
 	oval = wm_get(ice, WM_ADC_MUX);
-	nval = (oval & 0xe0) | ucontrol->value.integer.value[0];
+	nval = (oval & 0xe0) | ucontrol->value.enumerated.item[0];
 	if (nval != oval) {
 		wm_put(ice, WM_ADC_MUX, nval);
 		change = 1;
-- 
2.20.1

