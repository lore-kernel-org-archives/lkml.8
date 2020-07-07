Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EDE2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGGTX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:23:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:41456 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgGGTX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:23:27 -0400
IronPort-SDR: rb6LxXfNW/2ZwGSE3Z+flXMeOPoJHBCtliaGMtNAAs/QaqYr98ZeD5TgWQPzZGj3svU04L3PBK
 JwDaJdGHVm8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127277726"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="127277726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:23:27 -0700
IronPort-SDR: nZd1XNfBgSexdEI+Op9MoJXOk1LmIOxOGcG1+OVzQaZ0IqMS97VDSWk6TLGuC8zKrF4+G5dR8+
 mVMUiSDNd3cg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="266915972"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:23:25 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Piotr Maziarz <piotrx.maziarz@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ASoC: Intel: Skylake: remove comparison always false warning
Date:   Tue,  7 Jul 2020 14:23:08 -0500
Message-Id: <20200707192310.98663-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707192310.98663-1-pierre-louis.bossart@linux.intel.com>
References: <20200707192310.98663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings:

skl-sst-dsp.c: In function ‘skl_dsp_get_enabled_cores’:
include/linux/bits.h:26:28: warning: comparison of unsigned expression
< 0 is always false [-Wtype-limits]

cast the core number to a long to avoid checking if an unsigned value
is lower than zero.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 225706d148d8..cb83b395f210 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -52,7 +52,7 @@ unsigned int skl_dsp_get_enabled_cores(struct sst_dsp *ctx)
 	unsigned int core_mask, en_cores_mask;
 	u32 val;
 
-	core_mask = SKL_DSP_CORES_MASK(skl->cores.count);
+	core_mask = SKL_DSP_CORES_MASK((long)skl->cores.count);
 
 	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS);
 
-- 
2.25.1

