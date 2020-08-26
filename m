Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E296C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AFA2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4MqR1kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHZQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgHZQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z18so1148535pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vD2rRkpHQd7S7fgYM9UtluBQRAWNlF6cNXgHEuKBTDo=;
        b=u4MqR1kfjSxsFjxQ0PC6CVjxgQW0LN3TJ+f5D5WxPBbfYC7VvbcnbDe6a2bsjweMD0
         zqA0IvUIthS4sUphaqwCH0nFieEOcHnKksL0wv2C9jzLeZUP6R7/VnUoG5X0fDF/Zort
         O6tTF023b0+CKYMxv1qDpgPMNneIPHm8Js2tzpU7KU2SwgUqeSP8ZUBIryDQ/VD8kTcB
         Iah0xIR/R0yB9nB1NY/Ue3ZnarEhN+fkVgmGGKsVP7Yuw4/iSSTjTmCOLH1FpaASL3T5
         J9eD7F7tlXchyJQSE42YPgiBpdC7nM5HbjRZE5W/hKT32qW+jk36o9D9MI00tNeNGSSA
         5D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vD2rRkpHQd7S7fgYM9UtluBQRAWNlF6cNXgHEuKBTDo=;
        b=SdNpirQ3UT/syVjQs55uHR7B/I4i6qyHEk/on4FhokuTgj9SbJwuyWkh/9/HL8SdxJ
         BiSCY4pEYhyEBBolFRVe+ztI/fMDsdKxLGumB2S2Rxils/HhygpEgROmvBIK5AXpsjWz
         b1Tfogrq4Qp8oEMcqChBRQGuIs2eaju5/cVq6z47q2p97/tRpYTruvoaLEr5fGMi1nSz
         hDT9m+qSUnO35bVW6gMzcoNWj6OQ8D9Ooi6RlD23kwTaULsRDxBUH96BdqwUM6v5Fsi6
         LbTfuJt2el1dOPy2ZpMF7r8uEnpfoJT7HT/0ZPQwqZHzsC4iFk7wRshX5uf1tjVuXOfM
         fLIw==
X-Gm-Message-State: AOAM530g0FPkcPwJSsz9Hp43fWcdmrWvagnZB+A0UK3GZNg+OZQ7Totw
        LfyYSkJe+tt6wPPozjcVbJWVeg==
X-Google-Smtp-Source: ABdhPJwLOPNkqm5e+DQ+X7A/oEpZmAGhLQhscSDhlh/mGOryZjdpE/jnG4AFfe2aiQaYUUcS6lZ34A==
X-Received: by 2002:a17:90a:d3c2:: with SMTP id d2mr6797133pjw.112.1598460342752;
        Wed, 26 Aug 2020 09:45:42 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] remoteproc: Properly deal with detach request
Date:   Wed, 26 Aug 2020 10:45:27 -0600
Message-Id: <20200826164529.224476-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached to or booted by the remoteproc core.  For
that to happen a rproc::ops::detach() operation need to be
available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_cdev.c  | 6 ++++++
 drivers/remoteproc/remoteproc_sysfs.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index d06f8d4919c7..3a3830e27050 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -42,6 +42,12 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (!strncmp(cmd, "detach", len)) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 6134d2f083ce..013231f69837 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -118,6 +118,12 @@ static ssize_t state_store(struct device *dev,
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (sysfs_streq(buf, "detach")) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

