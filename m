Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27622078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSc0W8yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHTItu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgHTIts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:49:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59C7C061757;
        Thu, 20 Aug 2020 01:49:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so669734pjx.5;
        Thu, 20 Aug 2020 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qXRk8WNpMQk2AT9ln8YjfpemcnbIfXjB5cVAcAd151E=;
        b=pSc0W8ykxaogfh5HhhcosJssTFpPxajgLuwsoSqWBxNM/QcPKq4CgsE/KIGXXZEZse
         +rQv7fMfCqMWVmGjlxnfkkO+KvIqk3k8WN038loCKNtXJmm4NuKaed0cyN0MSMA3gghK
         Y6ndyJjyA84KDBSLUuDfM+bTZ1LDlRI5QBLMxSq9W/5fA9IpE6/d9VUSDYYksFdh1Pzw
         ur2aso8usyqoIMrqGaCwE6xN4/6OjpOFuokgRQnjV7ZhXKRGbqj8YFsGnwlB9efiYrU0
         v0WAnID1sszWc6V3vqc2LAre5kRYu6iHlnBRnjUL0FsbY0JZmOHQtO6oUu5Oq7Y6HtOq
         pwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qXRk8WNpMQk2AT9ln8YjfpemcnbIfXjB5cVAcAd151E=;
        b=XWvtDoV7RAU+7GVHyYnUJmBIvFfxMe5ePAA/pecVc7FiYYQPXETGMUuBo8Kc7II8vQ
         LHK9eSrTzFQRPbM2wrDPMDGghlw4RDXMpPQB8+tftYOxoniJGuSudT3Kp2O0K+i/UuzB
         lA84WLRuY3OMRkgRWVskoRVZB6iJMN5cdiY0e2920TNVuOuMyMEROpYcMjJ09KcwlLVj
         CNB0r3MT8XP03bLcccP4zw9OjMbpSOLWbLow7q0HFSiQhKFdd1XWPgseuLNItGH1iTG6
         x/Mz/hZc0jWex8Ixx3kzpQZXvpmDabKEQnvTXhrK1NMEpswjBjNFEowNG4Ye9W7m1txD
         YJTg==
X-Gm-Message-State: AOAM530PJPl/jBbLwfD+We2BJw+/ItjohNWZd8BJHczM7xH0opXgJKWo
        cGunCC9Yn8vkxFbEHbEjWU0ZRc33hcXUb70x
X-Google-Smtp-Source: ABdhPJxY5iScA98PzltpTmwq22HrzfQTY1T+l1y3SaDpG4JNya2yVjq5ex+FJiOEeupU9Z9ir7Fvnw==
X-Received: by 2002:a17:902:b405:: with SMTP id x5mr1716182plr.319.1597913386345;
        Thu, 20 Aug 2020 01:49:46 -0700 (PDT)
Received: from blackclown ([103.88.82.201])
        by smtp.gmail.com with ESMTPSA id i1sm1951257pfo.212.2020.08.20.01.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 01:49:45 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:19:33 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/6] staging: wfx/main.h: fix a spelling and grammar mistake
Message-ID: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistake "extention" => "extension".
And correct the statement in passive-voice by adding "be".

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.h b/drivers/staging/wfx/main.h
index c59d375dd3ad..2457cb595b0f 100644
--- a/drivers/staging/wfx/main.h
+++ b/drivers/staging/wfx/main.h
@@ -19,7 +19,7 @@ struct wfx_dev;
 struct hwbus_ops;
 
 struct wfx_platform_data {
-	/* Keyset and ".sec" extention will appended to this string */
+	/* Keyset and ".sec" extension will be appended to this string */
 	const char *file_fw;
 	const char *file_pds;
 	struct gpio_desc *gpio_wakeup;
-- 
2.17.1

