Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2103C2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgGOQ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:27:19 -0400
Received: from ipmail04.adl3.internode.on.net ([150.101.137.10]:23235 "EHLO
        ipmail04.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbgGOQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:27:18 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 12:27:14 EDT
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BKBABQLA9f/5UxyQ5ggRCBQ4MZVF+?=
 =?us-ascii?q?NNIYAnDCBaQsBMwkBAgQBAYRGBAKCDCU3Bg4CEAEBBgEBAQEBBgSGSAyGHQs?=
 =?us-ascii?q?BIyNPgQKDJgGCexCqdTOJMIE6BoE4iAOFCYIAgRGDToJcBBd+CiAFhg8EjzK?=
 =?us-ascii?q?LbJoRgmeBC4dIkHkwgQuBbYk7kwYBnBuWZoF7MxoIKAg7gmlQGQ2OKheDTop?=
 =?us-ascii?q?mNDACNQIGCAEBAwlXAY0cgjUBAQ?=
Received: from 14-201-49-149.tpgi.com.au (HELO silver.lan) ([14.201.49.149])
  by ipmail04.adl3.internode.on.net with ESMTP; 16 Jul 2020 01:52:09 +0930
From:   Paul Schulz <paul@mawsonlakes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Schulz <paul@mawsonlakes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] sound/pci/hda: Changes 'blacklist/whitelist' to 'blocklist/allowlist'
Date:   Thu, 16 Jul 2020 01:52:04 +0930
Message-Id: <20200715162204.104646-1-paul@mawsonlakes.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This edit changes instances of 'blacklist' and 'whitelist' to
'blocklist' and 'allowlist' (and associated variations)
in sound/pci/hda.

This is a functionally trivial patch and has no other effect.

Signed-off-by: Paul Schulz <paul@mawsonlakes.org>
---
 Documentation/sound/hd-audio/notes.rst |  2 +-
 sound/pci/hda/hda_intel.c              | 32 +++++++++++++-------------
 sound/pci/hda/patch_realtek.c          |  6 ++---
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index 0f3109d9abc8..1024ca1a7bd2 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -142,7 +142,7 @@ thus we disabled MSI for them.
 There seem also still other devices that don't work with MSI.  If you
 see a regression wrt the sound quality (stuttering, etc) or a lock-up
 in the recent kernel, try to pass ``enable_msi=0`` option to disable
-MSI.  If it works, you can add the known bad device to the blacklist
+MSI.  If it works, you can add the known bad device to the blocklist
 defined in hda_intel.c.  In such a case, please report and give the
 patch back to the upstream developer. 
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3565e2ab0965..c7596773358b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -178,9 +178,9 @@ module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
 
-static bool pm_blacklist = true;
-module_param(pm_blacklist, bool, 0644);
-MODULE_PARM_DESC(pm_blacklist, "Enable power-management blacklist");
+static bool pm_blocklist = true;
+module_param(pm_blocklist, bool, 0644);
+MODULE_PARM_DESC(pm_blocklist, "Enable power-management blocklist");
 
 /* reset the HD-audio controller in power save mode.
  * this may give more power-saving, but will take longer time to
@@ -1508,7 +1508,7 @@ static bool check_hdmi_disabled(struct pci_dev *pci)
 #endif /* SUPPORT_VGA_SWITCHEROO */
 
 /*
- * white/black-listing for position_fix
+ * allow/block-listing for position_fix
  */
 static const struct snd_pci_quirk position_fix_list[] = {
 	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_LPIB),
@@ -1601,7 +1601,7 @@ static void assign_position_fix(struct azx *chip, int fix)
 }
 
 /*
- * black-lists for probe_mask
+ * block-lists for probe_mask
  */
 static const struct snd_pci_quirk probe_mask_list[] = {
 	/* Thinkpad often breaks the controller communication when accessing
@@ -1649,9 +1649,9 @@ static void check_probe_mask(struct azx *chip, int dev)
 }
 
 /*
- * white/black-list for enable_msi
+ * allow/block-list for enable_msi
  */
-static const struct snd_pci_quirk msi_black_list[] = {
+static const struct snd_pci_quirk msi_block_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x2191, "HP", 0), /* AMD Hudson */
 	SND_PCI_QUIRK(0x103c, 0x2192, "HP", 0), /* AMD Hudson */
 	SND_PCI_QUIRK(0x103c, 0x21f7, "HP", 0), /* AMD Hudson */
@@ -1674,7 +1674,7 @@ static void check_msi(struct azx *chip)
 		return;
 	}
 	chip->msi = 1;	/* enable MSI as default */
-	q = snd_pci_quirk_lookup(chip->pci, msi_black_list);
+	q = snd_pci_quirk_lookup(chip->pci, msi_block_list);
 	if (q) {
 		dev_info(chip->card->dev,
 			 "msi for device %04x:%04x set to %d\n",
@@ -2074,11 +2074,11 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
 #endif
 }
 
-/* Blacklist for skipping the whole probe:
+/* Blocklist for skipping the whole probe:
  * some HD-audio PCI entries are exposed without any codecs, and such devices
  * should be ignored from the beginning.
  */
-static const struct pci_device_id driver_blacklist[] = {
+static const struct pci_device_id driver_blocklist[] = {
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
@@ -2101,8 +2101,8 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
-	if (pci_match_id(driver_blacklist, pci)) {
-		dev_info(&pci->dev, "Skipping the blacklisted device\n");
+	if (pci_match_id(driver_blocklist, pci)) {
+		dev_info(&pci->dev, "Skipping the blocklisted device\n");
 		return -ENODEV;
 	}
 
@@ -2192,7 +2192,7 @@ static int azx_probe(struct pci_dev *pci,
  * So we keep a list of devices where we disable powersaving as its known
  * to causes problems on these devices.
  */
-static const struct snd_pci_quirk power_save_blacklist[] = {
+static const struct snd_pci_quirk power_save_blocklist[] = {
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0xc892, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
@@ -2235,12 +2235,12 @@ static void set_default_power_save(struct azx *chip)
 	int val = power_save;
 
 #ifdef CONFIG_PM
-	if (pm_blacklist) {
+	if (pm_blocklist) {
 		const struct snd_pci_quirk *q;
 
-		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
+		q = snd_pci_quirk_lookup(chip->pci, power_save_blocklist);
 		if (q && val) {
-			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
+			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blocklist, forcing power_save to 0\n",
 				 q->subvendor, q->subdevice);
 			val = 0;
 		}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 194ffa8c66ce..3ced5762bac4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1070,7 +1070,7 @@ static int set_beep_amp(struct alc_spec *spec, hda_nid_t nid,
 	return 0;
 }
 
-static const struct snd_pci_quirk beep_white_list[] = {
+static const struct snd_pci_quirk beep_allow_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x103c, "ASUS", 1),
 	SND_PCI_QUIRK(0x1043, 0x115d, "ASUS", 1),
 	SND_PCI_QUIRK(0x1043, 0x829f, "ASUS", 1),
@@ -1080,7 +1080,7 @@ static const struct snd_pci_quirk beep_white_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x834a, "EeePC", 1),
 	SND_PCI_QUIRK(0x1458, 0xa002, "GA-MA790X", 1),
 	SND_PCI_QUIRK(0x8086, 0xd613, "Intel", 1),
-	/* blacklist -- no beep available */
+	/* blocklist -- no beep available */
 	SND_PCI_QUIRK(0x17aa, 0x309e, "Lenovo ThinkCentre M73", 0),
 	SND_PCI_QUIRK(0x17aa, 0x30a3, "Lenovo ThinkCentre M93", 0),
 	{}
@@ -1090,7 +1090,7 @@ static inline int has_cdefine_beep(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	const struct snd_pci_quirk *q;
-	q = snd_pci_quirk_lookup(codec->bus->pci, beep_white_list);
+	q = snd_pci_quirk_lookup(codec->bus->pci, beep_allow_list);
 	if (q)
 		return q->value;
 	return spec->cdefine.enable_pcbeep;
-- 
2.25.1

