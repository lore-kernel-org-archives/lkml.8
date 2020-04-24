Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93401C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B91C214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQ2U1b8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgDXUCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgDXUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC16C09B04B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so4130058pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rb70E/sjGdouOLoWnX7vl3Ag+u7wzfoBCVwZVo3HJd8=;
        b=nQ2U1b8khZFfIfjOuvs7xqMrSwowogjemD4mPQXzUxFybJtnqqu0wz83C9Xy9WzxjK
         BR5SM0fkeuVtP00aV10s31vFYUrPfKfroOSGtQ+x6c7zp9iEYrg9LYxy2nQo6XVNJK9o
         tA1hkmNN3wXKGrpFuueUK2WquyplBhHywJqkjiteGWj/SpancKa4wHsaBVd3r+ITQLt5
         nZYDGLys/6olCPsbJAs2TYqvlArstuJvbBTyyWSo1tvYu1Yfjaa8t/JPfuKttZwiLnGS
         kmn3KZKlGNFMPu+I4r7/7/mGV+j+taV3mOtBzqEvITyaCXnXG+PF4q1J1AJATywYH+TO
         AAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rb70E/sjGdouOLoWnX7vl3Ag+u7wzfoBCVwZVo3HJd8=;
        b=t4rkaA50sz9vKijVkhzlU/CqP6WFNys3Jts0Cm6AP0gcass8YcCgCC3sYcru2AjLlI
         gu/9sPv4R7pnMxlLhHrz78DRXQQknyPRaW+Rh7PvoMqbZdrHjfqDWkBzoVJAZAzDlhMs
         6ak6i7A22aHYtYR5SbtFIVe6fOt1LHF6nclvn2OoYZEMUyV1Il0OSWokAi/dKVygM0nN
         Nu3lTO4Upa7syZrAOAIP2EEeiYHEp3crlkuRFuaUXjauQ/PzoZtKTl3+6v7IAgfA0wav
         mxHkTtMJXfn79PzyUPhq6sQo7LSTlLriWInzZYkFcPOtFjuttoaGWi5DMMZfo6+MZY9q
         htJg==
X-Gm-Message-State: AGi0PuYv19HPug8OAarAvhnVM6TWSRhVHwYoGHaPVtXb8yqbJY8JgJYj
        opKBqH+xTSk0B1sIMTgtOANidg==
X-Google-Smtp-Source: APiQypK4C28yh0PLdX0/fSmEWnxbUJ2uF1f02JWzlTKDSyT3ZBXAedHvxEuxZren5njEVG7AHjvb4A==
X-Received: by 2002:a17:90a:1b67:: with SMTP id q94mr8348667pjq.84.1587758514536;
        Fri, 24 Apr 2020 13:01:54 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:53 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/14] remoteproc: Document function rproc_set_state_machine()
Date:   Fri, 24 Apr 2020 14:01:34 -0600
Message-Id: <20200424200135.28825-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few words on the newly added rproc_set_state_machine()
in order to adversite the new API and help put people into
context.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/remoteproc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/remoteproc.txt b/Documentation/remoteproc.txt
index 2be1147256e0..550ed9a06a27 100644
--- a/Documentation/remoteproc.txt
+++ b/Documentation/remoteproc.txt
@@ -132,6 +132,23 @@ On success, the new rproc is returned, and on failure, NULL.
   **never** directly deallocate @rproc, even if it was not registered
   yet. Instead, when you need to unroll rproc_alloc(), use rproc_free().
 
+::
+
+  int rproc_set_state_machine(struct rproc *rproc,
+			      const struct rproc_ops *sync_ops,
+			      struct rproc_sync_flags sync_flags)
+
+This function should be called for cases where the remote processor has
+been started by another entity, be it a boot loader or trusted environment,
+and the remoteproc core is to synchronise with the remote processor rather
+then boot it.  The synchronisation flags @sync_flags tell the core whether
+it should synchronise with a remote processor when the core initialises, after
+a remote processor has crashed and after it was voluntarily stopped.  Operations
+provided in the @sync_ops should reflect the reality of the use case.  For
+example if the remoteproc core is to synchronise with a remote processor at
+initialisation time, sync_ops::find_loaded_rsc_table should provide a pointer to
+the resource table in memory rather than fetch it from the firmware image.
+
 ::
 
   void rproc_free(struct rproc *rproc)
-- 
2.20.1

