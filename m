Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91303C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E931206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtAO3vqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgELMyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730015AbgELMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:54:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB1BC05BD10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so21614712wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvKbAOWfl/knTZNX27VnXfewubIaPbz+/XetIklYZ7g=;
        b=CtAO3vqc/5ciyMQoZsCfVYtGsZMc+eGRSXx8OOoeAcTbEVI4XVBa71bqTsRSIHZ0gK
         cIoZxWJLoMHxPgfW90arxdJ8OlAjwSTl9umY/OPCe30eJ/bW7vTcQkNceICuv313oULW
         TOGrpVNZ9fr3FpbebaRAGuhnQhXb7jCQv3QOwonNO2kt4Ps1rNkm//Xwdg34qLqRAsiw
         ZF0XfOyfRoK6lhpW+QCop6SAla1XYxNLOWCXFpFzGfqvQkIGLdm42P0TaQuoqZBRveos
         tJhRidy4xOS3ok+vXCq8VghzXgIU1qoCXK7qMumPAlU/3O+ElEbAbTKGV5pfpG4mgQ0B
         137Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvKbAOWfl/knTZNX27VnXfewubIaPbz+/XetIklYZ7g=;
        b=eDRtFmFR/kMNMIG8ZAbKyqMCpf8wlCSgEe/mI+QzjdlvakimZAzolLBvTY70r9INMH
         hGs88orJp6dwgDOT0H5qp3jJe3A5grUKqFBubtUqhausQ484xrMYRnctQPDXYAktDhMY
         GH/c/KceE8BZcR7d5++DOc7L9TGx1vN9Ynx7KDmmD/aWIY5quYim1mPN0Lczs9QgUtWK
         bw9DhU8svSsvQ7PcEPcNeeq7pF58f8sVmCuloHYU4DO+8yWSerUR+C6HI3iTVb4Sf0aq
         6O8xXDzaJkPB4GqoES8stF2LVx1K+NS8l6BBuDwDrIM1LeEme4mFTvn7Wlt1T2Y7YGxV
         22Ig==
X-Gm-Message-State: AOAM5309DB0D6oHQ5bnvDcIcONsj9dpKtgSHFl3EfMb2vshbbMOKsF28
        pgI7q+Ok3CfsdlmaT5e8eEC+sg==
X-Google-Smtp-Source: ABdhPJwY/a0cn3q6lCGX60mZA2InAaE/IzVG1DBnCICgZqVoe54tj6ukY4c547zEb5HQfe3aDNwFYA==
X-Received: by 2002:a1c:444:: with SMTP id 65mr351423wme.21.1589288054568;
        Tue, 12 May 2020 05:54:14 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 10/10] OPP: Add support for setting interconnect-tags
Date:   Tue, 12 May 2020 15:53:27 +0300
Message-Id: <20200512125327.1868-11-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Add support for setting tags on icc paths associated with
the opp_table.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* New patch, picked from here:
  https://lore.kernel.org/r/20200504202243.5476-11-sibis@codeaurora.org

 drivers/opp/of.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 3a64f2aa0f86..fd148d54022f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -336,6 +336,7 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 {
 	struct device_node *np;
 	int ret, i, count, num_paths;
+	u32 tag;
 
 	np = of_node_get(dev->of_node);
 	if (!np)
@@ -344,20 +345,25 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 	count = of_count_phandle_with_args(np, "interconnects",
 					   "#interconnect-cells");
 	of_node_put(np);
-	if (count < 0)
-		return 0;
+	if (count < 0) {
+		ret = 0;
+		goto put_np;
+	}
 
 	/* two phandles when #interconnect-cells = <1> */
 	if (count % 2) {
 		dev_err(dev, "%s: Invalid interconnects values\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_np;
 	}
 
 	num_paths = count / 2;
 	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
 				   GFP_KERNEL);
-	if (!opp_table->paths)
-		return -ENOMEM;
+	if (!opp_table->paths) {
+		ret = -ENOMEM;
+		goto put_np;
+	}
 
 	for (i = 0; i < num_paths; i++) {
 		opp_table->paths[i] = of_icc_get_by_index(dev, i);
@@ -369,8 +375,14 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 			}
 			goto err;
 		}
+
+		/* Set tag if present */
+		if (!of_property_read_u32_index(np, "interconnect-tags",
+						i, &tag))
+			icc_set_tag(opp_table->paths[i], tag);
 	}
 	opp_table->path_count = num_paths;
+	of_node_put(np);
 
 	return 0;
 
@@ -380,6 +392,8 @@ int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
 
 	kfree(opp_table->paths);
 	opp_table->paths = NULL;
+put_np:
+	of_node_put(np);
 
 	return ret;
 }
