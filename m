Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61974C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B2206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgCLTfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:35:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:5127 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgCLTfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:35:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 12:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243142681"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.241.169])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:35:06 -0700
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
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>
Subject: [PATCH 07/10] ASoC: SOF: Intel: hda: merge IPC, stream and SoundWire interrupt handlers
Date:   Thu, 12 Mar 2020 14:33:43 -0500
Message-Id: <20200312193346.3264-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We have a single irq handler for SOF interrupts. We can further merge
SoundWire ones to completely remove MSI interrupts handling issues
leading to timeouts.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 36 ++++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h | 11 +++++++++++
 2 files changed, 47 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 1892f612c11d..f7e5371789f2 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -198,6 +198,38 @@ static int hda_sdw_exit(struct snd_sof_dev *sdev)
 
 	return 0;
 }
+
+static bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	bool ret = false;
+	u32 irq_status;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	if (!hdev->sdw)
+		return ret;
+
+	/* store status */
+	irq_status = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPIS2);
+
+	/* invalid message ? */
+	if (irq_status == 0xffffffff)
+		goto out;
+
+	/* SDW message ? */
+	if (irq_status & HDA_DSP_REG_ADSPIS2_SNDW)
+		ret = true;
+
+out:
+	return ret;
+}
+
+static irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
+{
+	return sdw_intel_thread(irq, context);
+}
+
 #endif
 
 /*
@@ -619,6 +651,7 @@ static irqreturn_t hda_dsp_interrupt_handler(int irq, void *context)
 static irqreturn_t hda_dsp_interrupt_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
+	struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
 
 	/* deal with streams and controller first */
 	if (hda_dsp_check_stream_irq(sdev))
@@ -627,6 +660,9 @@ static irqreturn_t hda_dsp_interrupt_thread(int irq, void *context)
 	if (hda_dsp_check_ipc_irq(sdev))
 		sof_ops(sdev)->irq_thread(irq, sdev);
 
+	if (hda_dsp_check_sdw_irq(sdev))
+		hda_dsp_sdw_thread(irq, hdev->sdw);
+
 	/* enable GIE interrupt */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 				SOF_HDA_INTCTL,
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 3cf2fb5985b9..2b72eefe1635 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -233,6 +233,8 @@
 #define HDA_DSP_REG_ADSPIC2		(HDA_DSP_GEN_BASE + 0x10)
 #define HDA_DSP_REG_ADSPIS2		(HDA_DSP_GEN_BASE + 0x14)
 
+#define HDA_DSP_REG_ADSPIS2_SNDW	BIT(5)
+
 /* Intel HD Audio Inter-Processor Communication Registers */
 #define HDA_DSP_IPC_BASE		0x40
 #define HDA_DSP_REG_HIPCT		(HDA_DSP_IPC_BASE + 0x00)
@@ -697,6 +699,15 @@ static inline void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 {
 }
 
+static inline bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
+{
+	return false;
+}
+
+static inline irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
+{
+	return IRQ_HANDLED;
+}
 #endif
 
 /* common dai driver */
-- 
2.20.1

