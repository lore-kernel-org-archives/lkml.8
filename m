Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51374C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247EF206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHiXmus/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBXCIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:08:23 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52464 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgBXCIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:08:21 -0500
Received: by mail-pf1-f201.google.com with SMTP id v26so5648895pfn.19
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e5neKRQE0Ylu70uQVNqG6CPXmoPxHODfaRvH7F2C0Pw=;
        b=YHiXmus/EnjFAU6PeaWn5LwpzUc7PCFQI/d8yZl9grAa0B/xUi4r5vcOTDITCKIMoW
         makG0khPu6K/gEZosHvwYEmmd5qMT4sL+7dMkWgIbSHv/wa0qLv74DkUKsqsYKrbEmFq
         cz+79KiVOwo1hux6wHBTXNldhNPIpnpM0JKH8Hbaz7ocFT6PA43kqynKv4cGs9BnsHRT
         3KjHFvgTMpihahJNCJ4GKPSuHch2mMMIGfseexNT7auHTeecCgYy6TSRwVT0jr0rUP13
         8HcCPaDMPQPjZWzW/E6ZqvaP2GHWTPhtfMdx/01vxbjrzu9CsFbz6zPZr/Mps6xv0QQc
         x+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e5neKRQE0Ylu70uQVNqG6CPXmoPxHODfaRvH7F2C0Pw=;
        b=TRtQzcW2HXq4d5ECud8nsY/MZao7cbqg1+sgQZYMLvVLDR2l4KKFv/i1J/waNuE1sD
         RkLw8pimuxLPrhoSu02Fg1CfbqmevE278ADg3C9hU+eZ3hesqWzVwkmCyZUpT6QZq1iR
         OY+XjZ9khCNec9bemIvLGgcQ9JVh0JU/zXAu6t/5QAKaWnLJVt8+GU+4Rr1rq+vZRBru
         6Q5TtUHxCT5/s4oU6qpaEhd5S3um07upifWZOCBdY2DNdG+3AqZOVGD+xaZOHi4EomcS
         rKk28U8nEicTAulGSZzpM8F8nWh0jKvVlziKOrOj5kvWmQFptZM/JK7fxn6pnCdM7Llo
         HVpA==
X-Gm-Message-State: APjAAAXSOEy9wj1XloHycRGSHXBZ5EgUZTWsEnurqlbNhguH3w1zzGAv
        Is7ni19L5aGjl1kwEQ376jpv7qNww6FYk46UqKtAKVyvRlbPZree8nc+cwUvLo36AEQB3KZhffn
        qruP1oBQ2lINdcqVixgY9F0DrNc+VC6ZrP6yX5hjDboCwklIJbSC2dpNd8zzRgaxz4F3cvw==
X-Google-Smtp-Source: APXvYqxYYdZX9abJhfwReiJ8C0V/zBLnRqxvKYMmDdPec8/r7k35sA3GrzCBR2B2f8BSFH0cnrJqWNBQpbc=
X-Received: by 2002:a63:8b41:: with SMTP id j62mr2267520pge.18.1582510100578;
 Sun, 23 Feb 2020 18:08:20 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:08:14 -0800
In-Reply-To: <20200224020815.139570-1-adelva@google.com>
Message-Id: <20200224020815.139570-2-adelva@google.com>
Mime-Version: 1.0
References: <20200224020815.139570-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 2/3] libnvdimm/of_pmem: handle memory-region in DT
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

Add support for parsing the 'memory-region' DT property in addition to
the 'reg' DT property. This enables use cases where the pmem region is
not in I/O address space or dedicated memory (e.g. a bootloader
carveout).

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
 drivers/nvdimm/of_pmem.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index fdf54494e8c9..cff47cc5fc4a 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -49,11 +49,12 @@ static void of_pmem_register_region(struct platform_device *pdev,
 
 static int of_pmem_region_probe(struct platform_device *pdev)
 {
+	struct device_node *mr_np, *np;
 	struct of_pmem_private *priv;
-	struct device_node *np;
 	struct nvdimm_bus *bus;
+	struct resource res;
 	bool is_volatile;
-	int i;
+	int i, ret;
 
 	np = dev_of_node(&pdev->dev);
 	if (!np)
@@ -83,6 +84,21 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 					is_volatile);
 	}
 
+	i = 0;
+	while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
+		ret = of_address_to_resource(mr_np, 0, &res);
+		if (ret) {
+			dev_warn(
+				&pdev->dev,
+				"Unable to acquire memory-region from %pOF: %d\n",
+				mr_np, ret);
+		} else {
+			of_pmem_register_region(pdev, bus, np, &res,
+						is_volatile);
+		}
+		of_node_put(mr_np);
+	}
+
 	return 0;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

