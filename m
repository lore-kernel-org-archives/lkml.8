Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA6C2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgGGTQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:16:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:5637 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGGTQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:16:35 -0400
IronPort-SDR: fMST3UIfL8aM21BsZna8FjeVVpsSaPPyb8z2nAbVssfehjcqhCHiSWaxpMN7TiPus6kd1I0XbW
 POutIIKdiWEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="165752974"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="165752974"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:16:34 -0700
IronPort-SDR: Mrh8mRHyFds+T1m32396SgIrB0QyGje5PilUBFte6R4jkDcYUEOJq5tmWWj2oQfBw036N6Ru6f
 SM09mqr0DF+Q==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="388601621"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:16:33 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 03/10] ASoC: sunxi: sun4i-spdif: fix kernel-doc
Date:   Tue,  7 Jul 2020 14:16:08 -0500
Message-Id: <20200707191615.98296-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning - typo in field description

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 86779a99df75..326dd45e39da 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -167,7 +167,7 @@
 /**
  * struct sun4i_spdif_quirks - Differences between SoC variants.
  *
- * @reg_dac_tx_data: TX FIFO offset for DMA config.
+ * @reg_dac_txdata: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
  * @val_fctl_ftx: TX FIFO flush bitmask.
  */
-- 
2.25.1

