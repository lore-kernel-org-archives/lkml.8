Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09377C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46962080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9S6Gl/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgHZLyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgHZLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:50:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:50:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so862583pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tryfDmsq8J+S8CIysHu14Sy9xIe8k9L5z/SAmRPWEvQ=;
        b=K9S6Gl/yPJf+4iRIOJURLX0jZIfzzKuoLqIWdhAwGNvRwUtT7rlO+a91+tpquF6m63
         TqKnKg0EmKJmU1iAU7ZRvzgTJhWy5MlAsKJ727GsNY7I3yeh4calb536VT5LQUKuKsME
         LJJerq2jwlelEqub3qvFIjfL7M8AcQEzhnOO0AwvM544Bqgbb3NVL9X3X0UWBJFGalye
         BGqrpBUU8y4ua1rv9gYqbfNfuXkc7qKOQol/C1JpQl02XwFgq6XBF52SrkhA8aHoi4Yv
         iTUGdM5pYqeVBft3p0T+exfAUm5tzMi0oDDaH+NWRLAdUTcUYp4O8ycUnR62H6rUFx0r
         +kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tryfDmsq8J+S8CIysHu14Sy9xIe8k9L5z/SAmRPWEvQ=;
        b=I/565qnLq8pEXiTdd/RsEKK2kDpXE5GIQ0ZJu+P3bWTAx/E2z0RO02Qr9w1rLN1vOp
         cXV2RDqlt9Z9z86BhWZsbsw0mGCzMYCEiXPVD448RFemph00ClTmDrxSwvG1vRLSsImM
         chCxoE70h9F5fwIYh4HCAXxvxRcZznB7VRpS4g70G03KqkVP+a2CQMCUtRgi5bu3TOz5
         WiQuw8Qx8I4bAvJEtCNF//T7VoxTyf8MRWKRsiaWMe04PE5x7lGQsruRwXij/vSbkFfa
         BPSgFuJ8RPYLB32g4QnWmOSjwBcOc+GMH7TVTFaxOg2mDkXcnCa6pix+TJd7+RjYY5l0
         3TvA==
X-Gm-Message-State: AOAM532Bzp4fl0tsC/mxNqxn6+hYcSLtFonENNpg3f1GbPmYWsSYqDfx
        VXSBraPRtBjStPfhD8LtfgnXbg==
X-Google-Smtp-Source: ABdhPJztcwN8EHa6UOwG0fvOLxS69d/buMurM5WYvvacPyKM+b6A2zg2wIyMpy1yWByrjeHDs6epGA==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr9999244pgp.341.1598442646550;
        Wed, 26 Aug 2020 04:50:46 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id c8sm2632593pfc.203.2020.08.26.04.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:50:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] opp: Allow opp-supported-hw to contain multiple versions
Date:   Wed, 26 Aug 2020 17:20:29 +0530
Message-Id: <c4d59ad206394e4f73ab7547c6cd99d95c032128.1598442485.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598442485.git.viresh.kumar@linaro.org>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings allow multiple versions to be passed to "opp-supported-hw"
property, either of which can result in enabling of the OPP.

Update code to allow that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e39ddcc779af..5dac8bffd68c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -434,9 +434,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_icc_paths);
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
-	unsigned int count = opp_table->supported_hw_count;
-	u32 version;
-	int ret;
+	unsigned int levels = opp_table->supported_hw_count;
+	int count, versions, ret, i, j;
+	u32 val;
 
 	if (!opp_table->supported_hw) {
 		/*
@@ -451,21 +451,40 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			return true;
 	}
 
-	while (count--) {
-		ret = of_property_read_u32_index(np, "opp-supported-hw", count,
-						 &version);
-		if (ret) {
-			dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
-				 __func__, count, ret);
-			return false;
+	count = of_property_count_u32_elems(np, "opp-supported-hw");
+	if (count <= 0 || count % levels) {
+		dev_err(dev, "%s: Invalid opp-supported-hw property (%d)\n",
+			__func__, count);
+		return false;
+	}
+
+	versions = count / levels;
+
+	/* All levels in at least one of the versions should match */
+	for (i = 0; i < versions; i++) {
+		bool supported = true;
+
+		for (j = 0; j < levels; j++) {
+			ret = of_property_read_u32_index(np, "opp-supported-hw",
+							 i * levels + j, &val);
+			if (ret) {
+				dev_warn(dev, "%s: failed to read opp-supported-hw property at index %d: %d\n",
+					 __func__, i * levels + j, ret);
+				return false;
+			}
+
+			/* Check if the level is supported */
+			if (!(val & opp_table->supported_hw[j])) {
+				supported = false;
+				break;
+			}
 		}
 
-		/* Both of these are bitwise masks of the versions */
-		if (!(version & opp_table->supported_hw[count]))
-			return false;
+		if (supported)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
-- 
2.25.0.rc1.19.g042ed3e048af

