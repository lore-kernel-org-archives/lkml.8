Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9743EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2222173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvES/tYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHFVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:46:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 14:46:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so7378562pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBJo4g7WD8Q0CXMt6Faq1mpWS1XwcImWvPnpBXweObY=;
        b=cvES/tYtOBfPE65oKMlCW5cYBN4Vl8SiwPfRFOb22ZM2czR4EnhDYDBzk+X5yEPJzj
         FwLm94z7CBBXwTDd2f3s7CTX2xPmIF43l9PhaTJ2VFAWSERlIzuhAyDxw38H/VAxM0uh
         Ig+JdxpHkVs6HWfMZzEhGjTgrYlaYXGHpc4BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBJo4g7WD8Q0CXMt6Faq1mpWS1XwcImWvPnpBXweObY=;
        b=gd255Epm4LidoaKAbUcmIDU+/N9/QNIHsu9D5W4QKdMeWj4Ez0UlaFUOGLO0u4iDrG
         tOwRvVlj9QTSKwQOCbkdPoSfNmiwm8vSM8/O2ImGFh4PVUjrWBrxiUrJqFz23vkqwNQS
         6sq8udKbtsDVFQUvSlNwkMRkGmzJFt+xTqBZIvvpJe4xVmLIRkvNMTWbUURNCon3G1bq
         IH9eusbyFKDC0uOV8M190yrgt1w39jrBkL70GIw8C5lmY+uxDVL/HV3lfDrX6Pv9M1Cr
         Xa+HbFzjXJzERuJ4WG6ZqgZBry26Uhx0JgyUSJOTda0noqVk4H2nDQnlEPqGPmThvz4o
         N2jw==
X-Gm-Message-State: AOAM530FObSvJG0/1PjGbysZ7uSxTdeC89YyV/KUHUdFQ1RHNty+07rM
        +Zkiz0ZlPPSuuTs4o/38SaAYTk/9qrA=
X-Google-Smtp-Source: ABdhPJzDB/TW1q7lZWSPnvsYG2AvoynhJcTqAaCNox6pzNQzytl9kA53uQIKodzes5RpZbwfxBMW8A==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr9645941plj.170.1596750394363;
        Thu, 06 Aug 2020 14:46:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id n10sm8677549pgf.7.2020.08.06.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 14:46:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] syscore: Use pm_pr_dbg() for syscore_{suspend,resume}()
Date:   Thu,  6 Aug 2020 14:46:33 -0700
Message-Id: <20200806214633.204472-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug messages about what syscore suspend/resume hooks are called
are only present if you have initcall debugging enabled. Let's move
these messages to pm_pr_dbg() so that the syscore PM messages are
included along with all the other PM debugging info that can be seen
during suspend/resume debugging.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/syscore.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/syscore.c b/drivers/base/syscore.c
index 0d346a307140..13db1f78d2ce 100644
--- a/drivers/base/syscore.c
+++ b/drivers/base/syscore.c
@@ -50,7 +50,7 @@ int syscore_suspend(void)
 	int ret = 0;
 
 	trace_suspend_resume(TPS("syscore_suspend"), 0, true);
-	pr_debug("Checking wakeup interrupts\n");
+	pm_pr_dbg("Checking wakeup interrupts\n");
 
 	/* Return error code if there are any wakeup interrupts pending. */
 	if (pm_wakeup_pending())
@@ -61,8 +61,7 @@ int syscore_suspend(void)
 
 	list_for_each_entry_reverse(ops, &syscore_ops_list, node)
 		if (ops->suspend) {
-			if (initcall_debug)
-				pr_info("PM: Calling %pS\n", ops->suspend);
+			pm_pr_dbg("Calling %pS\n", ops->suspend);
 			ret = ops->suspend();
 			if (ret)
 				goto err_out;
@@ -99,8 +98,7 @@ void syscore_resume(void)
 
 	list_for_each_entry(ops, &syscore_ops_list, node)
 		if (ops->resume) {
-			if (initcall_debug)
-				pr_info("PM: Calling %pS\n", ops->resume);
+			pm_pr_dbg("Calling %pS\n", ops->resume);
 			ops->resume();
 			WARN_ONCE(!irqs_disabled(),
 				"Interrupts enabled after %pS\n", ops->resume);
-- 
Sent by a computer, using git, on the internet

