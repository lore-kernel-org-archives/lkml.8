Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C0C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE2224D2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+2XZhU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgGNTuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbgGNTuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so7446033ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqC/r0kZGRE0C9tFepj9Kth0ejpSIA3U+4WW75ILzcw=;
        b=X+2XZhU5UYCGPhuwRNJ+463fWfT4ufqSVSE9vwV5GAXH8K4noMZHqr/R9+Rev+GTHD
         nI7nnJa4b3Cr60ljApAjy7JHa7T7ZDX2l5MaOtVkJ8fZPRbQ/VWDGAs9b5tKrkBmlMZj
         mqr/nq/bX2nudSdkUPL1HQwr+0U3o9ByTpfuJFOabm5TawHJaDdRxPiPYqPKmj/ZKPLX
         MM2Oqi5U2Aq8miSEWJE4KhwvnFBvos24kQTdv4D3Kuz4SLmnQXXwRxARcERlskY9z0wx
         l9GN83NjlfsNLDVoflG8YVe6gCDVbGtj3QQ5xsSrY5xb7PKTBERqdEt94rPsvTE3lc5h
         G2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqC/r0kZGRE0C9tFepj9Kth0ejpSIA3U+4WW75ILzcw=;
        b=R/zThW3+RXHQK2DYHBe0zEVAHnWP/ESoaRcXBjVF6v0EHkbs5dVQay2X8e0vZwg/a0
         zYB/OkmKISClMts7m57ctIJHnptb3il+IUS7P7wz0ppcmLrSJ3mb+K7BsrFV1lw51ZjJ
         JIzRg0WIAeH2K+TwCkA9INpuApROqI5PlllQe83RDmSPZS1mrHtxbhUxB5afujWz/syc
         CsjMp46kcycGjw0b9EDzDNgiMjpmZpXirpocrHpcAWRsrzeJCLw5xT2bY+1+sxwT7rBg
         zRw1W14phxetDOGgRa4UI9gSXJmve2P3H62nEE7DUQozneLAIlt5XnFKltgs94WYczFi
         m/sg==
X-Gm-Message-State: AOAM533x4/VPnM8Po+96aW7bwZwzyjZZ6YxiTUnF4r6RLkeneIX+CSUq
        Y28CAVEFScHFODOAyRGr7RZG+w==
X-Google-Smtp-Source: ABdhPJz5fnG+i3dbqwIWs+jFBwufIKFoal4ZG5OQg7uDu6XlcjoRvtcJSwzZednf3VeUffwJtZlZJw==
X-Received: by 2002:a17:90a:3a81:: with SMTP id b1mr6446790pjc.217.1594756245406;
        Tue, 14 Jul 2020 12:50:45 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:44 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] remoteproc: Refactor function rproc_trigger_auto_boot()
Date:   Tue, 14 Jul 2020 13:50:33 -0600
Message-Id: <20200714195035.1426873-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
References: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_trigger_auto_boot() to properly deal
with scenarios where the remoteproc core needs to attach with a
remote processor that has already been booted by an external
entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index caea920ce4b8..08de81828e4e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1568,6 +1568,15 @@ static int rproc_trigger_auto_boot(struct rproc *rproc)
 {
 	int ret;
 
+	/*
+	 * Since the remote processor is in a detached state, it has already
+	 * been booted by another entity.  As such there is no point in waiting
+	 * for a firmware image to be loaded, we can simply initiate the process
+	 * of attaching to it immediately.
+	 */
+	if (rproc->state == RPROC_DETACHED)
+		return rproc_boot(rproc);
+
 	/*
 	 * We're initiating an asynchronous firmware loading, so we can
 	 * be built-in kernel code, without hanging the boot process.
-- 
2.25.1

