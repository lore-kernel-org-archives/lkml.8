Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA66FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BA820575
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9U8U4mS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgDMTei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387900AbgDMTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:34:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320EC00860C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:34:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i3so889537pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbfVjk3n7dmtNabMVVrC9yJ09gyFOYpKGc85h9CW1lY=;
        b=d9U8U4mSflEe4j0ZiTHJv35UwXRhVJ6QMZ+zO0JqNkV1GgmqV90Rb0/4+crhwnfLC8
         xqF6GP1ev/WVIK2HJORf8n+ak1kc6JX4ZXSoAB6fxMYEyG788bXAbE51VRWOe6CaCBxs
         2/0IgpNVCE/emIsUO91F29x7Ls9fgsm9bw1aVBRCUNDWQiSGz3L2j123CgwVImEq5fzC
         B/03oKZ6RoNdcrH9vKZCKIQ5HhTDzR5JVocDGQcbq7ytU9MiChJ0BqUgJSodelh8Dcbu
         BNpUOZ2vwiBKNi9tOoZMVTYRbA2APdRQBkz8jNU4jRDD7Xe3J8AHr/BfXhvi29LIPp25
         Wrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbfVjk3n7dmtNabMVVrC9yJ09gyFOYpKGc85h9CW1lY=;
        b=DPPbRFeIfX/Nv+w0635Dz02Gm1kYboeeaRDIG4K3Kg1KLWuWXfcBDm37+TU/EsDbqm
         TDsuGAILR1skHtjpQpr/e9X3O5hRN18f9VTo/aubqe9I/PJuBLXVcSxQ2SRCHsrVtL3G
         YxohNpR34hM6DpjbfjBMkp5xjoOQ4m1VN02pjZu2I8h4d90LVLeDNjdMyvJEvRioWO8H
         V/SErt/PSfThnzLvzjsILh8zk1b4iqcPHUICV6HVYZH+kWH0Qu1TqlUJN21IQjbH2+LI
         /yZTJW9pzTpzdpctetedrR5YgmG9coIKrsN+2U/WhgB1V40ts7QZlPdu5TihPN3i7WOr
         wcMg==
X-Gm-Message-State: AGi0PuZxawK8EpvfJDzzmcGmIhFpsGoRbbJLIvknZ+Sdov0wZi0ccWod
        vxfnDjiqbg0I3pkjW9I6+UhufA==
X-Google-Smtp-Source: APiQypISK1cjUZOJJw7oxYyo4pLuVlNFM1tkqhgi6XI1egohf6p7Zoqspbr9PWLC3pqLQirvf6uSHw==
X-Received: by 2002:a63:6604:: with SMTP id a4mr17533914pgc.381.1586806446754;
        Mon, 13 Apr 2020 12:34:06 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ml24sm7032330pjb.48.2020.04.13.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:34:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] remoteproc: Split rproc_ops allocation from rproc_alloc()
Date:   Mon, 13 Apr 2020 13:34:00 -0600
Message-Id: <20200413193401.27234-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413193401.27234-1-mathieu.poirier@linaro.org>
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the rproc_ops allocation a function on its own in order to
introduce more flexibility to function rproc_alloc().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 4dee63f319ba..c272d78f07e8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2006,6 +2006,25 @@ static int rproc_alloc_firmware(struct rproc *rproc,
 	return 0;
 }
 
+static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
+{
+	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
+	if (!rproc->ops)
+		return -ENOMEM;
+
+	/* Default to ELF loader if no load function is specified */
+	if (!rproc->ops->load) {
+		rproc->ops->load = rproc_elf_load_segments;
+		rproc->ops->parse_fw = rproc_elf_load_rsc_table;
+		rproc->ops->find_loaded_rsc_table =
+						rproc_elf_find_loaded_rsc_table;
+		rproc->ops->sanity_check = rproc_elf_sanity_check;
+		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
+	}
+
+	return 0;
+}
+
 /**
  * rproc_alloc() - allocate a remote processor handle
  * @dev: the underlying device
@@ -2045,8 +2064,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (rproc_alloc_firmware(rproc, name, firmware))
 		goto free_rproc;
 
-	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
-	if (!rproc->ops)
+	if (rproc_alloc_ops(rproc, ops))
 		goto free_firmware;
 
 	rproc->name = name;
@@ -2073,16 +2091,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
 	atomic_set(&rproc->power, 0);
 
-	/* Default to ELF loader if no load function is specified */
-	if (!rproc->ops->load) {
-		rproc->ops->load = rproc_elf_load_segments;
-		rproc->ops->parse_fw = rproc_elf_load_rsc_table;
-		rproc->ops->find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table;
-		if (!rproc->ops->sanity_check)
-			rproc->ops->sanity_check = rproc_elf32_sanity_check;
-		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
-	}
-
 	mutex_init(&rproc->lock);
 
 	INIT_LIST_HEAD(&rproc->carveouts);
-- 
2.20.1

