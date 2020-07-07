Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ED2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828CB20775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcnXdAvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgGGVbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgGGVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:31:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44907C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:31:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so17260114plq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/h+lVOr/RBj1CX1aOHHsCmrTQA/AlJdomb+YOh2q4g=;
        b=tcnXdAvzX03mqCigv8Jy421RijVdkg0ecDvQfyDHz2jEEBlnhbfGivOaU/+2s0Pgmn
         3tsdKfEC8PhWGEvoDo/I6w9YedSWGtghsgyLEVpOKCtaBncu3pYmX1Z5yYuxYCYNOtSL
         uQEGUnCE3qyhanG0SciQRhdQq+J8NodcGwvE9gKvYIkPy7sfRa7Mo1p+NV6V0WtJJN4F
         /Wq/2FO5r114g1JCNjdWfNjqp40FwSjTf1wX7uNznIqmQeEvtY1IxdeFAjJo7TBSI1Tn
         dIDBHMmf7HY3He0o/5ZMIImkvc/Hv5tJdOlpu8GoHrW0rg/ctMq11cGahf7RfgFLai3Q
         WKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/h+lVOr/RBj1CX1aOHHsCmrTQA/AlJdomb+YOh2q4g=;
        b=VWjhgCmMLokJy8WZt+CO2WdTNnj3rFJSUX1C0XPVhCg/43CYZ5fMvnxUXX4PWKnQqi
         dZDfOJT5yzKD1NsMpsI73fS38o0qx5tzQQ4FYOTWLQtD/E0cm+SjXIHepvJw2gKk2mVy
         yvjYZFhwl3pNiJ2qL7Zx1aq+gMzlBaKvP89od/u9SnsdooWUzVRw1IlmyB5mSTB0WkqS
         Wp8mdjtfITGPrqEDVZMzEBKfe2aCzOa0oG2HgP9TvtZyh9O39vKbjei0dazBxjS3iq9z
         i6FDPI4AXz789C5jhEU1HuahcCcR9z6hSaIkn4f6rr8c4IhGtcGzL+7eWZiLP3KzNb1V
         h/cg==
X-Gm-Message-State: AOAM531xMHg0x/ZFqz2ISV0VopilvXbr3f1F7eSj/FqAghTmj/pUm0wA
        WhZ3DBkmuFWxTFpbsIkfntz/RQ==
X-Google-Smtp-Source: ABdhPJzxps+cB0xsIwcYtX4mckhbPISXHLhDLBza/r3J8rLtrIUt/l/0xypzOFeCzqE7blRJ7NQWVw==
X-Received: by 2002:a17:90a:6948:: with SMTP id j8mr5811255pjm.45.1594157475841;
        Tue, 07 Jul 2020 14:31:15 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o128sm23560832pfg.127.2020.07.07.14.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:31:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 01/11] remoteproc: stm32: Decouple rproc from memory translation
Date:   Tue,  7 Jul 2020 15:31:02 -0600
Message-Id: <20200707213112.928383-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the remote processor from the process of parsing the memory
ranges since there is no correlation between them.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 062797a447c6..2973ba201c1d 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -128,10 +128,10 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 	return 0;
 }
 
-static int stm32_rproc_of_memory_translations(struct rproc *rproc)
+static int stm32_rproc_of_memory_translations(struct platform_device *pdev,
+					      struct stm32_rproc *ddata)
 {
-	struct device *parent, *dev = rproc->dev.parent;
-	struct stm32_rproc *ddata = rproc->priv;
+	struct device *parent, *dev = &pdev->dev;
 	struct device_node *np;
 	struct stm32_rproc_mem *p_mems;
 	struct stm32_rproc_mem_ranges *mem_range;
@@ -607,7 +607,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-	return stm32_rproc_of_memory_translations(rproc);
+	return stm32_rproc_of_memory_translations(pdev, ddata);
 }
 
 static int stm32_rproc_probe(struct platform_device *pdev)
-- 
2.25.1

