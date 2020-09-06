Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9F5C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63742080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 18:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejEGc7Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIFS46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgIFSvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 14:51:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD171C061795;
        Sun,  6 Sep 2020 11:51:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so7171964ljp.13;
        Sun, 06 Sep 2020 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCu9HVRGhyFEmtcQWW/qcOwFZ8quoNlG5Ub55FZw3fI=;
        b=ejEGc7HkiXVHkyQDM90Er6stn6zQWIZhWppwKCjcSAXdPqpTiqplnbUvY6IsRGhaS+
         MB57AHdZPQOTqCY9C40kn+5+hXwnAZ6kWppXAG4cV7oVj3EI8OZlrJTzMsGsueYWjvqg
         4hJMiujk8dpyEbrXF61vDNLf0rTz0PiToBs33y2oEp4vD6XldYqUyF5XLuB8hzdKdvhO
         XafjU+BPyjkJxttf0E3waXJFhNBBQ+rO4ZpovbNIoOqMBftmkrXYUaHUonoPxYNkQATW
         BBn22AU3SK8nK5FMvTC4ReyMWoiZvwAOcsiZjlrX4+YjVRxrYnKdcWYy3kMIrIGWyL9h
         bvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCu9HVRGhyFEmtcQWW/qcOwFZ8quoNlG5Ub55FZw3fI=;
        b=qvO3HHYU51g5nugTxoV90TQg463X2//dZp3+2byaW01twX/Mq3dw+RPsiXghqJ0YDs
         WvejOQnl9kQap/48+hi29fzovFpehAXwzDnIU1qtY/QQQ/lfdPEx6aWxK47+H3yWxVNt
         jfFedroUYPrLjJlAn0yEZ0b1pkPjEBT+4NlIxFjIHpbDodTMIbxNIfrhQmLn/QvqyG+M
         yA4oq7Jmvj2HIIRc1T2jvzPk6cjoqaXILOg0vR2CGVs343P0poXUdTb9od/cVAWfEq+Z
         SxDDpKPYfp5ARSgy+vX8HK68wrJtzle1xpucGaVA1NJJNDWbC5z6Yh48tGJ5pVXlZm4E
         s8KA==
X-Gm-Message-State: AOAM532O5nPlgy85Pbg8+PtrhKafC8BwZwK/+WmAG6z1DIfCwhfdSzuO
        kMSpZbrsz/GYOqg56Vg9OOdKPKVyKow=
X-Google-Smtp-Source: ABdhPJzTt0KMyvsusNWUnDcfHx8UfnOAJqlkjJTpww4W91oy3QqEPlkmqP+YWtZrBopjpPpSt+ilgg==
X-Received: by 2002:a05:651c:2c9:: with SMTP id f9mr8332922ljo.257.1599418307102;
        Sun, 06 Sep 2020 11:51:47 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id s3sm4883407ljd.44.2020.09.06.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 11:51:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/36] i2c: tegra: Use devm_platform_get_and_ioremap_resource()
Date:   Sun,  6 Sep 2020 21:50:12 +0300
Message-Id: <20200906185039.22700-10-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200906185039.22700-1-digetx@gmail.com>
References: <20200906185039.22700-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver now uses devm_platform_get_and_ioremap_resource() which replaces
the typical boilerplate code and makes code cleaner.

Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 52e15ec246b3..2cfc96bdd9e0 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1668,12 +1668,12 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_phys = res->start;
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	base_phys = res->start;
+
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no irq resource\n");
-- 
2.27.0

