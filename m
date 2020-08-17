Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C38AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2928F20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/fB+QTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgHQI5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgHQI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E97C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so7156436plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BUyJfA7GFxP9WYsjCnnZ5mhqqCfe8H9sguy9Hytfvfg=;
        b=G/fB+QTqCm8k7mhRijwIxwba+mTQode2Jl/2UU6gOPC0JsAFH/fIL8evc9I3tbrOyU
         cCqDbaJvuDHO40b6W/et7LZulgTWe+MXBEldXqlH9kbb0hJFj88uGimDxS1dTXO3N3sY
         YSMFtlclh4VZbFzrvqQL5ZcMHKl8JLRHqaKPtTK45jYZq61Vr+giBnUA7uGzZO8WwNqf
         Cy0dO0sXHnJ6g9HJp8InvVgcQbjh297hWRiwD9bR1lm2kN+X1wfCave1/wQyoCg2+v6W
         kDqd8EPX/VIG/qkduURrSkBgjlaSZ2HE1ihEUUUaxtHVNF5Tcv3kug/7chOYpLpi56BT
         x/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BUyJfA7GFxP9WYsjCnnZ5mhqqCfe8H9sguy9Hytfvfg=;
        b=lfB8+bBHwDyLG5IX4ZTmmJzdZefG2CSb7cRzSApxU7k7s3mpi0rxzuLTgo4xJ+72vo
         pz6BQtY7PHxUFhBhUbmoh4qEJ3QTTawzdP8xDzWHbbaberfBCUz4Imq5xKlOC13z7Jfh
         zhub4DndvrLzdenMwdx5ZMcH0/chmeKDCT4r7F6cdPhkHq9wxThqowjrEZuixfpdhuPQ
         HU5M9lsBqBF2adQEtTJoXora3YC7eJJi7nRSaayEJoxvj3fWvPRjTJK/slMbAyaEHlIj
         JAqLB3jfQoaA0GdKX/7GXGO7UHm84M3XFZuADVkJCrz3Zn/vgr8gvbGpV6/dh4fVtqUm
         ulkQ==
X-Gm-Message-State: AOAM5339hJB41rqQNHYKb06xjnFKySDbUUjRPY12zQl2QzheUV+7bYak
        GHbyYiIiaTZfOvs/WFRphKE=
X-Google-Smtp-Source: ABdhPJw7/y8A/avyYJkiysQnBIdqxOnFQJNr9WEE5nQtoVqyG0Vhc3lJVXthcnXO0rCAGGIqhorW3w==
X-Received: by 2002:a17:90a:13c7:: with SMTP id s7mr8101561pjf.233.1597654672671;
        Mon, 17 Aug 2020 01:57:52 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:52 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 06/10] sound/soc: fsl_esai: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:26:59 +0530
Message-Id: <20200817085703.25732-7-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085703.25732-1-allen.cryptic@gmail.com>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 4ae36099ae82..79b861afd986 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -708,9 +708,9 @@ static void fsl_esai_trigger_stop(struct fsl_esai *esai_priv, bool tx)
 			   ESAI_xFCR_xFR, 0);
 }
 
-static void fsl_esai_hw_reset(unsigned long arg)
+static void fsl_esai_hw_reset(struct tasklet_struct *t)
 {
-	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
+	struct fsl_esai *esai_priv = from_tasklet(esai_priv, t, task);
 	bool tx = true, rx = false, enabled[2];
 	unsigned long lock_flags;
 	u32 tfcr, rfcr;
@@ -1070,8 +1070,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	tasklet_init(&esai_priv->task, fsl_esai_hw_reset,
-		     (unsigned long)esai_priv);
+	tasklet_setup(&esai_priv->task, fsl_esai_hw_reset);
 
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.17.1

