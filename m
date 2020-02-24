Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D15C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF3D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewQZZzHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBXCKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:10:32 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37438 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBXCKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:10:32 -0500
Received: by mail-pf1-f202.google.com with SMTP id x10so5665286pfn.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 18:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xXnVPSTtq6JKEca5i5uwLN/shdFSGa9fDblOik0nzOE=;
        b=ewQZZzHbAIm9IaVDu9F0bc2esO1BNMP2dV5Rp45y8mFa8Z0HBz43i3HohNjPmgKnZF
         iGvAM0Z71h7ZTE66msAdaRCfRpaOSuKti3gKQcx16Iza8AaubCFm30jx7F0Y8VJdz56P
         p5JifXyJlkxxvdhB0WTwuFfXVQ90hE8ZMGORE/RZCHHPnqei3atfgwfHGcNA3I1FZ18h
         0Iuvr5oHofTsZzrJmhJipc5xrmilXc5ctdxC6HQ5QgYDVHvMWu4d5abZXY/KvQjNxha7
         Hkur+YO1PRIZeqbJcGRVm8AwuZFnIei1lXZgQF++GRM57usyRdsHLq5QnO0h2KmhgnQA
         RitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xXnVPSTtq6JKEca5i5uwLN/shdFSGa9fDblOik0nzOE=;
        b=cP4a0idI9lHLHPs9565NAMisNPp1GkkW8mSg1JdsnLRwomZIr3Asow+DfwaOWOaTD9
         1//DX2fOfWpxvObaE1N5StTqsZXym1qm+Dpri869FmZOjJgPyyDlD+pHmomZOOKjQq0L
         FTsN7Ligh96MvjPK1HW4yGFNgoQMrEF0upY83vQf2lye802SNq2toC3E2da7tzae4dib
         XLXEOrJLmHXaToqWlCxHDT9eMB7+s4f9nv9qCCk1HwnPXHvEJL7rVEz5/bGq4AVQpZBK
         Dg7cD7dFaCKuo0RfiwJm8loGWaAb5Z6XLPSFKXyqLJ8h+99yb+ufRzvGaJC1+ZhhBw7J
         84Gg==
X-Gm-Message-State: APjAAAUcqGN4gyFVpoQN5lZvYjxMhRTwrBbzgoMxpuT1NcQgZnvbNAVv
        BcjESh+iIWm6+ovJzKeuUivb/PmqRsMc6F60d3l1vPoIIwOZH0nToH8ydh3KON9kRzbE2o2OJ8G
        6niS0FocLuoggYM+tiIu9kwnMjAYxReIObM6dAtHKPR/hREAbpdEMpnnltwoC+ByPXf6sxw==
X-Google-Smtp-Source: APXvYqzh7LWx5FHfbXoqvdMOKLDRvpI9RTMgE9OYFl93HPIxPAzkWl5IGjaOk/mtBxp40jqIQkZIat3Is54=
X-Received: by 2002:a63:8743:: with SMTP id i64mr49147206pge.243.1582510231389;
 Sun, 23 Feb 2020 18:10:31 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:10:27 -0800
Message-Id: <20200224021029.142701-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 1/3] libnvdimm/of_pmem: factor out region registration
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
[v3: adelva: remove duplicate "From:"]
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

