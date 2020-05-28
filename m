Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D7220721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gzq7o17B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437284AbgE1WoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437076AbgE1WoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:44:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54AC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:44:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p30so297071pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=l45d2ebIgVTYBdcwadzZn1AiPQm55aaNY7J4mpFY86s=;
        b=gzq7o17BUls8m2QY2K9AJK73zJe60aWiWfGiLBL/NiD7RUd+s6lCnOfHl7LoNFT1j8
         qUfkNJRnB4CVStoGo7C3cdIym/GnWivmbC9QxLGwQnffvtyrbxvnJGPRw7RWIsuC7vUG
         FLFzERKd/C0fKkrxYUq6SV8Tg4nf6ol0XslnBxchnkDaurX2rs9c3LDvq8sgF0RgXViB
         ehS3OoqYMb91sZHeE2cWUKybggSjQDPEf7unUbr4TKmzePcNEut6vMJ2/xpXZPXea2ww
         gqQixF/rQUwmBXjbvbOCl6doypj/KE5VWH0xcSnS+tnL/w2h0J6I5ff1MQ5MQlVEus29
         xaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=l45d2ebIgVTYBdcwadzZn1AiPQm55aaNY7J4mpFY86s=;
        b=Jxm95JIsGyJJQ6sW/Z9s5r5gFaM/A2as9qsQ3xx09e8IenP0VqwKfx3ZgBJTiIs5yX
         5lvkEeruSSFh/xCMgHKYjHufXRGKEg9W/WX862XeVjkPbiw7L7sgDawxDON0UnjM+9PJ
         +HSenZEJ22xa48AnLGSoC9WAXtIuhpisxsEsuVDtY1P0rlPmSiLC3uY0LujAp30FQhpL
         uiGsSABaN3ojZ5JF0YP3c6MkMZObFSpKJzZO3XIbMeH7/FvYmC48EgdV/IzHw3p5DH0c
         QIiDdaHPKqBXRhYx/ZA+EbAmej4MTs4bAGq7pI125JbMU+p9Q4fZIwEPTAnkGT4QSwDL
         RzYA==
X-Gm-Message-State: AOAM531XCXC42ykj16svHpePMb6j7ppFkp5/NNdFstU6odWlkPoWXOz6
        FJKccfjKYmri6caTKq/nEyHYdA==
X-Google-Smtp-Source: ABdhPJwq9RAGTsT72bc6ZS4m4DqTZ9XT3ecH6wm1LPKrA30nov53xcwsWLSkrP5e8rF1Klixj+jFzQ==
X-Received: by 2002:aa7:9e52:: with SMTP id z18mr5446497pfq.57.1590705844915;
        Thu, 28 May 2020 15:44:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e19sm5488131pfn.17.2020.05.28.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:44:04 -0700 (PDT)
Subject: [PATCH 1/2] soc: sifive: l2 cache: Eliminate an unsigned zero compare warning
Date:   Thu, 28 May 2020 15:43:52 -0700
Message-Id: <20200528224353.32559-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, yash.shah@sifive.com,
        anup@brainfault.org, bp@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

GCC warns about this comparison, which is unnecessary.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/soc/sifive/sifive_l2_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index d5f266551880..51e198880a8d 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -51,7 +51,7 @@ static ssize_t l2_write(struct file *file, const char __user *data,
 
 	if (kstrtouint_from_user(data, count, 0, &val))
 		return -EINVAL;
-	if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
+	if ((val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
 		writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
 	else
 		return -EINVAL;
-- 
2.27.0.rc0.183.gde8f92d652-goog

