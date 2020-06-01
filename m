Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C9FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE9D208B6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHad1ZlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgFATBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgFAR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D3C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so255618plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGa03lX7GA8URIieK7PnLLIsoaCKdhXRKV0c6GJ73tI=;
        b=fHad1ZlRXRd6UFFqcnWYGebp/1qiqu6I6YG7lmTYQPfLmvzU3ili028ezh0WLK6pL9
         Soka818wrsXboZC9AvizDk68exysKOKDQ1RcJCPKrE+/0vdSZ/cmiawUXYna4OKrGuv8
         tBBUKyqOoaSXMrxEoXGWa+62ZlZXjm7bGFY5nIm1riaCWiEDMRngQrWDF45EXUCBin4K
         ZyX2u202Adr0pTbCPrmrJOn7CDMj65Tcgy6v/bALMyxvMBhv/9dfcX6yUpJTZ/esArXm
         QzGuovIftcEXt3zk1WrFNj7qPB6ldEVUAqa4wN8mb2ouUlCm02CQW4ojpI7EKCJiXb1S
         fbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGa03lX7GA8URIieK7PnLLIsoaCKdhXRKV0c6GJ73tI=;
        b=RB1DZ2H7uAwpPoU0yiCMbSV7Ip6TX2zLOOHhJYONApDov84fDFgNyjcgPxo4aVbgRZ
         +7wsxZ6X4NAua00EnEzAvhu1wGMgxmV9oZ8KiwVv94Hj7IgI6z1Z6/zoAUWtobhktARZ
         Y4JeZjLtczEDEPnagYqQXn/SmgkVJJaOO7v64WH9v1rOJqmmOfOH87pGz+J3lP7f65oK
         FsY8C09P34mbYVA9Grqaw3vcGumfWaQPYpOBgwOGo/6qNJxnE6BxxvA4Ep36Jro00CtO
         E8OW/0XAwBinkG2hoUSHrtewqpBaleJRgvi7igVKkSRMblfALLhc/RdOKySw4w5zr1bh
         kawQ==
X-Gm-Message-State: AOAM530URJY2pAsHnJN+kFNm8GbNkpfJzoKu8Hvz7ilk1PayB47K5Y83
        mOLCrZMB3ABCwT1gaqQi4ID50g==
X-Google-Smtp-Source: ABdhPJxo+rRAuznsmQHkRYV/lgJKQUgNvxDihegVF54QvvvmZmMN1dJgN7m3M9TYTxlxRQLGujQuYA==
X-Received: by 2002:a17:90a:7787:: with SMTP id v7mr598171pjk.199.1591034164890;
        Mon, 01 Jun 2020 10:56:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:56:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 08/11] remoteproc: stm32: Split function stm32_rproc_parse_fw()
Date:   Mon,  1 Jun 2020 11:55:49 -0600
Message-Id: <20200601175552.22286-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split function stm32_rproc_parse_fw() in two parts, the first one
to parse the memory regions and the second one to load the
resource table.  That way parsing of the memory regions can be
re-used when attaching to the remote processor.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2154c8b90a2a..9316ce3b03c2 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -212,7 +212,7 @@ static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
 	return 0;
 }
 
-static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+static int stm32_rproc_parse_memory_regions(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
 	struct device_node *np = dev->of_node;
@@ -265,6 +265,16 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 		index++;
 	}
 
+	return 0;
+}
+
+static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	int ret = stm32_rproc_parse_memory_regions(rproc);
+
+	if (ret)
+		return ret;
+
 	return stm32_rproc_elf_load_rsc_table(rproc, fw);
 }
 
@@ -692,15 +702,20 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	if (state == M4_STATE_CRUN)
+	if (state == M4_STATE_CRUN) {
 		rproc->state = RPROC_DETACHED;
 
+		ret = stm32_rproc_parse_memory_regions(rproc);
+		if (ret)
+			goto free_resources;
+	}
+
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
 	if (!ddata->workqueue) {
 		dev_err(dev, "cannot create workqueue\n");
 		ret = -ENOMEM;
-		goto free_rproc;
+		goto free_resources;
 	}
 
 	platform_set_drvdata(pdev, rproc);
@@ -719,6 +734,8 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	stm32_rproc_free_mbox(rproc);
 free_wkq:
 	destroy_workqueue(ddata->workqueue);
+free_resources:
+	rproc_resource_cleanup(rproc);
 free_rproc:
 	if (device_may_wakeup(dev)) {
 		dev_pm_clear_wake_irq(dev);
-- 
2.20.1

