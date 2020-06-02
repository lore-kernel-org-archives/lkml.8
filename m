Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0997C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D6F20659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA7MWJLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFBEzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgFBEzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:55:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F7C061A0E;
        Mon,  1 Jun 2020 21:55:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d5so9447472ios.9;
        Mon, 01 Jun 2020 21:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tR3pb9zLW9qW76HoUBY9/GySYeS2bQ9hX+MbLbDoBAQ=;
        b=AA7MWJLU4Q+ZY2dvzZ2vnKSuHcGmn8CyWqkfEsfk5TVkN9hrl61R3cKhJNeRAC90WR
         1zU4/A3kH3OdEwc+Mp9ZIEAFgu5w5LJjC5PEgOgH+qpvA4EDc5X17QmuLeyh4QRMCpQd
         f/QCfeIhSkWfHTEIkkUUe4QMAHtt6swqMwuAIs9/20cpMxf11YfHtZw+BnpymBb7XuYN
         sqMC0uVvVtlH4m+lI8PiXWI0SKRjOmRdfprTCQh/dve/B0hWm4AbPuPyRuix6pE3MQ6g
         UmxR2jnecDFNqLoTji1RTa0DfJgoug3H7aujneTjtR4pf8zgdX6UaybOFOyuUt9BkgfQ
         e9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tR3pb9zLW9qW76HoUBY9/GySYeS2bQ9hX+MbLbDoBAQ=;
        b=HrvsdbA5qAaq8FjN1Ru17n/lpiiRkZOKp1ac27oUFMt8DIJHrQkJCx5hH3xUvGDL0G
         KEXqWo7yuqF26riaAmrtc4CaTEy1wRgwUVmg/ysSvGegXJq/egtTFPBkwvs/MUzYJp6T
         YW8RBjoaB1CBEl4bifBJbFcNFDEa5pWqeG/Hr+3gAqF3LJQ2ipUeJjZE3Aic9knAkH0Z
         uyK0EnV1LeTMSfQSLSjLrGkDc74krFIw8yikyVonnxft692SDp1Klk48b6A0mufCo3pM
         7BR+tuw1Mll94OtbtDgC8c3SwY07eY8xm3coCB3uuHRYXhK+40db3ZE+SKPt6zMF2whZ
         kvVw==
X-Gm-Message-State: AOAM533YtfT3iSjVBlUmUEVyVuHYDK6nrmuojMZb3rToutNQCjkY2jwY
        2qxUDfzdgrAXQDMv+4aKuPM=
X-Google-Smtp-Source: ABdhPJyH5YLy5kRSaAizKTlmWLJsJqTBQw36lHMl8PS29xk/DcvXZ/AZJ+JkpWIOacJHPa8SQ9JY4g==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr21963611iob.103.1591073715272;
        Mon, 01 Jun 2020 21:55:15 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id 4sm869758ilc.34.2020.06.01.21.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:55:14 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: tegra114: missing put on pm_runtime_get_sync failure
Date:   Mon,  1 Jun 2020 23:55:06 -0500
Message-Id: <20200602045506.40574-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the call to pm_runtime_get_sync increments the counter even 
in case of failure leading to incorrect ref count.
Call pm_runtime_put if pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-tegra114.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 83edabdb41ad..dccd2ac1a975 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -974,6 +974,7 @@ static int tegra_spi_setup(struct spi_device *spi)
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
 		if (cdata)
 			tegra_spi_cleanup(spi);
+		pm_runtime_put(tspi->dev);
 		return ret;
 	}
 
@@ -1398,6 +1399,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
+		pm_runtime_put(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
@@ -1479,6 +1481,7 @@ static int tegra_spi_resume(struct device *dev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(dev);
 		return ret;
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
-- 
2.17.1

