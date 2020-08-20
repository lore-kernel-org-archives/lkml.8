Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9F7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5320E206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3bStRN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgHTXUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHTXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:20:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA82C061385;
        Thu, 20 Aug 2020 16:20:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so103936pgk.1;
        Thu, 20 Aug 2020 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WWik1+r7ug1ahh3ihIBeIV7cbQz02Md5UqkfuQNEKrg=;
        b=j3bStRN6cq4EnGVkRLbJ0DBfDu6LXUlS406Tt1neeHJf2aiffRbt7IfalTBpgwKqLM
         1/5LqBV9rB3OaXKop4Yg02vdXp5rHu/EVXLujWfT+zOM02acIub/4P7hcqwXoe6Gvjhx
         0ushBhWUyEA3MHPI8aTwLdGG5Hfxf1MOUcljxKHEeuuUnJiJgDKzFHQiFUB1jdP98oZ2
         QaJa9MtJCMaXYF3vIkkewbYKf7WRrQiBOTkuAZ0/NP/3RZBobaO4jJ+yab+2CnbHz19i
         XQCUWvleF2t8ULjSuXoDhlnVgAWIolfnExuzH4htYK4v0fQ3lQv5ZMQykP4KQA1nd2gE
         YeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WWik1+r7ug1ahh3ihIBeIV7cbQz02Md5UqkfuQNEKrg=;
        b=ce2yGB7HqWujfrTu18OojX99yY8eN+3qE8WCwvZv5nD49xPYGXCKPwW0jKuMo2OHdW
         8yQLWKODim01mQqHCJhDbDgDMWKSVYqqAYvvUEyLFqrZ3K4fWpRoTI7VHSJkt5rnAKqX
         V4KjoSaADnIeqDQy2tHIqAbO9ylMda7ipAC1Y+k3f8nbTVPLfWwiVyT+GpOixen9wk3A
         ih7kKzJBeNPW80PRX6sQhK8lvzm/Bn88w55FIFyBpLRSHwyxmm8Zp3ehCSEbMfkUoSRy
         xmlKkHNf2vfw/fLgGXuI71LE86x0AA+lXm0bBhxSFqqgp07Nfx1Po1yn9qqo4btNdR3c
         gvIg==
X-Gm-Message-State: AOAM532eNH8kt+kUCTpNimo/efVIgx21qs/CgNJ1wwnn926axTpQ8eH/
        iGH6t+X8gtrtMmwHH9EEmidzpuh/4uiMmg==
X-Google-Smtp-Source: ABdhPJxM1unyOaRiyWvnEnvKBgovRBg8W51tYqmCbq9vSLYxp2j4wXdLbbhHwPp/ekUOOAwTpb0GDQ==
X-Received: by 2002:a63:ef07:: with SMTP id u7mr314855pgh.69.1597965633487;
        Thu, 20 Aug 2020 16:20:33 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e3sm109419pgu.40.2020.08.20.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:20:33 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     hch@lst.de, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 3/7] ia64/sba_iommu: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:20:18 -0700
Message-Id: <20200820232018.23803-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary_size might be as large as ULONG_MAX, which means
that a device has no specific boundary limit. So either "+ 1"
or passing it to ALIGN() would potentially overflow.

According to kernel defines:
    #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
    #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)

We can simplify the logic here:
  ALIGN(boundary + 1, 1 << shift) >> shift
= ALIGN_MASK(b + 1, (1 << s) - 1) >> s
= {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
= [b + 1 + (1 << s) - 1] >> s
= [b + (1 << s)] >> s
= (b >> s) + 1

So fixing a potential overflow with the safer shortcut.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/hp/common/sba_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 656a4888c300..945954903bb0 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -485,8 +485,8 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 	ASSERT(((unsigned long) ioc->res_hint & (sizeof(unsigned long) - 1UL)) == 0);
 	ASSERT(res_ptr < res_end);
 
-	boundary_size = (unsigned long long)dma_get_seg_boundary(dev) + 1;
-	boundary_size = ALIGN(boundary_size, 1ULL << iovp_shift) >> iovp_shift;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> iovp_shift) + 1;
 
 	BUG_ON(ioc->ibase & ~iovp_mask);
 	shift = ioc->ibase >> iovp_shift;
-- 
2.17.1

