Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C18AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F222087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbgGaMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:30:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:51623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733165AbgGaMah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:30:37 -0400
IronPort-SDR: zMWc68lAhgkivuW1x/1CycdK9MwoMUC8GdsGjUE3FufrDKA7sV86lZOlFjO3pAgoEUeugBRp55
 v+k9w2d0P+0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139748502"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="139748502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:30:37 -0700
IronPort-SDR: sX08mrnWSa8zWJRRR0sQWabTwfdl6QPDe7BNgwczv9dgtKx8nIawNWaHg0kD/HBT4Vaauwirv1
 p2sElXqEMG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="365483154"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2020 05:30:33 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: [PATCH v3 0/2] Add period size constraint for Atom Chromebook
Date:   Fri, 31 Jul 2020 20:26:03 +0800
Message-Id: <1596198365-10105-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two different constraints are implemented: one is in platform's CPU
DAI to enforce the period to be multiple of 1ms to align with firmware
design. The other is in Atom Chromebook's machine driver to use 240 as
period size which is selected by google.


Changes since v1:
-Add comma at the end of media_period_size array declaration.

Changes since v2:
-Use snd_pcm_hw_constraint_step to enforce the 1ms period.


Brent Lu (1):
  ASoC: intel: atom: Add period size constraint

Yu-Hsuan Hsu (1):
  ASoC: Intel: Add period size constraint on strago board

 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 11 +++++++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.7.4

