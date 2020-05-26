Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC840C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 02:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5B1207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 02:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QrkWi+59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgEZCiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 22:38:46 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43642 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgEZCip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 22:38:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49WJ781Wnxz9vKfL
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vB8eo0316ofv for <linux-kernel@vger.kernel.org>;
        Mon, 25 May 2020 21:38:44 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49WJ776vRHz9vK1q
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 21:38:43 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49WJ776vRHz9vK1q
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49WJ776vRHz9vK1q
Received: by mail-io1-f72.google.com with SMTP id b30so2642211ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T2pyZeWX2xec+ABdMSwYqLtzMRs3/3YjO1fw5oaVquU=;
        b=QrkWi+59wzuuP/esokdUKbXtJZTN1ik3pHrfAJIkMVshbZGSE1sx38s6j2J10klopp
         uBSwcdBVUFJ8WUhzv9aCl3BLWo9s3Ipr4ForP9F3PsMURdRbHQcztqiPOnAoydBCoh2n
         Zn9AoBvWL8M5A0Tgg1thLFT5Kfq6TVJhSw9i2NGNCIsggZ5GIu+8ZtR9BbXCdbScob/V
         1UY+QVUtuJbGM7lS929r9xyYBzD5zPjVzbRHRxxvxh8htzlm86KHw9S5PR/NzEVoMQ03
         i9zOoEHadZfe92uyr7JTC/CAh9rg7VKxP3yLXww1rfCmuH6O0Mf+dmHxXKnJLULBQWmM
         6S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2pyZeWX2xec+ABdMSwYqLtzMRs3/3YjO1fw5oaVquU=;
        b=AVeDMYkHLAu7WQkFwtL6GPeE0VfhF/vjMyNVNpHCDbAUKi5Uo2CCSqiQjtM+Gbplou
         8XKuf9LmQXnKNIqRsd3PqgBeC79fq05HnWh4ykRaBFIFR/Z0yhNZpWSweusZFQJ1KCVG
         /Td5Csgs0uAz+rNh+D/Sw8SgoEudBkAnOHq9zutTVhAkfjOjwbErzQUsXWHztUzCYs7s
         NiCtA1R/QYLE1SjJUS9xdsF580+Lg39bH53B6I6Bg7qmVi+A71mVxUPz1Ox5EDkRUdW5
         VICEDC105ffv3a6ApCPCeBG0FrVdyRcffY2GmGhOrMkCLxESWwNN0paH9qJ1UZeNB57R
         8UJQ==
X-Gm-Message-State: AOAM533v3s726AEWqv40FU/fBBj1pc13ge30njTduP65u9A24Fxh9S5X
        ZHKKbDjCkvQf4U7VT+6jmoK5c+jdx7/vAsQoUyTQlCNnMQOHYEudC24H9KboJmIfz/4xmpvW46g
        lxJajvbSdpNgXhO3sq/tW9M8+5xgy
X-Received: by 2002:a92:d2ca:: with SMTP id w10mr27598005ilg.141.1590460723485;
        Mon, 25 May 2020 19:38:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxUlisi2OBDfGcYZPt6a3J73pAP0NhbInGJihnQnLZHFBPNyxHuTnFkRnboV3hBIBHQBy0Zg==
X-Received: by 2002:a92:d2ca:: with SMTP id w10mr27597982ilg.141.1590460723159;
        Mon, 25 May 2020 19:38:43 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id f10sm10058337ilj.85.2020.05.25.19.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 19:38:42 -0700 (PDT)
From:   wu000273@umn.edu
To:     svarbanov@mm-sol.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, helgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] PCI: qcom: fix several error-hanlding problem.
Date:   Mon, 25 May 2020 21:38:35 -0500
Message-Id: <20200526023835.5468-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function qcom_pcie_probe(), there are several error-handling problem.
1. pm_runtime_put() should be called after pm_runtime_get_sync() failed,
because refcount will be increased even pm_runtime_get_sync() returns 
an error.
2. pm_runtime_disable() are called twice, after the call of phy_init() and
dw_pcie_host_init() failed.
Fix these problem by pm_runtime_put() after the call of call 
pm_runtime_get_sync() failed. Also removing the redundant 
pm_runtime_disable().

Fixes: 6e5da6f7d824 ("PCI: qcom: Fix error handling in runtime PM support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
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

