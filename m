Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E953BC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBBA20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEce7CVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgDXUBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgDXUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E47C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h69so5120497pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thvt7ABu2oknElk6aMlYpSKsdaIxDnUq/lm1lGmYKAw=;
        b=OEce7CVYAQrD+2/fCQ7jAAUkpy1uaYWusDID0du7fpICLUzFqnf6/1vU0bUtxkf6vw
         aNOjg8KrkImP9oAqyhCCte3mkPwmu7Ykwimj3EuqY0HjMsKjw5kbjLt1SbiMWGDm7qQ7
         US0tREGO3J5hUBiThXe/u8ffLLhBOB+lKPFkClNBWVftYk4Pu6TpAc4WzPmS+2UkGU4K
         7fHt/V27b33sABBBZvhD+1nwXCDUvbIOIiSHakEwhIdNQiMGNW9NzBWy9OH3UP0hHrJM
         mpvXwr4yua+xFlFktoRHVNwY5rCQaiipj1NZx4rX/kBQ4st6hj6pm78MK1ZZZZf1Sit3
         EXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thvt7ABu2oknElk6aMlYpSKsdaIxDnUq/lm1lGmYKAw=;
        b=dOFGuH3H1oWDD9jhOrE6SV8/O0i5oO/G3QFYNHY++/U4B97y/H9pZ9DIxA1mY6lrQL
         ugohH5uyKjnkHKxEEzEKNsTHXavxM2gypIO1wQ1drD0zQvApwp0CYAgguHnJYpFYPMrG
         p7+OVODgofzi8e4XAN6xx9ndTPpXJdBN1E6XZOfvnP9JYvpkAGPaM/NFzyukWjGOdI39
         DoSlZFbHBSNNWhE8RGDz1VOCGa+HpKlnzRkccLcFgiFozcii7Lyu/7IO9H3P4R2mRl7T
         Vfr4KiXYC2KDGafjgee5QRINSOOMSIdvKMgLK9MKJ6x6P8C+LcWTIhjbAg+1kbNttJ0W
         qbuA==
X-Gm-Message-State: AGi0Pua7SBlXBsdjRyVM/5gp+Ka7VxZ3/sjMLCzpZ2xfx8mztQkyr+t7
        03VGd3Hpp7RASFeOvm0kvWRdWA==
X-Google-Smtp-Source: APiQypK7A3kQi4xZwp9Up10ceDilox6vD3IgS1MUQXhRxkQuczYicJnzio3ayo8mu7gV6CdUXZe2bg==
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr11118517pfb.130.1587758502506;
        Fri, 24 Apr 2020 13:01:42 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] remoteproc: Refactor function rproc_boot()
Date:   Fri, 24 Apr 2020 14:01:25 -0600
Message-Id: <20200424200135.28825-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring function rproc_boot() in order to properly handle
cases where the core needs to synchronise with a remote processor
rather than booting it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c     | 25 ++++++++++++++++--------
 drivers/remoteproc/remoteproc_internal.h |  5 +++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1b4756909584..a02593b75bec 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1762,7 +1762,9 @@ static void rproc_crash_handler_work(struct work_struct *work)
  * rproc_boot() - boot a remote processor
  * @rproc: handle of a remote processor
  *
- * Boot a remote processor (i.e. load its firmware, power it on, ...).
+ * Boot or synchronise with a remote processor.  In the former case the
+ * firmware is loaded and the remote processor powered on, in the latter
+ * those steps are simply skipped.
  *
  * If the remote processor is already powered on, this function immediately
  * returns (successfully).
@@ -1771,8 +1773,9 @@ static void rproc_crash_handler_work(struct work_struct *work)
  */
 int rproc_boot(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
+	const struct firmware *firmware_p = NULL;
 	struct device *dev;
+	bool syncing;
 	int ret;
 
 	if (!rproc) {
@@ -1788,6 +1791,8 @@ int rproc_boot(struct rproc *rproc)
 		return ret;
 	}
 
+	syncing = rproc_needs_syncing(rproc);
+
 	if (rproc->state == RPROC_DELETED) {
 		ret = -ENODEV;
 		dev_err(dev, "can't boot deleted rproc %s\n", rproc->name);
@@ -1800,13 +1805,17 @@ int rproc_boot(struct rproc *rproc)
 		goto unlock_mutex;
 	}
 
-	dev_info(dev, "powering up %s\n", rproc->name);
+	dev_info(dev, "%s %s\n",
+		 !syncing ? "powering up" : "syncing with", rproc->name);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto downref_rproc;
+
+	/* load firmware if not syncing with remote processor */
+	if (!syncing) {
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto downref_rproc;
+		}
 	}
 
 	ret = rproc_fw_boot(rproc, firmware_p);
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 59fc871743c7..47b500e40dd9 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -64,6 +64,11 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 struct rproc_mem_entry *
 rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
 
+static inline bool rproc_needs_syncing(struct rproc *rproc)
+{
+	return rproc->sync_with_rproc;
+}
+
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
-- 
2.20.1

