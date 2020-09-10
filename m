Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCDEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3122075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trv3TSNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgIJHLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgIJHAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:00:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A14C061367
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:55:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so4486099wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVfVHRbfLs77xvEowdNmRYJl1Eqf3t8uGBw9b5yOc7s=;
        b=trv3TSNssv4jT0t36HHkekyc5oQb9OrM4SsI9V82hbXUfKMjBOl87eNt5/GlaRiJ1N
         b4CNDROwIGksCc9TQn1MhsscUtgT/gCzPhxxv7ckxHZzRvTEQZQRI4+UyxSQYnsefY4g
         3atu7eH/kqNeLVaFi3AswTh+b5onrTfyRZT/tX7cIE1CB6xhSCPAHi7uHcYpHkgtNqYe
         s6Oz2ylbPHLbs+GIgOUP9cmpxIPC0uj8VvmFFHqDLm4uTLp1PvIA1JvhpPmFICzV5CAJ
         hydx8KqkleMdHQbi2lCMJWP3Air13xuIRIVXhXyjZm4+RYumUgaXf4MZQMY64yV19jso
         kgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVfVHRbfLs77xvEowdNmRYJl1Eqf3t8uGBw9b5yOc7s=;
        b=lprNInC0Dv5Ar+n0WooG50G6iF71KR3Ia1wGPW7uzBevgdpkidhP12IAnDAhPNqShg
         CXETVtAi3ReYE2W1ceBCMNmhiIjQvr2Oi3iSbI05WTVNWz7q9oHeJlO9xQieMto7P3zW
         AV/EqknsNfXMqymJnwZrXEtuHl1PLHVd3bGCcEV4ZAZernPc5uFRcLLjz5Wqbm6lfyeP
         fBixsOzXZg7v/QuDZgm+szRlAYR7wNl6TPMImlgsQZUhTgNV3iQWtieUmA0EoChhtXdE
         fWSoVMUAErBd8lWfOPrb4AhbLQduijBgT1uCFF4Xy37Z2FE0tO0VdHGnBGb5O2Kg8KSi
         F9oQ==
X-Gm-Message-State: AOAM533M/6SfBpsWF47nG92xEinK3HA57rDNMUoVkgSKP5hqJrLfVoc0
        ZJBc69W6ug6n6J54kUkobYISDg==
X-Google-Smtp-Source: ABdhPJyK8KGbYnywMP2YHH8s/CfQGpRnnXKWDD5/aH/JPxN4EAvG/bWpYAX3/8b5XNDbUCTa5/8R9Q==
X-Received: by 2002:a7b:c44b:: with SMTP id l11mr6834265wmi.52.1599720922334;
        Wed, 09 Sep 2020 23:55:22 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: [PATCH 25/29] ath9k: ar9001_initvals: Remove unused array 'ar5416Bank6_9100'
Date:   Thu, 10 Sep 2020 07:54:27 +0100
Message-Id: <20200910065431.657636-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar9001_initvals.h:462:18: warning: ‘ar5416Bank6_9100’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../net/wireless/ath/ath9k/ar9001_initvals.h  | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9001_initvals.h b/drivers/net/wireless/ath/ath9k/ar9001_initvals.h
index 59524e1d4678c..aa5f086fa3b0b 100644
--- a/drivers/net/wireless/ath/ath9k/ar9001_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9001_initvals.h
@@ -459,43 +459,6 @@ static const u32 ar5416Common_9100[][2] = {
 	{0x0000a3e0, 0x000001ce},
 };
 
-static const u32 ar5416Bank6_9100[][3] = {
-	/* Addr      5G          2G        */
-	{0x0000989c, 0x00000000, 0x00000000},
-	{0x0000989c, 0x00000000, 0x00000000},
-	{0x0000989c, 0x00000000, 0x00000000},
-	{0x0000989c, 0x00e00000, 0x00e00000},
-	{0x0000989c, 0x005e0000, 0x005e0000},
-	{0x0000989c, 0x00120000, 0x00120000},
-	{0x0000989c, 0x00620000, 0x00620000},
-	{0x0000989c, 0x00020000, 0x00020000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x005f0000, 0x005f0000},
-	{0x0000989c, 0x00870000, 0x00870000},
-	{0x0000989c, 0x00f90000, 0x00f90000},
-	{0x0000989c, 0x007b0000, 0x007b0000},
-	{0x0000989c, 0x00ff0000, 0x00ff0000},
-	{0x0000989c, 0x00f50000, 0x00f50000},
-	{0x0000989c, 0x00dc0000, 0x00dc0000},
-	{0x0000989c, 0x00110000, 0x00110000},
-	{0x0000989c, 0x006100a8, 0x006100a8},
-	{0x0000989c, 0x004210a2, 0x004210a2},
-	{0x0000989c, 0x0014000f, 0x0014000f},
-	{0x0000989c, 0x00c40002, 0x00c40002},
-	{0x0000989c, 0x003000f2, 0x003000f2},
-	{0x0000989c, 0x00440016, 0x00440016},
-	{0x0000989c, 0x00410040, 0x00410040},
-	{0x0000989c, 0x000180d6, 0x000180d6},
-	{0x0000989c, 0x0000c0aa, 0x0000c0aa},
-	{0x0000989c, 0x000000b1, 0x000000b1},
-	{0x0000989c, 0x00002000, 0x00002000},
-	{0x0000989c, 0x000000d4, 0x000000d4},
-	{0x000098d0, 0x0000000f, 0x0010000f},
-};
-
 static const u32 ar5416Bank6TPC_9100[][3] = {
 	/* Addr      5G          2G        */
 	{0x0000989c, 0x00000000, 0x00000000},
-- 
2.25.1

