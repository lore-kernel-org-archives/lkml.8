Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBC5C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91802054F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371170AbgDOO4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:56:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:42016 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371087AbgDOOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:55:47 -0400
IronPort-SDR: VjJYu0/6LCKtfaTMf6L9vBN8RQsxVx4wQ+Cs+t4J59+8BcUzZkAYI11AwnzkG/lP9J3Z/RTqXJ
 siId0qJD2QfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:55:47 -0700
IronPort-SDR: +KYJznJZrPzuyOD3Y42B+qzVt0oL0BhBCIGbGaF9acPAG1/G8vWQV6uHF6RjJTK9LzWrruuNdO
 C6H0y9RvFOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="453951224"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 07:55:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 684B2DD7; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 8/9] ASoC: rt5645: Switch DMI table match to a test of variable
Date:   Wed, 15 Apr 2020 17:55:23 +0300
Message-Id: <20200415145524.31745-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a common x86 quirk that provides an exported variable,
use it instead of local DMI table match.

Note, arch/x86/kernel/quirks.c::early_platform_detect_quirk() prints
the detected platform.

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 6ba1849a77b0..06bd3560b736 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/platform_data/x86/machine.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
@@ -3674,13 +3675,6 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&intel_braswell_platform_data,
 	},
-	{
-		.ident = "Microsoft Surface 3",
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-		.driver_data = (void *)&intel_braswell_platform_data,
-	},
 	{
 		/*
 		 * Match for the GPDwin which unfortunately uses somewhat
@@ -3797,7 +3791,7 @@ static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
 static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
-	struct rt5645_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	const struct rt5645_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	const struct dmi_system_id *dmi_data;
 	struct rt5645_priv *rt5645;
 	int ret, i;
@@ -3812,6 +3806,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
+	/* Put it first to allow DMI to override, if needed */
+	if (x86_microsoft_surface_3_machine)
+		pdata = &intel_braswell_platform_data;
+
 	dmi_data = dmi_first_match(dmi_platform_data);
 	if (dmi_data) {
 		dev_info(&i2c->dev, "Detected %s platform\n", dmi_data->ident);
-- 
2.25.1

