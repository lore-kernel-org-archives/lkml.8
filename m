Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E9C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91FE20728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD0RTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:19:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:57350 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgD0RTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:19:38 -0400
IronPort-SDR: ychK89L7NwivRBY9XM0PYnKMdKxu0g286zvGNPARdDUbOnLHs/60nIeoiHxUrDNG23ehFoqST6
 kh/vEiUCi70Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:19:37 -0700
IronPort-SDR: jD3RywuxRGpJyIx//YURsX+NblkmEcMB1+ljm2BF1Z5scQR8yCB5T79BYSoFVDEuNJz98JclyA
 gXsgZd/Zaj9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="458932248"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:19:34 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] add channel constraint for BDW machine drivers
Date:   Tue, 28 Apr 2020 01:13:31 +0800
Message-Id: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
recording while other two drivers support only 2-channel recording. HW
constraints are implemented to reflect the hardware limitation on BDW
platform.

Changes since v1:
- Change the patch title.
- Remove the DUAL_CHANNEL and QUAD_CHANNEL macros which are too obvious.
- Follow the naming convertion, using 'bdw_rt5650_' and 'bdw_rt5677_' to
  name startup functions.
- Refine the comments in startup functions.
- Redesign the bdw_rt5650_fe_startup() function for readability.
- Add an assignment to initialize runtime->hw.channels_max variable.

Brent Lu (3):
  ASoC: bdw-rt5677: add channel constraint
  ASoC: bdw-rt5650: add channel constraint
  ASoC: broadwell: add channel constraint

 sound/soc/intel/boards/bdw-rt5650.c | 29 +++++++++++++++++++++++++++++
 sound/soc/intel/boards/bdw-rt5677.c | 26 ++++++++++++++++++++++++++
 sound/soc/intel/boards/broadwell.c  | 26 ++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

-- 
2.7.4

