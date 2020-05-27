Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE75C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A87208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIzf7gA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgE0Gp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Gp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:45:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so11344313pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XIhz9DXnj/A7mpbN2JONtLaO9sSOaKnu8Zni2kFEuPk=;
        b=kIzf7gA5Eo3d4iL+VRC5D+X4qfCOcLA5PG0otOOWyHcD2sxBnWKmgeamtxTLENsrQv
         ZMXZRwcdWUdVKdc4w+dQ1DSpoEukbxZSQ5nvsThfqHxd0Et7acI6DrV4A2GXMa0aDHxx
         KBMthjaPzIEhxMjXtamW8olIjJ3XUbHwuyTfEozqXQOWSXrNfreGAkx0bPWF036CuGFK
         4Ha2oMsG0wNcogLBglECzxi1K61VnUeGrUJN+y0Wd/mYoTeEVOUkRWxCuityvUjAerux
         zYwZ76vSwuvn3rZxBHaek0hmWco+zt/I84SX9rOQWHbydKt53oFdR6hF7zw/JPpg8xUc
         R88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XIhz9DXnj/A7mpbN2JONtLaO9sSOaKnu8Zni2kFEuPk=;
        b=PWn9r1G1mPKdxXU2zrsdzAs8YPHbqSX7KI1aLzTIn5KbTklQwxTMcmCWKxgl99t309
         /5M9t5LA3kTRGsjXIZG+yQfa9GwdAZcECMEld85rJWSbqtX7zFCbm9ExKKpYj0SZo1IQ
         G6AvPqq5lRAZVVwn9jbOc3i93lKsAXY9BiCt3r5S+9kW9q/rpXeamWHBsVu87Aj82VsY
         IWgzCCVv3SFVuqq8I53v855/DKQwOt0kOmpiMLBzxrypeDhifTm+CpRqqTEmT64jJATm
         kE4B7rcnAWaBbYa1adoHEAlG9CQ3UbxKLYNsro3bsMxHlAUE9Ib4pGlI6l8e28t8GeK3
         IapA==
X-Gm-Message-State: AOAM532XQ+oezSNMmPMNbTGifNCXut+JNHdN0A1fXbbGrNTgE2lHd3XO
        3xouhiIRFSVZe1fXzoUxs1M=
X-Google-Smtp-Source: ABdhPJzcy7l+xXTR1zMoeBNqdc3F9cDxUNllOsY6v6Gpnat6hbKIkXYenAKDlDHTv/jcHg+NTfZSXw==
X-Received: by 2002:a62:75d7:: with SMTP id q206mr2519609pfc.172.1590561956128;
        Tue, 26 May 2020 23:45:56 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:45:55 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 04/12] mm/hugetlb: use provided ac->gfp_mask for allocation
Date:   Wed, 27 May 2020 15:44:55 +0900
Message-Id: <1590561903-13186-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

gfp_mask handling on alloc_huge_page_(node|nodemask) is
slightly changed, from ASSIGN to OR. It's safe since caller of these
functions doesn't pass extra gfp_mask except htlb_alloc_mask().

This is a preparation step for following patches.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 453ba94..dabe460 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1985,7 +1985,7 @@ struct page *alloc_huge_page_node(struct hstate *h,
 {
 	struct page *page = NULL;
 
-	ac->gfp_mask = htlb_alloc_mask(h);
+	ac->gfp_mask |= htlb_alloc_mask(h);
 	if (ac->nid != NUMA_NO_NODE)
 		ac->gfp_mask |= __GFP_THISNODE;
 
@@ -2004,7 +2004,7 @@ struct page *alloc_huge_page_node(struct hstate *h,
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac)
 {
-	ac->gfp_mask = htlb_alloc_mask(h);
+	ac->gfp_mask |= htlb_alloc_mask(h);
 
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
-- 
2.7.4

