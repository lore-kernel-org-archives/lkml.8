Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2AFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A53A2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur5vYE+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbgEYWAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgEYWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 18:00:21 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228E2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:00:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k19so16078492edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O655F/SobHiBfw89KwZt4cdPafswvir9iAWsC16mmk4=;
        b=Ur5vYE+MTeBS1LfJ+Bssiq/4pJZ7hq6BjlwzZWAEJxTZKmvhKKR+7vRrPuuFIiiOC8
         fgi/2+MM2Vs995z/jr6ybwwGcNfbzYYEC25G8zKmUAp4M0OJFMre7L+iSL9To5/sGN1B
         6JuHZ4lRGG5ar1BsBxl+Ez2qmMnwHQtkLE6BVWiVCeR9Q3sWaK8pKO8eRTn8myH43VUz
         pI/u3T5NLN3KGS7v5MFevd+ma6b0IlH7UZeVeanLJtv/7jFWapEj4IMHuGkcBWTEzNmd
         Kcq33Cxg74UNkYWV2VYzxUTMX8PYUa0aRNmFkupCsxhVwjSmwo8qR3jBXlnkOcA9hzB1
         EJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O655F/SobHiBfw89KwZt4cdPafswvir9iAWsC16mmk4=;
        b=KUdVtH6QtQJevsFjCr/Pjprj+lbNCLYSrWNBckHvqN0o9fNOYeJtYyldW9u/898Eza
         8xMXFNiPH8oRxuisWRBeIVxMFiKRPG5srh7RC4vpfRcP6/Ghwov0f5Vm26OeIUhhlDaZ
         WFu3jNpbF6jXbhm33hQGvIV0/aMg8V4JHqV06+IybSm1ykQM9dZcIm8mrhKvCc9qWg2x
         xf28oUvi+xHt8TQ+bIIJAJlvvD4zSavCSakjVy36lXNcEcyXPp5vEcSK31NqEfbjjaEu
         lPlesFFdtT63mxgA0n6yQS3yQPZYPTq5SHa8/VJ8y9iWp46Y1cXtm2PzY6NpmlhEhbfE
         jIYw==
X-Gm-Message-State: AOAM533ytoa3mvxX24wxtwJLMvfo0Pvfbe7Y0f9AMY1HH6kUpNl1C//B
        4Gh/YYE/6Y4DHmZapOGV68C+gpcX
X-Google-Smtp-Source: ABdhPJzyjNBtzYAk7pEQF4xj4XwEyKR+I+JgFJBTrdtdxQikNwDTLXXmyZpjKGBmPKiJ2hGAaVL9Zw==
X-Received: by 2002:a50:a693:: with SMTP id e19mr16485374edc.275.1590444018874;
        Mon, 25 May 2020 15:00:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b13sm16935486edw.50.2020.05.25.15.00.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 15:00:18 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] bitops: use the same mechanism for get_count_order[_long]
Date:   Mon, 25 May 2020 21:59:58 +0000
Message-Id: <20200525215958.21653-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions share the same logic.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/bitops.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5b5609e81a84..80703ef27aee 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -188,12 +188,10 @@ static inline unsigned fls_long(unsigned long l)
 
 static inline int get_count_order(unsigned int count)
 {
-	int order;
+	if (count == 0)
+		return -1;
 
-	order = fls(count) - 1;
-	if (count & (count - 1))
-		order++;
-	return order;
+	return fls(--count);
 }
 
 /**
-- 
2.23.0

