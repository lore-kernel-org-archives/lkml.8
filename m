Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65393C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D116206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uxBkYCD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGK5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:57:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A824C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:57:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so33386036wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=q8a6HmZPzdfh5fojW+wd4kULWFylxpCdZMDt/VjHsYk=;
        b=uxBkYCD9cby7tyOPMcSSy0MbnXsqFwdLtTpXFPUTXV2YGHFOu7ohUGwNBvMsQLZjUq
         2A5DGPfLNwk94DItzTz0uTkhoNYfoXbtNs9RhrRwIGgKW6PZ4rIog4kzuWibWJ6Fqfw7
         QWTUTgIFcpzvfxKHVQaaVROk6/YH1ADsDVkX83V7E6G5u0/sjNfM/TE3g4w1t4xyHU+T
         A5cPFy0ci+Qdc8j/76igytJl6jk6E5TAXXNVt3nYhMY6BxErS1HOujQaZJbaUV64IfVT
         TQoVWa01dB21tc7IbM3dADeQW8ugON44mS3IUvvom4fxcdDu49KdKtZfZevQiMsziijx
         Mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=q8a6HmZPzdfh5fojW+wd4kULWFylxpCdZMDt/VjHsYk=;
        b=ckOTJfu9hZR9rkuVWmz67/MQCH4k0MwEONezj8AaOWTHhXZQmnoo1BZ/4rFDhl8f4i
         IHF4QfMgjI6TcNU34zKZGUOoQmnZI51WFZwPsDW3VVQ7ErcsCpy+A3WUpqu938L7ttxx
         5e4OfAsCjWfQyXoTMvL0+RuD7x6uCke89Z40Pr12/ZHkSoBXKSSWroDAgfixOicUhxNM
         o01+4uQ3JVIkzM2UI026eDCgTDYGBn1/OFvFe/5G/ZIu3C6+8p1JAejcUcBNP/Yx2w2L
         6S3cbTezgf/jub9pwJa4q1nrdYC2G5hB1dggmPaDBtpAdOZ4H4bgwKCZpkdRmbbnv13D
         a8vA==
X-Gm-Message-State: AOAM531EZ7uroA/kXlGdN87/bDa6EJbfv8rrzpmoO+0UIE4W/zeuwRbE
        GQSiyatURWXLihVrFROFxo0=
X-Google-Smtp-Source: ABdhPJy72BFvPskKUMxKOLWyFkJtu2+NGdu5Yeow7LK337w+73BbyRgxAdERs3syVzDZOBPHL9LEZQ==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr54061782wrx.106.1594119452809;
        Tue, 07 Jul 2020 03:57:32 -0700 (PDT)
Received: from ?IPv6:2a02:8070:bb9:bc00::fc? ([2a02:8070:bb9:bc00::fc])
        by smtp.gmail.com with ESMTPSA id d201sm529110wmd.34.2020.07.07.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:57:32 -0700 (PDT)
Message-ID: <1c437154873ace65ff738a0ebca511308f1cecc1.camel@googlemail.com>
Subject: [PATCH] regulator: fan53880: Add support for COMPILE_TEST
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Jul 2020 12:57:31 +0200
In-Reply-To: <20200707102042.GD4870@sirena.org.uk>
References: <202007071433.Z3bmcgjU%lkp@intel.com>
         <da3aece9abd23b12837e9abf908ee67f0c2c988c.camel@googlemail.com>
         <20200707102042.GD4870@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for COMPILE_TEST while fixing a warning when
no support for device tree is there.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/regulator/Kconfig    | 2 +-
 drivers/regulator/fan53880.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d47055db999d..1cc3c93a9621 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -338,7 +338,7 @@ config REGULATOR_FAN53555
 
 config REGULATOR_FAN53880
 	tristate "Fairchild FAN53880 Regulator"
-	depends on I2C
+	depends on I2C && (OF || COMPILE_TEST)
 	select REGMAP_I2C
 	help
 	  This driver supports Fairchild (ON Semiconductor) FAN53880
diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index 285acc705a55..c45baf581299 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -152,11 +152,13 @@ static int fan53880_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id fan53880_dt_ids[] = {
 	{ .compatible = "onnn,fan53880", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fan53880_dt_ids);
+#endif
 
 static const struct i2c_device_id fan53880_i2c_id[] = {
 	{ "fan53880", },
-- 
2.20.1

