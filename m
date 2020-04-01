Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6431C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A4D20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbgDAJLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:11:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728225AbgDAJLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:11:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 181AA36B604C7E698AC0;
        Wed,  1 Apr 2020 17:11:10 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 17:10:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oder_chiou@realtek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] ASoC: rt5682: Fix build error without CONFIG_I2C
Date:   Wed, 1 Apr 2020 17:10:55 +0800
Message-ID: <20200401091055.34112-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200401082540.21876-1-yuehaibing@huawei.com>
References: <20200401082540.21876-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I2C is n but SoundWire is m, building fails:

sound/soc/codecs/rt5682.c:3716:1: warning: data definition has no type or storage class
 module_i2c_driver(rt5682_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/rt5682.c:3716:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/rt5682.c:3716:1: warning: parameter names (without types) in function declaration

Guard this use #ifdef CONFIG_I2C.

Fixes: 5549ea647997 ("ASoC: rt5682: fix unmet dependencies")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use __maybe_unused
---
 sound/soc/codecs/rt5682.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index c9268a230daa..d36f560ad7a8 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -3703,7 +3703,7 @@ static const struct acpi_device_id rt5682_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5682_acpi_match);
 #endif
 
-static struct i2c_driver rt5682_i2c_driver = {
+static struct i2c_driver __maybe_unused rt5682_i2c_driver = {
 	.driver = {
 		.name = "rt5682",
 		.of_match_table = of_match_ptr(rt5682_of_match),
@@ -3713,7 +3713,10 @@ static struct i2c_driver rt5682_i2c_driver = {
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
+
+#ifdef CONFIG_I2C
 module_i2c_driver(rt5682_i2c_driver);
+#endif
 
 MODULE_DESCRIPTION("ASoC RT5682 driver");
 MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
-- 
2.17.1


