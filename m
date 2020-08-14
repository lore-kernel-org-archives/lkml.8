Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A0BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C53A20771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHNIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:46:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:24196 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgHNIqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:46:44 -0400
IronPort-SDR: WCXVbP3qtXG0lXoiHLDGPT/PEL7cXN7NLlxlElXyZxyqSSzdF2hFj9DNifcBEkW4DkWsEFgcnq
 X97y1QTWYXUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133897305"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="133897305"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 01:46:42 -0700
IronPort-SDR: 7SUjLnKdtkf6mm5php99netnUFQYhe5d3szIy6e3H89YsXzBJU9rK2Y+SUoHsiXPGga/vkIg80
 56Qz9/kj1T5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="291678153"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2020 01:46:40 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdac_hdmi: support 'ELD' mixer
Date:   Fri, 14 Aug 2020 16:34:36 +0800
Message-Id: <20200814083436.19845-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an binary mixer 'ELD' to each HDMI PCM device so user space
could read the ELD data of external HDMI display.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 139 +++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f26b77faed59..83656bbf22a7 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -9,6 +9,7 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
+
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -107,6 +108,7 @@ struct hdac_hdmi_pcm {
 	unsigned char chmap[8]; /* ALSA API channel-map */
 	struct mutex lock;
 	int jack_event;
+	struct snd_kcontrol *eld_ctl;
 };
 
 struct hdac_hdmi_dai_port_map {
@@ -1248,6 +1250,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	struct hdac_hdmi_pcm *pcm;
 	int size = 0;
 	int port_id = -1;
+	bool eld_valid, eld_changed;
 
 	if (!hdmi)
 		return;
@@ -1273,6 +1276,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 			size = -EINVAL;
 	}
 
+	eld_valid = port->eld.eld_valid;
+
 	if (size > 0) {
 		port->eld.eld_valid = true;
 		port->eld.eld_size = size;
@@ -1281,6 +1286,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 		port->eld.eld_size = 0;
 	}
 
+	eld_changed = (eld_valid != port->eld.eld_valid);
+
 	pcm = hdac_hdmi_get_pcm(hdev, port);
 
 	if (!port->eld.monitor_present || !port->eld.eld_valid) {
@@ -1313,6 +1320,12 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 
 	}
 	mutex_unlock(&hdmi->pin_mutex);
+
+	if (eld_changed && pcm)
+		snd_ctl_notify(hdmi->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE |
+			       SNDRV_CTL_EVENT_MASK_INFO,
+			       &pcm->eld_ctl->id);
 }
 
 static int hdac_hdmi_add_ports(struct hdac_device *hdev,
@@ -1411,6 +1424,122 @@ static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdev)
 
 }
 
+static int hdac_hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+	struct hdac_hdmi_pcm *pcm;
+	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_eld *eld;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = 0;
+
+	pcm = get_hdmi_pcm_from_id(hdmi, kcontrol->id.device);
+	if (!pcm) {
+		dev_dbg(component->dev, "%s: no pcm, device %d\n", __func__,
+			kcontrol->id.device);
+		return 0;
+	}
+
+	if (list_empty(&pcm->port_list)) {
+		dev_dbg(component->dev, "%s: empty port list, device %d\n",
+			__func__, kcontrol->id.device);
+		return 0;
+	}
+
+	mutex_lock(&hdmi->pin_mutex);
+
+	list_for_each_entry(port, &pcm->port_list, head) {
+		eld = &port->eld;
+
+		if (eld->eld_valid) {
+			uinfo->count = eld->eld_size;
+			break;
+		}
+	}
+
+	mutex_unlock(&hdmi->pin_mutex);
+
+	return 0;
+}
+
+static int hdac_hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+	struct hdac_hdmi_pcm *pcm;
+	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_eld *eld;
+
+	memset(ucontrol->value.bytes.data, 0, ARRAY_SIZE(ucontrol->value.bytes.data));
+
+	pcm = get_hdmi_pcm_from_id(hdmi, kcontrol->id.device);
+	if (!pcm) {
+		dev_dbg(component->dev, "%s: no pcm, device %d\n", __func__,
+			kcontrol->id.device);
+		return 0;
+	}
+
+	if (list_empty(&pcm->port_list)) {
+		dev_dbg(component->dev, "%s: empty port list, device %d\n",
+			__func__, kcontrol->id.device);
+		return 0;
+	}
+
+	mutex_lock(&hdmi->pin_mutex);
+
+	list_for_each_entry(port, &pcm->port_list, head) {
+		eld = &port->eld;
+
+		if (!eld->eld_valid)
+			continue;
+
+		if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data) ||
+		    eld->eld_size > ELD_MAX_SIZE) {
+			mutex_unlock(&hdmi->pin_mutex);
+
+			dev_err(component->dev, "%s: buffer too small, device %d eld_size %d\n",
+				__func__, kcontrol->id.device, eld->eld_size);
+			snd_BUG();
+			return -EINVAL;
+		}
+
+		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
+		       eld->eld_size);
+		break;
+	}
+
+	mutex_unlock(&hdmi->pin_mutex);
+
+	return 0;
+}
+
+static int hdac_hdmi_create_eld_ctl(struct snd_soc_component *component, struct hdac_hdmi_pcm *pcm)
+{
+	struct snd_kcontrol *kctl;
+	struct snd_kcontrol_new hdmi_eld_ctl = {
+		.access	= SNDRV_CTL_ELEM_ACCESS_READ |
+			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.iface	= SNDRV_CTL_ELEM_IFACE_PCM,
+		.name	= "ELD",
+		.info	= hdac_hdmi_eld_ctl_info,
+		.get	= hdac_hdmi_eld_ctl_get,
+		.device	= pcm->pcm_id,
+	};
+
+	/* add ELD ctl with the device number corresponding to the PCM stream */
+	kctl = snd_ctl_new1(&hdmi_eld_ctl, component);
+	if (!kctl)
+		return -ENOMEM;
+
+	pcm->eld_ctl = kctl;
+
+	return snd_ctl_add(component->card->snd_card, kctl);
+}
+
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup = hdac_hdmi_pcm_open,
 	.shutdown = hdac_hdmi_pcm_close,
@@ -1784,6 +1913,16 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 		}
 	}
 
+	/* add control for ELD Bytes */
+	err = hdac_hdmi_create_eld_ctl(component, pcm);
+	if (err < 0) {
+		dev_err(&hdev->dev,
+			"eld control add failed with err: %d for pcm: %d\n",
+			err, device);
+		kfree(pcm);
+		return err;
+	}
+
 	list_add_tail(&pcm->head, &hdmi->pcm_list);
 
 	return 0;
-- 
2.17.1

