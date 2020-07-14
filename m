Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24872C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED70D224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1onkpR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgGNTus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbgGNTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE11C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j20so8029389pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dkdk1HU4RvzeNvsp6TinYFs07yUk0YfjlyMcPX/N2O0=;
        b=w1onkpR0METlahp/EUYmJcn6mWjsIh2w1U7rLwYVuoEy65Ux3Cvt8dqR0ywX28J9do
         1QqnVlHR24CaclQatHlIDa/QIToenuxeRPBco4ZpaT5U//3wkqnLYnOtJS8LheG3A5Wb
         uBiRjzoZ25c/bipZUnK9eg1EqXr1iSBQ4uwdFi871GEADiHCUTZ2hjrQNVXmcSaDjlGq
         U7Mkssbp8c5qhFG2x+puXK3BAv6xAWqiExRbz+2uhyFiMbbDqyrnjfy92Hu5js8p7arA
         HfOSJP5BRf85TLSmz/18fng4/Xr58rPI6Kyfl8urJ+mDTmZs1+4PHgGhkoVLcDdv+Gsp
         Jj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dkdk1HU4RvzeNvsp6TinYFs07yUk0YfjlyMcPX/N2O0=;
        b=HU/B2dxXyg+AnyvljKMBRvJ1PY61OEv3nMJ1Xizjdr03VYd3OgeHY9/3lYkjHSwbjv
         7/5z5MEFrX08YeWeiRYz40sZl4gj4w7eQpW0zWkpV8v1wqETcyvWyAmcBsT19YM1VF3Q
         8eOq7dHXfS7I6dApn0sbQGPZBoP5fO42TkjmiEYHItHxIJmcZzLr521MvLgVjxxpgwX7
         oErN7tDjdfiFeqmA/umlOsH1e3m+p8eaTQdYfw0Kyn1vJcCxefFXm2O1w4mZYfUdT+b/
         Lvo/PNmkY12ujGoKQAhgBmbGMn1FYyXRr29x57729KulnLW1MxYmf+wrvAOCPZpC5M+X
         RGXg==
X-Gm-Message-State: AOAM530GYDrt+mvH9eVq3PbBYi1qBkFx4ayYkiyG9zBPG0drMrsbRpyN
        ogU1aiNSGEIh3R3xjpBYgsFDfg==
X-Google-Smtp-Source: ABdhPJxGDve+4ouHSFclk3B4WQKVvxx6xzUCSPGKIHmneSYbayoSOqfgHE5SYmLNVv6A79SUzG33ZA==
X-Received: by 2002:aa7:8550:: with SMTP id y16mr5379487pfn.151.1594756240988;
        Tue, 14 Jul 2020 12:50:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] remoteproc: Introducing function rproc_attach()
Date:   Tue, 14 Jul 2020 13:50:29 -0600
Message-Id: <20200714195035.1426873-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing function rproc_attach() to enact the same actions as
rproc_start(), but without the steps related to the handling of
a firmware image.  That way we can properly deal with scenarios
where the remoteproc core needs to attach with a remote processsor
that has been booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0f95e025ba03..1e8e66a25bd6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1369,6 +1369,48 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static int __maybe_unused rproc_attach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	ret = rproc_prepare_subdevices(rproc);
+	if (ret) {
+		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
+			rproc->name, ret);
+		goto out;
+	}
+
+	/* Attach to the remote processor */
+	ret = rproc_attach_device(rproc);
+	if (ret) {
+		dev_err(dev, "can't attach to rproc %s: %d\n",
+			rproc->name, ret);
+		goto unprepare_subdevices;
+	}
+
+	/* Start any subdevices for the remote processor */
+	ret = rproc_start_subdevices(rproc);
+	if (ret) {
+		dev_err(dev, "failed to probe subdevices for %s: %d\n",
+			rproc->name, ret);
+		goto stop_rproc;
+	}
+
+	rproc->state = RPROC_RUNNING;
+
+	dev_info(dev, "remote processor %s is now attached\n", rproc->name);
+
+	return 0;
+
+stop_rproc:
+	rproc->ops->stop(rproc);
+unprepare_subdevices:
+	rproc_unprepare_subdevices(rproc);
+out:
+	return ret;
+}
+
 /*
  * take a firmware and boot a remote processor with it.
  */
-- 
2.25.1

