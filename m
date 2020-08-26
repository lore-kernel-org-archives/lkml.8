Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C762078B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMLNjq8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHZQqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgHZQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203D6C06179F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so1153012plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNFft0GFzwMNPipG6PxUltilEz9gyBFGoUVi1I8lj4Q=;
        b=nMLNjq8yjm/NUynPzx37UUN9LqO3b27Jf++W8JLhDrjddCoJMAFPApmaVpsY6VrM7u
         xq/L4oBUsy38SMEIU2cyaIsp44HuUlgmZBYIj6G8uO+76QHGFCI/qxWK28uXsjrBeYM4
         EBfdP0ZJeqOkliiX9A6yTH0HwDy3JIKO/x2Vy8vndeFHkLHDN+W0lPqYoCNu5cIWSddx
         2d35R31AOfNwu4etj7+guYWGUz9IQM33sr/pJIAQUY7MkHmThG9rT7ZeyyY1OrTfbOqY
         Lq8NJvePTZZxR9sIzfy+aXfm4lylDezwswwAGdXvnRp1xKyFeh+yqpopC/VILgI8dW/2
         81ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNFft0GFzwMNPipG6PxUltilEz9gyBFGoUVi1I8lj4Q=;
        b=na4Mgt8B1tyCxML3EloXrTIijz4pYChldollZ/PAzgO8xKNNCc36bet2TSdXLNl+91
         O4goi3AschKokwuK2ENaLNUUFXkOYL4iKq5kRBehRcZy+Q2TryXkvls8xtRTPTu5jrS4
         ncjoR04wLXEaT5gLQc0OBIOw5nc95237VW8klVt7pFUyABAonFKESja2WHMtc9LOLmsV
         VG6WX/lTlLBa2DoA1kGAz7tFyMMIYCendUY9tdsDRmgXcXEXXPSwCHnRA8NWdZ2/2lmY
         ORoy0dYi3MNAsNlEG/BgT77nbzg1NuNFaBRlkwNyY+0bznIQ2nm2yR+DnMhJ9Ksqb4dW
         qLfw==
X-Gm-Message-State: AOAM533f6fkx2w8kzqKBsZvvg66h/yb6QSBx7ysnetoxiDPuJcPT5YBP
        ZN5MYJo6wWJOu+t7IbJYK+GkNg==
X-Google-Smtp-Source: ABdhPJy1MJxT7kKGzzFPpIVippgTa9e/nZKttQoTzJf1s3N5NpD6NJUh9Oeyl9EmUFcR4xSb8qD7qg==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr6700880pjh.230.1598460338618;
        Wed, 26 Aug 2020 09:45:38 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:38 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] remoteproc: Introduce function rproc_detach()
Date:   Wed, 26 Aug 2020 10:45:23 -0600
Message-Id: <20200826164529.224476-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function rproc_detach() to enable the remoteproc
core to release the resources associated with a remote processor
without stopping its operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 65 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  1 +
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7a1fc7e0620f..f3943a1e2754 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1644,7 +1644,7 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 /*
  * __rproc_detach(): Does the opposite of rproc_attach()
  */
-static int __maybe_unused __rproc_detach(struct rproc *rproc)
+static int __rproc_detach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1887,6 +1887,69 @@ void rproc_shutdown(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
+/**
+ * rproc_detach() - Detach the remote processor from the
+ * remoteproc core
+ *
+ * @rproc: the remote processor
+ *
+ * Detach a remote processor (previously attached to with rproc_actuate()).
+ *
+ * In case @rproc is still being used by an additional user(s), then
+ * this function will just decrement the power refcount and exit,
+ * without disconnecting the device.
+ *
+ * Function rproc_detach() calls __rproc_detach() in order to let a remote
+ * processor know that services provided by the application processor are
+ * no longer available.  From there it should be possible to remove the
+ * platform driver and even power cycle the application processor (if the HW
+ * supports it) without needing to switch off the remote processor.
+ */
+int rproc_detach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret) {
+		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
+		return ret;
+	}
+
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* if the remote proc is still needed, bail out */
+	if (!atomic_dec_and_test(&rproc->power)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = __rproc_detach(rproc);
+	if (ret) {
+		atomic_inc(&rproc->power);
+		goto out;
+	}
+
+	/* clean up all acquired resources */
+	rproc_resource_cleanup(rproc);
+
+	rproc_disable_iommu(rproc);
+
+	/*
+	 * Set the remote processor's table pointer to NULL.  Since mapping
+	 * of the resource table to a virtual address is done in the platform
+	 * driver, unmapping should also be done there.
+	 */
+	rproc->table_ptr = NULL;
+out:
+	mutex_unlock(&rproc->lock);
+	return ret;
+}
+EXPORT_SYMBOL(rproc_detach);
+
 /**
  * rproc_get_by_phandle() - find a remote processor by phandle
  * @phandle: phandle to the rproc
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 1a57e165da2c..6250491ee851 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -656,6 +656,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
 
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
+int rproc_detach(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
 int rproc_coredump_add_custom_segment(struct rproc *rproc,
-- 
2.25.1

