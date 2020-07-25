Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D47C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4C9206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="juKzEYGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGYBo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgGYBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 21:44:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 18:44:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so6463811pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 18:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A62G1Aaub8NEhYGlTVl8rRO7mj1Y7NBxkFlNcLDXv3I=;
        b=juKzEYGjuSefBIMKT0S2G5oME02AtcR/T8zLF3LTULSDKrnK6Ge15vsv8P+W2O45b6
         syLuMmCjpkuuGs6o3on52ggfQ8vwWnkxy+op+ZJgrUyi8fJVqpdQCse/hno+UTulZ54l
         peUCHXNGXjL7nq/JkOqy1tQOUtWzZlQBSTaDMfaF/xn+ch/lVUb2C60WjW5PkWY1JfZA
         Pg0c+iE6botIQDhUmOUIwA8XV+FFxUAA02fz0rGr/sflSRbAfoQzh4bD6fwv3bo/yJLo
         dFl54/9pTfj/uE2fhRymT7nHCQSO/iAzUAnfU2RgLyEhnl8g2GkwJdc4xJkwR13MNLML
         ihVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A62G1Aaub8NEhYGlTVl8rRO7mj1Y7NBxkFlNcLDXv3I=;
        b=E+U9ytCS+97Qlihw0frOyIaXnS203akWEXXlIgxPxmA5rEuMPfCk0co51F5ycYQTSK
         5DxS6qLb6sqgdVAUOn1+QctGGVmWnwtU5E3qHv0ivp1OWfGA30LDygZct161SRCEgSUB
         88H5VR4EWWyc/d7l89TXbruRZBnnJDU9bL/IiRJw4XZI8WrGjUVD+VxBzK0dVUwJfx3k
         PpCJWUFXwz3o5MeBSxJUgNunlWgC40xN9zuzRGvrfUlyi4XRfbSvVYepgkMqzijDD8nb
         EmncnrPTcWJ3TYK5tWJMyEPyak5KSKjrwJyF5VP6aEyXDqTCv8Qkd50sfOARjzWkTdv4
         RxMA==
X-Gm-Message-State: AOAM532iTujz7Hw9dtmEy/RgOB8uswqKlLv5be2NA3G69YtJFPBJy2f1
        u5vsGdymhiayG3c5T7iQBT1zyg==
X-Google-Smtp-Source: ABdhPJzK0eXUXL8tWh2AMsh9yF6uTM3mwduo3xzv/HW6pW2L0/NLm/ATUnDCyD8B9ocMQ0h0WLl74g==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr1865231pjb.70.1595641464486;
        Fri, 24 Jul 2020 18:44:24 -0700 (PDT)
Received: from localhost.localdomain (36-239-223-247.dynamic-ip.hinet.net. [36.239.223.247])
        by smtp.gmail.com with ESMTPSA id q22sm7294483pgn.91.2020.07.24.18.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:44:23 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: pca9450: Convert to use module_i2c_driver
Date:   Sat, 25 Jul 2020 09:44:14 +0800
Message-Id: <20200725014414.1825183-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use module_i2c_driver to simplify driver init boilerplate.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/pca9450-regulator.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 02250459aa90..eb5822bf53e0 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -826,17 +826,7 @@ static struct i2c_driver pca9450_i2c_driver = {
 	.probe = pca9450_i2c_probe,
 };
 
-static int __init pca9450_i2c_init(void)
-{
-	return i2c_add_driver(&pca9450_i2c_driver);
-}
-module_init(pca9450_i2c_init);
-
-static void __exit pca9450_i2c_exit(void)
-{
-	i2c_del_driver(&pca9450_i2c_driver);
-}
-module_exit(pca9450_i2c_exit);
+module_i2c_driver(pca9450_i2c_driver);
 
 MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
 MODULE_DESCRIPTION("NXP PCA9450 Power Management IC driver");
-- 
2.25.1

