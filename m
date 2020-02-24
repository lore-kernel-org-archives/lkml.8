Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CDBC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7B20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBXRng convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:43:36 -0500
Received: from mail-oln040092254037.outbound.protection.outlook.com ([40.92.254.37]:25831
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgBXRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:43:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwt61FsGvWNM+hktfrQR/13JOnZeIoZH7Ep/zO64XuOUDnPuHFed1uDcgwzkjQ+u5UuscveawBafQ5kLQu0oWuQLWQPOMfZvXy97KApG0r4JgaSpYxy2dMp8nBrshCF/SfNERSVL+NPfLcse/K76NvWb4ojSlSoSsbx/HcMiMP03IKj8it40xU4FFdAbnzpAsVsuFJZ2u94sUKzpzcVS38rFe395B0EqwwRFtKkFWreDJv6OrTe8oRZhMdhQxLQJUaplHXmzr9lH66EawibeOnv3Fd9eN+YQKHPp/clRrH/ySyqPu1lWv9MnQ4CzDwBym53BalnUUEn7F/DatBxSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32qJKq7hMi4w6a3+pYbG9rNn+7l0hyEWiEYPAzjWBmo=;
 b=DY6xnl/CfBCG/OIUkudfl8Z0hP4POBkG50y5TT2JxKKSE9iihv02KXX5Tn8Xnb8MgIpRh2Ote0qqWE77izgHmTqqYzmnKy5gB9bsjLnM39Bg/aoVdmQeYtpzqWr/YDO+QtkkE9JdssX2l9XJAgGrJ6+nJjRxtHgUHmTUenUOV31kb1fU9JEsKDVsp+TUZzGj/Iqgzzwa/vvXmMKii4MyRXuHYeWHMhdz7umHSpg80Vr58er68jr3AvSyJy+E01aBDqd3OjbCB0wdZP/PTMwYGX5ZqTf2c/Yt6TsOZjttxLq6yhXdlO48QijZEH1oiDVeWWZJ6LPGPRjPlromWkaOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT063.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::36) by
 SG2APC01HT058.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::349)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.19; Mon, 24 Feb
 2020 17:43:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT063.mail.protection.outlook.com (10.152.251.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:43:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:43:29 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0151.ausprd01.prod.outlook.com (2603:10c6:201:2f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Mon, 24 Feb 2020 17:43:27 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 3/3] nvmem: Remove .read_only field from nvmem_config
Thread-Topic: [PATCH v1 3/3] nvmem: Remove .read_only field from nvmem_config
Thread-Index: AQHV6znsaiedl+y69kCc/s7T8T7K2w==
Date:   Mon, 24 Feb 2020 17:43:29 +0000
Message-ID: <PSXP216MB043836D392E998FB3193568480EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0151.ausprd01.prod.outlook.com
 (2603:10c6:201:2f::19) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:D70631FE8BA5F1B40369DC13D84E1589BE80E2A09DF272E018BBD7FF0D9EC112;UpperCasedChecksum:A67C82B4BD0CA05892F4930F194FC5AA5D18E5625D9C61E279A20E4C2390048C;SizeAsReceived:7838;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7HY4jC7x3CvvjNVTwOZR8q8Kbhlmy8PRjobxl2/1uNaVmHJ5mq+af52znCE86UDC]
x-microsoft-original-message-id: <20200224174322.GA3727@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 443f68f6-33d7-4777-b34b-08d7b9510f00
x-ms-exchange-slblob-mailprops: gjx25WM8ZNX0Yn+GlkLgg++2GZLLkjhChQGS3bz+r14CLK8NVDRoeeMr5RUPqqDfpaSHPAZaeyxcN2L8VTypQ3dvwAnsOToZOLhUgzfHqNRS1/dYqDw6km9Q+VfHMIdznKW42ZC6QtjX4jgKvihvYVNciUa7Wxkjx15VBhir+NM47+eBX59ugWhfOhDxXAdH2qw6+Z+FZlfY9IaFIJUOVkGOUH7Qq1xP3pRucRASORitwwGj9imVriwxvlF79o3VG+bpG+pHigwcwfZzlhVSvkBCzk5wslI9+1eAc2D2VbhlzeAcc7JKJBikNEUc9aEfHY4ERNQjUwczNysdLfTPvWSIxaMagGj/GlZ4wzgseB6myT76c4oDmC822JG/ojR6aT38Yg/Skov0T7GbMwDR0J+hfe1eFGs3wWaUxH+rMTVjbpgY3nhU/9xIdptEsNI9yjWQXm5+LKDr+Dkf+UGtSnLUhqA0ZgkLnjk25ADU5UszdGUu4bc+PY3pLkV47L9/9F9Ylt/SRzZz7SVh+Ko87/UFKi5rk0cIHPPfPc63OHazd0aejwzOmhjzv4LCjGjlqyMthMz43CJaNUJvXFxID6W8MHbeKGiOp483JuY9H1bjruNTADeDqC+hI8UG/NEK76dNGNuA2zTU10bpYOCnuecY1DMUOGpzfNHmyX1VmFAJuLVqutdO9KUgW5cGw0kz0VAdBntMJgdXKiRCtJGTJ/UlmJYAzzXlOZtZrF0puKA=
x-ms-traffictypediagnostic: SG2APC01HT058:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAPoQu9PsGt6rssXtxWTF7U+DUDwjAAHJWK0aFl2W860jPnVMc7i7VeicgveRpJ5w1BW7KA+0BCdnH+0TI3qz6uYCTtxBsYavRrE+e8VvxwwPI6+wuXWBS5hZKc2Xvw9KA8cBXbUSL4+4qSFvBG2XnOsHhAdJgYQPXZNGZ0uU/VzVv+iUDL1RnuOw1QJCD//
x-ms-exchange-antispam-messagedata: nfAeKl8KN6e3pIhZjqYj8o1WYOnYrjCQIBXqKLQTOV8BLnu3iqBmKZSDzS5G9QefVlvnkvjkgoIR0E4oNM0Hakk/d5IW+MLOdGdzkYe/fLx+kngUj1T3QftHN5NtZpSWLojtv2OXQPBMvxJ/c+wXl1r8f5CGVbMpPmlNd/Npken+bSMO3Zql8cXELeUaOOxqN+WoIpu7uJpbcMgDK4QvPw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93FE8421EE50FE44A5C2AF01B9944BCC@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 443f68f6-33d7-4777-b34b-08d7b9510f00
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 17:43:29.5926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no .write_only field in nvmem_config, so having .read_only
makes no sense. We can determine the attrs based on whether .reg_read
and .reg_write are provided. Using only .reg_read and .reg_write means
that there can no longer be contradictions (for instance, if .read_only
is set but .reg_read is NULL).

Remove .read_only field from nvmem_config.

Remove all references to .read_only field from drivers.

Update drivers to only supply nvmem->reg_write if write attrs are
desired.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/misc/eeprom/at24.c          | 4 ++--
 drivers/misc/eeprom/at25.c          | 4 ++--
 drivers/misc/eeprom/eeprom_93xx46.c | 4 ++--
 drivers/mtd/mtdcore.c               | 1 -
 drivers/nvmem/bcm-ocotp.c           | 1 -
 drivers/nvmem/core.c                | 5 +----
 drivers/nvmem/imx-iim.c             | 1 -
 drivers/nvmem/imx-ocotp-scu.c       | 1 -
 drivers/nvmem/imx-ocotp.c           | 1 -
 drivers/nvmem/lpc18xx_otp.c         | 1 -
 drivers/nvmem/meson-mx-efuse.c      | 1 -
 drivers/nvmem/nvmem.h               | 1 -
 drivers/nvmem/rockchip-efuse.c      | 1 -
 drivers/nvmem/rockchip-otp.c        | 1 -
 drivers/nvmem/sc27xx-efuse.c        | 1 -
 drivers/nvmem/sprd-efuse.c          | 1 -
 drivers/nvmem/stm32-romem.c         | 1 -
 drivers/nvmem/sunxi_sid.c           | 1 -
 drivers/nvmem/uniphier-efuse.c      | 1 -
 drivers/nvmem/zynqmp_nvmem.c        | 1 -
 drivers/soc/tegra/fuse/fuse-tegra.c | 1 -
 drivers/thunderbolt/switch.c        | 1 -
 drivers/w1/slaves/w1_ds250x.c       | 1 -
 include/linux/nvmem-provider.h      | 2 --
 24 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 031eb6454..000a78f0f 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -679,13 +679,13 @@ static int at24_probe(struct i2c_client *client)
 
 	nvmem_config.name = dev_name(dev);
 	nvmem_config.dev = dev;
-	nvmem_config.read_only = !writable;
 	nvmem_config.root_only = !(flags & AT24_FLAG_IRUGO);
 	nvmem_config.owner = THIS_MODULE;
 	nvmem_config.compat = true;
 	nvmem_config.base_dev = dev;
 	nvmem_config.reg_read = at24_read;
-	nvmem_config.reg_write = at24_write;
+	if (writable)
+		nvmem_config.reg_write = at24_write;
 	nvmem_config.priv = at24;
 	nvmem_config.stride = 1;
 	nvmem_config.word_size = 1;
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index cde9a2fc1..57e26ca2c 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -350,13 +350,13 @@ static int at25_probe(struct spi_device *spi)
 
 	at25->nvmem_config.name = dev_name(&spi->dev);
 	at25->nvmem_config.dev = &spi->dev;
-	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
 	at25->nvmem_config.root_only = true;
 	at25->nvmem_config.owner = THIS_MODULE;
 	at25->nvmem_config.compat = true;
 	at25->nvmem_config.base_dev = &spi->dev;
 	at25->nvmem_config.reg_read = at25_ee_read;
-	at25->nvmem_config.reg_write = at25_ee_write;
+	if (!(chip.flags && EE_READONLY))
+		at25->nvmem_config.reg_write = at25_ee_write;
 	at25->nvmem_config.priv = at25;
 	at25->nvmem_config.stride = 4;
 	at25->nvmem_config.word_size = 1;
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 94cfb675f..29c05ea5f 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -457,13 +457,13 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->size = 128;
 	edev->nvmem_config.name = dev_name(&spi->dev);
 	edev->nvmem_config.dev = &spi->dev;
-	edev->nvmem_config.read_only = pd->flags & EE_READONLY;
 	edev->nvmem_config.root_only = true;
 	edev->nvmem_config.owner = THIS_MODULE;
 	edev->nvmem_config.compat = true;
 	edev->nvmem_config.base_dev = &spi->dev;
 	edev->nvmem_config.reg_read = eeprom_93xx46_read;
-	edev->nvmem_config.reg_write = eeprom_93xx46_write;
+	if (!(pd->flags & EE_READONLY))
+		edev->nvmem_config.reg_write = eeprom_93xx46_write;
 	edev->nvmem_config.priv = edev;
 	edev->nvmem_config.stride = 4;
 	edev->nvmem_config.word_size = 1;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5fac4355b..660871f7b 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -557,7 +557,6 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.size = mtd->size;
 	config.word_size = 1;
 	config.stride = 1;
-	config.read_only = true;
 	config.root_only = true;
 	config.no_of_node = true;
 	config.priv = mtd;
diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a80975115..e692143d2 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -230,7 +230,6 @@ static int bcm_otpc_write(void *context, unsigned int offset, void *val,
 
 static struct nvmem_config bcm_otpc_nvmem_config = {
 	.name = "bcm-ocotp",
-	.read_only = false,
 	.word_size = 4,
 	.stride = 4,
 	.reg_read = bcm_otpc_read,
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243..2b4df8c42 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -384,9 +384,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			     config->name ? config->id : nvmem->id);
 	}
 
-	nvmem->read_only = device_property_present(config->dev, "read-only") ||
-			   config->read_only || !nvmem->reg_write;
-
 	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
 
 	device_initialize(&nvmem->dev);
@@ -1065,7 +1062,7 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 	struct nvmem_device *nvmem = cell->nvmem;
 	int rc;
 
-	if (!nvmem || nvmem->read_only ||
+	if (!nvmem || (nvmem->reg_read && !nvmem->reg_write) ||
 	    (cell->bit_offset == 0 && len != cell->bytes))
 		return -EINVAL;
 
diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index 701704b87..4778f44b3 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -122,7 +122,6 @@ static int imx_iim_probe(struct platform_device *pdev)
 		return PTR_ERR(iim->clk);
 
 	cfg.name = "imx-iim",
-	cfg.read_only = true,
 	cfg.word_size = 1,
 	cfg.stride = 1,
 	cfg.reg_read = imx_iim_read,
diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 399e1eb8b..ed21256fd 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -220,7 +220,6 @@ static int imx_scu_ocotp_write(void *context, unsigned int offset,
 
 static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 	.name = "imx-scu-ocotp",
-	.read_only = false,
 	.word_size = 4,
 	.stride = 1,
 	.owner = THIS_MODULE,
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 4ba9cc8f7..2c4b5d9be 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -437,7 +437,6 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 
 static struct nvmem_config imx_ocotp_nvmem_config = {
 	.name = "imx-ocotp",
-	.read_only = false,
 	.word_size = 4,
 	.stride = 4,
 	.reg_read = imx_ocotp_read,
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 16c92ea85..27a6aa1dc 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -58,7 +58,6 @@ static int lpc18xx_otp_read(void *context, unsigned int offset,
 
 static struct nvmem_config lpc18xx_otp_nvmem_config = {
 	.name = "lpc18xx-otp",
-	.read_only = true,
 	.word_size = LPC18XX_OTP_WORD_SIZE,
 	.stride = LPC18XX_OTP_WORD_SIZE,
 	.reg_read = lpc18xx_otp_read,
diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 07c9f38c1..9ecda17de 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -217,7 +217,6 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	efuse->config.stride = drvdata->word_size;
 	efuse->config.word_size = drvdata->word_size;
 	efuse->config.size = SZ_512;
-	efuse->config.read_only = true;
 	efuse->config.reg_read = meson_mx_efuse_read;
 
 	efuse->core_clk = devm_clk_get(&pdev->dev, "core");
diff --git a/drivers/nvmem/nvmem.h b/drivers/nvmem/nvmem.h
index be0d66d75..1d6c76ef4 100644
--- a/drivers/nvmem/nvmem.h
+++ b/drivers/nvmem/nvmem.h
@@ -19,7 +19,6 @@ struct nvmem_device {
 	int			id;
 	struct kref		refcnt;
 	size_t			size;
-	bool			read_only;
 	int			flags;
 	enum nvmem_type		type;
 	struct bin_attribute	eeprom;
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index e4579de5d..6bd18511d 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -207,7 +207,6 @@ static struct nvmem_config econfig = {
 	.name = "rockchip-efuse",
 	.stride = 1,
 	.word_size = 1,
-	.read_only = true,
 };
 
 static const struct of_device_id rockchip_efuse_match[] = {
diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 9f53bcce2..38ae30363 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -183,7 +183,6 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 static struct nvmem_config otp_config = {
 	.name = "rockchip-otp",
 	.owner = THIS_MODULE,
-	.read_only = true,
 	.stride = 1,
 	.word_size = 1,
 	.reg_read = rockchip_otp_read,
diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index ab5e7e0bc..92183db62 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -222,7 +222,6 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
-	econfig.read_only = true;
 	econfig.name = "sc27xx-efuse";
 	econfig.size = SC27XX_EFUSE_BLOCK_MAX * SC27XX_EFUSE_BLOCK_WIDTH;
 	econfig.reg_read = sc27xx_efuse_read;
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 2f1e0fbd1..f2580d692 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -388,7 +388,6 @@ static int sprd_efuse_probe(struct platform_device *pdev)
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
-	econfig.read_only = false;
 	econfig.name = "sprd-efuse";
 	econfig.size = efuse->data->blk_nums * SPRD_EFUSE_BLOCK_WIDTH;
 	econfig.reg_read = sprd_efuse_read;
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 354be5268..c71c1b8e0 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -162,7 +162,6 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	cfg = (const struct stm32_romem_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
 	if (!cfg) {
-		priv->cfg.read_only = true;
 		priv->cfg.size = resource_size(res);
 		priv->cfg.reg_read = stm32_romem_read;
 	} else {
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index e26ef1bbf..8bf2d66f1 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -142,7 +142,6 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	nvmem_cfg->dev = dev;
 	nvmem_cfg->name = "sunxi-sid";
-	nvmem_cfg->read_only = true;
 	nvmem_cfg->size = cfg->size;
 	nvmem_cfg->word_size = 1;
 	nvmem_cfg->stride = 4;
diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
index aca910b3b..312a3a99d 100644
--- a/drivers/nvmem/uniphier-efuse.c
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -48,7 +48,6 @@ static int uniphier_efuse_probe(struct platform_device *pdev)
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
-	econfig.read_only = true;
 	econfig.reg_read = uniphier_reg_read;
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 589354391..0336aa056 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -43,7 +43,6 @@ static struct nvmem_config econfig = {
 	.owner = THIS_MODULE,
 	.word_size = 1,
 	.size = 1,
-	.read_only = true,
 };
 
 static const struct of_device_id zynqmp_nvmem_match[] = {
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 802717b9f..38663a389 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -221,7 +221,6 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	nvmem.cells = tegra_fuse_cells;
 	nvmem.ncells = ARRAY_SIZE(tegra_fuse_cells);
 	nvmem.type = NVMEM_TYPE_OTP;
-	nvmem.read_only = true;
 	nvmem.root_only = true;
 	nvmem.reg_read = tegra_fuse_read;
 	nvmem.size = fuse->soc->info->size;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index ad5479f21..a0f05a47e 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -390,7 +390,6 @@ static struct nvmem_device *register_nvmem(struct tb_switch *sw, int id,
 	if (active) {
 		config.name = "nvm_active";
 		config.reg_read = tb_switch_nvm_read;
-		config.read_only = true;
 	} else {
 		config.name = "nvm_non_active";
 		config.reg_write = tb_switch_nvm_write;
diff --git a/drivers/w1/slaves/w1_ds250x.c b/drivers/w1/slaves/w1_ds250x.c
index e50711744..35b92e791 100644
--- a/drivers/w1/slaves/w1_ds250x.c
+++ b/drivers/w1/slaves/w1_ds250x.c
@@ -170,7 +170,6 @@ static int w1_eprom_add_slave(struct w1_slave *sl)
 		.dev = &sl->dev,
 		.reg_read = w1_nvmem_read,
 		.type = NVMEM_TYPE_OTP,
-		.read_only = true,
 		.word_size = 1,
 		.priv = sl,
 		.id = -1
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 6d6f8e5d2..69b63f4c2 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -37,7 +37,6 @@ enum nvmem_type {
  * @cells:	Optional array of pre-defined NVMEM cells.
  * @ncells:	Number of elements in cells.
  * @type:	Type of the nvmem storage
- * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
@@ -64,7 +63,6 @@ struct nvmem_config {
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
 	enum nvmem_type		type;
-	bool			read_only;
 	bool			root_only;
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
-- 
2.25.1

