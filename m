Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BAC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D06F20738
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH+QpIys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgIEUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgIEUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:42:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65008C061251;
        Sat,  5 Sep 2020 13:42:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n25so874135ljj.4;
        Sat, 05 Sep 2020 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypldeaZCI+lVDyJ1TAp37EOXECCvTrJEiX4igKe1ykw=;
        b=QH+QpIyscIeZTHooBjaJfExfnHpiSmdsbws1/DCbZGPMav01u6Dptx4d1wUasOKca5
         VtyhcgR5dTwUezXkBdrgVduEiD56ju4nIUSdDFERYG8KT7a7zsKzf2qmmHTzUqbrlfXu
         SK57asEUzEcbj6UVg/BlCqz0FA3DyDquioNMWUyIxHpHbNgkPwItMcAm5Rtzdqu9ruue
         kaLrBrW0R+tNIfqb5dVIzaS5jLzVF6DalG+liEYiDmSbpl7uCSJCti9zbrovzq6l10JP
         LfYH5WycQxwrW7OIthry3vDNXE8qvdc9kxKeJ/ThY8xgW0yEg0XIO/3Oio/gMc3/wzkj
         THIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypldeaZCI+lVDyJ1TAp37EOXECCvTrJEiX4igKe1ykw=;
        b=LZzlIlT8A9FRJ4rHe+qqDOiNu1pt2V624ZJpx9Tv7bx69sjNVKOdaxC/eVSylkGdPv
         bXfpUt2B5R/zYGj87ciXaGIa9cedHxuGcJarkx68Cn0Fk27QALENx02ZyVRp+tYH8VMk
         3cQUadgjmVKg7htPYgIW9gcihen1Irbd48JEUS9roIeTwaig5psuvK/GrM2G0D0WDBKE
         7J5gtCnNxroNf/bG96HX2+ct1gbOeWBG9Sa1aan9mOPz1h80S0sOe1ZWcJUYZg7BKYv2
         5hk6GTI1f/0MQTiNERImHWmLURxJSbO62q8mlOivpOw7xLxONxikiaDvdLdFMkvyiMlu
         mb7Q==
X-Gm-Message-State: AOAM530QqiVboSmPFIz9j9+f4K0ef0HUMfpGKBcd3yET2/KDJfTFQBjs
        NlopgpcBoJG2xzCRKVhKHS1eakGyTPg=
X-Google-Smtp-Source: ABdhPJzNGfYVWpSD8YcJS2AfeXwx42jtBqEyt+WVvD1nvEX7XBJkk8b0ik9qbmvODW/V0gWsjiAa+A==
X-Received: by 2002:a2e:8896:: with SMTP id k22mr6186586lji.298.1599338553143;
        Sat, 05 Sep 2020 13:42:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id e17sm1677763ljn.18.2020.09.05.13.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 13:42:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/31] i2c: tegra: Use platform_get_irq()
Date:   Sat,  5 Sep 2020 23:41:29 +0300
Message-Id: <20200905204151.25343-10-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200905204151.25343-1-digetx@gmail.com>
References: <20200905204151.25343-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for retrieval of the interrupt number in order to make
code cleaner. Note that platform_get_irq() prints error message by itself.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index abcfb53d649c..f1c4334faed3 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1672,12 +1672,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 
 	base_phys = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no irq resource\n");
-		return -EINVAL;
-	}
-	irq = res->start;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	div_clk = devm_clk_get(&pdev->dev, "div-clk");
 	if (IS_ERR(div_clk)) {
-- 
2.27.0

