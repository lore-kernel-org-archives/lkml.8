Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B51C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20C0212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0Qfzvcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgGNUE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbgGNUEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:04:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5CEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so8036404pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lt6hUGBu1W7gsJ62+tKE3hemun/1WgbhEsuA1Og1vF8=;
        b=z0QfzvcuY8UXpEMaWd0eYrnoexDsWkEkaUr1ko+xuaYhkXow4CV0zu9U/tVxsgMzHs
         rKsB25o67wL+CYAXzhh4j3OVlTXaOLqZkOq9NTO5k+usChXYc+AbA/4RkSbHU2vAGcvs
         1DsudTiGZpMlrZEeBILbFSqa3dLVSgBmmNODhRtdVRBd7JbbslLNwqSFfeWBGo6cal+2
         cNfnYjH1BLLYZhF3xezF9OheQvF5XQ5qAMJeaSpqDKRxsdWu0Dmc3OO6zr/JmObUovLp
         bRzbavVxlWZjhj57NoeSjNZXMt35fPeaGU1dQc7ny++7Pk2mriTJU4id633LLAAMkS5i
         Q5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lt6hUGBu1W7gsJ62+tKE3hemun/1WgbhEsuA1Og1vF8=;
        b=C4x4aA230lxoaIZV+IfEr7VGrnlGjJP7N6aRA/2eyUKTF6birSaXpTJrKX7+Y10YMT
         +NHNzKjAUxeBvVDaTpIk0sks2lC/WDAu71DJ5Ifb5OT3thy+ALH6RPq3JSCioKqw9UPW
         SyFDkXbkLORgBPrjzJeFV8sqQnDPEpeaj2lXbplhfJvqE4cV7r7FG4pJS4E2Pwj97OFr
         ygAGYwwIcD2AAREce8tKkckK6+boFjlvPjCSlNVwkt3YjGB7BqTM2i4dI5A3EVqXgd3t
         GAn26pBoVgTVqzU4fBSiK/u1dSi1fIvPIXTIbaJYFloOyrxTWwjkBk/df5K6SmHuxiWW
         LxvQ==
X-Gm-Message-State: AOAM5335BnpDMHmBAr1bx8PA8Wo3Mgah2sURBkoij+Qu8biFzNzk98lH
        tDx8mRb3SQr+aj1D5eQvytEvSQ==
X-Google-Smtp-Source: ABdhPJxH9fMPN5yqVrmNyyec1zYwr6oRXO3bFA8YxRV7pwXlyeYQPOCDIeVUy0MXXSNm8FzbruPlsA==
X-Received: by 2002:a63:3ece:: with SMTP id l197mr4751414pga.313.1594757093193;
        Tue, 14 Jul 2020 13:04:53 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:04:52 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 04/11] remoteproc: stm32: Remove memory translation from DT parsing
Date:   Tue, 14 Jul 2020 14:04:38 -0600
Message-Id: <20200714200445.1427257-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than one has to be done after the other, there is no correlation
between memory translation and DT parsing.  As such move function
stm32_rproc_of_memory_translations() to stm32_rproc_probe() so that
stm32_rproc_parse_dt() can be extended to look for attach bindings
in a clean way.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index cbba995a80a2..986f34a336a7 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -607,7 +607,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 
 	*auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-	return stm32_rproc_of_memory_translations(pdev, ddata);
+	return 0;
 }
 
 static int stm32_rproc_probe(struct platform_device *pdev)
@@ -634,6 +634,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = stm32_rproc_of_memory_translations(pdev, ddata);
+	if (ret)
+		goto free_rproc;
+
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
 	if (!ddata->workqueue) {
-- 
2.25.1

