Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D01207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="I1PT9sPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgE0Czr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:55:47 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39502 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgE0Czq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:55:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49WwSK36pXz9vFJL
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 02:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r-VwdQaY9lq5 for <linux-kernel@vger.kernel.org>;
        Tue, 26 May 2020 21:55:45 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49WwSK1LvPz9vFHx
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 21:55:45 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49WwSK1LvPz9vFHx
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49WwSK1LvPz9vFHx
Received: by mail-il1-f200.google.com with SMTP id b29so19412671ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dd9TczXeKWbVN5d9i1e4JepiH139Y9rdVzxnRRWNp88=;
        b=I1PT9sPm4WcUrEiIQ1S3ZUiObaUysFl97PlWe/VAhRNCrhzJQYyNP6Hn0V7cnJgFFt
         lsV96KMIvxM54AHjO3cYchqFRc+FKWUXtW/OM1RC1akTgSX7tD/7TkU3W81P7/msPPl/
         nlIxYzM+L8dZIibGy9mPKMpz2UxflLKrBL88CD4TvyNFY/83OKQGL9PJvsc03Ms6QcFz
         +w4T7/sIuDVeyKCUjaquACx5V6x+btMUYqqgecYnuA4tTutQaa+oixCHaLBzpcCrM+DN
         nw42UaBY6C8vSUU1etu/J4ha6ajphVS13rLf0kyDr8t+GWLCdageKidRCvz/MxxgX2Su
         /DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dd9TczXeKWbVN5d9i1e4JepiH139Y9rdVzxnRRWNp88=;
        b=T5y67wTdIK8jegeqo9za0ElYNLLCyKWx1KiLRxANgdTvu712yb1Wg2RkoMjQypv9vK
         yVG9aefcP3i9LW2QEuDRbDas4oiihcfIPmjd/HGeyp0iKYD93HQzuG3gZSPjSW5cI56f
         Iks4t5MNXJVZS7VlJ+7LGm7qw4uKHPFZgq86YA1OgsHMfFmDnHHj/VY2BhWQpzeLu4IY
         x61lQaalKoO+LW4LsHq1cM5Zd3rtziEMOG5fGrAN8yjbbMDkI7E2AD6Pr/Za5fmWjv7c
         fjHbIBp6u+ry7x9tKSwf2DLPFaHOYOTNsx0lIMh/WYOhWfrWNzASI4R2XdIQGsT9M+j+
         UusQ==
X-Gm-Message-State: AOAM5326LJDdy5ljrwM3BN0aiaqqzyrOqOCQ3R4nvSdSvk4mbooc9wGm
        4MY1zVRALipoN5FTgUBVnpaSyPFL2HzNbH+k+ea3Gg7XLFW6bJXnqWjHMKrz5iGfqkQkogu6W6D
        9yNFWnnJum2iGs98uAfWyWGWDgLK8
X-Received: by 2002:a92:58d6:: with SMTP id z83mr3895934ilf.129.1590548144631;
        Tue, 26 May 2020 19:55:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHYUY+uSNCCON7fyGW5rBDCaOJIjvP0uCMCJ/fAmp1UOgXVlUABz74vZTjaLO5+Tbkt+YNig==
X-Received: by 2002:a92:58d6:: with SMTP id z83mr3895912ilf.129.1590548144188;
        Tue, 26 May 2020 19:55:44 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id j17sm882047ilq.79.2020.05.26.19.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 19:55:43 -0700 (PDT)
From:   wu000273@umn.edu
To:     svarbanov@mm-sol.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, helgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH V2] PCI: qcom: Improve exception handling in qcom_pcie_probe().
Date:   Tue, 26 May 2020 21:55:31 -0500
Message-Id: <20200527025531.32357-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

This function contained improvable implementation details according to
exception handling.
1. pm_runtime_put() should be called after pm_runtime_get_sync() failed,
because the reference count will be increased despite of the failure.
Thus add the missed function call.
2. pm_runtime_disable() are called twice, after the call of phy_init() and
dw_pcie_host_init() failed. Thus remove redundant function calls.


Fixes: 6e5da6f7d824 ("PCI: qcom: Fix error handling in runtime PM support")
Co-developed-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 V2: words adjustments and fix some typos 
 drivers/pci/controller/dwc/pcie-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 138e1a2d21cc..10393ab607bf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1340,8 +1340,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		pm_runtime_disable(dev);
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
 	pci->dev = dev;
@@ -1401,7 +1400,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = phy_init(pcie->phy);
 	if (ret) {
-		pm_runtime_disable(&pdev->dev);
 		goto err_pm_runtime_put;
 	}
 
@@ -1410,7 +1408,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		pm_runtime_disable(&pdev->dev);
 		goto err_pm_runtime_put;
 	}
 
-- 
2.17.1

