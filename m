Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760D82080D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcE3vFoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGGVAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgGGVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7DC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so202529pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhwZoAnzEhcEEldBirUE6UrK8n9jKUX6Rf1BSaeDteo=;
        b=KcE3vFoT4T4iNFbrk0y+HXUo4W+ZWNwjP0L6IR1g1OHWcbBfSKtExSvzRZYS3b9yCd
         +U/XfEYHmwY3Gdx5dHrml5vLKHDhFOd8g+10Yn4geAlXH4Oikl/w00w2TOE9Vl/Yu+DE
         APPqq+khoADK1goM0ttFnFWGJnqmZ0j6DKxln0GPBmw3mxrhsWNfXVc8I+6GLLfY6WhP
         Wta0ZwM+6N0l1Bf0md/pB4/rkueBueq35yX1779AisASor7K2FfXUqO4OsT0P3+eLo9L
         I1TabNL9iN8DOoxqaAngggKZmUuwEpG9XJ5mpeFcdN9LyqoY7qPx03bWMexvRHw/LGso
         2Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhwZoAnzEhcEEldBirUE6UrK8n9jKUX6Rf1BSaeDteo=;
        b=KBczn4sOxsNy4bCr1yb+/5SZdDi2fD86G2EW9S6cxARStbDoAf50PWHxRIK1ACYgZ7
         HFS8iyLXWEab9yyW9ruui5D/Eanl2ksqIvNl+9GtdZsM3VsJ6z91XyVZ4rrHwXObJIDi
         akdrUNbEwGOamV1FrDt5jdd6YQ+GSt/aIa7SJCkuEFK51OagzlaxItDo2nnSeW9vvBAm
         x5aYA3QHq0B06YCbZVlDjj3Vk6Vw6UC9FEAxBWmiOLy8XRZXCggz2GVfzsoptq0SXQuq
         N5FZ1jVtLAUHeIpvKXLEG2NYmI0VQUzY7bBC0+t8cEEDZXU/0hSCz+Z6WXYo9gQSNuNE
         5zsQ==
X-Gm-Message-State: AOAM53221gl6C708wqu7TvP6VeQHhdpv76S1zvm3kPxQobPj2xay0yX9
        L1Ig/pqXWXLc7gYL5Po4ZokTKt1IJWs=
X-Google-Smtp-Source: ABdhPJy4QJpzH/XmBzCGNu1gC/yOn8c4Bhc6mE4Lxk0rOxnc2ADK41OsJWqAIBxQ5eb9a/DHJBs9YQ==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22mr10578737plo.189.1594155621998;
        Tue, 07 Jul 2020 14:00:21 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/9] remoteproc: Introducing function rproc_validate()
Date:   Tue,  7 Jul 2020 15:00:10 -0600
Message-Id: <20200707210014.927691-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function to assert the general health of the remote
processor before handing it to the remoteproc core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fd424662801f..ad500c291d5f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2040,6 +2040,43 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 #endif
 EXPORT_SYMBOL(rproc_get_by_phandle);
 
+static int rproc_validate(struct rproc *rproc)
+{
+	switch (rproc->state) {
+	case RPROC_OFFLINE:
+		/*
+		 * An offline processor without a start()
+		 * function makes no sense.
+		 */
+		if (!rproc->ops->start)
+			return -EINVAL;
+		break;
+	case RPROC_DETACHED:
+		/*
+		 * A remote processor in a detached state without an
+		 * attach() function makes not sense.
+		 */
+		if (!rproc->ops->attach)
+			return -EINVAL;
+		/*
+		 * When attaching to a remote processor the device memory
+		 * is already available and as such there is no need to have a
+		 * cached table.
+		 */
+		if (rproc->cached_table)
+			return -EINVAL;
+		break;
+	default:
+		/*
+		 * When adding a remote processor, the state of the device
+		 * can be offline or detached, nothing else.
+		 */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * rproc_add() - register a remote processor
  * @rproc: the remote processor handle to register
@@ -2069,6 +2106,10 @@ int rproc_add(struct rproc *rproc)
 	if (ret < 0)
 		return ret;
 
+	ret = rproc_validate(rproc);
+	if (ret < 0)
+		return ret;
+
 	dev_info(dev, "%s is available\n", rproc->name);
 
 	/* create debugfs entries */
-- 
2.25.1

