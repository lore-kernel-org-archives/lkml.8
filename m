Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746F2C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8A1215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlbzOYZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgDXUZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgDXUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028AC09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so5324399pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqZ+BJyxifVcrtE3LQT7/v41/moffbFoiyW2JFMtzmM=;
        b=KlbzOYZF4XuoC0+4q2eozDIEdNHu5c84JN2Jf1E9xX5EKrw3Hnkon8pPEloKgp49+B
         yt4yJ04XEeH1shSmHH+bhF1X3jfdN6XbStt0azopWfmuHfy4E/gC2oIuOvSSFmYTV93O
         324Qicy4CJQfu8A4yNSGQc9dbaCQL+9hbsiYPPB14/HrEBMhNau/1cn+E+2JAakqiOpT
         4SU/HfyRKARtZuxSB499DIXysvhRzB1QI6EpaLSGjayRHkbn37cYV/35aYaQSm1nNBFj
         sCiNGzO0wbcSkC5BJgpqu1fKqXFSjHTiA+L/L1vlUWzHZek6UgAFb6k2ODMxwG+NZzy9
         6R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqZ+BJyxifVcrtE3LQT7/v41/moffbFoiyW2JFMtzmM=;
        b=ZDnAZrMrN1jVOhYqBs1nRuh3bfxeKATUvR/+apcX5cewno9C1EOoEUdHSO3TsAbVZ1
         tLFWIamkFLQCw+rzCRk+T9k/AayYiimPqFHpHmvSXdPqbIdywTrJ3FrCaNWqOhBc+0Yp
         MnUfXiEGpa2mHNHPyibcbkjTRFOepFrdUPM0Wn5CjJ+3cujbg53AXMCLBZ5aPVqHaKzL
         hr+1+a/Rc0OsEXTZ//EA2rcZdpOq7mPNtEYsENvIs1Ii2Mqc0iAm7HN1noGkKkJlW4Ae
         EmPQnE5Ciy/eTVl1GXUGazgo4j1ha96HWKcFqYkNj73pksYlgHum9Jr4r2reLz/4XZwx
         k/Kg==
X-Gm-Message-State: AGi0PubGhHOzPlFZPSS85u0GE/KqrUzMvHFLE7J9zXpoULgSEmhox7Fc
        VsDmydxSjVfsgUvxL7IzCK2WUw==
X-Google-Smtp-Source: APiQypJ/18O8EzmmOyV9pza2XTZukTkmU7hCPlE0hRPLSf//lsxriH6VEC17D+y2boj6LQTLZh8jOw==
X-Received: by 2002:a65:6250:: with SMTP id q16mr11309222pgv.9.1587759919091;
        Fri, 24 Apr 2020 13:25:19 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:18 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] remoteproc: stm32: Introduce new parse fw ops for synchronisation
Date:   Fri, 24 Apr 2020 14:25:03 -0600
Message-Id: <20200424202505.29562-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new parse firmware rproc_ops functions to be used when
synchonising with an MCU.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 51 +++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 86d23c35d805..b8ae8aed5585 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -215,7 +215,34 @@ static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
 	return 0;
 }
 
-static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+static int stm32_rproc_sync_elf_load_rsc_table(struct rproc *rproc,
+					       const struct firmware *fw)
+{
+	struct resource_table *table = NULL;
+	struct stm32_rproc *ddata = rproc->priv;
+
+	if (ddata->rsc_va) {
+		table = (struct resource_table *)ddata->rsc_va;
+		/* Assuming that the resource table fits in 1kB is fair */
+		rproc->cached_table = kmemdup(table, RSC_TBL_SIZE, GFP_KERNEL);
+		if (!rproc->cached_table)
+			return -ENOMEM;
+
+		rproc->table_ptr = rproc->cached_table;
+		rproc->table_sz = RSC_TBL_SIZE;
+		return 0;
+	}
+
+	rproc->cached_table = NULL;
+	rproc->table_ptr = NULL;
+	rproc->table_sz = 0;
+
+	dev_warn(&rproc->dev, "no resource table found for this firmware\n");
+	return 0;
+}
+
+static int stm32_rproc_parse_memory_regions(struct rproc *rproc,
+					    const struct firmware *fw)
 {
 	struct device *dev = rproc->dev.parent;
 	struct device_node *np = dev->of_node;
@@ -268,9 +295,30 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 		index++;
 	}
 
+	return 0;
+}
+
+static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	int ret = stm32_rproc_parse_memory_regions(rproc, fw);
+
+	if (ret)
+		return ret;
+
 	return stm32_rproc_elf_load_rsc_table(rproc, fw);
 }
 
+static int stm32_rproc_sync_parse_fw(struct rproc *rproc,
+				     const struct firmware *fw)
+{
+	int ret = stm32_rproc_parse_memory_regions(rproc, fw);
+
+	if (ret)
+		return ret;
+
+	return stm32_rproc_sync_elf_load_rsc_table(rproc, fw);
+}
+
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
 {
 	struct platform_device *pdev = data;
@@ -544,6 +592,7 @@ static struct rproc_ops st_rproc_ops = {
 static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
 	.start		= stm32_rproc_sync_start,
 	.stop		= stm32_rproc_stop,
+	.parse_fw       = stm32_rproc_sync_parse_fw,
 };
 
 static const struct of_device_id stm32_rproc_match[] = {
-- 
2.20.1

