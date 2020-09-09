Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ECAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF792145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1TuTK4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgIIAVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgIIAVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:21:34 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9360C061757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 17:21:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b17so691353ilh.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AO2162Bte/ulZ9CvnofKmBqr4RKglDOxVaujf63iCE=;
        b=a1TuTK4MtJFjMI99KomH5XteYCTQYRkUTzIPMFhkGS3RBppusrMHJ1452iq2Akobdl
         mOT92hlud7Ezx19XbZ+Q+T9GD2D2QAwRSz5xDLCmueKASaMZy7Fb3pua5Yny9LJpyjay
         qt6AwEKqxOBcn/baHxGgfksCzuBagajdJD1ykKc5VUALsLpxNjjBwTKC0CHdWkdMD2qx
         nx20wh0CxVzBoW0f1K06wYNTOXdnEuNVA37OuJfS/CoWDbhAuF5OxGSlSQkGrrrpFy9O
         K4pJ6ejXwWaKa6UJegzqfqzGQDyIBFMGd9oYYDfdw1U7fttRIVZLGTzWtP1kF68lcN/j
         ukIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AO2162Bte/ulZ9CvnofKmBqr4RKglDOxVaujf63iCE=;
        b=ZMruFu9uv3RrZQkAqTURn/jtg7g7gV3UWvi1EO4FEB50RB6gAh7MVTKywy7waJlAH9
         ZxBnJw+LLkist22OlwHzjKqqj31YqXTkMKB4wQLLYxv5YwZnZEtXTqDgpIpUkH6TK034
         CFVACHljRF2hRsA5wvP4xBrdCGcgu8J8+Nd+9Hqk6j1UnNnpQe0p5pHWRh5x66p/waJ2
         s0qmP+MUXFR3NxcJMnTxnza4p5tqEcokiymb9II5umqsXg+fmF55tKbEAUb6DB1W09rW
         bUcRnsLLp0MxxTDiuhnWiaKsF7cARhF4ovyHwWMTdMERuzC2iG+d81ibdEtDXGtvlnAv
         DPJA==
X-Gm-Message-State: AOAM530DcwCo+GGfn+yE2qHF2mUC1kEkRAHwzVxZBWHrUsDt4Ecw7dAC
        e9sel9DgC0PiwX5R5eTTc5Gecg==
X-Google-Smtp-Source: ABdhPJxJHNJvd6vjUWApZQY6Iihzu397LyiVMDZUtmGPGDmu/Zlt6omKQG/F4Y+EvlSaPNiE71np+A==
X-Received: by 2002:a92:9604:: with SMTP id g4mr1495062ilh.6.1599610893171;
        Tue, 08 Sep 2020 17:21:33 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f21sm457739ioh.1.2020.09.08.17.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 17:21:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: ipa: use atomic exchange for suspend reference
Date:   Tue,  8 Sep 2020 19:21:23 -0500
Message-Id: <20200909002127.21089-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909002127.21089-1-elder@linaro.org>
References: <20200909002127.21089-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We take a single IPA clock reference to keep the clock running
until we get a system suspend operation.  When a system suspend
request arrives, we drop that reference, and if that's the last
reference (likely) we'll proceed with suspending endpoints and
disabling the IPA core clock and interconnects.

In most places we simply set the reference count to 0 or 1
atomically.  Instead--primarily to catch coding errors--use an
atomic exchange to update the reference count value, and report
an error in the event the previous value was unexpected.

In a few cases it's not hard to see that the error message should
never be reported.  Report them anyway, but add some excitement
to the message by ending it with an exclamation point.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 1fdfec41e4421..6b843fc989122 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -83,6 +83,7 @@ static void ipa_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	/* Take a a single clock reference to prevent suspend.  All
 	 * endpoints will be resumed as a result.  This reference will
 	 * be dropped when we get a power management suspend request.
+	 * The first call activates the clock; ignore any others.
 	 */
 	if (!atomic_xchg(&ipa->suspend_ref, 1))
 		ipa_clock_get(ipa);
@@ -502,13 +503,15 @@ static void ipa_resource_deconfig(struct ipa *ipa)
  */
 static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 {
+	struct device *dev = &ipa->pdev->dev;
 	int ret;
 
 	/* Get a clock reference to allow initialization.  This reference
 	 * is held after initialization completes, and won't get dropped
 	 * unless/until a system suspend request arrives.
 	 */
-	atomic_set(&ipa->suspend_ref, 1);
+	if (atomic_xchg(&ipa->suspend_ref, 1))
+		dev_err(dev, "suspend clock reference already taken!\n");
 	ipa_clock_get(ipa);
 
 	ipa_hardware_config(ipa);
@@ -544,7 +547,8 @@ static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 err_hardware_deconfig:
 	ipa_hardware_deconfig(ipa);
 	ipa_clock_put(ipa);
-	atomic_set(&ipa->suspend_ref, 0);
+	if (!atomic_xchg(&ipa->suspend_ref, 0))
+		dev_err(dev, "suspend clock reference already dropped!\n");
 
 	return ret;
 }
@@ -562,7 +566,8 @@ static void ipa_deconfig(struct ipa *ipa)
 	ipa_endpoint_deconfig(ipa);
 	ipa_hardware_deconfig(ipa);
 	ipa_clock_put(ipa);
-	atomic_set(&ipa->suspend_ref, 0);
+	if (!atomic_xchg(&ipa->suspend_ref, 0))
+		dev_err(&ipa->pdev->dev, "no suspend clock reference\n");
 }
 
 static int ipa_firmware_load(struct device *dev)
@@ -913,7 +918,8 @@ static int ipa_suspend(struct device *dev)
 	struct ipa *ipa = dev_get_drvdata(dev);
 
 	ipa_clock_put(ipa);
-	atomic_set(&ipa->suspend_ref, 0);
+	if (!atomic_xchg(&ipa->suspend_ref, 0))
+		dev_err(dev, "suspend: missing suspend clock reference\n");
 
 	return 0;
 }
@@ -933,7 +939,8 @@ static int ipa_resume(struct device *dev)
 	/* This clock reference will keep the IPA out of suspend
 	 * until we get a power management suspend request.
 	 */
-	atomic_set(&ipa->suspend_ref, 1);
+	if (atomic_xchg(&ipa->suspend_ref, 1))
+		dev_err(dev, "resume: duplicate suspend clock reference\n");
 	ipa_clock_get(ipa);
 
 	return 0;
-- 
2.20.1

