Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40B6C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922E6212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLGHaDr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgGNUFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgGNUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8277C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so7481998plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YiyO8YAURPMKhdCUUf90yIifUk9z/vNRci8et/i7Y4=;
        b=fLGHaDr7EGhI0ARXCJ6FH15LxIgXWZnfSIc3WnGgMWJwl028i6hQ3LB6bvS56g26XA
         FcY/0tJaJ2tdTNk0oIaThlXdzziyQdbHs/AcjMxu+6RWhHMyANZePUH2rjyLY3R387EX
         GM4lXJzKgt6Znm+vKyzm6vLGFf1bA0WKqSTBpW2U2HP/xBXPpPZFQqY1R2yZLq6S1tN8
         e+Yj5vYAnjzyKxHIpLd+Fzw9F4HKOzBe0o+f1C4vC7JyPXtdzTWYMq3r8G9ld+zNVrSr
         qDVhLGSJQ1S7mHOGXl0s519r/zc2k+lLYCsMHO2S9WoxpouX6TnAQFmU0dF2jq1o30Ey
         dM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YiyO8YAURPMKhdCUUf90yIifUk9z/vNRci8et/i7Y4=;
        b=BC3CZdXjEONUoNoKPe8lT7Kn3sIYRHWTAR2WhPHy6U3Mh3hQx04xReVSkhcK12G/uC
         fcLiBxnq2Y90ETUtZ3NSaXvhhye0PwkDfOYkwvzuVXnEGHsW7BktEnRxaBfIAnOArML1
         q5FD6Zdc6Dm77p+2tIwsu/ZegJLEWyn0ce4FJi6fr90jt7GilYwGDYBnIDCviQKVo9/1
         aPr/EJg9wfefCuSQG9kvZGgXP/Bx7qKAuCxoj+9eZ8o9t4rNzGPcfysE8PhwGn9SJB/n
         +uUyyquPdgh3e+y4dGYZ77YgXXr4oVC+K2Q3DL/x8tXHPLxk/o6MxeVxX1qvOYnns6h1
         q6aA==
X-Gm-Message-State: AOAM530vZGVp5OCHCiFabYCKktkEqdYvEawWIy2LBD4n1hXxVZCTaUxb
        gIh98bT9ZxUl93Uj2i9joStCRA==
X-Google-Smtp-Source: ABdhPJxCgxZL477MT/4ssjdsMbb7uSFgaJyv5Am639vvkRN66dzOSJdYNppKZ+oP/EXpPWLRvPwvfQ==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr6489416pjy.189.1594757099351;
        Tue, 14 Jul 2020 13:04:59 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:58 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 09/11] remoteproc: stm32: Properly handle the resource table when attaching
Date:   Tue, 14 Jul 2020 14:04:43 -0600
Message-Id: <20200714200445.1427257-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly set the remote processor's resource table based on where it was
loaded by the external entity when attaching to a remote processor.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2a1cccd8d311..882229f3b1c9 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -39,6 +39,8 @@
 #define STM32_MBX_VQ1_ID	1
 #define STM32_MBX_SHUTDOWN	"shutdown"
 
+#define RSC_TBL_SIZE		1024
+
 #define M4_STATE_OFF		0
 #define M4_STATE_INI		1
 #define M4_STATE_CRUN		2
@@ -86,6 +88,7 @@ struct stm32_rproc {
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
 	bool secured_soc;
+	void __iomem *rsc_va;
 };
 
 static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
@@ -669,6 +672,75 @@ static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
 	return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
 }
 
+static int stm32_rproc_da_to_pa(struct platform_device *pdev,
+				struct stm32_rproc *ddata,
+				u64 da, phys_addr_t *pa)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_rproc_mem *p_mem;
+	unsigned int i;
+
+	for (i = 0; i < ddata->nb_rmems; i++) {
+		p_mem = &ddata->rmems[i];
+
+		if (da < p_mem->dev_addr ||
+		    da >= p_mem->dev_addr + p_mem->size)
+			continue;
+
+		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
+		dev_dbg(dev, "da %llx to pa %#x\n", da, *pa);
+
+		return 0;
+	}
+
+	dev_err(dev, "can't translate da %llx\n", da);
+
+	return -EINVAL;
+}
+
+static int stm32_rproc_get_loaded_rsc_table(struct platform_device *pdev,
+					    struct rproc *rproc,
+					    struct stm32_rproc *ddata)
+{
+	struct device *dev = &pdev->dev;
+	phys_addr_t rsc_pa;
+	u32 rsc_da;
+	int err;
+
+	err = regmap_read(ddata->rsctbl.map, ddata->rsctbl.reg, &rsc_da);
+	if (err) {
+		dev_err(dev, "failed to read rsc tbl addr\n");
+		return err;
+	}
+
+	if (!rsc_da)
+		/* no rsc table */
+		return 0;
+
+	err = stm32_rproc_da_to_pa(pdev, ddata, rsc_da, &rsc_pa);
+	if (err)
+		return err;
+
+	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
+	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+			&rsc_pa, RSC_TBL_SIZE);
+		ddata->rsc_va = NULL;
+		return -ENOMEM;
+	}
+
+	/*
+	 * The resource table is already loaded in device memory, no need
+	 * to work with a cached table.
+	 */
+	rproc->cached_table = NULL;
+	/* Assuming the resource table fits in 1kB is fair */
+	rproc->table_sz = RSC_TBL_SIZE;
+	rproc->table_ptr = (struct resource_table *)ddata->rsc_va;
+
+	return 0;
+}
+
 static int stm32_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -708,6 +780,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		ret = stm32_rproc_parse_memory_regions(rproc);
 		if (ret)
 			goto free_resources;
+
+		ret = stm32_rproc_get_loaded_rsc_table(pdev, rproc, ddata);
+		if (ret)
+			goto free_resources;
 	}
 
 	rproc->has_iommu = false;
-- 
2.25.1

