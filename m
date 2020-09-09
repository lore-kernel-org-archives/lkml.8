Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CA82145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hq5DELpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIIAVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgIIAVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:21:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC88C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 17:21:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so1334536ioe.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLkAtO8yV6hC5XQeCIKds/Y/O7Y4arloVOta9bNoDaY=;
        b=hq5DELpR+vU0Y9o5e2HUj0mATndL/qH/lvWoOo5vpdPAnLmfDyqNVW2XmT94onsQsr
         qsowN6z3HwhMa7tuAn8DwOQrm6Va35JvqXV2sda28FRc5mgRitvOeT2mN3Ane0hyyDbU
         WYrH9+XjpJoYQz6usO7IoYk33gAKTd8gGyjs5nC9rd7DQk67XFE+YfhvlwrOzJJaf83w
         jqsDM1wexcB9D9Pc1af4smM3lwmMrlpX00yLkLx5ky2Q7GJRcpEDoZJ7+Ax5AZrPGVJZ
         hlgEBHyUZMu0dGFEZ5sa2cJ+/fb8ifo+9EtvXPcHkwQ4eFTqslM3Yt3+exuWte+6VHRt
         QulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLkAtO8yV6hC5XQeCIKds/Y/O7Y4arloVOta9bNoDaY=;
        b=qyH8zp4IE7cujQeEMHgRqPD0cnbXxaXKqRQldrS5DHYZRD6DMRNNxJd+VfynG0boBE
         j1Yfv41brcL5ThMDuZeJso03328LMX83TnZV4KxKmBa+O0QeAS8mm593KYYwPv24FsSx
         /j88JN6memc9HdZQnDIKsp1WYvwFH1+LkNqfSZzRKY146ws9sjoN9IEFu/KFpkPebjSY
         o/LACVz3jytF1mkgCMILp/aV6wj0Hzfq6yl/aZpjjhxoV93DZvKOF8B6DMhaih1Tn6vM
         N5cln/EXaMquDKh16U557gHKUTqbKnnvq9HRaSLfwaZHgLVBRbBg6LSLs+G05BJ3ZOOa
         TyFg==
X-Gm-Message-State: AOAM530WxHzGDWFN23TdosuaaAbW5yHIYmAeqHeKCRpJbubt6HK6uVs7
        LkQYi+O/a+GBc786XSi7YeuPFw==
X-Google-Smtp-Source: ABdhPJyzaytMOdMELvsLiAoxAUyb2niwFIKcmbNaUbQfBW1zi44brpxBXl/X/F5gRw/0l7C1M2zV+Q==
X-Received: by 2002:a02:ac5:: with SMTP id 188mr1673917jaw.79.1599610894247;
        Tue, 08 Sep 2020 17:21:34 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f21sm457739ioh.1.2020.09.08.17.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 17:21:33 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: manage endpoints separate from clock
Date:   Tue,  8 Sep 2020 19:21:24 -0500
Message-Id: <20200909002127.21089-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909002127.21089-1-elder@linaro.org>
References: <20200909002127.21089-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when (before) the last IPA clock reference is dropped,
all endpoints are suspended.  And whenever the first IPA clock
reference is taken, all endpoints are resumed (or started).

In most cases there's no need to start endpoints when the clock
starts.  So move the calls to ipa_endpoint_suspend() and
ipa_endpoint_resume() out of ipa_clock_put() and ipa_clock_get(),
respectiely.  Instead, only suspend endpoints when handling a system
suspend, and only resume endpoints when handling a system resume.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 4 ----
 drivers/net/ipa/ipa_main.c  | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 398f2e47043d8..f2d61c35ef941 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -229,8 +229,6 @@ void ipa_clock_get(struct ipa *ipa)
 		goto out_mutex_unlock;
 	}
 
-	ipa_endpoint_resume(ipa);
-
 	atomic_inc(&clock->count);
 
 out_mutex_unlock:
@@ -249,8 +247,6 @@ void ipa_clock_put(struct ipa *ipa)
 	if (!atomic_dec_and_mutex_lock(&clock->count, &clock->mutex))
 		return;
 
-	ipa_endpoint_suspend(ipa);
-
 	ipa_clock_disable(ipa);
 
 	mutex_unlock(&clock->mutex);
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 6b843fc989122..b8e4a2532fc1a 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -917,6 +917,8 @@ static int ipa_suspend(struct device *dev)
 {
 	struct ipa *ipa = dev_get_drvdata(dev);
 
+	ipa_endpoint_suspend(ipa);
+
 	ipa_clock_put(ipa);
 	if (!atomic_xchg(&ipa->suspend_ref, 0))
 		dev_err(dev, "suspend: missing suspend clock reference\n");
@@ -943,6 +945,8 @@ static int ipa_resume(struct device *dev)
 		dev_err(dev, "resume: duplicate suspend clock reference\n");
 	ipa_clock_get(ipa);
 
+	ipa_endpoint_resume(ipa);
+
 	return 0;
 }
 
-- 
2.20.1

