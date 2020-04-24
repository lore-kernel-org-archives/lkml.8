Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEBC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C509215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEIHT4o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgDXUZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgDXUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9BCC09B04B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so4162420plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrZHw3wDEqsWxtX6I3Qw+OHrqvqS6c3mqgfKBC8xSv8=;
        b=nEIHT4o5k+submU1rUBIRjPzreeeM7YSY4E7V1SEGu5YkKslbOpGjRxk2PVJ0e6xHd
         SXjmkQFR0s76Vs+SIhZbiqdwxsxXClpb114b/0W8uabUhIKFao3OKd1L4nuMX1znjiPe
         qQP7XgxiC4lZLDwECOiQbzUW0fEuqUgbDTn0rw28bGRcuJ7ngPnzqT2ZSGJLoxMn/PxZ
         fffRPF6DxDAFWbgEb6z50zzUw7NNjxuXSWuXCgJJacAYw3fPqEgIUoslVBSEZMjMwBxp
         BI43yLdV4LCUQzNbtcSRkmPWV1eRNty/VNcNXkODiU/gepJb91dnMBcF8aeufnmxkkCX
         lQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrZHw3wDEqsWxtX6I3Qw+OHrqvqS6c3mqgfKBC8xSv8=;
        b=LuaGU3IIW4xZ5GCpnUwXv/7NBjNibQeiq80Vuga380eNjh5MtVnYZT8iEBYAOEibrP
         BygGM2mWFkHUKwQDZ9pgVNden01Jh02XnDpVR88hf48GH+YWvpz407TY+TqyKJC8vShs
         bIwYZNI3NM26ZHhofaMkGunkUfHk1pPBvwSguWt8xajvQrYwTeFpnfNusuRJbUgCisAb
         JS9/yonELUI9CMbV6wGVlBKbZvx1urWemXKH/GALDH6odL329GqfoVSvhfpFDLpMkGWO
         o+nrvf30562wAWXc3vyjZ7yZTQcav7g4ArPTzGwX+tdKb3Yl/PiZ1bI4vgtcTQCga2mb
         jGBA==
X-Gm-Message-State: AGi0PuYoiaa3+mQQy4nKo4vprIzwcmhkx/K4HC6lj6/Bv0eisNPafIh8
        R3xzUGGibMpi1qTjQIrpJCCalg==
X-Google-Smtp-Source: APiQypIckGk/05A/UD8d3TxSQDoWu1T4/CMGlEehpQVQAKrC1wqh0IN3n+KIr7o6Kj7ucki41lXmAQ==
X-Received: by 2002:a17:90a:d703:: with SMTP id y3mr8770619pju.75.1587759911901;
        Fri, 24 Apr 2020 13:25:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] remoteproc: stm32: Remove memory translation from DT parsing
Date:   Fri, 24 Apr 2020 14:24:57 -0600
Message-Id: <20200424202505.29562-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than one has to be done after the other, there is no correlation
between memory translation and DT parsing.  As move function
stm32_rproc_of_memory_translations() to stm32_rproc_probe() so that
stm32_rproc_parse_dt() can be extended to look for synchronisation
related binding in a clean way.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 57a426ea620b..658439d4b00a 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -606,7 +606,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
 
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
 	rproc->auto_boot = auto_boot;
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
-- 
2.20.1

