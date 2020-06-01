Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F550C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B130206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAL0xv+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFAR4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgFARz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:55:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3065C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:55:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v24so252087plo.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiaQOah0tkVij5o2XB19f+57g9nxyi9Dr0rKn4GNNWo=;
        b=JAL0xv+J0eDQvIWE9P08dNSkHM11snhLNWBIKigP5OWrAyaQOl2aH7kIY4OQZ65Itw
         txVqAp3KExHzk+qIz30vM58NovUzH03bOLTvfdSdeZlodE/khP02rrMkEZV/eLl56XP0
         1NmD1KVXjuzjkrg/5zNfF9BUTz9vJVkkIJcRJ5XVGjMtsm7XbrBbP/3YKn+m3N++ZtM3
         6yuvhHwsQm8LyueSGhn9P6nyA9bjiWn+eLsYNJUy7rGTqTRKPZ2zV+RMt02baecdKX9m
         KJtzqPdFRzaB/xlrbKEl8YVhHRy1h+XuYLzDOLBNycDzgSiN/BJE7J8TWnyJCGWzuX7p
         TIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiaQOah0tkVij5o2XB19f+57g9nxyi9Dr0rKn4GNNWo=;
        b=TDvlpfb7Go6+MOuZMaBsSdjlWZYxBRz9SgYj55Z8Sd2ZKdxNv3fpVKnPUf19F832m9
         sTMaldCVbxggAuWzRumvR9gk2oI5Gl75Ss6UCPUOj3i2bpySurpTJH7SUWfCvsGUX9Qr
         Y45uZ8MI/w3UVZ2aZp/5UiQEXhwRS31MQUzkyhqDxj3SwUjxCZFv+JCklNBnzod5U0ND
         49cJgYSiBIxFB2j4rbhXbO4JwHrInJoouCi0z/iPfjC3sQvQFG9DbgGrgVFDSFgj5+bT
         rA7TKUga6u1fY/H1usdkQLmSw8eWNG3YmNOGh8UphetiCVfCVgkYHxzRN+aQy6wMuk4k
         ZXsw==
X-Gm-Message-State: AOAM532wf03C5I9jWHu4B6qNnqRgi7HDPx6DPK02S9Z9DTYTqK1DZAD4
        W2ZyKJ3UIFYsQNoV+lqY4Zwt5w==
X-Google-Smtp-Source: ABdhPJwCeQOCr89X+QwuX83o1+B8wMZb1kqOYTtx1WnyqkdzZeWW1Be4A4m7ZXhsCX7hyj9yIQeS8w==
X-Received: by 2002:a17:90a:6706:: with SMTP id n6mr621042pjj.13.1591034155457;
        Mon, 01 Jun 2020 10:55:55 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:55:55 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 01/11] remoteproc: stm32: Decouple rproc from memory translation
Date:   Mon,  1 Jun 2020 11:55:42 -0600
Message-Id: <20200601175552.22286-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
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
index f45b8d597da0..a80733fb08e7 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -127,10 +127,10 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
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
@@ -606,7 +606,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-	return stm32_rproc_of_memory_translations(rproc);
+	return stm32_rproc_of_memory_translations(pdev, ddata);
 }
 
 static int stm32_rproc_probe(struct platform_device *pdev)
-- 
2.20.1

