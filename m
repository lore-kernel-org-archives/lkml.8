Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4FC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3JMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:12:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgD3JMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:12:14 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jU5EZ-00063O-A0; Thu, 30 Apr 2020 09:11:56 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: SOF: Update correct LED status at the first time usage of update_mute_led()
Date:   Thu, 30 Apr 2020 17:11:39 +0800
Message-Id: <20200430091139.7003-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the first time update_mute_led() gets called, if channels are already
muted, the temp value equals to led_value as 0, skipping the following
LED setting.

So set led_value to -1 as an uninitialized state, to update the correct
LED status at first time usage.

Fixes: 5d43001ae436 ("ASoC: SOF: acpi led support for switch controls")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/soc/sof/control.c   | 4 ++--
 sound/soc/sof/sof-audio.h | 2 +-
 sound/soc/sof/topology.c  | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index dfc412e2d956..6d63768d42aa 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -19,8 +19,8 @@ static void update_mute_led(struct snd_sof_control *scontrol,
 			    struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	unsigned int temp = 0;
-	unsigned int mask;
+	int temp = 0;
+	int mask;
 	int i;
 
 	mask = 1U << snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index bf65f31af858..875a5fc13297 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -56,7 +56,7 @@ struct snd_sof_pcm {
 struct snd_sof_led_control {
 	unsigned int use_led;
 	unsigned int direction;
-	unsigned int led_value;
+	int led_value;
 };
 
 /* ALSA SOF Kcontrol device */
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index fe8ba3e05e08..ab2b69de1d4d 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1203,6 +1203,8 @@ static int sof_control_load(struct snd_soc_component *scomp, int index,
 		return ret;
 	}
 
+	scontrol->led_ctl.led_value = -1;
+
 	dobj->private = scontrol;
 	list_add(&scontrol->list, &sdev->kcontrol_list);
 	return ret;
-- 
2.17.1

