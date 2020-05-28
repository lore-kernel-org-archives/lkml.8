Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2625207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="dDY0jVQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437293AbgE1WoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437274AbgE1WoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:44:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948CC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:44:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 185so298044pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=QBaFOqv0c0/uBoZDY4aBNnVcpPLEnLmvCHMRgMWJn+k=;
        b=dDY0jVQscLnglFYCeXXKPUxOnkZFOHI5oMCCUUPgtlbaRyofv6Vpb0Him68Mti4lWX
         5w0dhZCT7JnfW42xatGA0hjcLyLLONd3lAvTdhtIEM1t7EXrC/kARgFClKxQBhl1jTvE
         rW1Y2HyQLrpBtepMEL0DV5DPyJ3mDD4EcX0/hfFbLOKZNoWgm4WhcJstUHT8QrtO9QgO
         q2up7VizS/0UL6ik6mv9JyoT+b44/orAoL0vuXY4DNOIhD6dPyP8l5/wALJE3wu0y+cB
         Y4gAVxg3JbJNnxjbKrmZUN6pAsRSIRZh53N5a+7JEvhk2BGBzZu0DxsGnteNzQrT0C6u
         +YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=QBaFOqv0c0/uBoZDY4aBNnVcpPLEnLmvCHMRgMWJn+k=;
        b=UGhH8zkKmdoLjcfy9YFvWgecxWLveqOUXtjBd2i/dmbU7MKXmZ1KYv+goq3P3lMee8
         O/8Ig0y3gEcO6n74LLy61ioFWitQj5wLDPnChvysxH4Y7+JZjMRNpAAADUUAUPjV7EJr
         obv7olNATUyQi+BopNNI4oW4A9dmHzc614+ky7PloUN5nGCMSaH0f7BzJhQAVNu6Vaku
         oSQwL4qU0J79kyHPrVgJBCdJ6SnatXT0EU/0WnMr5/Hh4P9FRgPZnUy67+aLYfp/l5LD
         Cj8QM88Gs4tMwoyfuoeWZ4JdoU84vQkhXGgztUiU/TLSBlICTJifEKHoHgS0Ib184UEm
         V9DQ==
X-Gm-Message-State: AOAM530nX9B4U0mv2q0KME81AuFztcgARnOLRbDijGIxzNhB+oaS2B7Y
        8ruxLK4WXdywiClPcU09P9EWYw==
X-Google-Smtp-Source: ABdhPJzXp10j3U1SqiSNNvW2qS7iKYsaFZh/pXRojdN889cl3hLRU0TNFJlZmE3kLeQ4vUf429apmA==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr5496919pgh.406.1590705846528;
        Thu, 28 May 2020 15:44:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 9sm6258908pju.1.2020.05.28.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:44:06 -0700 (PDT)
Subject: [PATCH 2/2] soc: sifive: l2 cache: Mark l2_get_priv_group as static
Date:   Thu, 28 May 2020 15:43:53 -0700
Message-Id: <20200528224353.32559-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200528224353.32559-1-palmer@dabbelt.com>
References: <20200528224353.32559-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, yash.shah@sifive.com,
        anup@brainfault.org, bp@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        kbuild test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

The kbuild test robot is firing a warning over a missing prototype.  The
function can just be static.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/soc/sifive/sifive_l2_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 51e198880a8d..44d7e1951da3 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -133,7 +133,7 @@ static const struct attribute_group priv_attr_group = {
 	.attrs = priv_attrs,
 };
 
-const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
+static const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
 {
 	/* We want to use private group for L2 cache only */
 	if (this_leaf->level == 2)
-- 
2.27.0.rc0.183.gde8f92d652-goog

