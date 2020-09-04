Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310B220722
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA3kZzLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgIDN1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbgIDN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:26:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ADCC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:26:27 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m5so2950485lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=to8yGy7pHihTBT/93HN//DxGYS+102uxdQTAldLv0Xg=;
        b=pA3kZzLQLp9KkrmZE2CIfgA7yXMv+24CpAbAlKDA+YkSgL4ec26BOM23e79D0mUPFg
         o2VZZ0QNRQPciwDU0YR10+ujbKO/oTMU0GIom66c3XLVBPDRjLPn+WsjyUvyaOOF5oO5
         yEt6UPzHZxK4UZgzv4wVpzw/m6zUTZoHgbNjpwgba5/pBy4CBTaH7xF2v+LUQiT3uSOg
         XUeyqoVXPeRmOU3NDP7K2cn+CYnfv2FnPhfzQ8Z85xzwOMKp7bweyKBgqwtVy89SHEls
         SHLPivQUIShZq1q5d6YZRB+9s3j4W4/xVJEziFqSx5UEAALiDZBlCALDMOtRJBsTweq0
         RlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=to8yGy7pHihTBT/93HN//DxGYS+102uxdQTAldLv0Xg=;
        b=Ec1JDrz8+fiL0RR716BRanwhXaG9tExkEsoYWtsafplqR2g4wbToxvNlk4IRlW9RCc
         ISLxfGADOEsBRtOapm+f2x9W26urFMLvXFqwcenQdPmbiqvzZ9KRlAguNnfDbU6v99wL
         JfqwOCe27EnGQZVcuCPaNhE4/HHuXs4LZLUHlpleE2zSCw6dbfXR9MZabNE6HunWSHSD
         pLzlfHGnrqYPrC2a9ex2X6xZKq7fPNeoOlnOa2Scc8LN5O/uHPaqqyoYO4KrAOvI0xN2
         o/Sqd3ww/bbXoOZWbzRGJrtog4pfGD4olmYaqidkeb/02RfvXgfbr4Xq1EhUExNDt6M3
         J2cA==
X-Gm-Message-State: AOAM531uk/N6aBCSBKh8uhUVLwwUVpVzKeToAO4lmR6+/FwQrR1zTk3X
        hFyLVLkaXY8c/9LW2JUihSU=
X-Google-Smtp-Source: ABdhPJwp282W1wItjcXF7u18XZ7DcCmHWiEUTloxD227WOQg1SzZqHcn+m3WeqcA1L5DxWExlqGtQg==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr3814999lfg.185.1599225985745;
        Fri, 04 Sep 2020 06:26:25 -0700 (PDT)
Received: from localhost.localdomain (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id l15sm1281116lje.16.2020.09.04.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:26:25 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/page_alloc.c: Clean code by removing unnecessary initialization
Date:   Fri,  4 Sep 2020 15:24:22 +0200
Message-Id: <20200904132422.17387-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously variable 'tmp' was initialized, but was not read later
before reassigning. So the initialization can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3ae4f3651aec..77c3d2084004 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5637,7 +5637,7 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
 	int n, val;
 	int min_val = INT_MAX;
 	int best_node = NUMA_NO_NODE;
-	const struct cpumask *tmp = cpumask_of_node(0);
+	const struct cpumask *tmp;
 
 	/* Use the local node if we haven't already */
 	if (!node_isset(node, *used_node_mask)) {
-- 
2.20.1

