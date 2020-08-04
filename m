Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7912075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHDNs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:48:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49564 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:48:22 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k2xIT-0002gl-8L; Tue, 04 Aug 2020 13:48:05 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ALSA: hda/hdmi: Add quirk to force connectivity
Date:   Tue,  4 Aug 2020 21:48:00 +0800
Message-Id: <20200804134801.10872-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI on some platforms doesn't enable audio support because its Port
Connectivity [31:30] is set to AC_JACK_PORT_NONE:
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x58560010: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 3
     0x02 0x03* 0x04

For now, use a quirk to force connectivity based on SSID. If there are
more platforms affected by the same issue, we can eye for a more generic
solution.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use a quirk list instead.

 include/sound/hda_codec.h  |  1 +
 sound/pci/hda/patch_hdmi.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index d16a4229209b..947cba68d9fe 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -254,6 +254,7 @@ struct hda_codec {
 	unsigned int link_down_at_suspend:1; /* link down at runtime suspend */
 	unsigned int relaxed_resume:1;	/* don't resume forcibly for jack */
 	unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
+	unsigned int force_connect:1; /* force connectivity */
 
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index cd46247988e4..40d4f0e0e3d7 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1701,7 +1701,8 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	 * all device entries on the same pin
 	 */
 	config = snd_hda_codec_get_pincfg(codec, pin_nid);
-	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
+	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE &&
+	    !codec->force_connect)
 		return 0;
 
 	/*
@@ -1803,11 +1804,17 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 	return 0;
 }
 
+static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
+	{}
+};
+
 static int hdmi_parse_codec(struct hda_codec *codec)
 {
 	hda_nid_t start_nid;
 	unsigned int caps;
 	int i, nodes;
+	const struct snd_pci_quirk *q;
 
 	nodes = snd_hda_get_sub_nodes(codec, codec->core.afg, &start_nid);
 	if (!start_nid || nodes < 0) {
@@ -1815,6 +1822,11 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 		return -EINVAL;
 	}
 
+	q = snd_pci_quirk_lookup(codec->bus->pci, force_connect_list);
+
+	if (q && q->value)
+		codec->force_connect = 1;
+
 	/*
 	 * hdmi_add_pin() assumes total amount of converters to
 	 * be known, so first discover all converters
-- 
2.17.1

