Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD26FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D53F224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAhGruAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgGNTu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbgGNTuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE42C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so1232698pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMyi9G4SQ4whd75yWsK3XcIzJ3knuveu4wwY4ps0adQ=;
        b=bAhGruAwC8ofZckxr4Bc1z5NeDH/ZzOKiajCa4lg05QaBfUnVHPEWgYjSAsi7SqZhe
         CfujtZ4ErzL0fTYr5XlxD5jBxue3Gyim6FsVweK1WRNyCD9HzsA6MqMSeIuZSsMYUZiz
         xIUjqwBFLJjU00b4adosiyv3tC+2U8Imas6UCS924n4EC+9+MiOjolS//PBslNmxRGyP
         6TeKhORVNYhSx4DdWRoZFHlb/1KpNxq6A44epNhsPHbUcaf9DebdIsaR2GuGBQCYGu42
         99iHsvjghfqKBemizQkzN43tetUKz/DcVsaRuDlJoIb7uUsVC+5/hQ9gwTWzRjMDrnqZ
         Qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMyi9G4SQ4whd75yWsK3XcIzJ3knuveu4wwY4ps0adQ=;
        b=K8mIn6igSgMYIGgy402DIk2TUTQppXN5qxVHbp+nQTGQxpsuZ2eJ7W0WJKbGm1aV6n
         SJkiSnlb6UdAu6xapycvXqZgz4qzoNthymnd9Vfa14dL7bUZACT6avrMRpABAI6hYw3v
         GHRY3X/f5cvijQg4tmke9tRODn3sInKwWN1vAbSVr0lCXPT6o84IOzJwXnTRuLY0gW6A
         vdS3Kh1xMpxQgWarlsvRY3tUFGjxIuuotYLxmAlb0PfmefZHhZ8+vEbxJ1FkQTfh4TsA
         Rht1AdllKbXddsgCtt1gb/2iGAyX3wQobHvi9HBv5Bn5nBV9Vp/yTyMwxzKwicHycMlK
         sFQQ==
X-Gm-Message-State: AOAM530cw2guyMAsA8UoELv/Cfo+rKtF1tGxPNToweTTlY4Xy78oekXX
        Kd00E81l6TulpteGTqCPhO76FQ==
X-Google-Smtp-Source: ABdhPJz2/oKVIa7YB+mIuN2swG7Ca/VMKtO0ZCgPjLyOHESdHDISHwd3fbG5yzu6V0bhvIMlNS7yKg==
X-Received: by 2002:a17:90a:e987:: with SMTP id v7mr6121530pjy.56.1594756246494;
        Tue, 14 Jul 2020 12:50:46 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] remoteproc: Refactor function rproc_free_vring()
Date:   Tue, 14 Jul 2020 13:50:34 -0600
Message-Id: <20200714195035.1426873-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
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
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
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

