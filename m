Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5EFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A7207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFLGGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:06:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:37896 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgFLGGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:06:35 -0400
IronPort-SDR: VqHlzLLVtE8ri6LCL85wIA66Yl9Ea5G1YVi7Mzu/L6YzWLnMEAy7yKVvZtP0SAg9PO0egn3PCS
 OmtoTJQ3Q/gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 23:06:35 -0700
IronPort-SDR: t2oR15pPScZH7yIFwN9eLEB+YnIWO4LXheA7PMMH6XUiA6mgEok6PLUVsgBPntobo7EceaVyzQ
 2mPBceX+rm7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="289783286"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2020 23:06:30 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: SOF: Intel: hda: unsolicited RIRB response
Date:   Fri, 12 Jun 2020 14:01:09 +0800
Message-Id: <1591941669-28683-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
WP") from legacy HDA driver to fix the get response timeout issue.
Current SOF driver does not suffer from this issue because sync write
is enabled in hda_init. The issue will come back if the sync write is
disabled for some reason.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 7f65dcc..1bda14c 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -653,11 +653,16 @@ irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
 		if (status & AZX_INT_CTRL_EN) {
 			rirb_status = snd_hdac_chip_readb(bus, RIRBSTS);
 			if (rirb_status & RIRB_INT_MASK) {
+				/*
+				 * Clearing the interrupt status here ensures
+				 * that no interrupt gets masked after the RIRB
+				 * wp is read in snd_hdac_bus_update_rirb.
+				 */
+				snd_hdac_chip_writeb(bus, RIRBSTS,
+						     RIRB_INT_MASK);
 				active = true;
 				if (rirb_status & RIRB_INT_RESPONSE)
 					snd_hdac_bus_update_rirb(bus);
-				snd_hdac_chip_writeb(bus, RIRBSTS,
-						     RIRB_INT_MASK);
 			}
 		}
 #endif
-- 
2.7.4

