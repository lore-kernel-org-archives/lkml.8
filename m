Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D71C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3156206E2
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbOWC4VR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBVSaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:30:16 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:47194 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:30:16 -0500
Received: by mail-qv1-f73.google.com with SMTP id dr18so3643314qvb.14
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1SCGFJcdT57UM9g569dFzCXIAoXI2cL9T0Egcs4At5A=;
        b=rbOWC4VRcR9Ei8+SP5+fapjsG7JlPOKlvg+6qkAOKcy6S/PxZg8y9o8/iIVVyJzQkW
         9ip7Q7kYYyXMXXXHv88LopTajfUnbdYyt5OkA+tLHFSAE90ujIrBQjaMBXPPp3jSfvC/
         DVzVECbEepl/OuWA/FGV1dp5oEP9g6coMxU0VY7VWgdnJigkNDeJpwObPa47iOzjo3at
         qMKV56vuAatorqaL/0c60rV+QnIljtSwi795S+MLa3Y7gsohW1qCnzUjKct0OM33VHCm
         PxSouKW+/VhINbMOOj1hyCHu3RxI4zYU7SmlVsv+iSMtdW/a8qWiRR6aBgUJXOg8kr/B
         yTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1SCGFJcdT57UM9g569dFzCXIAoXI2cL9T0Egcs4At5A=;
        b=shq+PfOOp6QT/+BQ5SftBNltnQipfRnWYJ8/dO3sqMpnWLlSzQ0BOS2/TQ3m99reXR
         hU4MgVpWa0uA8PPEg+fo9GyJjpwXz5DtaV7T+gZBDaEhcu1L7dhNdGN9ZeR/zE3+jxTN
         qNNNns5cXM2Jpo0u/q3VjYm8gWSvSGcs+Pv5ogSLVgRCi94+WOEgTd8/250ahMId8uDi
         aE1wWaNoAKi1cGLtXCcMCJRanjFvP9vAx8fbO2PnG1IjHcEA8WzxRARNYshzlYqFmyj0
         DUHMiKLOTVurMWGmQWf2XvOiuhRoN7AqNiKK/ySYbJ8GmqsxW1v0uMRNJNFrcYvnd7Ag
         gdmg==
X-Gm-Message-State: APjAAAWBiNFRdqUzy2s4UAPUZhn2RAuiiclHmx+N4GCy6e6NzDLpKqoj
        tTf9reIQ5UC59dRObjE8FF+As4/m1mQf3U5Qvh+KMsxpBjquncIbDBzQMYEYnajlWRcS+CZk0FZ
        7xANzc7+1qu0P0X7QIPA2M2tyuBMtKa4pQ7+2RjxG6NgXLY5KFnCYfU1lado/lsVkN8u3Ag==
X-Google-Smtp-Source: APXvYqyI0nbEkK8t5PqjH2XUeMtXnlvIm2qcZEUezASmjw62vNPGTkH8/bD15V7Jh7dUFdFSRS3DMwUqrcY=
X-Received: by 2002:ac8:835:: with SMTP id u50mr38957444qth.15.1582396213599;
 Sat, 22 Feb 2020 10:30:13 -0800 (PST)
Date:   Sat, 22 Feb 2020 10:30:09 -0800
Message-Id: <20200222183010.197844-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
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

Add support for parsing the 'memory-region' DT property in addition to
the 'reg' DT property. This enables use cases where the pmem region is
not in I/O address space or dedicated memory (e.g. a bootloader
carveout).

Signed-off-by: Kenny Root <kroot@google.com>
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: devicetree@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: kernel-team@android.com
---
 drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 8224d1431ea9..a68e44fb0041 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -14,13 +14,47 @@ struct of_pmem_private {
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
-	struct device_node *np;
+	struct device_node *mrp, *np;
 	struct nvdimm_bus *bus;
+	struct resource res;
 	bool is_volatile;
-	int i;
+	int i, ret;
 
 	np = dev_of_node(&pdev->dev);
 	if (!np)
@@ -46,31 +80,22 @@ static int of_pmem_region_probe(struct platform_device *pdev)
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
+		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
+					is_volatile);
+	}
 
-		if (!region)
-			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-					ndr_desc.res, np);
+	i = 0;
+	while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
+		ret = of_address_to_resource(mr_np, 0, &res);
+		if (ret)
+			dev_warn(
+				&pdev->dev,
+				"Unable to acquire memory-region from %pOF: %d\n",
+				mr_np, ret);
 		else
-			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
-					ndr_desc.res, np);
+			of_pmem_register_region(pdev, bus, np, &res,
+						is_volatile);
+		of_node_put(mr_np);
 	}
 
 	return 0;
-- 
2.25.0.265.gbab2e86ba0-goog

