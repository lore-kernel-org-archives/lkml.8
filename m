Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D07C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9252074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Baz4t0Ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHZQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHZQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803FC06179E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so1144702pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ge2KsJvwuhlm+r4J63UN3uyDACII1r8lxNC/L+4iQUs=;
        b=Baz4t0UlEiKvXXEcGCQFy1LCd7CA7ydvEsN9JNvj8Uu0iDUjh51jMX791NKnutvndD
         bcEchugiLEj7UdoF+fx/VNcpyA9R4IHkYAp8jlKGV6QCuFjDi9JNjhYU55VCDDKvYCbc
         ZtTJitekE4uxWOwd/4VJH50Ssa+b5kwDCs0eQD0jBz/xDLtjXFEd3zN5uZm8MylD+kiC
         RkClUWVTfOw2DSNB4X6m/MYqjmuJGBx/UV/78oF56kjbH11AS6W6wUoQxCDfSLl1f1O5
         xNJ5bVnMC7kGhbtOPT2c4saUIh/5mn6fT9XQ4XHDvUVsKVtMuX31MWiUeHTO5xkeSXcr
         wesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge2KsJvwuhlm+r4J63UN3uyDACII1r8lxNC/L+4iQUs=;
        b=gkuOJCjj3wFRxcbmNDw8mq3WPhNzYunaY5Yj/q+wt/+PyEnfM65huCLHHuy0EDdgy5
         lzhCfSeG88hbdm7FA7Luifmia4nlQ9MnDRqbR1Q+4QEzGY6vv2AOCE8jpuKyYKfDt1p2
         Qiizgqfi5Vl9I8wEHEgs4OhEZg13WdgsLkVUUooOOitRDvtnWb87jbFET9eXJxwgD9+i
         iK9SDjR767SbBm/TnilEs4RIIS4mDdhn5YZz+3JwT0Ejn/zCZNJDYNQkpvYsl0kIkglR
         r7eQNH8Q3O+rVWG5Ls4wWOQ85EZh9h1YrEaJlVTSaKz1gAu8A93yeopSKE7reKohhx/v
         H6vQ==
X-Gm-Message-State: AOAM533wME6ojEPHhkvlVeNvC8PZx1haGjOGeRIbEUffiX6DMuzz/jxw
        /S5M2fnbmlrOurD6z9I2yc1Hqw==
X-Google-Smtp-Source: ABdhPJxDQFBQv8ALN+gaTkci32Mt/yvuWhIU99J28awxznb+Ef2mxlvE0Ze/xFwAAyI0jBo2Rp/2XA==
X-Received: by 2002:a17:90a:8d84:: with SMTP id d4mr5023378pjo.165.1598460337657;
        Wed, 26 Aug 2020 09:45:37 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:37 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] remoteproc: Introduce function __rproc_detach()
Date:   Wed, 26 Aug 2020 10:45:22 -0600
Message-Id: <20200826164529.224476-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function __rproc_detach() to perform the same kind of
operation as rproc_stop(), but instead of switching off the
remote processor using rproc->ops->stop(), it uses
rproc->ops->detach().  That way it is possible for the core
to release the resources associated with a remote processor while
the latter is kept operating.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index bffaa9ea7c8f..7a1fc7e0620f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1641,6 +1641,37 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	return 0;
 }
 
+/*
+ * __rproc_detach(): Does the opposite of rproc_attach()
+ */
+static int __maybe_unused __rproc_detach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	/* No need to continue if a detach() operation has not been provided */
+	if (!rproc->ops->detach)
+		return -EINVAL;
+
+	/* Stop any subdevices for the remote processor */
+	rproc_stop_subdevices(rproc, false);
+
+	/* Tell the remote processor the core isn't available anymore */
+	ret = rproc->ops->detach(rproc);
+	if (ret) {
+		dev_err(dev, "can't detach from rproc: %d\n", ret);
+		rproc_start_subdevices(rproc);
+		return ret;
+	}
+
+	rproc_unprepare_subdevices(rproc);
+
+	rproc->state = RPROC_DETACHED;
+
+	dev_info(dev, "detached remote processor %s\n", rproc->name);
+
+	return 0;
+}
 
 /**
  * rproc_trigger_recovery() - recover a remoteproc
-- 
2.25.1

