Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996AFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DD9206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgGGTQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:16:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:5637 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbgGGTQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:16:30 -0400
IronPort-SDR: C+MFUbgcJZ0Bg70bY68E38uFspsLF45HXINE7Ozy/lhsLdHkrzNvoqKWb7wklu+zaJF1YB9ZI+
 8BGz08KUn0Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="165752966"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="165752966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:16:29 -0700
IronPort-SDR: KHOmIPY9+z07ZZY077Ns86We1sv3ZlbZ4IbOE3DTwZnvoEMHE3bvPTa/VEF2KMPPtC6V6HQrxV
 xCwkh/ddznsg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="388601595"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:16:28 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Weitao Hou <houweitaoo@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/10] ASoC: qcom: q6asm: fix kernel-doc
Date:   Tue,  7 Jul 2020 14:16:06 -0500
Message-Id: <20200707191615.98296-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning - missing parameter description

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index ae4b2cabdf2d..d67b23a5f397 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -912,9 +912,9 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
 
 /**
  * q6asm_open_write() - Open audio client for writing
- *
  * @ac: audio client pointer
  * @format: audio sample format
+ * @codec_profile: compressed format profile
  * @bits_per_sample: bits per sample
  *
  * Return: Will be an negative value on error or zero on success
-- 
2.25.1

