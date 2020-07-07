Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24FE206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twl7enwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgGGVAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgGGVAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F059EC08C5E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so20564444pgn.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVtbty6MuR7LBEWWuCJGvwLM4FSBtYk/iYw5ZIvpQoA=;
        b=twl7enwz7kHhrli2x2cq44nDscH6dGKdCAgl9f+ftKAMLM3qCH1z3Cd8eOuMmTwjBD
         pP2E+bDWwrI1VG6K1dJDCAPGf2PTRGzevND10bKqX/rIiQgAGbV/ExAVlQbUneFWdMcM
         mVvi2mxwtD0jwI3Tgeoe2+mDoefxbmvlFWbxfTqLqwIjTRi/mMLLpcufIstRcg8dHY0F
         VAVHdSDpGp2fcaaGdLxw7AnGM826Joap5sqxNo4Jz+ymlCp3QmijmAzEWG6vOP6ySPHP
         PB1oBhPhi2idwpn1AUCtb6UTk/vIsUXlZJ4Lnd+mZ0R84767rUAN+MDwKRMvincktecT
         VXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVtbty6MuR7LBEWWuCJGvwLM4FSBtYk/iYw5ZIvpQoA=;
        b=r+hxXHMcKoc9a1gz+O529AShjiiY6Z4or4svSfL0nupLbPsYDkDvreqzBDi96Kcn4C
         kOzQt61HWpKQG5pbrkjjz+luRD10cm7eyJV5a2jDBP6/2bn/NZnbaQfkMkD2yrSP/1j7
         UHwxxCUQXmxinR8i6sUuxAbjAu5uxshGvbJz7RROlYHZvVzh3JT0YDGT8RD2SdU1hFgj
         gZE9Q7zmDNxHJGHnniV+5Qn5/D/Bx1lBKWqp19LKm8orXkXwyKrtrHSFX04WKOx1ybSN
         JjVJLFeD4TSB4OYUHtGQBG5QwnQK5MMvIJC4sVxCNzuUh4v4zVTH9yg6Hpo7I042G8vL
         Bo9w==
X-Gm-Message-State: AOAM53129eSHieR520ToWGXHxcAw3Eu8nVqPEfMOHGCfoCOY0YqrYoA7
        K2cqiE/P4414Emcz73FZ6p2hYQ==
X-Google-Smtp-Source: ABdhPJzbouKkw8rF4UU8dz3+uRSIpdjSqdZ9zhLg/igFtFrkRfUKweAwArYZzWKyqlnramTwIw5Raw==
X-Received: by 2002:a65:5c0b:: with SMTP id u11mr10831269pgr.191.1594155618453;
        Tue, 07 Jul 2020 14:00:18 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/9] remoteproc: Add new attach() remoteproc operation
Date:   Tue,  7 Jul 2020 15:00:07 -0600
Message-Id: <20200707210014.927691-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an new attach() operation in order to properly deal with
scenarios where the remoteproc core needs to attach to a
remote processor that has been booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_internal.h | 8 ++++++++
 include/linux/remoteproc.h               | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 4ba7cb59d3e8..fc710866f8ce 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -79,6 +79,14 @@ static inline int rproc_unprepare_device(struct rproc *rproc)
 	return 0;
 }
 
+static inline int rproc_attach_device(struct rproc *rproc)
+{
+	if (rproc->ops->attach)
+		return rproc->ops->attach(rproc);
+
+	return 0;
+}
+
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 21182ad2d059..bf6a310ba870 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -359,6 +359,7 @@ enum rsc_handling_status {
  * @unprepare:	unprepare device after stop
  * @start:	power on the device and boot it
  * @stop:	power off the device
+ * @attach:	attach to a device that his already powered up
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
@@ -379,6 +380,7 @@ struct rproc_ops {
 	int (*unprepare)(struct rproc *rproc);
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
+	int (*attach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
-- 
2.25.1

