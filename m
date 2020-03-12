Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CAAC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4206206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCLTew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:34:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:23851 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgCLTew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:34:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 12:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243142589"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.241.169])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:34:49 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 05/10] ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
Date:   Thu, 12 Mar 2020 14:33:41 -0500
Message-Id: <20200312193346.3264-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now we have a limited number of machine driver configurations, and
we can detect them based on the link configuration returned after
checking hardware and firmware (BIOS) configurations.

The link configuration is checked with a link_mask as well as a list
of _ADR descriptors for each link.

There is a chance that in extreme cases where the BIOS contains too
much information we would need to detect which Slave devices actually
report as 'attached'. This would be more accurate than static
table-based solutions, but it also introduces timing dependencies
since we don't know when those devices might become attached, so will
only be only be looked at if we see limitations with static methods
and the usual quirks based e.g. on DMI information.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 164 ++++++++++++++++++++++++++++++++++----
 1 file changed, 149 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index f257b21d2551..1892f612c11d 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -20,6 +20,7 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
 #include <sound/intel-nhlt.h>
 #include <sound/sof.h>
@@ -136,11 +137,8 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hdev;
 	struct sdw_intel_res res;
-	acpi_handle handle;
 	void *sdw;
 
-	handle = ACPI_HANDLE(sdev->dev);
-
 	hdev = sdev->pdata->hw_pdata;
 
 	memset(&res, 0, sizeof(res));
@@ -180,6 +178,9 @@ int hda_sdw_startup(struct snd_sof_dev *sdev)
 
 	hdev = sdev->pdata->hw_pdata;
 
+	if (!hdev->sdw)
+		return 0;
+
 	return sdw_intel_startup(hdev->sdw);
 }
 
@@ -537,24 +538,31 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	/* scan SoundWire capabilities exposed by DSDT */
 	ret = hda_sdw_acpi_scan(sdev);
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: SoundWire ACPI scan error\n");
-		return ret;
+		dev_dbg(sdev->dev, "skipping SoundWire, ACPI scan error\n");
+		goto skip_soundwire;
 	}
 
 	link_mask = hdev->info.link_mask;
 	if (!link_mask) {
-		/*
-		 * probe/allocated SoundWire resources.
-		 * The hardware configuration takes place in hda_sdw_startup
-		 * after power rails are enabled.
-		 */
-		ret = hda_sdw_probe(sdev);
-		if (ret < 0) {
-			dev_err(sdev->dev, "error: SoundWire probe error\n");
-			return ret;
-		}
+		dev_dbg(sdev->dev, "skipping SoundWire, no links enabled\n");
+		goto skip_soundwire;
 	}
 
+	/*
+	 * probe/allocate SoundWire resources.
+	 * The hardware configuration takes place in hda_sdw_startup
+	 * after power rails are enabled.
+	 * It's entirely possible to have a mix of I2S/DMIC/SoundWire
+	 * devices, so we allocate the resources in all cases.
+	 */
+	ret = hda_sdw_probe(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire probe error\n");
+		return ret;
+	}
+
+skip_soundwire:
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
@@ -953,6 +961,122 @@ static int hda_generic_machine_select(struct snd_sof_dev *sdev)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
+/* Check if all Slaves defined on the link can be found */
+static bool link_slaves_found(struct snd_sof_dev *sdev,
+			      const struct snd_soc_acpi_link_adr *link,
+			      struct sdw_intel_ctx *sdw)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct sdw_intel_slave_id *ids = sdw->ids;
+	int num_slaves = sdw->num_slaves;
+	unsigned int part_id, link_id, unique_id, mfg_id;
+	int i, j;
+
+	for (i = 0; i < link->num_adr; i++) {
+		u64 adr = link->adr_d[i].adr;
+
+		mfg_id = SDW_MFG_ID(adr);
+		part_id = SDW_PART_ID(adr);
+		link_id = SDW_DISCO_LINK_ID(adr);
+		for (j = 0; j < num_slaves; j++) {
+			if (ids[j].link_id != link_id ||
+			    ids[j].id.part_id != part_id ||
+			    ids[j].id.mfg_id != mfg_id)
+				continue;
+			/*
+			 * we have to check unique id
+			 * if there is more than one
+			 * Slave on the link
+			 */
+			unique_id = SDW_UNIQUE_ID(adr);
+			if (link->num_adr == 1 ||
+			    ids[j].id.unique_id == SDW_IGNORED_UNIQUE_ID ||
+			    ids[j].id.unique_id == unique_id) {
+				dev_dbg(bus->dev,
+					"found %x at link %d\n",
+					part_id, link_id);
+				break;
+			}
+		}
+		if (j == num_slaves) {
+			dev_dbg(bus->dev,
+				"Slave %x not found\n",
+				part_id);
+			return false;
+		}
+	}
+	return true;
+}
+
+static int hda_sdw_machine_select(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *pdata = sdev->pdata;
+	const struct snd_soc_acpi_link_adr *link;
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct snd_soc_acpi_mach *mach;
+	struct sof_intel_hda_dev *hdev;
+	u32 link_mask;
+	int i;
+
+	hdev = pdata->hw_pdata;
+	link_mask = hdev->info.link_mask;
+
+	/*
+	 * Select SoundWire machine driver if needed using the
+	 * alternate tables. This case deals with SoundWire-only
+	 * machines, for mixed cases with I2C/I2S the detection relies
+	 * on the HID list.
+	 */
+	if (link_mask && !pdata->machine) {
+		for (mach = pdata->desc->alt_machines;
+		     mach && mach->link_mask; mach++) {
+			if (mach->link_mask != link_mask)
+				continue;
+
+			/* No need to match adr if there is no links defined */
+			if (!mach->links)
+				break;
+
+			link = mach->links;
+			for (i = 0; i < hdev->info.count; i++, link++) {
+				/*
+				 * Try next machine if any expected Slaves
+				 * are not found on this link.
+				 */
+				if (!link_slaves_found(sdev, link, hdev->sdw))
+					break;
+			}
+			/* Found if all Slaves are checked */
+			if (i == hdev->info.count)
+				break;
+		}
+		if (mach && mach->link_mask) {
+			dev_dbg(bus->dev,
+				"SoundWire machine driver %s topology %s\n",
+				mach->drv_name,
+				mach->sof_tplg_filename);
+			pdata->machine = mach;
+			mach->mach_params.links = mach->links;
+			mach->mach_params.link_mask = mach->link_mask;
+			mach->mach_params.platform = dev_name(sdev->dev);
+			pdata->fw_filename = mach->sof_fw_filename;
+			pdata->tplg_filename = mach->sof_tplg_filename;
+		} else {
+			dev_info(sdev->dev,
+				 "No SoundWire machine driver found\n");
+		}
+	}
+
+	return 0;
+}
+#else
+static int hda_sdw_machine_select(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+#endif
+
 void hda_set_mach_params(const struct snd_soc_acpi_mach *mach,
 			 struct device *dev)
 {
@@ -972,8 +1096,18 @@ void hda_machine_select(struct snd_sof_dev *sdev)
 	if (mach) {
 		sof_pdata->tplg_filename = mach->sof_tplg_filename;
 		sof_pdata->machine = mach;
+
+		if (mach->link_mask) {
+			mach->mach_params.links = mach->links;
+			mach->mach_params.link_mask = mach->link_mask;
+		}
 	}
 
+	/*
+	 * If I2S fails, try SoundWire
+	 */
+	hda_sdw_machine_select(sdev);
+
 	/*
 	 * Choose HDA generic machine driver if mach is NULL.
 	 * Otherwise, set certain mach params.
-- 
2.20.1

