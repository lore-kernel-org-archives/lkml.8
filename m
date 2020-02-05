Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26813C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D098121741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAkOAnHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgBECs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:48:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40052 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgBECs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:48:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so302492pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MRDhJuZsobxZbBaPuN6bZIjazIto3gnjDbkwzeLGfHY=;
        b=KAkOAnHjz600Tb4WO02Q6o0yQ99rH+OP85ewGtpzACJn9wb8mQdaJls3dehxopLcJJ
         k1V3g1ra+nutpk4xp7Vr/VqIILnI8h5s2Ps+PHrSCs8Id5/4DIJS1kPLEM6myru+7c7+
         R0Z4Oq7OqwIkvsLgcFS2Abox5wfyGOvxG7BeeQs92WsVlhQzw736q0HgNVbxDW8oxmqh
         GzU+QqY8yzLTVYG4XjnBBFlKe3uLgte/cI9CVFazOpFuOqCyzoFGIgQKgnQpI0oezKXx
         JksnCrAir+GCeT3hNApGcdyckZxmNez6cycB0akxYvmcSyIwsvzOSVs0NaFb+uHgLU97
         jCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MRDhJuZsobxZbBaPuN6bZIjazIto3gnjDbkwzeLGfHY=;
        b=I5K6nAzdf09nQqsmxeXNrDFP2zbc7PfribEyWi+96ORf/615ckWTf71KLhPWUWC/Ba
         6T/CJLZk6GiYvmEsSP7lHHQ3Eyy5jNAPqUlk7VZSY0cWXZs3s/YFjvYgwmf6CThBOpzI
         ZM2MFpokaWds56DX1B4wbYBG4uk2+7ZSpf85r/ixWhlOO/z9/mZVutzOQ/4DYp9hr19+
         1oW3WzXImFy7k5qOJvu54MYLwBpJuSV29GCmYxKk4ZIp9PI/mrU0VZWGzc92RRXgJxaD
         GywkTFfI7grNFycT0ZqcEFECeqdDnbDfdBXV2BS7q8PhGxFmux/JiLEV2hIcoumBq6zS
         t79g==
X-Gm-Message-State: APjAAAW53BavJsBhY0wKK3trHZt5HaVuuayWKQmYlkS/LyalyjfVt/yW
        Dt5BbqbUvFfH6+BJ456BPHrd+Q62
X-Google-Smtp-Source: APXvYqyExpZj1TpnrM+/UU/EKUzpygjCeEa3Ffqzj0/LIJFxBdd62yped2aMMFpTF2ypzDYKr8vR5Q==
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr34651122pln.59.1580870906160;
        Tue, 04 Feb 2020 18:48:26 -0800 (PST)
Received: from compute1 ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id x23sm22118410pge.89.2020.02.04.18.48.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2020 18:48:25 -0800 (PST)
Date:   Wed, 5 Feb 2020 10:48:21 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: rename some variables and clean up code
Message-ID: <20200205024821.GA32262@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename some variables to be more understandable and module-related
and remove some redundant code to make it more easy-to-read.

Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 118 +++++++++++++---------------------
 1 file changed, 44 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 4b8ab4b..ed2f823 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -16,6 +16,7 @@
  *	Matt Sickler <matt.sickler@daktronics.com>,
  *	Jordon Hofer <jordon.hofer@daktronics.com>
  */
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -27,13 +28,14 @@
 #include <linux/fs.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+
 #include "kpc.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@Daktronics.com");
 
 struct kpc_i2c {
-	unsigned long           smba;
+	unsigned long           io_base;
 	struct i2c_adapter      adapter;
 	unsigned int            features;
 };
@@ -45,16 +47,16 @@ struct kpc_i2c {
 #define REG_SIZE 8
 
 /* I801 SMBus address offsets */
-#define SMBHSTSTS(p)    ((0  * REG_SIZE) + (p)->smba)
-#define SMBHSTCNT(p)    ((2  * REG_SIZE) + (p)->smba)
-#define SMBHSTCMD(p)    ((3  * REG_SIZE) + (p)->smba)
-#define SMBHSTADD(p)    ((4  * REG_SIZE) + (p)->smba)
-#define SMBHSTDAT0(p)   ((5  * REG_SIZE) + (p)->smba)
-#define SMBHSTDAT1(p)   ((6  * REG_SIZE) + (p)->smba)
-#define SMBBLKDAT(p)    ((7  * REG_SIZE) + (p)->smba)
-#define SMBPEC(p)       ((8  * REG_SIZE) + (p)->smba)   /* ICH3 and later */
-#define SMBAUXSTS(p)    ((12 * REG_SIZE) + (p)->smba)   /* ICH4 and later */
-#define SMBAUXCTL(p)    ((13 * REG_SIZE) + (p)->smba)   /* ICH4 and later */
+#define SMBHSTSTS(p)    ((0  * REG_SIZE) + (p)->io_base)
+#define SMBHSTCNT(p)    ((2  * REG_SIZE) + (p)->io_base)
+#define SMBHSTCMD(p)    ((3  * REG_SIZE) + (p)->io_base)
+#define SMBHSTADD(p)    ((4  * REG_SIZE) + (p)->io_base)
+#define SMBHSTDAT0(p)   ((5  * REG_SIZE) + (p)->io_base)
+#define SMBHSTDAT1(p)   ((6  * REG_SIZE) + (p)->io_base)
+#define SMBBLKDAT(p)    ((7  * REG_SIZE) + (p)->io_base)
+#define SMBPEC(p)       ((8  * REG_SIZE) + (p)->io_base)   /* ICH3 and later */
+#define SMBAUXSTS(p)    ((12 * REG_SIZE) + (p)->io_base)   /* ICH4 and later */
+#define SMBAUXCTL(p)    ((13 * REG_SIZE) + (p)->io_base)   /* ICH4 and later */
 
 /* PCI Address Constants */
 #define SMBBAR      4
@@ -433,9 +435,9 @@ static int i801_block_transaction(struct kpc_i2c *priv,
 }
 
 /* Return negative errno on error. */
-static s32 i801_access(struct i2c_adapter *adap, u16 addr,
-		       unsigned short flags, char read_write, u8 command,
-		       int size, union i2c_smbus_data *data)
+static s32 kpc_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write, u8 command,
+			  int size, union i2c_smbus_data *data)
 {
 	int hwpec;
 	int block = 0;
@@ -444,19 +446,18 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) &&
 		(flags & I2C_CLIENT_PEC) &&
-		size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA;
+		(size != I2C_SMBUS_QUICK) &&
+		(size != I2C_SMBUS_I2C_BLOCK_DATA);
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_QUICK\n");
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
-
 		xact = I801_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BYTE\n");
-
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
 		if (read_write == I2C_SMBUS_WRITE)
@@ -467,7 +468,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BYTE_DATA\n");
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
-
 		outb_p(command, SMBHSTCMD(priv));
 		if (read_write == I2C_SMBUS_WRITE)
 			outb_p(data->byte, SMBHSTDAT0(priv));
@@ -477,7 +477,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_WORD_DATA\n");
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
-
 		outb_p(command, SMBHSTCMD(priv));
 		if (read_write == I2C_SMBUS_WRITE) {
 			outb_p(data->word & 0xff, SMBHSTDAT0(priv));
@@ -489,7 +488,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		dev_dbg(&priv->adapter.dev, "  [acc] SMBUS_BLOCK_DATA\n");
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMBHSTADD(priv));
-
 		outb_p(command, SMBHSTCMD(priv));
 		block = 1;
 		break;
@@ -517,11 +515,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 	if (hwpec) { /* enable/disable hardware PEC */
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec: yes\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC,
+		       SMBAUXCTL(priv));
 	} else {
 		dev_dbg(&priv->adapter.dev, "  [acc] hwpec: no\n");
-		outb_p(inb_p(SMBAUXCTL(priv)) &
-				(~SMBAUXCTL_CRC), SMBAUXCTL(priv));
+		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
+		       SMBAUXCTL(priv));
 	}
 
 	if (block) {
@@ -572,7 +571,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	return 0;
 }
 
-static u32 i801_func(struct i2c_adapter *adapter)
+static u32 kpc_func(struct i2c_adapter *adapter)
 {
 	struct kpc_i2c *priv = i2c_get_adapdata(adapter);
 
@@ -587,54 +586,25 @@ static u32 i801_func(struct i2c_adapter *adapter)
 
 	// http://lxr.free-electrons.com/source/include/uapi/linux/i2c.h#L85
 
-	u32 f =
-		I2C_FUNC_I2C                     | /* 0x00000001(I enabled this
-						    * one)
-						    */
-		!I2C_FUNC_10BIT_ADDR             |		/* 0x00000002 */
-		!I2C_FUNC_PROTOCOL_MANGLING      |		/* 0x00000004 */
-		((priv->features & FEATURE_SMBUS_PEC) ?
-			I2C_FUNC_SMBUS_PEC : 0)  |		/* 0x00000008 */
-		!I2C_FUNC_SMBUS_BLOCK_PROC_CALL  |		/* 0x00008000 */
-		I2C_FUNC_SMBUS_QUICK             |		/* 0x00010000 */
-		!I2C_FUNC_SMBUS_READ_BYTE	 |		/* 0x00020000 */
-		!I2C_FUNC_SMBUS_WRITE_BYTE       |		/* 0x00040000 */
-		!I2C_FUNC_SMBUS_READ_BYTE_DATA   |		/* 0x00080000 */
-		!I2C_FUNC_SMBUS_WRITE_BYTE_DATA  |		/* 0x00100000 */
-		!I2C_FUNC_SMBUS_READ_WORD_DATA   |		/* 0x00200000 */
-		!I2C_FUNC_SMBUS_WRITE_WORD_DATA  |		/* 0x00400000 */
-		!I2C_FUNC_SMBUS_PROC_CALL        |		/* 0x00800000 */
-		!I2C_FUNC_SMBUS_READ_BLOCK_DATA  |		/* 0x01000000 */
-		!I2C_FUNC_SMBUS_WRITE_BLOCK_DATA |		/* 0x02000000 */
-		((priv->features & FEATURE_I2C_BLOCK_READ) ?
-			I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0) |	/* 0x04000000 */
-		I2C_FUNC_SMBUS_WRITE_I2C_BLOCK   |		/* 0x08000000 */
-
-		I2C_FUNC_SMBUS_BYTE              | /* _READ_BYTE  _WRITE_BYTE */
-		I2C_FUNC_SMBUS_BYTE_DATA         | /* _READ_BYTE_DATA
-						    * _WRITE_BYTE_DATA
-						    */
-		I2C_FUNC_SMBUS_WORD_DATA         | /* _READ_WORD_DATA
-						    * _WRITE_WORD_DATA
-						    */
-		I2C_FUNC_SMBUS_BLOCK_DATA        | /* _READ_BLOCK_DATA
-						    * _WRITE_BLOCK_DATA
-						    */
-		!I2C_FUNC_SMBUS_I2C_BLOCK        | /* _READ_I2C_BLOCK
-						    * _WRITE_I2C_BLOCK
-						    */
-		!I2C_FUNC_SMBUS_EMUL;              /* _QUICK  _BYTE
-						    * _BYTE_DATA  _WORD_DATA
-						    * _PROC_CALL
-						    * _WRITE_BLOCK_DATA
-						    * _I2C_BLOCK _PEC
-						    */
+	u32 f = I2C_FUNC_I2C |
+		I2C_FUNC_SMBUS_QUICK |
+		I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA;
+
+	if (priv->features & FEATURE_SMBUS_PEC)
+		f |= I2C_FUNC_SMBUS_PEC;
+	if (priv->features & FEATURE_I2C_BLOCK_READ)
+		f |= I2C_FUNC_SMBUS_READ_I2C_BLOCK;
+
 	return f;
 }
 
-static const struct i2c_algorithm smbus_algorithm = {
-	.smbus_xfer     = i801_access,
-	.functionality  = i801_func,
+static const struct i2c_algorithm kpc_algorithm = {
+	.smbus_xfer     = kpc_smbus_xfer,
+	.functionality  = kpc_func,
 };
 
 /********************************
@@ -653,16 +623,16 @@ static int kpc_i2c_probe(struct platform_device *pldev)
 	i2c_set_adapdata(&priv->adapter, priv);
 	priv->adapter.owner = THIS_MODULE;
 	priv->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	priv->adapter.algo = &smbus_algorithm;
+	priv->adapter.algo = &kpc_algorithm;
 
 	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
 
-	priv->smba = (unsigned long)devm_ioremap_nocache(&pldev->dev,
-							 res->start,
-							 resource_size(res));
-	if (!priv->smba)
+	priv->io_base = (unsigned long)devm_ioremap_nocache(&pldev->dev,
+							    res->start,
+							    resource_size(res));
+	if (!priv->io_base)
 		return -ENOMEM;
 
 	platform_set_drvdata(pldev, priv);
-- 
2.7.4

