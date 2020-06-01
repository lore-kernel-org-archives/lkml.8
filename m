Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4C1207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvQCaQ6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgFAR4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgFAR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74ABC08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so242558pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViPzLIdY6S5F9ukM8AO/hVR30UuoYhcnMI2Jw2fXDro=;
        b=nvQCaQ6BDkTVt4N68rp3+7sk/OjINYsb1pnrOSFmRo/gwHwW1MLtNPDYyIYmMUN7va
         pAGWbWmDdudAr+B1HdFaXSDQy9VeZAFeSH/E6a92sqnzHfG9lfLVzh8eNYil7KOpas5V
         MsifJkeC4UtOyw3PTK8mW0nPUHppgrAmoEx+Irz0tFmiA4rqGRLq25pCeBMzo0dpob2+
         lAQGp4nwcRTEAsxGWAJgDmyysDFPYpDEOwin8u5jplAGUwE8IctWxAvV8Tsa6MlJrBQS
         9QRaD9k42fv/ghRMP4rXysqNHgx+j0SuDNtEhzUPdJSE/gtORupjQvx/D7d6/k1FR8ZZ
         6Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViPzLIdY6S5F9ukM8AO/hVR30UuoYhcnMI2Jw2fXDro=;
        b=M0Pa6TyT1/dKmXOgG/JwvoE+h7qUDcpIbnnFcrTZ9Cq3GuvkZByggXcSrYvds9cUC+
         3RnEZvbPZCHO6y0K1G1hkgRXhsjOAASNjJpeOeVZlevCzwF+RIDssgwZNa4Y9+kkhgmU
         rvuxhi2Vg1GRxEBdGh3uOEavQW409WT6U4oXFW4ml0iT03szvRN+gyBePtSke3NNFbTz
         w7GNxOTJWPM5rmFhgYgzkSP2FjWuUfAISvFo0agKNy6jeYJL7uOBKFpwo+LuOBMerP5C
         xfIYVqFFdl2sR5NrZxwpg8K9C8qJGDdusYRuXV7jRTXo+NwPCe5nKTSFAUlnHohfyfpM
         j4yw==
X-Gm-Message-State: AOAM530HMJEWUAN5Xc/oBVwxSCHbfbDiIqXjIVREyR3rPd9gSL7r87oy
        Vb8r4mUOSsHcU1IgJf484ZHDtA==
X-Google-Smtp-Source: ABdhPJynMxDT0cCzVhHBOevuGK2TcnLJIdmLB+om4mji64XigRKmYH5t1RVhWndkJJsbNUj/fxZJrQ==
X-Received: by 2002:a17:90b:705:: with SMTP id s5mr580608pjz.147.1591034161245;
        Mon, 01 Jun 2020 10:56:01 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:56:00 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 05/11] remoteproc: stm32: Parse syscon that will manage M4 synchronisation
Date:   Mon,  1 Jun 2020 11:55:46 -0600
Message-Id: <20200601175552.22286-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get from the DT the syncon to probe the state of the remote processor
and the location of the resource table.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 3e3b199a02c1..80fd8fd831da 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -70,6 +70,8 @@ struct stm32_rproc {
 	struct reset_control *rst;
 	struct stm32_syscon hold_boot;
 	struct stm32_syscon pdds;
+	struct stm32_syscon m4_state;
+	struct stm32_syscon rsctbl;
 	int wdg_irq;
 	u32 nb_rmems;
 	struct stm32_rproc_mem *rmems;
@@ -606,6 +608,30 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 
 	*auto_boot = of_property_read_bool(np, "st,auto-boot");
 
+	/*
+	 * See if we can check the M4 status, i.e if it was started
+	 * from the boot loader or not.
+	 */
+	err = stm32_rproc_get_syscon(np, "st,syscfg-m4-state",
+				     &ddata->m4_state);
+	if (err) {
+		/* remember this */
+		ddata->m4_state.map = NULL;
+		/* no coprocessor state syscon (optional) */
+		dev_warn(dev, "m4 state not supported\n");
+
+		/* no need to go further */
+		return 0;
+	}
+
+	/* See if we can get the resource table */
+	err = stm32_rproc_get_syscon(np, "st,syscfg-rsc-tbl",
+				     &ddata->rsctbl);
+	if (err) {
+		/* no rsc table syscon (optional) */
+		dev_warn(dev, "rsc tbl syscon not supported\n");
+	}
+
 	return 0;
 }
 
-- 
2.20.1

