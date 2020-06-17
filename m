Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822F821534
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0e+CM9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFQXfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgFQXfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:35:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3678C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 16:35:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c3so4489563ybp.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JEk1DvV7StGc2B/4az6pcE4cQmGW6gMF8cmlGg/pUZM=;
        b=j0e+CM9xVYFln9suMskzdp0bkFPVo1HzPayGtWYP1pTrDO5Frq0ROsDIrVT6aDMb4J
         EN1HJSyyMuJRMtjXBoQfle9rmKXfLBGuoUDS7ycc2BNogqEEkxU4b/seLCRBpdbuCSal
         AEqBvOme/HaVNJ0dviRjXbh9T0upLKyfHMdAZbOXmtbWqPbylXISbdJDtSEZHPAfJ7YD
         g+Y6OAl/juHy0ZnfqFqZCcFLC5rTJRoPRHZGFNW9Gz1lktrK3m0MyKcvXTXRD34CNvF8
         0UTee3wdgnDAcdjhreWcNcgNco2UZ+YFdaJW6oNI+91KbVkPH/IeSURv3/llA5+vvUGh
         uAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JEk1DvV7StGc2B/4az6pcE4cQmGW6gMF8cmlGg/pUZM=;
        b=YQi6BYaYCBLMrcEM/B/wKm3tbGN6XM9b3dz1E8s71rQRnR0h/O7A7E6+/jS6HlUrQ8
         H312WDTgAuDlhx4IYkxnglGea5oobHcUEjJMKBzDMMBfOHqsP+zN/GMCeWtJZlipuSMU
         GgCY6jwQ5+GR0wkFdgqc0PLf8011/2KMdmVNs1veCVgS8jdGkG0JHdc0CJrOzV2B3PtU
         Ck0oPm4hJXSFqKiFHEEVkBS6ITme1bKaMwdVwnFVrHVvxroHY6HPuum9cyJXZVo8pItG
         q9v9tTqYW+lTSQriAP17bqTta1VqnR89j69i1TSZ56fEc/uI2p0TcSeCaTquhHJ2hCNq
         zyzA==
X-Gm-Message-State: AOAM533P1QpCWDiiyYDU909DnDvP7zc01Jo3UxMxeHR+29QwxAmQ/ceC
        nNJQhoJiU8DyfbupEBoDpkwjSvsisWF5fKU=
X-Google-Smtp-Source: ABdhPJysIUfuTHo3ksbyMcJ6CJL1YB76sZVK1lq/+2uv1Jo29uya1Nyu+9Vkr14QoWK3Qd+ZH3K0ziSlqdlNLXw=
X-Received: by 2002:a25:d68a:: with SMTP id n132mr2109309ybg.255.1592436916545;
 Wed, 17 Jun 2020 16:35:16 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:35:12 -0700
Message-Id: <20200617233512.177519-1-zhangalex@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH] mm/memory.c: make remap_pfn_range() reject unaligned addr
From:   Kaiyu Zhang <zhangalex@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alex Zhang <zhangalex@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Zhang <zhangalex@google.com>

This function implicitly assumes that the addr passed in is page aligned.
A non page aligned addr could ultimately cause a kernel bug in
remap_pte_range as the exit condition in the logic loop may never be
satisfied.  This patch documents the need for the requirement, as
well as explicitly adds a check for it.

Signed-off-by: Alex Zhang <zhangalex@google.com>

---
 mm/memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc7f3543b1fd..16422acb6da8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2081,7 +2081,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 /**
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
- * @addr: target user address to start at
+ * @addr: target page aligned user address to start at
  * @pfn: page frame number of kernel physical memory address
  * @size: size of mapping area
  * @prot: page protection flags for this mapping
@@ -2100,6 +2100,9 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long remap_pfn = pfn;
 	int err;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
+		return -EINVAL;
+
 	/*
 	 * Physically remapped pages are special. Tell the
 	 * rest of the world about it:
-- 
2.27.0.111.gc72c7da667-goog

