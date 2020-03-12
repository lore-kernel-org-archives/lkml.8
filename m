Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41D3C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59C9206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCLTeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:34:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:23805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgCLTeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:34:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 12:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243142313"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.241.169])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:33:58 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/10] ASoC: SOF: Intel: add SoundWire support
Date:   Thu, 12 Mar 2020 14:33:36 -0500
Message-Id: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides the support for SoundWire support on Intel
CometLake, IcelLake and TigerLake RVP platforms and form-factor
devices to be released 'soon'.

The bulk of the code is about detecting a valid SoundWire
configuration from ACPI, and implementing the interfaces suggested in
'[PATCH 0/8] soundwire: remove platform devices, add SOF interfaces'
for interrupts, PCI wakes and clock-stop configurations.

Since that SoundWire series is stuck with no resolution, the build
support for SOF w/ SoundWire is not provided for now, and fall-back
functions will be used. This code is tested on a daily basis in the
SOF tree and is not expected to change. If audio maintainers will only
accept functional code, which isn't unreasonable, I would kindly ask
that they reach out to Vinod Koul.

Bard Liao (1):
  ASoC: SOF: Intel: hda: merge IPC, stream and SoundWire interrupt
    handlers

Pierre-Louis Bossart (7):
  ASoC: soc-acpi: expand description of _ADR-based devices
  ASoC: SOF: Intel: add SoundWire configuration interface
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
  ASoC: SOF: Intel: hda: disable SoundWire interrupts on suspend
  ASoC: SOF: Intel: hda: add parameter to control SoundWire clock stop
    quirks

Rander Wang (2):
  ASoC: SOF: Intel: hda: add WAKEEN interrupt support for SoundWire
  Asoc: SOF: Intel: hda: check SoundWire wakeen interrupt in irq thread

 include/sound/soc-acpi.h                      |  39 +-
 include/sound/sof/dai-intel.h                 |  18 +-
 .../intel/common/soc-acpi-intel-cml-match.c   |  87 +++-
 .../intel/common/soc-acpi-intel-icl-match.c   |  97 ++++-
 .../intel/common/soc-acpi-intel-tgl-match.c   |  49 ++-
 sound/soc/sof/intel/hda-dsp.c                 |   2 +
 sound/soc/sof/intel/hda-loader.c              |  31 ++
 sound/soc/sof/intel/hda.c                     | 399 ++++++++++++++++++
 sound/soc/sof/intel/hda.h                     |  66 +++
 9 files changed, 728 insertions(+), 60 deletions(-)


base-commit: 101247a3b86e1cc0e382b7e887a56176290fc957
-- 
2.20.1

