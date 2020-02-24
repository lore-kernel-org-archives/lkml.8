Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF26C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C461C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJZgCePM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXCIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:08:20 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52923 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXCIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:08:20 -0500
Received: by mail-pg1-f201.google.com with SMTP id h21so5673435pgl.19
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TTWq2HAMIWzKgBL7Xe45vNa7b1DEMoXXBFSs7M828Vo=;
        b=kJZgCePMmoxwA2xDEAPwUZmHtat6929L1+S4W8sNm4SjPsz1lNFd5rhvU8L0yzXAP4
         rcE6/ANzHRN09BnKZ9+yl1v5Ku5Ihl8A5hZbFNQVCoxh+iX5Y4vDOxxl7C3y0ifWWGME
         AVgAOmvnqo68lf+lsCTX64xV8O+AvAKhDjxAL/msdLzlmpNdY6HK8y+OvqgWKL6qdKkR
         8YoVFcIkWHgF2nltRXaDDfOzN4wAaD4It2dEXMPIGxUuQ/CK/RKWtQ9FIsCBSAcgLCuO
         yzpHLAWXUwxyFSCa3jOj+4rYUCFJT+H7nKnOoe/v2D1tLLPcn3nJuTq0QEKzvQCy2JBb
         O5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TTWq2HAMIWzKgBL7Xe45vNa7b1DEMoXXBFSs7M828Vo=;
        b=EUHzwIJG9WwzqIjDSEBwBDdlHwnSDKnNKJpd3R8TlIaLl3GDlRZINTXipt4dVU+g2e
         1ZAOJQWcHWf0pvuIdvvdGBUxccMITcu1YGAwGtX9ETz2xMMTzkbS4AWEcZQdli18B0Cd
         l9e+YIka5y+BYdGIlR1w50LcZbxl2tloNg82CwkDyGiJvhFx4wc7rBILp/D1y9lRX7i/
         HJUOUmCVYky0ZRlogopy3OKMfl8dWIk3QUcYS6kWkMzvb2pnhKOYoKQlOsJ65ic5E/o5
         uabDxNtco/BsgzY24LBPP9066NWpL5uInV8J9HxUrXx0WZVXUAF2vG+H/h4Idk9GK6R4
         582g==
X-Gm-Message-State: APjAAAX6Hc8sFPhQayEyoKe6S3TQGKYIA4vMq5cBEtrtcpjtU/JEaBQ4
        fwTGzNr1oIgaarnYJTBfaHwronqwFIoMEMoIFne3B5mUSXMAt9qolICEVvT8J0+5lPx9KqhsmaA
        tTcqOiu6CCjRzdsvVneVuBo1oVDkPL8LL5o9AgSI/2yuQZuIyZxuE41zIvWe7HIXuMYWMPQ==
X-Google-Smtp-Source: APXvYqy3+lHEJgJYcJNPNBHbt3vzQS08gQtp0v+NV+Un3Tbvyi8fw9vGD/+7qqprOjXR7zGnFnF9cUYziBY=
X-Received: by 2002:a63:3407:: with SMTP id b7mr23534176pga.163.1582510097904;
 Sun, 23 Feb 2020 18:08:17 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:08:13 -0800
Message-Id: <20200224020815.139570-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 1/3] libnvdimm/of_pmem: factor out region registration
From:   Alistair Delva <adelva@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kenny Root <kroot@google.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, devicetree@vger.kernel.org,
        linux-nvdimm@lists.01.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenny Root <kroot@google.com>

From: Kenny Root <kroot@google.com>

Factor out region registration for 'reg' node. A follow-up change will
use of_pmem_register_region() to handle memory-region nodes too.

Signed-off-by: Kenny Root <kroot@google.com>
Signed-off-by: Alistair Delva <adelva@google.com>
Reviewed-by: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: devicetree@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: kernel-team@android.com
---
 drivers/nvdimm/of_pmem.c | 60 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 8224d1431ea9..fdf54494e8c9 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -14,6 +14,39 @@ struct of_pmem_private {
 	struct nvdimm_bus *bus;
 };
 
+static void of_pmem_register_region(struct platform_device *pdev,
+				    struct nvdimm_bus *bus,
+				    struct device_node *np,
+				    struct resource *res, bool is_volatile)
+{
+	struct nd_region_desc ndr_desc;
+	struct nd_region *region;
+
+	/*
+	 * NB: libnvdimm copies the data from ndr_desc into it's own
+	 * structures so passing a stack pointer is fine.
+	 */
+	memset(&ndr_desc, 0, sizeof(ndr_desc));
+	ndr_desc.numa_node = dev_to_node(&pdev->dev);
+	ndr_desc.target_node = ndr_desc.numa_node;
+	ndr_desc.res = res;
+	ndr_desc.of_node = np;
+	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
+
+	if (is_volatile)
+		region = nvdimm_volatile_region_create(bus, &ndr_desc);
+	else
+		region = nvdimm_pmem_region_create(bus, &ndr_desc);
+
+	if (!region)
+		dev_warn(&pdev->dev,
+			 "Unable to register region %pR from %pOF\n",
+			 ndr_desc.res, np);
+	else
+		dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
+			ndr_desc.res, np);
+}
+
 static int of_pmem_region_probe(struct platform_device *pdev)
 {
 	struct of_pmem_private *priv;
@@ -46,31 +79,8 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 			is_volatile ? "volatile" : "non-volatile",  np);
 
 	for (i = 0; i < pdev->num_resources; i++) {
-		struct nd_region_desc ndr_desc;
-		struct nd_region *region;
-
-		/*
-		 * NB: libnvdimm copies the data from ndr_desc into it's own
-		 * structures so passing a stack pointer is fine.
-		 */
-		memset(&ndr_desc, 0, sizeof(ndr_desc));
-		ndr_desc.numa_node = dev_to_node(&pdev->dev);
-		ndr_desc.target_node = ndr_desc.numa_node;
-		ndr_desc.res = &pdev->resource[i];
-		ndr_desc.of_node = np;
-		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
-
-		if (is_volatile)
-			region = nvdimm_volatile_region_create(bus, &ndr_desc);
-		else
-			region = nvdimm_pmem_region_create(bus, &ndr_desc);
-
-		if (!region)
-			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-					ndr_desc.res, np);
-		else
-			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
-					ndr_desc.res, np);
+		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
+					is_volatile);
 	}
 
 	return 0;
-- 
2.25.0.265.gbab2e86ba0-goog

