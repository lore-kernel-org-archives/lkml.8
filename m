Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B6AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D3120706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHYRS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:18:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:23064 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgHYRRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:17:21 -0400
IronPort-SDR: NY8afB3irUII4JZVZPmUUjDmpkyhGagd+SRQYqivQpQy+LNS62/cNHCWKZtwrjWfqrKs0UoGvh
 Td3gNjqMZmcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136221335"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136221335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:17 -0700
IronPort-SDR: PBop5Lx7VvOJchCK1BWtuHjsg7bvEWt1wT488uBs4HceJPLmVXxtd7bdfOJ4PT28OHLA1Ufmia
 Ou/g8wqVtZlQ==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="331478445"
Received: from bgarring-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.4.243])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:15 -0700
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
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/4] soundwire: SDCA: add helper macro to access controls
Date:   Tue, 25 Aug 2020 12:16:55 -0500
Message-Id: <20200825171656.75836-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming SDCA (SoundWire Device Class Audio) specification defines
a hierarchical encoding to interface with Class-defined capabilities.

The specification is not yet accessible to the general public but this
information is released with explicit permission from the MIPI Board
to avoid delays with SDCA support on Linux platforms.

A block of 64 MBytes of register addresses are allocated to SDCA
controls, starting at address 0x40000000. The 26 LSBs which identify
individual controls are set based on the following variables:

- Function Number. An SCDA device can be split in up to 8 independent
  Functions. Each of these Functions is described in the SDCA
  specification, e.g. Smart Amplifier, Smart Microphone, Simple
  Microphone, Jack codec, HID, etc.

- Entity Number.  Within each Function,  an Entity is  an identifiable
  block.  Up   to  127  Entities   are  connected  in   a  pre-defined
  graph  (similar to  USB), with  Entity0 reserved  for Function-level
  configurations.  In  contrast  to  USB, the  SDCA  spec  pre-defines
  Function Types, topologies, and allowed  options, i.e. the degree of
  freedom  is not  unlimited to  limit  the possibility  of errors  in
  descriptors leading to software quirks.

- Control Selector. Within each Entity, the SDCA specification defines
  48 controls such as Mute, Gain, AGC, etc, and 16 implementation
  defined ones. Some Control Selectors might be used for low-level
  platform setup, and other exposed to applications and users. Note
  that the same Control Selector capability, e.g. Latency control,
  might be located at different offsets in different entities, the
  Control Selector mapping is Entity-specific.

- Control Number. Some Control Selectors allow channel-specific values
  to be set, with up to 64 channels allowed. This is mostly used for
  volume control.

- Current/Next values. Some Control Selectors are
  'Dual-Ranked'. Software may either update the Current value directly
  for immediate effect. Alternatively, software may write into the
  'Next' values and update the SoundWire 1.2 'Commit Groups' register
  to copy 'Next' values into 'Current' ones in a synchronized
  manner. This is different from bank switching which is typically
  used to change the bus configuration only.

- MBQ. the Multi-Byte Quantity bit is used to provide atomic updates
  when accessing more that one byte, for example a 16-bit volume
  control would be updated consistently, the intermediate values
  mixing old MSB with new LSB are not applied.

These 6 parameters are used to build a 32-bit address to access the
desired Controls. Because of address range, paging is required, but
the most often used parameter values are placed in the lower 16 bits
of the address. This helps to keep the paging registers constant while
updating Controls for a specific Device/Function.

Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 5d3c271af7d1..906dadda7387 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -305,4 +305,17 @@
 #define SDW_CASC_PORT_MASK_INTSTAT3		1
 #define SDW_CASC_PORT_REG_OFFSET_INTSTAT3	2
 
+/* v1.2 device - SDCA address mapping */
+#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
+						 (((fun) & 0x7) << 22) |	\
+						 (((ent) & 0x40) << 15) |	\
+						 (((ent) & 0x3f) << 7) |	\
+						 (((ctl) & 0x30) << 15) |	\
+						 (((ctl) & 0x0f) << 3) |	\
+						 (((ch) & 0x38) << 12) |	\
+						 ((ch) & 0x07))
+
+#define SDW_SDCA_MBQ_CTL(reg)			((reg) | BIT(13))
+#define SDW_SDCA_NEXT_CTL(reg)			((reg) | BIT(14))
+
 #endif /* __SDW_REGISTERS_H */
-- 
2.25.1

