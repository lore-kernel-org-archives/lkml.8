Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8C6C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1410021741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5Ri62NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBERRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:17:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36976 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgBERRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:17:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so1140456plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mUDsIDZABMZl51KhHVbThQf4Tq5Xiy3roaR+2Uewz3I=;
        b=T5Ri62NQ5TecG+H5Jkz3y/VrFKfdJk2hpW/44xQT4xfATYX7LgH825B+6EtpITWTBN
         oyasJgxuEGESnxck6nQSSFid9SW/150iHcHfGpFsB36AXkMbISfiS1bDQHBpPXv0JT9m
         xH944oVe2g7+4JGgSFu+AjCYq9KFiQWYzKZYTbQAoywFd8qHeAZ9CgMyloF8xIRELRLQ
         KFcz8JWHPlksC7SxfPTh+Wir8XqzEOx5dk5yQI+HgX/s4ifjGXGIkeis5/rZULtdZB2S
         C7Vuq7ixhvBCNTo+OkyqD5lQhWcR6TvE0uJaAjtjx9xSck5t5WjATT4mwSbqDwJmDUHs
         GKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=mUDsIDZABMZl51KhHVbThQf4Tq5Xiy3roaR+2Uewz3I=;
        b=OTq+Yga7/GQpxkTG3vM/zOb/aBXeaQSEomPvzjyPQxT97ABPWVSI0mzHaMv83l/HiH
         dkqdfBCDaf3CsAQ0twlWqwj4db2895mi5p5LQwezFAtFvjQc6nJsLGA4GqFk9uCOfpYi
         cNrQY05ElygleTL5vz5mLyxE7MKbL/xF0PquwxEqJdXlk1EALMKl/+2MQ/rxw8RaI2+w
         ae/B7KCC9raNYbU98FXXT81T0glrBVJJrAgXDEAMAwoxO9ertk2cE6H1bTQrXh6/ll+J
         ZsOB0Eh6JGskJUno2t6K7rF4we5Ooy0yYLj561/t7kXhEn35mNu6/+7+ASYCISeFVr+R
         +7hA==
X-Gm-Message-State: APjAAAVWC2tGgoVdUaEHR3OH5cKyHXyyhz7WlNlK/61nGQZv0avaOySC
        sFIuv+V30B8RdQhXL1vNPyo=
X-Google-Smtp-Source: APXvYqwAucub/1RnuK/N44ZKAJ/ubl68vA2EqER/Po2dotu9cAHraSFJVsBMiG0GURTaxB6fL5q9Dg==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr6863551pju.57.1580923069539;
        Wed, 05 Feb 2020 09:17:49 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id l8sm357945pjy.24.2020.02.05.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:17:49 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 4/4] ntb_tool: pass correct struct device to dma_alloc_coherent
Date:   Wed,  5 Feb 2020 22:46:58 +0530
Message-Id: <a408ec42122ec0d9ad9aa0d3287f485eb727a6d6.1580921119.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Currently, ntb->dev is passed to dma_alloc_coherent
and dma_free_coherent calls. The returned dma_addr_t
is the CPU physical address. This works fine as long
as IOMMU is disabled. But when IOMMU is enabled, we
need to make sure that IOVA is returned for dma_addr_t.
So the correct way to achieve this is by changing the
first parameter of dma_alloc_coherent() as ntb->pdev->dev
instead.

Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_tool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index d592c0ffbd19..025747c1568e 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -590,7 +590,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	inmw->size = min_t(resource_size_t, req_size, size);
 	inmw->size = round_up(inmw->size, addr_align);
 	inmw->size = round_up(inmw->size, size_align);
-	inmw->mm_base = dma_alloc_coherent(&tc->ntb->dev, inmw->size,
+	inmw->mm_base = dma_alloc_coherent(&tc->ntb->pdev->dev, inmw->size,
 					   &inmw->dma_base, GFP_KERNEL);
 	if (!inmw->mm_base)
 		return -ENOMEM;
@@ -612,7 +612,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	return 0;
 
 err_free_dma:
-	dma_free_coherent(&tc->ntb->dev, inmw->size, inmw->mm_base,
+	dma_free_coherent(&tc->ntb->pdev->dev, inmw->size, inmw->mm_base,
 			  inmw->dma_base);
 	inmw->mm_base = NULL;
 	inmw->dma_base = 0;
@@ -629,7 +629,7 @@ static void tool_free_mw(struct tool_ctx *tc, int pidx, int widx)
 
 	if (inmw->mm_base != NULL) {
 		ntb_mw_clear_trans(tc->ntb, pidx, widx);
-		dma_free_coherent(&tc->ntb->dev, inmw->size,
+		dma_free_coherent(&tc->ntb->pdev->dev, inmw->size,
 				  inmw->mm_base, inmw->dma_base);
 	}
 
-- 
2.17.1

