Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18E1C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD902072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTGqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:46:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:48034 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTGqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:46:12 -0400
IronPort-SDR: wjb+qwEr53pCWR2HQ5p8TUx3Zsum2gz2QcjAsspyUluq3yhprSYMBJqTJPkGAve897+I9o4J3F
 1HBHf0DCQatg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 23:46:10 -0700
IronPort-SDR: CEQtgG2TlUFykrrmk1GKgfeLqWwsttNnsS0NGryxHW7Vz/K5W/HCCcTcYK1gppwZ8oYXG+803K
 2vLggYJXz9Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="254845023"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2020 23:46:06 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/4] Documentation: SoundWire: clarify TDM mode support
Date:   Mon, 20 Apr 2020 02:51:14 +0800
Message-Id: <20200419185117.4233-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The current description of stream topologies does not explicitly
mention 'mirror' topologies used for audio amplifiers, where all
amplifiers see the same data and generate a different output based on
configuration or dynamic information. Add examples and notes to
explain how channels can be transmitted and mapped.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 Documentation/driver-api/soundwire/stream.rst | 89 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 8bceece51554..1b386076402c 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -75,8 +75,33 @@ Slaves are using single port. ::
 	                                                   |     (Data)    |
 	                                                   +---------------+
 
+Example 4: Stereo Stream with L and R channels is rendered by
+Master. Both of the L and R channels are received by two different
+Slaves. Master and both Slaves are using single port handling
+L+R. Each Slave device processes the L + R data locally, typically
+based on static configuration or dynamic orientation, and may drive
+one or more speakers. ::
 
-Example 4: Stereo Stream with L and R channel is rendered by two different
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +---------+------------------------+     Slave     |
+	|   Interface   |         |                        |   Interface   |
+	|               |         |                        |       1       |
+	|               |         |           Data Signal  |               |
+	|    L  +  R    +---+------------------------------+     L + R     |
+	|     (Data)    |   |     |    Data Direction      |     (Data)    |
+	+---------------+   |     |   +------------->      +---------------+
+	                    |     |
+	                    |     |
+	                    |     |                        +---------------+
+	                    |     +----------------------> |     Slave     |
+	                    |                              |   Interface   |
+	                    |                              |       2       |
+	                    |                              |               |
+	                    +----------------------------> |     L + R     |
+	                                                   |     (Data)    |
+	                                                   +---------------+
+
+Example 5: Stereo Stream with L and R channel is rendered by two different
 Ports of the Master and is received by only single Port of the Slave
 interface. ::
 
@@ -101,7 +126,7 @@ interface. ::
 	+--------------------+                             |                |
 							   +----------------+
 
-Example 5: Stereo Stream with L and R channel is rendered by 2 Masters, each
+Example 6: Stereo Stream with L and R channel is rendered by 2 Masters, each
 rendering one channel, and is received by two different Slaves, each
 receiving one channel. Both Masters and both Slaves are using single port. ::
 
@@ -123,12 +148,70 @@ receiving one channel. Both Masters and both Slaves are using single port. ::
 	|     (Data)    |     Data Direction               |     (Data)    |
 	+---------------+  +----------------------->       +---------------+
 
-Note: In multi-link cases like above, to lock, one would acquire a global
+Example 7: Stereo Stream with L and R channel is rendered by 2
+Masters, each rendering both channels. Each Slave receives L + R. This
+is the same application as Example 4 but with Slaves placed on
+separate links. ::
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|       1       |                                  |       1       |
+	|               |                     Data Signal  |               |
+	|     L + R     +----------------------------------+     L + R     |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|       2       |                                  |       2       |
+	|               |                     Data Signal  |               |
+	|     L + R     +----------------------------------+     L + R     |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+Example 8: 4-channel Stream is rendered by 2 Masters, each rendering a
+2 channels. Each Slave receives 2 channels. ::
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|       1       |                                  |       1       |
+	|               |                     Data Signal  |               |
+	|    L1 + R1    +----------------------------------+    L1 + R1    |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+	+---------------+                    Clock Signal  +---------------+
+	|    Master     +----------------------------------+     Slave     |
+	|   Interface   |                                  |   Interface   |
+	|       2       |                                  |       2       |
+	|               |                     Data Signal  |               |
+	|     L2 + R2   +----------------------------------+    L2 + R2    |
+	|     (Data)    |     Data Direction               |     (Data)    |
+	+---------------+  +----------------------->       +---------------+
+
+Note1: In multi-link cases like above, to lock, one would acquire a global
 lock and then go on locking bus instances. But, in this case the caller
 framework(ASoC DPCM) guarantees that stream operations on a card are
 always serialized. So, there is no race condition and hence no need for
 global lock.
 
+Note2: A Slave device may be configured to receive all channels
+transmitted on a link for a given Stream (Example 4) or just a subset
+of the data (Example 3). The configuration of the Slave device is not
+handled by a SoundWire subsystem API, but instead by the
+snd_soc_dai_set_tdm_slot() API. The platform or machine driver will
+typically configure which of the slots are used. For Example 4, the
+same slots would be used by all Devices, while for Example 3 the Slave
+Device1 would use e.g. Slot 0 and Slave device2 slot 1.
+
+Note3: Multiple Sink ports can extract the same information for the
+same bitSlots in the SoundWire frame, however multiple Source ports
+shall be configured with different bitSlot configurations. This is the
+same limitation as with I2S/PCM TDM usages.
+
 SoundWire Stream Management flow
 ================================
 
-- 
2.17.1

