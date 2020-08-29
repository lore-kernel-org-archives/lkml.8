Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C644AC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C9D208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaIeN6WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgH2Siw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2Siv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:38:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27228C061236;
        Sat, 29 Aug 2020 11:38:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so1762723wmd.1;
        Sat, 29 Aug 2020 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AgHtPh7HVKajATPSPCiZDeKl34/5NzQSjixpKDrOaBQ=;
        b=oaIeN6WKx3TMB4D1rbj4g/hNn0bgGvVMErZn+iSgtVwy91nXxTwDK4I8uxB4IE34dI
         IVg2fP3yt5tfVIqMYaeDeaTeR9v1ole2Wybi7lIqCzUoOUpaiM7Y+yG57+cPKzO09LUB
         LNA+A8hUwqZi629QZwFyGL/iZ7sTygWKVso+tVg286WZ/c1XFBRezZe7w/yT+tNLo64F
         vZQjOI3fUuNA1yOqqKFdWRxzpsbFSXTMegApGDVJP6IkzAKg3SHJebjxhsjnbu7Ly/8B
         BRI7BdLZ7N9dhsQ90e82i8JZ/SNWg8qGWcIUvLuPKmb0dMs9HmWXrT9fT1238Mc5Nppi
         OkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AgHtPh7HVKajATPSPCiZDeKl34/5NzQSjixpKDrOaBQ=;
        b=X65Wxl66k+OAC+iRWpTpqUv7/VDxFFcsunzeMeMawG6bAI6IQKdeOLZyeoYveG765d
         bLRO0m/MutTRRZ0KH5cPAX+iJAsddqwIxxJW5mYCZ8RVCRDwlmX7kw/4iBISGYN58iiZ
         ubXVzDGbDaoon+Pdpiq8yG3aliK1Gg+D6C1VLBuKJEQ9dPbNnQR+vN2jFlh9J8yznMHq
         Qn8KZvtDAoMapXEIZqi3UT2BlSLbfMxCqdrzAAi0LkKPR6iyDY18AfOMRDl33cuQPI8H
         mC5NT1LlILNEpwrA+Nyc0yIW/L0/gSnWYGtYV3m1FFi9D2T0yCvkxgD7AndhxrRf0BBZ
         XAxw==
X-Gm-Message-State: AOAM530xQ1+xa8uzLfSXZ/ZR78QoKvsu/vyH1L2yq3DC6iRA753Hhg9b
        VhSEr4RrR/QPUG5JRAgcbeQ=
X-Google-Smtp-Source: ABdhPJw6jlZVnMgVljS1Ufr9VbYYMfKfZKDzTpzFqDh5f9TAGgPGd1ywxEzlmZJOY8iZyi8BDDRWtw==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr2118309wmc.142.1598726329832;
        Sat, 29 Aug 2020 11:38:49 -0700 (PDT)
Received: from localhost.localdomain ([85.132.73.2])
        by smtp.gmail.com with ESMTPSA id r7sm3119986wrr.9.2020.08.29.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 11:38:49 -0700 (PDT)
From:   Emin Ghuliev <eminusgh@gmail.com>
To:     ysato@users.sourceforge.jp
Cc:     dalias@libc.org, eminusgh@gmail.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-sh@vger.kernel.org
Subject: [PATCH] sh: use kmem_cache_zalloc instead of kmem_cache_alloc with GFP_ZERO flag
Date:   Sat, 29 Aug 2020 18:38:38 +0000
Message-Id: <20200829183838.10166-1-eminusgh@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use kmem_cache_zalloc function which does kmem_cache_alloc and zero out
instead of manually setting kmem_cache_alloc with GFP_ZERO flag.

Signed-off-by: Emin Ghuliev <eminusgh@gmail.com>
---
 arch/sh/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index cf7ce4b57359..6e17d921f5f5 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -47,7 +47,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, GFP_KERNEL | __GFP_ZERO);
+	return kmem_cache_zalloc(pmd_cachep, GFP_KERNEL);
 }
 
 void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-- 
2.17.1

