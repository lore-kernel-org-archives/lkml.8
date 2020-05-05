Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFB6C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36511206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEEDEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 23:04:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgEEDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 23:04:41 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVnsR-0003MR-F8; Tue, 05 May 2020 03:04:12 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ALSA: hda: Use hdac_to_hda_codec macro
Date:   Tue,  5 May 2020 11:03:53 +0800
Message-Id: <20200505030357.28004-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505030357.28004-1-kai.heng.feng@canonical.com>
References: <20200505030357.28004-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hdac_to_hda_codec() instead of container_of().

No functional change intended.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 include/sound/hda_codec.h   |  4 ++++
 sound/pci/hda/patch_hdmi.c  | 12 ++++++------
 sound/soc/codecs/hdac_hda.h |  4 ----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 225154a4f2ed..8a32060e3d8d 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -288,6 +288,10 @@ struct hda_codec {
 #define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, core.dev)
 #define hda_codec_dev(_dev)	(&(_dev)->core.dev)
 
+#define hdac_to_hda_priv(_hdac) \
+			container_of(_hdac, struct hdac_hda_priv, codec.core)
+#define hdac_to_hda_codec(_hdac) container_of(_hdac, struct hda_codec, core)
+
 #define list_for_each_codec(c, bus) \
 	list_for_each_entry(c, &(bus)->core.codec_list, core.list)
 #define list_for_each_codec_safe(c, n, bus)				\
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4eff16053bd5..f21b66abb271 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2022,7 +2022,7 @@ static const struct hda_pcm_ops generic_ops = {
 
 static int hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 {
-	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hda_codec *codec = hdac_to_hda_codec(hdac);
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
 
@@ -2035,7 +2035,7 @@ static int hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 static void hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
 					unsigned char *chmap)
 {
-	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hda_codec *codec = hdac_to_hda_codec(hdac);
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
 
@@ -2049,7 +2049,7 @@ static void hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
 static void hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 				unsigned char *chmap, int prepared)
 {
-	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hda_codec *codec = hdac_to_hda_codec(hdac);
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
 
@@ -2065,7 +2065,7 @@ static void hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 
 static bool is_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 {
-	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hda_codec *codec = hdac_to_hda_codec(hdac);
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
 
@@ -3783,7 +3783,7 @@ static int atihdmi_paired_chmap_validate(struct hdac_chmap *chmap,
 static int atihdmi_pin_set_slot_channel(struct hdac_device *hdac,
 		hda_nid_t pin_nid, int hdmi_slot, int stream_channel)
 {
-	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hda_codec *codec = hdac_to_hda_codec(hdac);
 	int verb;
 	int ati_channel_setup = 0;
 
@@ -3819,7 +3819,7 @@ static int atihdmi_pin_set_slot_channel(struct hdac_device *hdac,
 static int atihdmi_pin_get_slot_channel(struct hdac_device *hdac,
 				hda_nid_t pin_nid, int asp_slot)
 {
-	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hda_codec *codec = hdac_to_hda_codec(hdac);
 	bool was_odd = false;
 	int ati_asp_slot = asp_slot;
 	int verb;
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index 598b07d9b6fe..d0efc5e254ae 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -28,10 +28,6 @@ struct hdac_hda_priv {
 	bool need_display_power;
 };
 
-#define hdac_to_hda_priv(_hdac) \
-			container_of(_hdac, struct hdac_hda_priv, codec.core)
-#define hdac_to_hda_codec(_hdac) container_of(_hdac, struct hda_codec, core)
-
 struct hdac_ext_bus_ops *snd_soc_hdac_hda_get_ops(void);
 
 #endif /* __HDAC_HDA_H__ */
-- 
2.17.1

