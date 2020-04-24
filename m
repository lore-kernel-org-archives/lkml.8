Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD0C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D21214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBYjk7oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgDXUZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgDXUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E3C09B04D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so4343708pjw.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8pkHvjPLwA96bIGz2NSSF7mXbbhD0VV71pWPGube4rE=;
        b=bBYjk7oGchLHLu2fhyb+5w8E3eMQmDXLajYwnSEoNKZRaYmkH0vi8FbFTDbUvVRsr8
         1kQ/9bmhSE9nEd0h8GciZnigyFT77H7YY3aEtLzrHHMfMG/paQO+0fWET24ArhZqHg3c
         vqdwlGoPskGInUqnaGxRnd2S8rBW6Fmj3W7VsY8JPtJkKnY/T5nKIfI7iR74vB69yuvV
         LmlaLQ8SiaFPpCkXS+0veavIxJ+YUQQsis25rSSvRTKWi/soBPN2Bdaf8IYVJ0TNJuqM
         zs5BXVrG20QdavJxkRWBiRJ0w9dkN4jxu1vN6mAggY6wBIiWECeO1jFR6r+iMr8S6B1k
         HarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pkHvjPLwA96bIGz2NSSF7mXbbhD0VV71pWPGube4rE=;
        b=KOVqYh+ptuNUuptNhl2njOAgxHxHf9BF2SG/2RH6bb1CuJyVNTAEmxjr173eoNeDFP
         0zPKygdEf2CidI1dlwdz42evGUQBAv3LP5G2PnNqTBzHrLh/2BWJBw1W10+ta4NNC5fq
         0o4nYh7LwTB0OZQB39QAZTXeiyRc/tGdPiGGnnNgCLHglfZPBvtzpMV8p/dN8HVaPtNk
         APraKsPOFtKbbwHAXASnMCwfVlt4mn/ecG99PZAXRcZYVAYDQuuivXrIzRfQYbhA77c2
         mApa0/HrtkLGKJU/CcpNIqfeDHyQNHZlcXiXJlKrLBZmVlKI84RIfjwPvDhQPqbFV0wA
         E9rA==
X-Gm-Message-State: AGi0PuarLIwxl8ZzpgCNXEGoFp6BEo5lFafUaO1cyL37Ff+oQtOu3X4C
        7oAwBqRwNpnoqpCmlDmCYsoqhw==
X-Google-Smtp-Source: APiQypI45S+tU5qGacvuJcZRdZ1Rko8UnR0Z/uIU3/5Gk8Rmx2uzncC3GiqshF8IMa1UpBS4OILd+Q==
X-Received: by 2002:a17:90a:101:: with SMTP id b1mr8385987pjb.154.1587759913129;
        Fri, 24 Apr 2020 13:25:13 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:12 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] remoteproc: stm32: Parse syscon that will manage M4 synchronisation
Date:   Fri, 24 Apr 2020 14:24:58 -0600
Message-Id: <20200424202505.29562-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
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
---
 drivers/remoteproc/stm32_rproc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 658439d4b00a..a285f338bed8 100644
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

