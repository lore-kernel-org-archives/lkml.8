Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C7C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AAC21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221630;
	bh=kS84/PMzUhc05SlVzbqfWKPVeFTCGPqj3rCQ/hKNBfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bp/wPUu1IVr1d/2T/E9L9QH7J/47+9kPIKHgUAY28MAeLD5jpCFtD9TtNWm0cCMA7
	 6P+7OqC67tSMskmse6+MdByY/6LP/XzRW0Z1/hnasFnQ9U/GNwX72IuyyEub00ZZZK
	 aLaudlJn1kIJYCLLIjiGyE5Cr6UibyTaijj3QgCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgDROxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgDROly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C98521D6C;
        Sat, 18 Apr 2020 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220914;
        bh=kS84/PMzUhc05SlVzbqfWKPVeFTCGPqj3rCQ/hKNBfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq30iur+eUVtJV2VxeLJKTwYR40zeAQhBPQSnUSampsz7M/gsqznryuOQORBdHYHC
         AkHfeK2IONjX9UL9j5jlmwyQBMgcrfXj66V0VzoKNSp1KIeYJ7OV7HX6u1nQqX51S8
         o1rXgm3agEOmG+rva3JhGul6v8rcM4lgEH5qJX7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 53/78] ALSA: ice1724: Fix invalid access for enumerated ctl items
Date:   Sat, 18 Apr 2020 10:40:22 -0400
Message-Id: <20200418144047.9013-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
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
index 9d71e9d5c9a06..3cf41c11a4050 100644
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

