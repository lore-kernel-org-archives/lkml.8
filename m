Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583F921548
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGBRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:22:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:2603 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgGBRWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:22:46 -0400
IronPort-SDR: 2XrI54glD95MTawmiVctFwo8s1bngd626dfVPuO3V66MtWQ7tuNGIyJq/LYwnjJVLPAAEd55/M
 LdJv7lgPqrzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="135255654"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="135255654"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:22:45 -0700
IronPort-SDR: UUNR5coPI111eAku83iHfdW4mTPO7RwdIt6eEIAR4P3mWO5KNZlCLKlFpUtyVpbM/TV3ZYFSkv
 aICZh4f9wwHQ==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="356521239"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:22:44 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/6] ASoC: fsl: fsl_ssi_dbg: remove spurious kernel-doc comment start
Date:   Thu,  2 Jul 2020 12:22:22 -0500
Message-Id: <20200702172227.164474-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings. There is no kernel-doc here.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_ssi_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 2a20ee23dc52..2c46c55f0a88 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -78,7 +78,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 		dbg->stats.tfe0++;
 }
 
-/**
+/*
  * Show the statistics of a flag only if its interrupt is enabled
  *
  * Compilers will optimize it to a no-op if the interrupt is disabled
@@ -90,7 +90,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 	} while (0)
 
 
-/**
+/*
  * Display the statistics for the current SSI device
  *
  * To avoid confusion, only show those counts that are enabled
-- 
2.25.1

