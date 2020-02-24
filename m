Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8514C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB62067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEZCOSfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBXCKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:10:36 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54596 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBXCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:10:34 -0500
Received: by mail-pl1-f201.google.com with SMTP id v16so4272478ply.21
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 18:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U9x1EVLhqUbvxZ1MWzxoNmpwHOpemfs+Xxa6i1IJDww=;
        b=OEZCOSfqHyCH0n82I//mUildBSBEUUWtDcYiq5Oo5rR6qwCUGmKPZzbMBisxmcQAbs
         TwUoh4G1YcGAerITwUuZ71yplkGbaMvFWpjDhsl44azfyp7P/KC4RBOS12hgxQY8jm8M
         ldIXaMtQFvHvaRURHKQJFJiIDj0VeJ4hObpDLPxHCrY4fTUWKMlQ2GNmcvZ8TYBqHV9C
         VILHHGsrHmqLJFAja4WXRD36IvuFwZ9qn2f1/Ybes/BbOLiEuQ7gbF3HMSYDNIZzN2Wl
         0+OLRiZL+3uLGxhSCLaFIvMWKj4va4dyktRr9Xz0/bsQkUhkikLjtVzf/ATL1C/LX4K+
         hhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U9x1EVLhqUbvxZ1MWzxoNmpwHOpemfs+Xxa6i1IJDww=;
        b=Zwt+Y0D4Wsbts30R928mGN+XE4IhNAoHSkYFlAXTVmaR2j1p27AgtH0dIBAbtAH9zB
         Fhg1kAQp3jpMWbuLuL9DEtjD0AYAAGl/QX0v96xl7pBEaL2TATaqaR5eWnhpCWWbzBcA
         JLI5hOoQS6voSWRYrk3i9+9bQS1hubfaj3Q4L41iEdI4kg05LVx453xLskhCiECKnWpx
         SqkR1X+WkHL+Phsq/Li3Srjnc7xpe1EsLjBLiYkK04YSEryoVJulHilaAAKCdbkB2qhL
         i/U+aagkrInRc6JqtI3CAKPsyXL/7R+txd6mxqMPAwwcOh9KK079cZV5RD9YTMvqAHnK
         2BJg==
X-Gm-Message-State: APjAAAV7Jv9D1ZwUrtO9VXaPGbVDMWnYtj6Ace0eCEZdbYYFdEYejeaq
        eAGmUk3CaV8PYsb1fbJMZBrhlWmc2UjZOldKJ57tmqDLgkTD+7E6DSeJhqZFWLcu+C34z2TcuLB
        IIoftQCJq7bPwvVJNSGv/9KlOXmU1wDabVsLttJwl0tJyodCURmxR7daNJy8DJYZR5zLhKA==
X-Google-Smtp-Source: APXvYqyTwjxCwbxReORBQcuv6XOeQhdEylhMml37cUwzX0Kd3xXx05FTdjuoUaIZYSsoX4pIMCxjPJwMRp0=
X-Received: by 2002:a63:2e42:: with SMTP id u63mr49471649pgu.137.1582510233602;
 Sun, 23 Feb 2020 18:10:33 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:10:28 -0800
In-Reply-To: <20200224021029.142701-1-adelva@google.com>
Message-Id: <20200224021029.142701-2-adelva@google.com>
Mime-Version: 1.0
References: <20200224021029.142701-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 2/3] libnvdimm/of_pmem: handle memory-region in DT
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

