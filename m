Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1832071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0A5itPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgH1IuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1IuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:50:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8020EC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:50:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l7so527322wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+3tnyknHgCWcY+CXnIQZy7jgmgvddABFfrqih1RlpU=;
        b=B0A5itPXeBN+0z06C4i2qeDYBj1zPxUlWoFeoxX1tf3yAAQFC08TX+JL7pAgAVOs+B
         n6Xw5DzvcljhL5InIo/s9qwM0SzHzK/Mfm0sSbs7ZoxjsGQVsuU4gjoCGJA2jihEo5Pn
         iwjupedOv8SeVYmoK85WjcskP7S+1+kT0M34omP7TcFVZBdky8umspDDeoJy/xUtQXD/
         6NvTcgs1crdHKt5uFbhzBi5a/KcOFYJ3+RiW8MenX83ZOtVZLbFThm/0IskQHzgeR++g
         NoZH0ZlDqLFlLVMivvVUrUlgV2vvXAJryOlrpCS4ndfRDbddoBcK+VedpsNZ3eQ0/ZRc
         4cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+3tnyknHgCWcY+CXnIQZy7jgmgvddABFfrqih1RlpU=;
        b=VEQ4q4szD2sPPgG5s/2hkwyF0Ug9yGu7DtiP64RnYXnip4PJHYM9Ou3FinKuLWH9Mp
         EKx9g0+9zab1RcUcXIbN25iKzqP9TpaBciB5r5IaElMahcXUx7+xD6mhGXqdUCTtofDi
         Ea9MdjC6xd1ooSE4JkQYwKEaQLZLW+267rB2pIaqAPuCw987AVMagMqTBY3PKe+OviLZ
         5IOor/kRs3qMPNhwYbBMdn5Fh0e8WNrT5vT+XMloOgYG+E4JVpGkGKehuKBvXZy9Ynm8
         fSBDBlVvWQNOdt0M2shRk3G+k7X7x9Unag0umF2quDhz7Wog2EJciBjtWvZ3ySkX/CJB
         4xPA==
X-Gm-Message-State: AOAM532AFYu2SNsqYPxWh0DmB3Gi++iOhah0L+5bzJP3G/gf4+q3W3De
        wyvSLWOM8j0Onq96uZjIxafosA==
X-Google-Smtp-Source: ABdhPJxKpuq5ifj5pswrU/neYc8lZDZhx4Q5BSNYHUmcMo/znm+G6K0NN0tMvVvhrGWR+/xW740azw==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr509062wrn.249.1598604616677;
        Fri, 28 Aug 2020 01:50:16 -0700 (PDT)
Received: from dell.default ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id a85sm1111057wmd.26.2020.08.28.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 01:50:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] mfd: khadas-mcu: Fix randconfig 'unused-const-variable' warning
Date:   Fri, 28 Aug 2020 09:50:07 +0100
Message-Id: <20200828085007.2008096-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing with !OF, the build system reports:

>> drivers/mfd/khadas-mcu.c:125:34: warning: unused variable 'khadas_mcu_of_match' [-Wunused-const-variable]
   static const struct of_device_id khadas_mcu_of_match[] = {
                                    ^

Cc: Neil Armstrong <narmstrong@baylibre.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/khadas-mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index 44d5bb462daba..f3d418810693c 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -122,11 +122,13 @@ static int khadas_mcu_probe(struct i2c_client *client,
 	return 0;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id khadas_mcu_of_match[] = {
 	{ .compatible = "khadas,mcu", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
+#endif
 
 static struct i2c_driver khadas_mcu_driver = {
 	.driver = {
-- 
2.25.1

