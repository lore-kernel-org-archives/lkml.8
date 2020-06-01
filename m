Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC19DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD3F2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEjCzgdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgFATBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgFAR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF6C08C5CA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so233203pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWgUrN+UJxeOnEn8O9BSntxA58isuMWyp3M6ttChdiM=;
        b=jEjCzgdu5MsL5KccNh8vxCzKIljzLYVxhF3CBPDDYzqJeFnwEgyE8ZgD0pRMbJAhkG
         JDFcly9sdSc6Jmt3XMaBExC/AbuJ4wqIMhj+/Vywvdp2RGTqWD7BXg+NhFODVOe2vDS7
         G5RTS985vDgtn5vBmfAqKzRnMZRbNI0p6JBtZnbhnvLKdelLH3H8kDXIyjtwYCu7Wccc
         uViDjvO9CCj9SHisEwviLNpAowii6v9jDA27zw/pqj39NxoPRW16fmxdmTezuDFagk0o
         R++/uvxlwxMGzUjBApiUUQ34SB129LvaYp9iVl0PwBhb5wbUwyAUYofiiomx3kLMqLnN
         JE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWgUrN+UJxeOnEn8O9BSntxA58isuMWyp3M6ttChdiM=;
        b=PMTJBsx2Qhf+IIGOu9PMwsXAbJ7lblxFi0YYjrB98mr1V90sN6/yFJ4kHolpQcHz5s
         kqu5NEuK2yb8OLEXvY8+ecXpXKAsV2JUN78m6Y5gTxsPMSEQAAEDHmGbxtJyvZTCmnEC
         G68HXgrulbrCPim1vkEUAadtugzyGD2hC2q1vVWJtd707JSYwcatL2Gk9GOiIJSzcCMX
         wRdqXWVE22OAYxUgq4UpIThynhHYR3RKHfKnV6OU/ISfBl2YzkpFavyIWZqfj+/4I2Wv
         jAifu57l6rcv3FKOezAw5XAv6keEa8qa3VmAZfVadXR2iQYIiL+6D6lkqttCrt/nqqDy
         Yw+A==
X-Gm-Message-State: AOAM530qK/3+NKjNdu5+S9OMtBeqQHIRWS+FOyR9sDT01iiPX5quzbOc
        mk57IqUyfRuER9Gr49zm3Kv1Kg==
X-Google-Smtp-Source: ABdhPJz6Uzgkggx9J2O27bgymb95HzErcAQMVBeWDG+YypocdNA0Y4UMUYMBvXdoeRv4M7+EppSTbg==
X-Received: by 2002:a17:90a:a515:: with SMTP id a21mr628227pjq.158.1591034166120;
        Mon, 01 Jun 2020 10:56:06 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:56:05 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 09/11] remoteproc: stm32: Properly handle the resource table when attaching
Date:   Mon,  1 Jun 2020 11:55:50 -0600
Message-Id: <20200601175552.22286-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
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
 drivers/remoteproc/stm32_rproc.c | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 9316ce3b03c2..7c8789164af7 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -38,6 +38,8 @@
 #define STM32_MBX_VQ1_ID	1
 #define STM32_MBX_SHUTDOWN	"shutdown"
 
+#define RSC_TBL_SIZE		1024
+
 #define M4_STATE_OFF		0
 #define M4_STATE_INI		1
 #define M4_STATE_CRUN		2
@@ -85,6 +87,7 @@ struct stm32_rproc {
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
 	bool secured_soc;
+	void __iomem *rsc_va;
 };
 
 static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
@@ -668,6 +671,74 @@ static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
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
 
 static int stm32_rproc_probe(struct platform_device *pdev)
 {
@@ -708,6 +779,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
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
2.20.1

