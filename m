Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C8208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGBQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:59:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:59112 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgGBQ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:59:27 -0400
IronPort-SDR: S4dbXLE/RDlm3EXK+ur36U/7m8fmPSiDgllWtmKNXKtBo6HbsOgc1NnAjUutjOpv+aSngH0gSt
 MWMl6KmGQhIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146051885"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="146051885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:26 -0700
IronPort-SDR: vGxT/CuKUh5jLpdKvlQm4zKG/12W+Hvv5itYzMUGo5sqS2C+x6tg9gr9gWEKdq5CBJqV8TjrJu
 yNKQDXS38xbA==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="426014917"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:25 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] ASoC: uniphier: aio-core: fix kernel-doc
Date:   Thu,  2 Jul 2020 11:59:01 -0500
Message-Id: <20200702165901.164100-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning - wrong parameter description and bad format

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/uniphier/aio-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 9bcba06ba52e..b8195778953e 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -93,9 +93,9 @@ void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
 
 /**
  * aio_chip_set_pll - set frequency to audio PLL
- * @chip  : the AIO chip pointer
- * @source: PLL
- * @freq  : frequency in Hz, 0 is ignored
+ * @chip: the AIO chip pointer
+ * @pll_id: PLL
+ * @freq: frequency in Hz, 0 is ignored
  *
  * Sets frequency of audio PLL. This function can be called anytime,
  * but it takes time till PLL is locked.
@@ -267,7 +267,6 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 /**
  * aio_port_set_ch - set channels of LPCM
  * @sub: the AIO substream pointer, PCM substream only
- * @ch : count of channels
  *
  * Set suitable slot selecting to input/output port block of AIO.
  *
-- 
2.25.1

