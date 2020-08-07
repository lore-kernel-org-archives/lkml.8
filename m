Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EF520866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHGPk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:40:58 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:56924 "EHLO
        8.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:40:58 -0400
X-Greylist: delayed 33439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 11:40:56 EDT
Received: from player737.ha.ovh.net (unknown [10.108.42.228])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6F16213AFF7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 17:31:17 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id 95BE7BA0F3BD;
        Fri,  7 Aug 2020 15:31:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001be37b43d-2adb-404c-9edc-3b4ec5cae877,
                    B1FDDFD4E508142116FDFB9194C63E8FBE397CFD) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] arch/arm: use simple i2c probe function
Date:   Fri,  7 Aug 2020 17:31:00 +0200
Message-Id: <20200807153100.384845-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8342073888835653110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

This avoids scanning the identifier tables during probes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 arch/arm/mach-davinci/board-dm644x-evm.c     |  5 ++---
 arch/arm/mach-davinci/board-dm646x-evm.c     | 10 ++++------
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  5 ++---
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index a5d3708fedf6..d0dcf69cc76d 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -548,8 +548,7 @@ static const struct property_entry eeprom_properties[] = {
  */
 static struct i2c_client *dm6446evm_msp;
 
-static int dm6446evm_msp_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+static int dm6446evm_msp_probe(struct i2c_client *client)
 {
 	dm6446evm_msp = client;
 	return 0;
@@ -569,7 +568,7 @@ static const struct i2c_device_id dm6446evm_msp_ids[] = {
 static struct i2c_driver dm6446evm_msp_driver = {
 	.driver.name	= "dm6446evm_msp",
 	.id_table	= dm6446evm_msp_ids,
-	.probe		= dm6446evm_msp_probe,
+	.probe_new	= dm6446evm_msp_probe,
 	.remove		= dm6446evm_msp_remove,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 4600b617f9b4..2dce16fff77e 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -160,8 +160,7 @@ static struct platform_device davinci_aemif_device = {
 #define DM646X_EVM_ATA_PWD		BIT(1)
 
 /* CPLD Register 0 Client: used for I/O Control */
-static int cpld_reg0_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int cpld_reg0_probe(struct i2c_client *client)
 {
 	if (HAS_ATA) {
 		u8 data;
@@ -197,7 +196,7 @@ static const struct i2c_device_id cpld_reg_ids[] = {
 static struct i2c_driver dm6467evm_cpld_driver = {
 	.driver.name	= "cpld_reg0",
 	.id_table	= cpld_reg_ids,
-	.probe		= cpld_reg0_probe,
+	.probe_new	= cpld_reg0_probe,
 };
 
 /* LEDS */
@@ -402,8 +401,7 @@ static struct snd_platform_data dm646x_evm_snd_data[] = {
 #ifdef CONFIG_I2C
 static struct i2c_client *cpld_client;
 
-static int cpld_video_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int cpld_video_probe(struct i2c_client *client)
 {
 	cpld_client = client;
 	return 0;
@@ -424,7 +422,7 @@ static struct i2c_driver cpld_video_driver = {
 	.driver = {
 		.name	= "cpld_video",
 	},
-	.probe		= cpld_video_probe,
+	.probe_new	= cpld_video_probe,
 	.remove		= cpld_video_remove,
 	.id_table	= cpld_video_id,
 };
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 34f1baa10c54..43b587e79d21 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -378,8 +378,7 @@ static const struct {
 	  .i2c_devs = wm2200_i2c, .num_i2c_devs = ARRAY_SIZE(wm2200_i2c) },
 };
 
-static int wlf_gf_module_probe(struct i2c_client *i2c,
-			       const struct i2c_device_id *i2c_id)
+static int wlf_gf_module_probe(struct i2c_client *i2c)
 {
 	int ret, i, j, id, rev;
 
@@ -432,7 +431,7 @@ static struct i2c_driver wlf_gf_module_driver = {
 	.driver = {
 		.name = "wlf-gf-module"
 	},
-	.probe = wlf_gf_module_probe,
+	.probe_new = wlf_gf_module_probe,
 	.id_table = wlf_gf_module_id,
 };
 
-- 
2.25.4

