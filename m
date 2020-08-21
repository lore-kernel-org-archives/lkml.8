Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D3C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F792067C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFrEgXxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHUXuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbgHUXuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598053808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E50SJh9B+Sgxu1xn3HyIGnKmtONG1p5IzDx7ax6fnpw=;
        b=JFrEgXxERp1s9dxd2I//Kn5WmQD6lezQplf/sYfeGqfiB5QUGPyEBZXqM+p7rDimLtD9bV
        1WXwSTk8EP8hiGsVul0XvVNiyVgCmph7qX4ondun6+f+yegkUwhx5k9KuQntAc8dMwgOu3
        DyeYUdlYlcIbPgln5nqbIZTCVRdje9k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-crDRdVQuNgm0iJMXVRqPSA-1; Fri, 21 Aug 2020 19:50:06 -0400
X-MC-Unique: crDRdVQuNgm0iJMXVRqPSA-1
Received: by mail-qk1-f197.google.com with SMTP id q18so2450784qkq.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E50SJh9B+Sgxu1xn3HyIGnKmtONG1p5IzDx7ax6fnpw=;
        b=FLKI9++G1ITXZdwUiWJysApvp7irikbXTHF8s2NFmi9tnSpWX+lBED2v+5YTcX+LVf
         MIUD/qS7hcgic95Ac8B2DkJqRGyzkrex/acz/xmcnmX+LnCXqctXzsrcq11yXwdBW9Ta
         Te/W2X7TbLsFeMmIDbzcO21HHhqNkzDeiJb6yIUg2e6LS+lpDxwGZbP6xRk9H4uZvZ6t
         bB2GV9MN85K2ktGUDunev+kRi+jsHQY3P1qKZzucjkFCcrkfrtfjqTBAe/XZTlnLSik1
         ePDvwCcEp+7vYVWkv/KLQMGYUy1BiVpQTmMzP8JUisGt71ZW8IJbbKswujKprxrVIiTd
         Ujbg==
X-Gm-Message-State: AOAM532FYsFmH5gWANPn2+zVJEwSEGNRC31hlNVQXJ5Fyxd4AJM2g0iZ
        5mmWs4paqAJTa0kf/Oj2YWmmkSCz83whAkQ0XEQLSo8UkRQNN27YMS71cdvDQiLgk3zNYFtBi5e
        015BBy6936N6pJ4P90Gd3u2hM
X-Received: by 2002:a05:620a:209b:: with SMTP id e27mr4796648qka.431.1598053806054;
        Fri, 21 Aug 2020 16:50:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy53upk9EFMrc/Hax1cL9L3oXvTx888A7mxN/O3e0tiSOWTQPvbIxHAhvX5TvNLa8j2FJcWIA==
X-Received: by 2002:a05:620a:209b:: with SMTP id e27mr4796632qka.431.1598053805795;
        Fri, 21 Aug 2020 16:50:05 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t69sm2821600qka.73.2020.08.21.16.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:50:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>, peterx@redhat.com,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] mm/ksm: Remove reuse_ksm_page()
Date:   Fri, 21 Aug 2020 19:49:56 -0400
Message-Id: <20200821234958.7896-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
References: <20200821234958.7896-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the function as the last reference has gone away with the do_wp_page()
changes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/ksm.h |  7 -------
 mm/ksm.c            | 25 -------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e48b1e453ff5..161e8164abcf 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -53,8 +53,6 @@ struct page *ksm_might_need_to_copy(struct page *page,
 
 void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
 void ksm_migrate_page(struct page *newpage, struct page *oldpage);
-bool reuse_ksm_page(struct page *page,
-			struct vm_area_struct *vma, unsigned long address);
 
 #else  /* !CONFIG_KSM */
 
@@ -88,11 +86,6 @@ static inline void rmap_walk_ksm(struct page *page,
 static inline void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 {
 }
-static inline bool reuse_ksm_page(struct page *page,
-			struct vm_area_struct *vma, unsigned long address)
-{
-	return false;
-}
 #endif /* CONFIG_MMU */
 #endif /* !CONFIG_KSM */
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 0aa2247bddd7..74d6bfff27c4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2657,31 +2657,6 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
 		goto again;
 }
 
-bool reuse_ksm_page(struct page *page,
-		    struct vm_area_struct *vma,
-		    unsigned long address)
-{
-#ifdef CONFIG_DEBUG_VM
-	if (WARN_ON(is_zero_pfn(page_to_pfn(page))) ||
-			WARN_ON(!page_mapped(page)) ||
-			WARN_ON(!PageLocked(page))) {
-		dump_page(page, "reuse_ksm_page");
-		return false;
-	}
-#endif
-
-	if (PageSwapCache(page) || !page_stable_node(page))
-		return false;
-	/* Prohibit parallel get_ksm_page() */
-	if (!page_ref_freeze(page, 1))
-		return false;
-
-	page_move_anon_rmap(page, vma);
-	page->index = linear_page_index(vma, address);
-	page_ref_unfreeze(page, 1);
-
-	return true;
-}
 #ifdef CONFIG_MIGRATION
 void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 {
-- 
2.26.2

