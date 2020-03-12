Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7FB206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCLTfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:35:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:27378 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgCLTfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:35:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 12:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243142761"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.241.169])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:35:28 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>
Subject: [PATCH 09/10] ASoC: SOF: Intel: hda: add WAKEEN interrupt support for SoundWire
Date:   Thu, 12 Mar 2020 14:33:45 -0500
Message-Id: <20200312193346.3264-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

When a SoundWire link is in clock stop state, a Slave device may wake
up the Master for some events such as jack detection. The WAKEEN
interrupt will be triggered and processed by the audio pci device.

If audio device is in D3, the interrupt will be routed to PME, or
aggregated at cAVS level as interrupt when audio device is in D0. This
patch only supports D3 case, where the audio pci device will be
resumed by a PME event and the WAKEEN interrupt will be processed
after audio pci device is powered up and ROM is initialized
successfully.

The WAKEEN handling is only enabled after the first boot due to
dependencies on a shim_lock mutex being initialized.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 18 ++++++++++++++++++
 sound/soc/sof/intel/hda.c        | 11 +++++++++++
 sound/soc/sof/intel/hda.h        |  5 +++++
 3 files changed, 34 insertions(+)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 8a37a473f8aa..4549d60d8cf8 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -349,6 +349,24 @@ int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev)
 		goto cleanup;
 	}
 
+	/*
+	 * When a SoundWire link is in clock stop state, a Slave
+	 * device may trigger in-band wakes for events such as jack
+	 * insertion or acoustic event detection. This event will lead
+	 * to a WAKEEN interrupt, handled by the PCI device and routed
+	 * to PME if the PCI device is in D3. The resume function in
+	 * audio PCI driver will be invoked by ACPI for PME event and
+	 * initialize the device and process WAKEEN interrupt.
+	 *
+	 * The WAKEEN interrupt should be processed ASAP to prevent an
+	 * interrupt flood, otherwise other interrupts, such IPC,
+	 * cannot work normally.  The WAKEEN is handled after the ROM
+	 * is initialized successfully, which ensures power rails are
+	 * enabled before accessing the SoundWire SHIM registers
+	 */
+	if (!sdev->first_boot)
+		hda_sdw_process_wakeen(sdev);
+
 	/*
 	 * at this point DSP ROM has been initialized and
 	 * should be ready for code loading and firmware boot
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 32b02d3b6536..9c7a816183b6 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -241,6 +241,17 @@ static irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
 	return sdw_intel_thread(irq, context);
 }
 
+void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+	if (!hdev->sdw)
+		return;
+
+	sdw_intel_process_wakeen_event(hdev->sdw);
+}
+
 #endif
 
 /*
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 2b72eefe1635..69717a38913c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -672,6 +672,7 @@ int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 
 int hda_sdw_startup(struct snd_sof_dev *sdev);
 void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
+void hda_sdw_process_wakeen(struct snd_sof_dev *sdev);
 
 #else
 
@@ -708,6 +709,10 @@ static inline irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
 {
 	return IRQ_HANDLED;
 }
+
+static inline void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
+{
+}
 #endif
 
 /* common dai driver */
-- 
2.20.1

