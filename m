Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10989C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66DB20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Plflf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgGGVAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgGGVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB524C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so2810782pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=We64aO7YKIIjo14efasxM75BhUGKiURq6Zfe9ioCNz0=;
        b=C3Plflf4zDY0SRUHIW3sw1Di9srXzaWxPO4Tc2Y/LTr2431t/fTOEm9ks48kIuVK+C
         7Ivelw/NqewhMQMWEaQqTmBjSqNkjEN6yKQO+1PU0gsWHLZpg5N1H3QQHAr+6z9/CI/C
         hSBM52mLajXKVYqufiKodDv/WH4y7gg9BodQNQi7xiX2/YIC96kb9zRHis0cF0cHApGo
         r2EHcvQ56UKaWjrVgdyQ/2vCHWkOPI5wrCLNxFG2uHQ5DlaK8jTFUvsSnV65UfcGQ521
         /6jVBdr71eF57laK7IvYFHAQKDhU04JGrP4+ZfKgeRDyXco1ikjcFqQT+XP6zGSdQDRd
         KGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=We64aO7YKIIjo14efasxM75BhUGKiURq6Zfe9ioCNz0=;
        b=Bz3SSEj5VGCTgtMJtxCzpFajFM5jCk2xMCRuWOsyiT8NVE/2GmDPkf5SrHDarRF775
         aWzjCUcQpP+HDiMkW6h/nbmRNNWUvBsyFd12hFku6S7Gl1LD7nt+r1L8PsP0xvoBILLe
         ksChrXJikaZDNiDI1qlluEXKcvwpavoqfySttmf8lKxzVUXC+lh3GG327EOHyJYIGQD4
         c6xSmz3jBQP+JZEUaXpQF8SbxjXWVoMb1XloHkPwQX7w7HktekeYPwYCW3OpXqaKOV94
         GUiD/kqGwlx4+ukC9/9yMICeSSfKo4+gQHCL8Bhn5F3TdvnFm6Tx43oc2F+wA6o48HIn
         PUsw==
X-Gm-Message-State: AOAM532ilXmPrRCfry0cnFbj4qGxqNenzaOOklTT1hxbsV6J0vUMSKaD
        +nlKK7E2yc4WlrY6BG5I9yR2Wg==
X-Google-Smtp-Source: ABdhPJx2r2QLPIBuk24dxnit7yFc7cgFfC9vpIJBZrrTPUVl5biKWDknt+CevhUIDfxQczPGKKAobQ==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr14614952plk.85.1594155625491;
        Tue, 07 Jul 2020 14:00:25 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:25 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] remoteproc: Refactor function rproc_free_vring()
Date:   Tue,  7 Jul 2020 15:00:13 -0600
Message-Id: <20200707210014.927691-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707210014.927691-1-mathieu.poirier@linaro.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When function rproc_free_vring() clears the virtio device section
it does so on the cached resource table rather than the one
installed in the remote processor memory.  When a remote processor
has been booted by another entity there is no need to use a cached
table and as such, no need to clear the virtio device section in
it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 08de81828e4e..6b6e4ec8cf3a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -410,10 +410,22 @@ void rproc_free_vring(struct rproc_vring *rvring)
 
 	idr_remove(&rproc->notifyids, rvring->notifyid);
 
-	/* reset resource entry info */
-	rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
-	rsc->vring[idx].da = 0;
-	rsc->vring[idx].notifyid = -1;
+	/*
+	 * At this point rproc_stop() has been called and the installed resource
+	 * table in the remote processor memory may no longer be accessible. As
+	 * such and as per rproc_stop(), rproc->table_ptr points to the cached
+	 * resource table (rproc->cached_table).  The cached resource table is
+	 * only available when a remote processor has been booted by the
+	 * remoteproc core, otherwise it is NULL.
+	 *
+	 * Based on the above, reset the virtio device section in the cached
+	 * resource table only if there is one to work with.
+	 */
+	if (rproc->table_ptr) {
+		rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
+		rsc->vring[idx].da = 0;
+		rsc->vring[idx].notifyid = -1;
+	}
 }
 
 static int rproc_vdev_do_start(struct rproc_subdev *subdev)
-- 
2.25.1

