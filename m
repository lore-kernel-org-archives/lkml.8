Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C63C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E1020720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lN1AXlS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgGGVAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgGGVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF93C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so5201690pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbYQfIqqJHKaf/AV7EAC2w0cpklnSxGXHmoxxnSA3xU=;
        b=lN1AXlS/JrrmRLIUyBjSFMpogicBURNVWYkAD5P93UAG2F9rf1AxJymtSUchh7oWxT
         iqxH+BkLEx0VrvI4qNWwaxsxMdv3F3cuzh6BC5p44DHLA6CC7SYOwfCNYdJBsZ0gduya
         XsGgA/b+6VCC8IO+8qy+U6VZkpTa3j3uRK+iMjKRBnii3wfTsO3xSNxyRsyIeOfeqRyq
         kRvN1uE5Qe3jB8i4yVBYtiYw9f4dRwzaZQHIAh2AlhwlNBUSXyE871ddBmJZryJ9Kf09
         fBsKmcy4HOyqjGeFhh8Y72NYm2HdUY6OxOFoQwEWXBGvl21P1qRhS13WUeuueM49eedv
         L5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbYQfIqqJHKaf/AV7EAC2w0cpklnSxGXHmoxxnSA3xU=;
        b=OPTB15M4SK2+xbX9QA+N5gX4G6rjG2WKCghTMDiQqq3INaG+aanAb+ZrnddlOgRH6a
         C3aLMmbuOdbM/WVuxED8g3hi6yuJhM2Lt0QMKJc7zHO+ASUOsSJ0qwn2hsx+FTLCRCjS
         xh+0G1fMIx7DqVoFxz/lmTcMxdo5vJZfPomuFDo32vwxkGz+Shjdj8gtQHUSIbubbiJj
         um8QHpZrJQNJHzPy2fa9UNgtS174Xv7DI7q+TVT0td/QpyPQee88o9/Q/eaHY9Rv/E5b
         jEZJMcg6TmJ7FwL2iQK7jVqBP5SmI6+MQPvuS35NLyaDj8HkAgq6HfSldbxFpe0eEMw7
         vo0w==
X-Gm-Message-State: AOAM533tx1HxKwHBZr+KhQZI6RIxvuShYf3UWNjoqaluXok4HPbzLWQU
        w36Hqr8OXpkxldMgmXqxWuBcSw==
X-Google-Smtp-Source: ABdhPJx3gwwwBEIT3dAT4JNWdPHKUJjmF3AXMNSxjdrwseqMA4lcVlcA7m+UcqoYaQFRhySIv9nB7A==
X-Received: by 2002:a17:902:bc82:: with SMTP id bb2mr45907161plb.225.1594155620894;
        Tue, 07 Jul 2020 14:00:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/9] remoteproc: Introducing function rproc_actuate()
Date:   Tue,  7 Jul 2020 15:00:09 -0600
Message-Id: <20200707210014.927691-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function rproc_actuate() that provides the same
functionatlity as rproc_fw_boot(), but without the steps that
involve interaction with the firmware image.  That way we can
deal with scenarios where the remoteproc core is attaching
to a remote processor that has already been started by another
entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 59 +++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1e8e66a25bd6..fd424662801f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1369,7 +1369,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
-static int __maybe_unused rproc_attach(struct rproc *rproc)
+static int rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1490,6 +1490,63 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+/*
+ * Attach to remote processor - similar to rproc_fw_boot() but without
+ * the steps that deal with the firmware image.
+ */
+static int __maybe_unused rproc_actuate(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	/*
+	 * if enabling an IOMMU isn't relevant for this rproc, this is
+	 * just a nop
+	 */
+	ret = rproc_enable_iommu(rproc);
+	if (ret) {
+		dev_err(dev, "can't enable iommu: %d\n", ret);
+		return ret;
+	}
+
+	/* reset max_notifyid */
+	rproc->max_notifyid = -1;
+
+	/* reset handled vdev */
+	rproc->nb_vdev = 0;
+
+	/*
+	 * Handle firmware resources required to attach to a remote processor.
+	 * Because we are attaching rather than booting the remote processor,
+	 * we expect the platform driver to properly set rproc->table_ptr.
+	 */
+	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
+	if (ret) {
+		dev_err(dev, "Failed to process resources: %d\n", ret);
+		goto disable_iommu;
+	}
+
+	/* Allocate carveout resources associated to rproc */
+	ret = rproc_alloc_registered_carveouts(rproc);
+	if (ret) {
+		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
+			ret);
+		goto clean_up_resources;
+	}
+
+	ret = rproc_attach(rproc);
+	if (ret)
+		goto clean_up_resources;
+
+	return 0;
+
+clean_up_resources:
+	rproc_resource_cleanup(rproc);
+disable_iommu:
+	rproc_disable_iommu(rproc);
+	return ret;
+}
+
 /*
  * take a firmware and boot it up.
  *
-- 
2.25.1

