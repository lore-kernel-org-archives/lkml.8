Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE1E20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPoMu5Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgHSH1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgHSH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:26:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A72C0612ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so1129861wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBzEfUvbe/jRxzO40K//jsXnpXNEErVa5XTqzMamXvQ=;
        b=ZPoMu5Mnjwjb2haLK/vWqa5/tiSHCy/nDwn5iNOZzCWhgKIwRtvzNmPbfgsLA9mSCg
         zRsT6Dl3A9atOt/5phe5ubnK5JMjdzGrA9GilbM4MIWx0166QKyIhojxdypPKC0V5VDK
         ZnHPLtq4hiYgQpqPWykjq7DJjbaoLzs6L0cejAK7tQXF8sxNxm0iuYv7Nd5EYpxeEDOw
         RUaCF1WLEKZeRwSl8QLaQmUP5olDYJQF4zxPVdACZYfdP6T2oZBQsW3yHRvpA7zVcJGA
         Z+xgsDSv/moQJLnT66JMqJgQB0tQMC3JT8GO+kBXgvwGJ4Ol5gE7zRGJOHjC5RGCSU6z
         qE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBzEfUvbe/jRxzO40K//jsXnpXNEErVa5XTqzMamXvQ=;
        b=LhHi7g5UdVh8uT7bGx5pRPxH8mUPxivQwnL9xBxFgXZL3Q5IKPfDPE+bVfPL4CPb7g
         mhzvG6HUIjImw3zPyTc5tOBIgQeNU8MOQwiA3qVhBN6hAkuWa0EkFSTSoC1e4hpxzR/W
         cZQ8nW7cNy7hmEHL4CgdjMS1KecqwQ1Bft72mXNamDMSlUdWat0BdqDQsSmRlkGAwU/S
         uqeuoA4IsbFHV7lgwTZQitNutzmZpWGwYpm8VMd9yGEVT7dhGjhUxDM6Pgj1s6CUSkWE
         fMzjz5lnKo7Cb1ApqECbMdei/zDQBjiJtXagWEmb4sPMcweHF1HMY6XyHGj/aAlLf7CS
         Y1VQ==
X-Gm-Message-State: AOAM532ZQ7smROuu7eXcXjueVrSh6UTre69wOQHOJuo+MfFMv+KIbx5N
        rvhoU7Vz7VpZnhaAGFSLISmpaQ==
X-Google-Smtp-Source: ABdhPJzJQETs3WOG9GwjxbvsGTLFleTEdZEW9PtH52FjwBnrRIrjVmDc7IjdsZMb1v2iOUU/ZscM1w==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr3322744wmg.183.1597821874070;
        Wed, 19 Aug 2020 00:24:34 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 23/28] wireless: rsi: rsi_91x_hal: File header comments should not be kernel-doc
Date:   Wed, 19 Aug 2020 08:23:57 +0100
Message-Id: <20200819072402.3085022-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_hal.c:25: warning: cannot understand function prototype: 'struct ta_metadata metadata_flash_content[] = '

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 6f8d5f9a9f7e6..3f7e3cfb6f00d 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.25.1

