Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CFC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BB9212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEqF6kjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgGNUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbgGNUEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256EEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so2430684pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+L0m/PbK8aAeOqWVeHEDiQMGUfIG8Y+7XMpTLF4upOo=;
        b=fEqF6kjWaxyZ1+V6TLHGALcgaDHO2s0ImXDRbJ6RX49FUiFX4NFc8v43GgWpaG2iFP
         EybqTnvGA7yDFIiC9BslvB0x1/lNnsOobFSwHSSpUzFT4Aa0Sgca493T3eEiH3WB69Ne
         xeLBljIAiwcnfwuEkeYR2BMQUX6HmahveCHhwtYcvNX2/WdiEdLdWSxWV9OodN4U4faC
         B/vwHhGNAHpacYPnCtJIyNqL7jhYpqFo3Y0LPsPvv/Ar2hbmfPYvHO2auCL0MIsf9ZgU
         B3PuJ2XLPFv0uOq1FAmcIoxCuehtSz3GQgV26G44YrBR4w54dwF6pbSepAQODw+GZkt1
         fzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+L0m/PbK8aAeOqWVeHEDiQMGUfIG8Y+7XMpTLF4upOo=;
        b=jSS68+2NE+GQIY0fvyWOnZ8c4nLtlAJ9h1/q7hw08+w2nXMnrmFU/rPorSeBLfwHBD
         S5TXsuaxlttOfnldpmIC4JxgzTQpIncKvo6/z4gkfW6sOpqPcsFtp0QokQaO1A61TNH6
         PAun7ethHfbdxq13c6p8tIay7n3aB5GniUHFBEUNt3tnNAeDhIx6CxoHcFmo+ugTrkRJ
         dN78aJEFNOh7tGPaerA8ya419xqK2LlhuxeMiD83EisD9tUNQvPEncEMpWxDLRGQNcDF
         MF2jDAcQpeIQEwjzx1fehwN1wTJNTmeVpCOXCr4PfJSwOK1J5z9OrVYfCM6dBUBSxZiI
         n67Q==
X-Gm-Message-State: AOAM532X1iIh6rNU98X/8GthkK2fq/wkteaOXEEHMkhEvV4WX5NZbS7g
        sU47seDlf+IhxsMP/hmCZs3OYw==
X-Google-Smtp-Source: ABdhPJxDBYL2W6Bl/6d0RgZHksPUhWpH+arn9L3GFnp4gCNsyD59y54jBwv5KQqmOWLLokMZqH1W1Q==
X-Received: by 2002:a65:6799:: with SMTP id e25mr4902524pgr.364.1594757091659;
        Tue, 14 Jul 2020 13:04:51 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:51 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 03/11] remoteproc: stm32: Decouple rproc from DT parsing
Date:   Tue, 14 Jul 2020 14:04:37 -0600
Message-Id: <20200714200445.1427257-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the remote processor from the process of parsing the device tree
since (1) there is no correlation between them and (2) to use the
information that was gathered to make a decision on whether to
synchronise with the M4 or not.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index c00f60d42ab6..cbba995a80a2 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -539,12 +539,11 @@ static int stm32_rproc_get_syscon(struct device_node *np, const char *prop,
 	return err;
 }
 
-static int stm32_rproc_parse_dt(struct platform_device *pdev)
+static int stm32_rproc_parse_dt(struct platform_device *pdev,
+				struct stm32_rproc *ddata, bool *auto_boot)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct rproc *rproc = platform_get_drvdata(pdev);
-	struct stm32_rproc *ddata = rproc->priv;
 	struct stm32_syscon tz;
 	unsigned int tzen;
 	int err, irq;
@@ -590,7 +589,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	err = regmap_read(tz.map, tz.reg, &tzen);
 	if (err) {
-		dev_err(&rproc->dev, "failed to read tzen\n");
+		dev_err(dev, "failed to read tzen\n");
 		return err;
 	}
 	ddata->secured_soc = tzen & tz.mask;
@@ -606,7 +605,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 	if (err)
 		dev_info(dev, "failed to get pdds\n");
 
-	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
+	*auto_boot = of_property_read_bool(np, "st,auto-boot");
 
 	return stm32_rproc_of_memory_translations(pdev, ddata);
 }
@@ -627,9 +626,15 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (!rproc)
 		return -ENOMEM;
 
+	ddata = rproc->priv;
+
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
+
+	ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
+	if (ret)
+		goto free_rproc;
+
 	rproc->has_iommu = false;
-	ddata = rproc->priv;
 	ddata->workqueue = create_workqueue(dev_name(dev));
 	if (!ddata->workqueue) {
 		dev_err(dev, "cannot create workqueue\n");
@@ -639,13 +644,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rproc);
 
-	ret = stm32_rproc_parse_dt(pdev);
-	if (ret)
-		goto free_wkq;
-
 	ret = stm32_rproc_request_mbox(rproc);
 	if (ret)
-		goto free_rproc;
+		goto free_wkq;
 
 	ret = rproc_add(rproc);
 	if (ret)
-- 
2.25.1

