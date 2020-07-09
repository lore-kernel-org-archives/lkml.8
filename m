Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED55C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87115207FC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGIQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:23:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:37037 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgGIQXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:23:51 -0400
IronPort-SDR: PQZQ/L+BkhXHb+78tcLBBkkCsm7j+e0EJNuNQDYyUPwpYuaYG6m4gbQVQYURQDt8tDsO+LOcq3
 rnSmkMHN9RDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128100570"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128100570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:23:50 -0700
IronPort-SDR: lm3Ib2ShWTmXznpfavx4QfxHF04ccoonCrDpdHI/ipqPyzv6ZFjViciQX1J5pm9ryztz9x4JQM
 LOi5/hqreAlQ==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="280353012"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:23:50 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PXA2xx/PXA3xx
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/10] ASoC: pxa: pxa-ssp: Demote seemingly unintentional kerneldoc header
Date:   Thu,  9 Jul 2020 11:23:22 -0500
Message-Id: <20200709162328.259586-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
References: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

This is the only use of kerneldoc in the sourcefile and full
descriptions are not provided.

Fixes the following W=1 kernel build warning(s):

sound/soc/pxa/pxa-ssp.c:186: warning: Function parameter or member
'ssp' not described in 'pxa_ssp_set_scr'

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/pxa/pxa-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6a72cc1665b7..d1e09ade0190 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -178,7 +178,7 @@ static int pxa_ssp_resume(struct snd_soc_component *component)
 #define pxa_ssp_resume	NULL
 #endif
 
-/**
+/*
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-- 
2.25.1

