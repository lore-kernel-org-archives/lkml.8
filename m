Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE55206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzRiq509"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442156AbgDOUtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442135AbgDOUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:49:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DDC061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o1so374167pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ch0sqi4G1BQL+KPaSc+5TNiMX3GlnJ1H3XmGIgfMOXw=;
        b=TzRiq5093NXJ/0OqFqhCAj1qbVzGr7tW44nNbIxfJn/A7jqQ0/YCn84qTB2JPTu3DL
         dW+DctrYoXTvqFyhdCjgv4a58jhmbCuu3r7b7rq/ZRJ2ZxX7AJbgtKtkJ4DGAxCmpwwg
         eqIn8zHn98l8qFJC0IbL2sDsiu4OMaXUT1ycD374kEdeX9yupAnBZyZyml4z8ucDCPwD
         Y2F3oc5sTsDvpHpXH9LY3SWM0dyK7iHC7CpyUd8w0S8UqHre261ESBKTWMV3NTQ+wrQe
         qI/8cXkgx5n9oy9vDLJ68gy9s2b0Hk+FFcCliMe+4eY0IjOYb3Zsi93hU9dP/KTKH/Ox
         qCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ch0sqi4G1BQL+KPaSc+5TNiMX3GlnJ1H3XmGIgfMOXw=;
        b=Gngp3HfqZq5uC5FnIy1nRT95UFr5GipAKaN4wPCR7PVU34vw8zJEzRbcEgbBEDWxqI
         aLAMnqS2mxRFQcb3FxapBMvrh1Baw4VsSBG2ljgQiglTigPlv75gClCtPnIbKN2GZZta
         3MaH0ee+E7US8m1dBRJDOVphTdFYGm5q9qw7K5jkiqozwitA57lf7W0b0lYSUbQGmDb4
         L3708Yg48cElKmDjC7/779gE58aPoZQ1JzEoTWNPJzhiVgcJJ84XcuKPs2/6x9p1jRdF
         e7UFtJbZM7nTqxYMSYyzKrEN8hlBBZAEODxj6JzwijF7OjIE4jq9kSNI+sQoALZeXelG
         fzSQ==
X-Gm-Message-State: AGi0Pubm1XhOQ5RyD2gH4jzIXZAp5axtu19k6MoNT116JW4JJ2IaAw0E
        /ghinPfpJRQUGQAqbYsJHZbMKA==
X-Google-Smtp-Source: APiQypJw0SHRb41jbv6PcjOXUYYXfOMslxfY0S2mxng747q472WCFQh7gfVpzkRFx/nVSkXdIcykvw==
X-Received: by 2002:a17:902:fe09:: with SMTP id g9mr6587197plj.306.1586983749174;
        Wed, 15 Apr 2020 13:49:09 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i13sm14461861pfa.113.2020.04.15.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:49:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] remoteproc: Split rproc_ops allocation from rproc_alloc()
Date:   Wed, 15 Apr 2020 14:48:57 -0600
Message-Id: <20200415204858.2448-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415204858.2448-1-mathieu.poirier@linaro.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the rproc_ops allocation a function on its own in an effort
to clean up function rproc_alloc().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0bfa6998705d..a5a0ceb86b3f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2001,6 +2001,25 @@ static int rproc_alloc_firmware(struct rproc *rproc,
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
@@ -2040,8 +2059,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (rproc_alloc_firmware(rproc, name, firmware))
 		goto free_rproc;
 
-	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
-	if (!rproc->ops)
+	if (rproc_alloc_ops(rproc, ops))
 		goto free_firmware;
 
 	rproc->name = name;
@@ -2068,16 +2086,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
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

