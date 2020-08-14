Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE70C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379E920771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOVFd+EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHNLny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgHNLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5403C061388
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so7661144wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxyYXnUUCZhHe8dpcSTNmo6M+HTgfG9I0aeJsix4sR8=;
        b=kOVFd+EKRHcOgiD8HFwFx0XNWvK5zXgOqGzWPcdwz7L45SP9KAQmTDuRgMEtDIWvWC
         KGy9FZZYUL0hSY1ceRAgUrsIPIdDQn+32RHicdNLMUHSBm3xElj7w47D3lnM8c0afIPG
         S7doL6pvSFEsK7TSBsbr64SJrCktcAl7x6l7C65t1dkMvqmvd8gC1eNKQOx5K5xJpb7b
         ysp+60MAN7Ox3BXtQNYCxDLOXGp3dPRn/1KCMDwnJ/xsv7XV1bMdfZ0U7PmHnIlo0aPM
         ONSPBgUPZLPHemsi/5HkM/Ah2dpCXv5IgY7DsVoFp1chYugRMuxkuEo64po9G+3khXp1
         CCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxyYXnUUCZhHe8dpcSTNmo6M+HTgfG9I0aeJsix4sR8=;
        b=qPumajGDiA8gZe3GyyrL2CMHZz8y6sHtnZH4TzFYXAZdhpmL/oylDWbU4awXdxqS9l
         wL7sN+uBL2+mGKWVyB7YCSWk40g84JFv950PjAFDS8tx3Aoi+qyn85XZgAb/efS3WWF1
         CB8LpUi7CEPbjmnp9S8nFifxpyE9USJex9jimkLU86ScRCMnA25QZ4S3X3ws9YCJaTpg
         6cmagfZFDOz/QMzbyP0ynjmfxa6eLD6cS7vhJwgYzyZ6VJ9rv5uzlSP6SYLl4Czb6o3i
         XNHwW2Csa+07NO0aLVBXY8RxFZYkGMG5rM+XTFNbivaBPXPj3lU9pJvMGG+8Q/kkEvf7
         UywQ==
X-Gm-Message-State: AOAM530NIH68RpiMZIWkRToDruiWZQ4TesjW0kCRKLcVXDgghwZ3ZgPj
        37oQe8dhfGWc2ZZkIWiklAbpbA==
X-Google-Smtp-Source: ABdhPJx8WHD9X6aqfdX1cuW9YJJqmiV+LKBUDjkV6yfghTL0ztl5sgx19ZXXSWtlxSgA6tCjQrrh6Q==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr2284684wmj.21.1597405199406;
        Fri, 14 Aug 2020 04:39:59 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Benjamin Reed <breed@users.sourceforge.net>,
        Javier Achirica <achirica@users.sourceforge.net>,
        Jean Tourrilhes <jt@hpl.hp.com>,
        Fabrice Bellet <fabrice@bellet.info>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 11/30] net: wireless: cisco: airo: Place brackets around empty statement
Date:   Fri, 14 Aug 2020 12:39:14 +0100
Message-Id: <20200814113933.1903438-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/cisco/airo.c: In function ‘airo_init_module’:
 drivers/net/wireless/cisco/airo.c:5663:21: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Benjamin Reed <breed@users.sourceforge.net>
Cc: Javier Achirica <achirica@users.sourceforge.net>
Cc: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Fabrice Bellet <fabrice@bellet.info>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/cisco/airo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 316672486d826..8002a4268e03e 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -5659,8 +5659,9 @@ static int __init airo_init_module( void )
 	for (i = 0; i < 4 && io[i] && irq[i]; i++) {
 		airo_print_info("", "Trying to configure ISA adapter at irq=%d "
 			"io=0x%x", irq[i], io[i] );
-		if (init_airo_card( irq[i], io[i], 0, NULL ))
+		if (init_airo_card( irq[i], io[i], 0, NULL )) {
 			/* do nothing */ ;
+		}
 	}
 
 #ifdef CONFIG_PCI
-- 
2.25.1

