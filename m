Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE721C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BE1214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h89uziQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgDXUCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgDXUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE198C09B050
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so4136782plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgVYOEmLZR8T9VFdpsNRc2Uupq9jBoUolgKHoUHryRE=;
        b=h89uziQxnhqYDcmCgJtLSGdwCmHn0rC3Bu6mCDpOZ1qvYGWQlY3Z/6z+q6XrQXUluw
         nBTa+n77E8ofbTHybs+f9luqWuEGK2sawnmbePJGXfy0Oc0mXGNd4b8etpYU09LVnKpa
         MTlPo9c+GaghCNR8InPWnE9jvvacc0i224AGTD5P+PxgUr1eaHcNoYS4mSvrOgKyMmAl
         3na+xIhktKRyb3SSIQVjk1ypUZxjl0/3pGUtbgGKS8NWqEW0twKZzV1lRfw2OuRBYGZq
         +moyE4C56HRvW/psOtJRhtJCti2DhCRmKO8k55+XHzf0FvEMYgBsdZDUX0eV3AxvaRPz
         N7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgVYOEmLZR8T9VFdpsNRc2Uupq9jBoUolgKHoUHryRE=;
        b=ZF/rZ34n1ImHCnMF66YHVatNi+vkbGsFCwFnmxFjXSg0DmJnoj/rhWLCta1vYvqXCe
         DdR4GMb55aVC8C6YsWwvQKCbUdIThoUq9hfVFN9GkBtXd673m+u5T8HYFBWGR2nLbNcA
         /QMZYJWaPStm7xeqCLl9GEWQeP8QKra0Jr0CDyXwjj9VGIaSnx6788MeUJcu6ILBZgDB
         wf/+x7jvZ9wOZxkNpNRdfHr+ZE6ZuV4h0NCiiCVv1q4I+i4b2xCKP5bEpk3KAUGKWZDg
         5K0FfgWEfEvcnigYqnrfhSfPzspE5fMff6jfAjRW53oyUCrNYUkgTtMfj1UQ1Vy9QDda
         5FOA==
X-Gm-Message-State: AGi0PuaW03KyQhm9Pe9yH9liNeh2dfav4hk329XbdmIK+0i5Rrib+Mbv
        kjmUXc6AqgT9lKRL2rvZbXYzrQ==
X-Google-Smtp-Source: APiQypJ83gbDmQF4KfzVXB98/GgtBjTuNiayG+21Qtkv8hHGZIq9fXWsjiw9IoOg1wXRMARx3iDpOw==
X-Received: by 2002:a17:90a:e608:: with SMTP id j8mr8415911pjy.44.1587758505366;
        Fri, 24 Apr 2020 13:01:45 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:44 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] remoteproc: Refactor function rproc_trigger_auto_boot()
Date:   Fri, 24 Apr 2020 14:01:27 -0600
Message-Id: <20200424200135.28825-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_trigger_auto_boot() so that it can deal with
scenarios where the remote processor is already running.  As such give
it a new name to better represent the capabilities and add a call to
rproc_boot() if instructed by the platform code to synchronise with the
remote processor rather than boot it from scratch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e90a21de9de1..9de0e2b7ca2b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1457,10 +1457,17 @@ static void rproc_auto_boot_callback(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
-static int rproc_trigger_auto_boot(struct rproc *rproc)
+static int rproc_trigger_auto_initiate(struct rproc *rproc)
 {
 	int ret;
 
+	/*
+	 * If the remote processor is already booted, all we need to do is
+	 * synchronise it it.  No point in dealing with a firmware image.
+	 */
+	if (rproc_needs_syncing(rproc))
+		return rproc_boot(rproc);
+
 	/*
 	 * We're initiating an asynchronous firmware loading, so we can
 	 * be built-in kernel code, without hanging the boot process.
@@ -1971,9 +1978,12 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
-	/* if rproc is marked always-on, request it to boot */
+	/*
+	 * If the auto boot flag is set, request to boot the remote
+	 * processor or synchronise with it.
+	 */
 	if (rproc->auto_boot) {
-		ret = rproc_trigger_auto_boot(rproc);
+		ret = rproc_trigger_auto_initiate(rproc);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.20.1

