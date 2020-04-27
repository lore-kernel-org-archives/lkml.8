Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79432C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA6B2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgD0Ina (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:43:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:49908 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgD0In3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:43:29 -0400
IronPort-SDR: gZMDhj3txVAvBelQflZGM/EKR/qVI0OBXeMWu1SA1+bQZN6B/9jt/06aWtCBf7icwjnF6QzB1I
 QL1OByV/JKkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 01:43:28 -0700
IronPort-SDR: VemkF1BSfDr8+m1vWMNfQ9oiEJlrq/vAWoJMxvZNd9BMuLKnpgsOHprvrTtmARAJkjF4V+W02A
 +lmcugod51rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="431673859"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2020 01:43:18 -0700
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
Subject: [PATCH 0/3] add channel constraint for BDW machine drivers
Date:   Mon, 27 Apr 2020 16:37:15 +0800
Message-Id: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
recording while other two drivers support only 2-channel recording. HW
constraints are implemented to reflect the hardware limitation on BDW
platform.

Brent Lu (3):
  ASoC: bdw-rt5677: channel constraint support
  ASoC: bdw-rt5650: channel constraint support
  ASoC: broadwell: channel constraint support

 sound/soc/intel/boards/bdw-rt5650.c | 34 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
 sound/soc/intel/boards/broadwell.c  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

-- 
2.7.4

