Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CECF20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFCDub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:50:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35086 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgFCDuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F3CCF1A0054;
        Wed,  3 Jun 2020 05:50:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7304E1A0F20;
        Wed,  3 Jun 2020 05:50:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9461840323;
        Wed,  3 Jun 2020 11:50:06 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: fsl_easrc: Fix "Function parameter not described" warnings
Date:   Wed,  3 Jun 2020 11:39:41 +0800
Message-Id: <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obtained with:
$ make W=1

sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'easrc' not described in 'fsl_easrc_normalize_filter'
sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'infilter' not described in 'fsl_easrc_normalize_filter'
sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'outfilter' not described in 'fsl_easrc_normalize_filter'
sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'shift' not described in 'fsl_easrc_normalize_filter'

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 7d8bf9d47842..2f6b3d8bfcfc 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -389,11 +389,11 @@ static int fsl_easrc_resampler_config(struct fsl_asrc *easrc)
  *  For input int[16, 24, 32] -> output float32
  *      scale it by multiplying filter coefficients by 2^-15, 2^-23, 2^-31
  *  input:
- *      asrc:  Structure pointer of fsl_asrc
- *      infilter : Pointer to non-scaled input filter
- *      shift:  The multiply factor
+ *      @easrc:  Structure pointer of fsl_asrc
+ *      @infilter : Pointer to non-scaled input filter
+ *      @shift:  The multiply factor
  *  output:
- *      outfilter: scaled filter
+ *      @outfilter: scaled filter
  */
 static int fsl_easrc_normalize_filter(struct fsl_asrc *easrc,
 				      u64 *infilter,
-- 
2.21.0

