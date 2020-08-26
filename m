Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31782078B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXRZ7wbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgHZQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgHZQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C7DC0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so1321995pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL9tfSUkFyPuvtiKmoHXxOSSKMmvouLhdaI7n7GXPMo=;
        b=nXRZ7wbXj6Yjj00jDZ4A8PJU7BVP76i8CVaoyZQ9eIBNGejqdVLMw/2FcEtskj4o8s
         uAc22g/QyUXcuwZj0/8uLoFXmOhJgaoNv/PnmWKksjMGMS/AcrBWR0cuucf+iIyunae/
         C3J0Vk1p54uOJglqvINLZdlNs7a5c1wkqSZxRhaIrx4RqRbFdrDbSdEcMH4Ebxo2q+QB
         UoqjTzVU8pXwf9tetqpqeL/p/1kulqSdFdAz7o4skGUxg6Z+hY5Dr7DjUZdTTWId4JYq
         jied080lnmYvxfszbWLJJw5h5dTtiC/EUgcz9SacdOSoDeN/hiVKrBIUhgn8aFEx3qFO
         S0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL9tfSUkFyPuvtiKmoHXxOSSKMmvouLhdaI7n7GXPMo=;
        b=dzdqXxX+3g1z13GfQPH5PHN6LWqZMLFsXSRO7Jm4vbKMoCDTHHGsu90Uc6OBjZFlnh
         cch531A3F0uMV+S70N/iJC4enFOXL79G0dMLJwJ9OvJHghAWkW8dUVBHiOf3+O49X4Eo
         ew8y4TxV9JdE2A/MQxkGooO6oCcxvkECxAMTWtgz+IEwp7Zo/l03+G0kUjTUrYHmrfbs
         VJo9AVDwX2uPInUGau9kCQKW+dVe548wcgEDxYeI8kACmbNGAw9SkTr1Wm6H5IqyQxDx
         T3X5j7VbJ6gBswlFtYlxOrrV7KuoUVflYs6YJqbDgiWqXGnURFxGw7ZnxFygWdq+1ZBg
         0+CQ==
X-Gm-Message-State: AOAM5336g9qMtDlX9D6uTwyonZlqPXOGK3hcE4J0LvWmSBGQQV43+swB
        e4ZKk79R9lTV7IpstUSTl6BG0A==
X-Google-Smtp-Source: ABdhPJzuZQ1lIacAimgfc2XPYOHki9uGBagGms3yAZQ+2MT+AfhexnSds4k4Pz5q9j1hYN3kf9HRzw==
X-Received: by 2002:a62:cf85:: with SMTP id b127mr13145936pfg.89.1598460339728;
        Wed, 26 Aug 2020 09:45:39 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:39 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] remoteproc: Rename function rproc_actuate()
Date:   Wed, 26 Aug 2020 10:45:24 -0600
Message-Id: <20200826164529.224476-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align what was done for rproc_detach() by renaming function
rproc_actuate().  That way it is easier to figure out the
opposite of each functions.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f3943a1e2754..c4b80ce6f22d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1393,7 +1393,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
-static int rproc_attach(struct rproc *rproc)
+static int __rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1518,7 +1518,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
  */
-static int rproc_actuate(struct rproc *rproc)
+static int rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1558,7 +1558,7 @@ static int rproc_actuate(struct rproc *rproc)
 		goto clean_up_resources;
 	}
 
-	ret = rproc_attach(rproc);
+	ret = __rproc_attach(rproc);
 	if (ret)
 		goto clean_up_resources;
 
@@ -1802,7 +1802,7 @@ int rproc_boot(struct rproc *rproc)
 	if (rproc->state == RPROC_DETACHED) {
 		dev_info(dev, "attaching to %s\n", rproc->name);
 
-		ret = rproc_actuate(rproc);
+		ret = rproc_attach(rproc);
 	} else {
 		dev_info(dev, "powering up %s\n", rproc->name);
 
@@ -1893,7 +1893,7 @@ EXPORT_SYMBOL(rproc_shutdown);
  *
  * @rproc: the remote processor
  *
- * Detach a remote processor (previously attached to with rproc_actuate()).
+ * Detach a remote processor (previously attached to with rproc_attach()).
  *
  * In case @rproc is still being used by an additional user(s), then
  * this function will just decrement the power refcount and exit,
-- 
2.25.1

