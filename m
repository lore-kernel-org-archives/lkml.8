Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF23AC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31C4206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgDHS41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:56:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:56:27 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MwxRN-1j6lFQ1JAh-00ySED; Wed, 08 Apr 2020 20:55:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shuming Fan <shumingf@realtek.com>,
        Derek Fang <derek.fang@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5682: fix building without I2C
Date:   Wed,  8 Apr 2020 20:55:18 +0200
Message-Id: <20200408185527.308213-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4AoJDCXVBq/rxRcJ104peoQYrzLDNcb3p1vOQ7Y937Nq+mHuurc
 mPlJhXivK+4f42v46kcfEnrMJRG5r7Kg1E11iAC1mT8ndXQcRJ/JgROVMhddj6HJ0f5p945
 QZ0AA8Lwne9UnABWVM4cRmiqzcMXmdiTLU/0vD+vcv3ZS6WapO13Bk7ccWW3jrGmOBCn0wy
 mL1AMEBlueU/zYwcFhylQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:29YYqW2EZs8=:TYqEai8QnFj5T50xeEt3TC
 0eDWr8s6Y96tKufknGNLHrTGNVcUoADmJ42LvoZXlHCcHqE14lsxa8rZDJLNOAegH6UHETfqX
 2MccJQ9/v2QV14PSEDFB7pXlxyqMDHT+C4dIQNqPYg6Jt4Jt/KGYnIUjJa+iiwXgM03rRc7BN
 4WwJZgOFVZKfOvfpSEuMivmdbo/z4nuvqXPdi2zidkGnu601FNvB6gqWY+6S+EoF9SROZUdDp
 G99v7sJ9pPlXa91hVpyGA98KBHi4HcjBmL7gfz1zq9PiCi6hbB05ZsdcWQolvAkwhGkV+jsGw
 M3tKV26GK6+5pOCrHAoV9A0ymf+qP9QHFF6I5t75syoPG3hT4O7vQDKdwKzIAHXofi3dPV7cr
 ti1quVNknN6FhoC4o1RuaDJzKzcyK8r79n89cq2JoIRzXmmNVqsF1tkQ0DGsl/4y/VYkY3doU
 S1kqkOYLfM7q8735C4c+rIRPf/q3qZ5bCXMudUxaGa5qmDpVId1DNnnh4vuedmushCnt9AjMD
 OTl7HTcmRJwh72dVSxUZISZ7Yd94IMIvWegrPrIiv7ARxJ3geEza3tWzVhxl+XKDmTQx8twF9
 Rl4fDpb68SxVf744Zyo6Oz2Cq6D38NeTvLi+Th1bhby1ZfCUjjlJQ81o5Yyo+ydMO2UGlvSCy
 8jC4WBg62+9/VNHkjHxmGwOfE6IHzv/1u6yrVydOA9j4c5HoeELs5mtHEgAljbGad35dR4I/c
 qXXrPHp0vPJ46gmUmkovehQ7UTvQRjB09oad4/icz5+HvY0OZceoHGJE/J4RKz59yQx2IHBUW
 ReNJEMSjW0l+VQrj3Vs5mvTeh+sQFbcA/jmb2Q0Pp82RdEnetc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I2C is disabled, building rt5682 produces a compile-time error:

sound/soc/codecs/rt5682.c:3716:1: warning: data definition has no type or storage class
 3716 | module_i2c_driver(rt5682_i2c_driver);
      | ^~~~~~~~~~~~~~~~~
sound/soc/codecs/rt5682.c:3716:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/rt5682.c:3716:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/rt5682.c:3706:26: error: 'rt5682_i2c_driver' defined but not used [-Werror=unused-variable]
 3706 | static struct i2c_driver rt5682_i2c_driver = {
      |                          ^~~~~~~~~~~~~~~~~

Move the i2c specific entry points into an #ifdef section so
it can actually be built standalone.

Fixes: 5549ea647997 ("ASoC: rt5682: fix unmet dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/rt5682.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index c9268a230daa..a6548f870807 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -3224,12 +3224,6 @@ static const struct regmap_config rt5682_regmap = {
 	.use_single_write = true,
 };
 
-static const struct i2c_device_id rt5682_i2c_id[] = {
-	{"rt5682", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, rt5682_i2c_id);
-
 static int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
 {
 
@@ -3526,7 +3520,7 @@ int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 EXPORT_SYMBOL_GPL(rt5682_io_init);
 #endif
 
-static int rt5682_i2c_probe(struct i2c_client *i2c,
+static int __maybe_unused rt5682_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
 	struct rt5682_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -3680,13 +3674,14 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 					rt5682_dai, ARRAY_SIZE(rt5682_dai));
 }
 
-static void rt5682_i2c_shutdown(struct i2c_client *client)
+static void __maybe_unused rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
 
 	rt5682_reset(rt5682);
 }
 
+#ifdef CONFIG_I2C
 #ifdef CONFIG_OF
 static const struct of_device_id rt5682_of_match[] = {
 	{.compatible = "realtek,rt5682i"},
@@ -3703,6 +3698,12 @@ static const struct acpi_device_id rt5682_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5682_acpi_match);
 #endif
 
+static const struct i2c_device_id rt5682_i2c_id[] = {
+	{"rt5682", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, rt5682_i2c_id);
+
 static struct i2c_driver rt5682_i2c_driver = {
 	.driver = {
 		.name = "rt5682",
@@ -3714,6 +3715,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 	.id_table = rt5682_i2c_id,
 };
 module_i2c_driver(rt5682_i2c_driver);
+#endif
 
 MODULE_DESCRIPTION("ASoC RT5682 driver");
 MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
-- 
2.26.0

