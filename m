Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6111C2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5KaDOmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406308AbgFYQgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406225AbgFYQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA2C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so6466222wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KndlWInJvGoRF0jx06iGKO8/jC8k1E3YyL6CPU2WcSo=;
        b=r5KaDOmoHmUoBA//c0h6Z/tJW/Efnytw8+jeKagT/nqoHeq8C7tkhS7rx7VkcrRRvB
         gwcclc1o0/1iRx/qtLDmRbp9C6WFXPhmErGnQMUnM4ZNkJjAAJ5xW+Y/Ahv7D5IbrErW
         qqDCfL8XFK+6FMHPqWSAmMTaVxuPOrmaCF1a2JnomKonFUbMNx/43JboGkeTMkZNOCce
         JSOHxB7P/CeOhFRi0jNWvSFZyhHPHlQPHGzNMLIZObk046kNJ9fKNOpwEuX0NjZdutLX
         IuvpOxeFl7UoJa6lK2QXF3qC9Y9Bue92b7rPFZFgkxBonDp+G/+dF9pwLxA2NjX8l/PF
         vWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KndlWInJvGoRF0jx06iGKO8/jC8k1E3YyL6CPU2WcSo=;
        b=WYkS5M/NeobQ5/IhPp7H5RgUbRxaoU1rEj7XPL1xCWd9+Q7b5ZeY2i+Yw1ByO14H00
         cDFo0kX74nlncT0ykIL8Xov1b1W58ZgTKJPFzpNtyUrz27Dxm17ps2Qtv4etyegU2OAs
         UfqW9toAyFPAlWrbIT76jTYNNvD4NxkLl/9uiwi6uhDLD5OCSH9A8wBKbLG9fgT0GElS
         88EcidRQRIF4UEE0FR7HWIiHGFnkG4ivZUIS3VfAjTZ5gxV9amdZTEo1Vl6sFqk5SNRp
         iG0eqeGXBapt7k8+qxaI3NrZspa3pHItizbkfy76n/dFzE00fD9VIwOb/WNV4DOrz/nB
         xUag==
X-Gm-Message-State: AOAM532jj9BE/WkCkYEssLiI5oqnpQ9CEUu0cHwOgxrkmlCKpqx7ZmTs
        Mj0s2wDbgIqPG7PxeBKB8vMzPg==
X-Google-Smtp-Source: ABdhPJy3yUyH7m9+jnH6hFEnfrBJRT4MVIZzAefQ4i4842f/fHklh/4aAb7/aJWNEGTQeJcFl9zbnA==
X-Received: by 2002:adf:e648:: with SMTP id b8mr38605083wrn.386.1593102987753;
        Thu, 25 Jun 2020 09:36:27 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/10] regulator: dbx500-prcmu: Remove unused function dbx500_regulator_testcase()
Date:   Thu, 25 Jun 2020 17:36:08 +0100
Message-Id: <20200625163614.4001403-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't any code present within the current kernel to
override this 'weak' function.  Besides returning '0', which
is never checked anyway, the whole function appears to be
superfluous.

Consequently fixes W=1 warning:

 drivers/regulator/dbx500-prcmu.c:113:27: warning: no previous prototype for ‘dbx500_regulator_testcase’ [-Wmissing-prototypes]
 113 | int __attribute__((weak)) dbx500_regulator_testcase(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/dbx500-prcmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index f604c8db6d0e9..c3ad6aa6b5d37 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -110,13 +110,6 @@ static int ux500_regulator_status_show(struct seq_file *s, void *p)
 }
 DEFINE_SHOW_ATTRIBUTE(ux500_regulator_status);
 
-int __attribute__((weak)) dbx500_regulator_testcase(
-	struct dbx500_regulator_info *regulator_info,
-	int num_regulators)
-{
-	return 0;
-}
-
 int
 ux500_regulator_debug_init(struct platform_device *pdev,
 	struct dbx500_regulator_info *regulator_info,
@@ -152,7 +145,6 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 	if (!rdebug.state_after_suspend)
 		goto exit_free;
 
-	dbx500_regulator_testcase(regulator_info, num_regulators);
 	return 0;
 
 exit_free:
-- 
2.25.1

