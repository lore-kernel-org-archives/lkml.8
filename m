Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A78C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B877207FB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgGIQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:23:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:37037 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgGIQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:23:47 -0400
IronPort-SDR: b7SPABVaVI1x4z5hfvL66N3iw0W9USKnmo1rdaU7KYXtWqL/2PfzBf9zVZwrYbhB2h16p3IHDq
 Uv/aSPB3f2WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128100543"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128100543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:23:46 -0700
IronPort-SDR: 7M/IjOs4vMcHmD2Fn3KPLM6GFnojEObAH9GKgFvIPoLMhdGwtqFlUCx7IYLE4NXPqTewOoviBw
 72LyqxJptXTw==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="280352985"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 09:23:46 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrea Venturi <be17068@iperbole.bo.it>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 03/10] ASoC: sunxi: sun4i-i2s: add missing clock and format arguments in kernel-doc
Date:   Thu,  9 Jul 2020 11:23:20 -0500
Message-Id: <20200709162328.259586-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
References: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings - missing fields in description

sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or
 member 'bclk_dividers' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'num_bclk_dividers' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'mclk_dividers' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'num_mclk_dividers' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'get_bclk_parent_rate' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'get_sr' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'get_wss' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'set_chan_cfg' not described in 'sun4i_i2s_quirks'
sound/soc/sunxi/sun4i-i2s.c:160: warning: Function parameter or member
'set_fmt' not described in 'sun4i_i2s_quirks'

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrea Venturi <be17068@iperbole.bo.it>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a..f23ff29e7c1d 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -128,13 +128,21 @@ struct sun4i_i2s;
 
 /**
  * struct sun4i_i2s_quirks - Differences between SoC variants.
- *
  * @has_reset: SoC needs reset deasserted.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
+ * @bclk_dividers: bit clock dividers array
+ * @num_bclk_dividers: number of bit clock dividers
+ * @mclk_dividers: mclk dividers array
+ * @num_mclk_dividers: number of mclk dividers
+ * @get_bclk_parent_rate: callback to get bclk parent rate
+ * @get_sr: callback to get sample resolution
+ * @get_wss: callback to get word select size
+ * @set_chan_cfg: callback to set channel configuration
+ * @set_fmt: callback to set format
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
-- 
2.25.1

