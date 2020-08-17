Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3030206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHQWsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:48:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:47:25 -0400
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k7nuK-0000uc-3W; Mon, 17 Aug 2020 22:47:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: remove duplicate "the the" phrase in Kconfig text
Date:   Mon, 17 Aug 2020 23:47:06 +0100
Message-Id: <20200817224706.6139-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of occurrences of "the the" in the Kconfig
text. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/xilinx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 1d3586b68db7..5bd2730aab76 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -9,14 +9,14 @@ config SND_SOC_XILINX_I2S
 	  encapsulates PCM in AES format and sends AES data.
 
 config SND_SOC_XILINX_AUDIO_FORMATTER
-	tristate "Audio support for the the Xilinx audio formatter"
+	tristate "Audio support for the Xilinx audio formatter"
 	help
 	  Select this option to enable Xilinx audio formatter
 	  support. This provides DMA platform device support for
 	  audio functionality.
 
 config SND_SOC_XILINX_SPDIF
-	tristate "Audio support for the the Xilinx SPDIF"
+	tristate "Audio support for the Xilinx SPDIF"
 	help
 	  Select this option to enable Xilinx SPDIF Audio.
 	  This provides playback and capture of SPDIF audio in
-- 
2.27.0

