Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FDC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F1C22527
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRS6WTI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAUCqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 21:46:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43139 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:46:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so635000pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 18:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gld+GR0KiO4kq3LejJtqjjfat4+3gMTejomsZyOT1JU=;
        b=CRS6WTI4AziCn5rJQDHpX6pvfCUsfFN8LWyDQXzJIG3iLBGkjVCk+5rhixih4h95D8
         KU9eLkWg/r9KBPm1SrRxT5WUKjlQ+0HzztYPev6PquYM7YSFIo479J+vQuP5i1q/isG5
         TjfLLcjEs11GtyxmKxdCHEmDQYMUdTLX1lEauvjou9bnZafta4QJ2QyLicx7rpE2JCnC
         fx/bNJMIm2p7MWYNGYrckL3w46PNI4iHrDb4SLB9EqeCW2nH5H6IjzjncNe4EzVZB/Co
         /AB9ZTPmlzMuzoy0GOKZdxExkOjm+kifTrKyOuOWqHlydjmHoDVu9nXejwbEeGrDpLIC
         3ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gld+GR0KiO4kq3LejJtqjjfat4+3gMTejomsZyOT1JU=;
        b=TNaOPvcf5KfZIdTHVp0LqilKNvV1qLRyyePMiddLzJvpTToKMgCZHWA0CU5nOLwrc3
         B0qPfYZ0i+uCv6EuW14aU68AJPpetKvVfMWbzBU9ooraJAD8x86eJn9Ih6nrtPpbInn1
         4qLjymv8qaYnj2iJRgr3AoZ2ypXr4HKXNDE/gz+M5CopRBBxVl0oPOmAHIyoOMaNXRVB
         2CylIXXvPnOSlZt6tosCOgWMWTfdrBmlsglkIlJe3ZhKl7zz13O3uaWxT817m+B+qd56
         t+zcA3JAg4devpm8fbj4wd2zflyXaC2msjngo/LQUTfAdI2JlIE9HSgCLTA1dRyrHOiL
         /eOw==
X-Gm-Message-State: APjAAAUBk6DOqNH1mpvtGwiQqu2Y46jtkpWRqw6KqKIqxDIiTC7mnVSc
        kfFpFborn/TfqFkqrU5R0Gx/qCnp
X-Google-Smtp-Source: APXvYqzu8ywwiPw0toTbGe8tN+O+ssWELE3fN2o7KP24TQNVemKJKtGHQvUl6e+kO/cpCuDXvtXZ7w==
X-Received: by 2002:a63:2a49:: with SMTP id q70mr2890452pgq.265.1579574789348;
        Mon, 20 Jan 2020 18:46:29 -0800 (PST)
Received: from compute1 ([210.200.12.126])
        by smtp.gmail.com with ESMTPSA id g8sm40283459pfh.43.2020.01.20.18.46.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jan 2020 18:46:28 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:46:21 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: rename variables with kpc namespace
Message-ID: <20200121024620.GA10842@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some namings in kpc2000_i2c are too ambiguous that may causing
confusion to the readers.

Rename some variable, function and struct name to prefix with 'kpc_i2c'
to eliminate confusions.

Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 5460bf9..4b8ab4b 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -32,7 +32,7 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@Daktronics.com");
 
-struct i2c_device {
+struct kpc_i2c {
 	unsigned long           smba;
 	struct i2c_adapter      adapter;
 	unsigned int            features;
@@ -131,7 +131,7 @@ struct i2c_device {
 /* Make sure the SMBus host is ready to start transmitting.
  * Return 0 if it is, -EBUSY if it is not.
  */
-static int i801_check_pre(struct i2c_device *priv)
+static int i801_check_pre(struct kpc_i2c *priv)
 {
 	int status;
 
@@ -156,7 +156,7 @@ static int i801_check_pre(struct i2c_device *priv)
 }
 
 /* Convert the status register to an error code, and clear it. */
-static int i801_check_post(struct i2c_device *priv, int status, int timeout)
+static int i801_check_post(struct kpc_i2c *priv, int status, int timeout)
 {
 	int result = 0;
 
@@ -206,7 +206,7 @@ static int i801_check_post(struct i2c_device *priv, int status, int timeout)
 	return result;
 }
 
-static int i801_transaction(struct i2c_device *priv, int xact)
+static int i801_transaction(struct kpc_i2c *priv, int xact)
 {
 	int status;
 	int result;
@@ -235,7 +235,7 @@ static int i801_transaction(struct i2c_device *priv, int xact)
 }
 
 /* wait for INTR bit as advised by Intel */
-static void i801_wait_hwpec(struct i2c_device *priv)
+static void i801_wait_hwpec(struct kpc_i2c *priv)
 {
 	int timeout = 0;
 	int status;
@@ -251,7 +251,7 @@ static void i801_wait_hwpec(struct i2c_device *priv)
 	outb_p(status, SMBHSTSTS(priv));
 }
 
-static int i801_block_transaction_by_block(struct i2c_device *priv,
+static int i801_block_transaction_by_block(struct kpc_i2c *priv,
 					   union i2c_smbus_data *data,
 					   char read_write, int hwpec)
 {
@@ -285,7 +285,7 @@ static int i801_block_transaction_by_block(struct i2c_device *priv,
 	return 0;
 }
 
-static int i801_block_transaction_byte_by_byte(struct i2c_device *priv,
+static int i801_block_transaction_byte_by_byte(struct kpc_i2c *priv,
 					       union i2c_smbus_data *data,
 					       char read_write, int command,
 					       int hwpec)
@@ -367,7 +367,7 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv,
 	return 0;
 }
 
-static int i801_set_block_buffer_mode(struct i2c_device *priv)
+static int i801_set_block_buffer_mode(struct kpc_i2c *priv)
 {
 	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
 	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) == 0)
@@ -376,7 +376,7 @@ static int i801_set_block_buffer_mode(struct i2c_device *priv)
 }
 
 /* Block transaction function */
-static int i801_block_transaction(struct i2c_device *priv,
+static int i801_block_transaction(struct kpc_i2c *priv,
 				  union i2c_smbus_data *data, char read_write,
 				  int command, int hwpec)
 {
@@ -440,7 +440,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	int hwpec;
 	int block = 0;
 	int ret, xact = 0;
-	struct i2c_device *priv = i2c_get_adapdata(adap);
+	struct kpc_i2c *priv = i2c_get_adapdata(adap);
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) &&
 		(flags & I2C_CLIENT_PEC) &&
@@ -574,7 +574,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 static u32 i801_func(struct i2c_adapter *adapter)
 {
-	struct i2c_device *priv = i2c_get_adapdata(adapter);
+	struct kpc_i2c *priv = i2c_get_adapdata(adapter);
 
 	/* original settings
 	 * u32 f = I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -640,10 +640,10 @@ static const struct i2c_algorithm smbus_algorithm = {
 /********************************
  *** Part 2 - Driver Handlers ***
  ********************************/
-static int pi2c_probe(struct platform_device *pldev)
+static int kpc_i2c_probe(struct platform_device *pldev)
 {
 	int err;
-	struct i2c_device *priv;
+	struct kpc_i2c *priv;
 	struct resource *res;
 
 	priv = devm_kzalloc(&pldev->dev, sizeof(*priv), GFP_KERNEL);
@@ -692,11 +692,11 @@ static int pi2c_probe(struct platform_device *pldev)
 	return 0;
 }
 
-static int pi2c_remove(struct platform_device *pldev)
+static int kpc_i2c_remove(struct platform_device *pldev)
 {
-	struct i2c_device *lddev;
+	struct kpc_i2c *lddev;
 
-	lddev = (struct i2c_device *)platform_get_drvdata(pldev);
+	lddev = (struct kpc_i2c *)platform_get_drvdata(pldev);
 
 	i2c_del_adapter(&lddev->adapter);
 
@@ -710,12 +710,12 @@ static int pi2c_remove(struct platform_device *pldev)
 	return 0;
 }
 
-static struct platform_driver i2c_plat_driver_i = {
-	.probe      = pi2c_probe,
-	.remove     = pi2c_remove,
+static struct platform_driver kpc_i2c_driver = {
+	.probe      = kpc_i2c_probe,
+	.remove     = kpc_i2c_remove,
 	.driver     = {
 		.name   = KP_DRIVER_NAME_I2C,
 	},
 };
 
-module_platform_driver(i2c_plat_driver_i);
+module_platform_driver(kpc_i2c_driver);
-- 
2.7.4

