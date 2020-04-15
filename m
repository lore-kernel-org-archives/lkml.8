Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F5C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC98206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egNlW/CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442189AbgDOUtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438392AbgDOUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:49:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0001C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 188so492360pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1hbSYFCQB3yszokgcBiVGsdFzFeGt348+BuoHZMJzg=;
        b=egNlW/CSCwQuT6WGzglAGTyPjuWi+aGrzOCTdAGwOaEZ7Kgd4B9RHAHH55pOxZzhmU
         392kfFr/2vEyV/vcSXdhaRtDqsBzgkk9bN6rOGcWYH1muIyaNkpbGbllThNX7j60A0Vh
         q4anYq+OzpZrkotySrS6xCtJElR2oV1SpdbngP+leW4q05vQnieuIZuU727i3Zyi2ymc
         MKQ0947uj0Vey76Ffkj4cYYDMALiAYiHasNiLP8liGtVREahPINgxg8IZIFPQddBO2u9
         4BqXf3mIatbMDNLPQsb1flw4HNfji5X6Rc5S+bxDskvpggXJnMecuW5CEVdenaNw75DG
         MN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1hbSYFCQB3yszokgcBiVGsdFzFeGt348+BuoHZMJzg=;
        b=s4SAjkKvHD/byNxP7WmADLyL5Ybsz5XpODjfLUPoUUv7knoUZGKL9P2kLG1HyS5ccF
         Zdnb33KAG5l+Aa8hq/OWnhyK2fERGJkUnuDFEg8vIo5UZMTL/i3VxGd75f/ci2Kkj7TD
         6C3n9DPFMvTFerIzXCOcYd4XwjaX/ob15acSbNdlNTm8itrEJd6r63e4oKTbinPv1VuB
         tDwDz6YITZ/A54uslQDcyeG70MH4rehATqSpjylS8uhPJAum+7cW3UB7dAIBowkFB4Cb
         ND/CvvHsg3P+eL5CBAWW4/mkwxELI+ybLXOSiXx8gG5SSKoautzLsU73rsqySb/pVwrt
         etXg==
X-Gm-Message-State: AGi0Pub2wEPH91jkz9ks3wl2ewqHqayZ6nI98wN2fEhjmCjLzqapeD+P
        o1DEerzSVgRVHYOosIBajWXcrA==
X-Google-Smtp-Source: APiQypJLUVSXF1Os2JTEHHQ8RcYmeMke3mHN+xDj0GD7Bj66NnNDTeCvgwM5GZlNCsN+NS6a6SupSw==
X-Received: by 2002:a63:4047:: with SMTP id n68mr27922364pga.321.1586983744336;
        Wed, 15 Apr 2020 13:49:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i13sm14461861pfa.113.2020.04.15.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:49:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] remoteproc: Split firmware name allocation from rproc_alloc()
Date:   Wed, 15 Apr 2020 14:48:53 -0600
Message-Id: <20200415204858.2448-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415204858.2448-1-mathieu.poirier@linaro.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the firmware name allocation a function on its own in an
effort to cleanup function rproc_alloc().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 80056513ae71..4dee63f319ba 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
 	.release	= rproc_type_release,
 };
 
+static int rproc_alloc_firmware(struct rproc *rproc,
+				const char *name, const char *firmware)
+{
+	char *p, *template = "rproc-%s-fw";
+	int name_len;
+
+	if (!firmware) {
+		/*
+		 * If the caller didn't pass in a firmware name then
+		 * construct a default name.
+		 */
+		name_len = strlen(name) + strlen(template) - 2 + 1;
+		p = kmalloc(name_len, GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		snprintf(p, name_len, template, name);
+	} else {
+		p = kstrdup(firmware, GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+	}
+
+	rproc->firmware = p;
+
+	return 0;
+}
+
 /**
  * rproc_alloc() - allocate a remote processor handle
  * @dev: the underlying device
@@ -2007,42 +2034,21 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 			  const char *firmware, int len)
 {
 	struct rproc *rproc;
-	char *p, *template = "rproc-%s-fw";
-	int name_len;
 
 	if (!dev || !name || !ops)
 		return NULL;
 
-	if (!firmware) {
-		/*
-		 * If the caller didn't pass in a firmware name then
-		 * construct a default name.
-		 */
-		name_len = strlen(name) + strlen(template) - 2 + 1;
-		p = kmalloc(name_len, GFP_KERNEL);
-		if (!p)
-			return NULL;
-		snprintf(p, name_len, template, name);
-	} else {
-		p = kstrdup(firmware, GFP_KERNEL);
-		if (!p)
-			return NULL;
-	}
-
 	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
-	if (!rproc) {
-		kfree(p);
+	if (!rproc)
 		return NULL;
-	}
+
+	if (rproc_alloc_firmware(rproc, name, firmware))
+		goto free_rproc;
 
 	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
-	if (!rproc->ops) {
-		kfree(p);
-		kfree(rproc);
-		return NULL;
-	}
+	if (!rproc->ops)
+		goto free_firmware;
 
-	rproc->firmware = p;
 	rproc->name = name;
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
@@ -2091,6 +2097,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	rproc->state = RPROC_OFFLINE;
 
 	return rproc;
+
+free_firmware:
+	kfree(rproc->firmware);
+free_rproc:
+	kfree(rproc);
+	return NULL;
 }
 EXPORT_SYMBOL(rproc_alloc);
 
-- 
2.20.1

