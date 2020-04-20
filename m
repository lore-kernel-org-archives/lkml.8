Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB7DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729DF20747
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgDTMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:54:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729693AbgDTMyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:54:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFF9BFC3FD05B4C312C1;
        Mon, 20 Apr 2020 20:54:30 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 20:54:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <geert@linux-m68k.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <ckeepax@opensource.cirrus.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: wm89xx: Add missing dependency
Date:   Mon, 20 Apr 2020 20:53:43 +0800
Message-ID: <20200420125343.20920-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200418090853.30340-1-yuehaibing@huawei.com>
References: <20200418090853.30340-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/wm8900.o: In function `wm8900_i2c_probe':
wm8900.c:(.text+0xa36): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/wm8900.o: In function `wm8900_modinit':
wm8900.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
sound/soc/codecs/wm8900.o: In function `wm8900_exit':
wm8900.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
sound/soc/codecs/wm8988.o: In function `wm8988_i2c_probe':
wm8988.c:(.text+0x857): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/wm8988.o: In function `wm8988_modinit':
wm8988.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
sound/soc/codecs/wm8988.o: In function `wm8988_exit':
wm8988.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
sound/soc/codecs/wm8995.o: In function `wm8995_i2c_probe':
wm8995.c:(.text+0x1c4f): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/wm8995.o: In function `wm8995_modinit':
wm8995.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
sound/soc/codecs/wm8995.o: In function `wm8995_exit':
wm8995.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'

Add SND_SOC_I2C_AND_SPI dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e6a0c5d05fa5..e60e0b6a689c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1525,6 +1525,7 @@ config SND_SOC_WM8804_SPI
 
 config SND_SOC_WM8900
 	tristate
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8903
 	tristate "Wolfson Microelectronics WM8903 CODEC"
@@ -1576,6 +1577,7 @@ config SND_SOC_WM8985
 
 config SND_SOC_WM8988
 	tristate
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8990
 	tristate
@@ -1594,6 +1596,7 @@ config SND_SOC_WM8994
 
 config SND_SOC_WM8995
 	tristate
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8996
 	tristate
-- 
2.17.1


