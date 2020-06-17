Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA65C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA12520CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKdUwab7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFQWcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgFQWci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:32:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336CC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f130so4269348yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dl8CpF2u3zjH2sdeNdfuapWfq9PffavQBlO7OcAgrZI=;
        b=vKdUwab7uP+uz/ILCRIEQUWTw1y628cbUve5KPb0pU8jh01zB0o77mA5nagbMWOTSc
         7OOwmSa0HgM1N5d2qYpqBxZ8X+9/CKPCT1I04mArfiOOHR/qZI6+6iy5xVqmsR9plMsS
         bE6eVXckKiCki3ClaPCxsyQPigQ/nWS/d2H9mRrqEH75uYmmxx3QCGYHAUx6HjqAZh8g
         Mhyw/prWu186TWslGG8SCdgJe47c5ED2M13op9MyZvNCrv0OcxuPMgclpMMPqO+tM475
         iWVA8XbKP4MbrhyEkoFEU0GU8iqUk+TSFLAnT97+NN9kfOzfMEDqPh6wTipvvHQQ+2e5
         O1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dl8CpF2u3zjH2sdeNdfuapWfq9PffavQBlO7OcAgrZI=;
        b=G74OwxMvx1OmEqm3xXm+a0ZbiPk82q+/OV4CftgYbxWxghIN2uGZmtWvNrdY7H17J7
         4hcVELhCi51WRnJGm1XrIINby1AnlD09+mS2if2i4KEivGjI9ym+5OjDwPNx4dXh4dyI
         f+yrVKkJ9PteQszt0wnSmfweuRLww7+JaDqmcgaB/5gWYIw7HjTvtELjucEGJODpHAAR
         PSC/8smr0AffcqrSWLs2q4n5/jjSBYzlahBgfK02/Ygzc40vugsGfE5CXpn/vZjjvMaH
         X0indRK6winmIjh3OT1nVXDvSt5hrwxn1erBfEcW6gpCovPL6LHGr5eD89TNK2Pq/vML
         uiNg==
X-Gm-Message-State: AOAM533B7QMrtSIQZlx+t1VxGjzlCCdYkx0VXkTKpxRUCt4UN6V2jwoT
        rceVxhD21J4FzhIn1ZVINOqx5wfS4hAkrH4=
X-Google-Smtp-Source: ABdhPJyeR4h0Me2Jqjjk5lMCpwfmgkUJ7m4BZVHZC7e5A3/e2NJJt9P6ANUw0qyp4w9dB87DwkgcWPw7kiZQu0o=
X-Received: by 2002:a25:73c3:: with SMTP id o186mr1779854ybc.230.1592433157594;
 Wed, 17 Jun 2020 15:32:37 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:32:29 -0700
Message-Id: <20200617223229.165040-1-zhangalex@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH] mm/memory.c: make remap_pfn_range() reject unaligned addr
From:   Kaiyu Zhang <zhangalex@google.com>
To:     Andrew Morton <apkm@linux-foundation.org>
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
well as explicitly adding a check for it.

Signed-off-by: Alex Zhang <zhangalex@google.com>

---
 mm/memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc7f3543b1fd..9cb0a75f1555 100644
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
 
+	if (!PAGE_ALIGN(addr))
+		return -EINVAL;
+
 	/*
 	 * Physically remapped pages are special. Tell the
 	 * rest of the world about it:
-- 
2.27.0.290.gba653c62da-goog

