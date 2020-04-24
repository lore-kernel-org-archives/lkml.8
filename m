Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A644C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5275E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTGfqd8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgDXUBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgDXUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545AC09B04B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so5314453pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waQEaUAc8T/vBKYd/zXfwKYFWqlxffUg008FrjfIrmw=;
        b=hTGfqd8yUCMrEdbo4rCuRrcxrgEuIVxsi1FKpsn5N9UVWk0yhp8NSaQUCiTweALuTl
         nSsjV+VSYO34bwnqqtZVCDRTL1kN6AZ/b2OmfeMgy13IG8dHrg7cgyE0a88sR1mMoywU
         Rkf3TXu2y2l9NgvP5jlyQRXcTjLLdpsEGmp1spmaHKWht3WF+oaFfxr3NDvCABivdKDw
         wB2B7y6DKbqoOoevPhDD9+sWs4AZr1deXLnLmUWvvifSKPwfsyjQzN6g+o7qN40U9k2B
         v3Y5xi26tYT2O3tApbY+hsoralVI34cTrxMeJYG4pyYpMPor+ewEgJO3BMWx9UE9r7DU
         xJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waQEaUAc8T/vBKYd/zXfwKYFWqlxffUg008FrjfIrmw=;
        b=lFLsZpkC6jQOfJjO7PM0BALRj6a8HgDjXAltdz2grtebjm9nGYFfGZyNQdIfYNBlm4
         5MfakmokeZV6Q0+6xR+Bq5hHpylLuP/KdAW/Gm+Lrb02/WbEnR5N7OTpkN/yCFUjG8Pr
         fKBamRCkyF1Kd0o7Dyr3Mh6lXo3g9ywUrU5GAGE5Gf5aZfRcAXA5F+i1XYJLNhfMkLgZ
         j8GayimFGGu7jBQ5RyA78cjj8XOSI5EKFWlSs2Mgl9euWFrJO7mAU7SuWbB988o81fdQ
         D43sAuLJCnVBPfPiQQfKf3tCcObVUrjzc0kV4FTa9YWVzjg0xPptcXFGvpUezUdOQU0s
         uAHg==
X-Gm-Message-State: AGi0PuaMPiv9yAjR0imGQeETer6HxpTXR3U+smvDP7HW/1fSyshjdtAH
        Adp4T1LCV9T5ziNf79DnDWDzCg==
X-Google-Smtp-Source: APiQypJXz4J3bpJOYburAtZcTnIr5jdsIwknm2zBGZGBjDvTEnEyq+jyTMnkG66K+fPMs/ob8wx0mA==
X-Received: by 2002:a63:6285:: with SMTP id w127mr3451248pgb.449.1587758500035;
        Fri, 24 Apr 2020 13:01:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:39 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] remoteproc: Introduce function rproc_alloc_internals()
Date:   Fri, 24 Apr 2020 14:01:23 -0600
Message-Id: <20200424200135.28825-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In scenarios where the remote processor's lifecycle is entirely
managed by another entity there is no point in allocating memory for
a firmware name since it will never be used.  The same goes for a core
set of operations.

As such introduce function rproc_alloc_internals() to decide if the
allocation of a firmware name and the core operations need to be done.
That way rproc_alloc() can be kept as clean as possible.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 31 +++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 448262470fc7..1b4756909584 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2076,6 +2076,30 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
 	return 0;
 }
 
+static int rproc_alloc_internals(struct rproc *rproc,
+				 const struct rproc_ops *ops,
+				 const char *name, const char *firmware)
+{
+	int ret;
+
+	/*
+	 * In scenarios where the remote processor's lifecycle is entirely
+	 * managed by another entity there is no point in carrying a set
+	 * of operations that will never be used.
+	 *
+	 * And since no firmware will ever be loaded, there is no point in
+	 * allocating memory for it either.
+	 */
+	if (!ops)
+		return 0;
+
+	ret = rproc_alloc_firmware(rproc, name, firmware);
+	if (ret)
+		return ret;
+
+	return rproc_alloc_ops(rproc, ops);
+}
+
 /**
  * rproc_alloc() - allocate a remote processor handle
  * @dev: the underlying device
@@ -2105,7 +2129,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 {
 	struct rproc *rproc;
 
-	if (!dev || !name || !ops)
+	if (!dev || !name)
 		return NULL;
 
 	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
@@ -2128,10 +2152,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (!rproc->name)
 		goto put_device;
 
-	if (rproc_alloc_firmware(rproc, name, firmware))
-		goto put_device;
-
-	if (rproc_alloc_ops(rproc, ops))
+	if (rproc_alloc_internals(rproc, ops, name, firmware))
 		goto put_device;
 
 	/* Assign a unique device index and name */
-- 
2.20.1

