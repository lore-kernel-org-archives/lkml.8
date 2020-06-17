Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE378C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98F22098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZbDoRPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFQWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:34:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1356C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:34:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f130so4273642yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dl8CpF2u3zjH2sdeNdfuapWfq9PffavQBlO7OcAgrZI=;
        b=XZbDoRPx9MaqRuyRsuE/Zz84rdx1Xg4cSOXtmTvC/TW75TfM/II++KXvkmOZ41Yqf6
         k0aimUW4ZwWVH3K11wIO5XxCn5FW6ghYzMqX6KekiZf7JAT+9xphRLQFmGCeSf2oWv2B
         joYHJsCZPN4lBHirZGH3DZRwU5eUSMEaMqB7Kf68HK4NaGlSZXTbS0af4dhERrXKNZ0O
         C6ROehJ0qKo+jcU7S0430TM9qa1DqWbamBFaRIdN1LWNkSr55f52P4EJEO6/tu4jdhdh
         sY4C0ESIhkZi3FAp6qi/HhG/QDIzDfFSu+UyLm7nC8Yv/FRs/bez0w6Kd2cDoHu7F+zT
         21zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dl8CpF2u3zjH2sdeNdfuapWfq9PffavQBlO7OcAgrZI=;
        b=uBIl7MSrxIbn4JubjZZIb9BfrF4d4zeLNVpDdrkAq/C43aNJFyHXijMhvpPE1VuhwR
         ZEWhVafSLSxE/6dvsJl7iRzFlgU+gMGewLa3TSGejxtU273eaNZT4TgVSTWV45XILnCE
         ++exCZ7Z4etxXjtSVFjcIS0C1kNqeC8gpsOnpKfOjhAPdWWXfSzDRPd08CDTs66/EKe4
         B5bN0m/5YRf2Gh2LeB12eJNnn0xb0Cki9T65AVNXyXwtZ0tzwNbZv1OjsBda4GVWbnWy
         +limHAOlSDt7/dwlhwkV2x/Kx+G53niHo3/IIjjJpKbwXwTFzoGrP/7222xkjMJ/fclX
         z9xw==
X-Gm-Message-State: AOAM531XO2IxwyEVonGy8vGsz8vPb6vBA3cp7zlu6oakcmfBE/f0znCW
        kPqnDNW4gazYUdV3j+pXxJdq4ZOYwBuspxo=
X-Google-Smtp-Source: ABdhPJwSX0MoqylBaNHo5+aHvkEKKYVU9E5bWuZtt82sujJuI/YxK/IxNKn5uJvJu1RQHd461b7kt2QU2QPNQUY=
X-Received: by 2002:a25:3784:: with SMTP id e126mr2000871yba.267.1592433256945;
 Wed, 17 Jun 2020 15:34:16 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:34:14 -0700
Message-Id: <20200617223414.165923-1-zhangalex@google.com>
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

