Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835ECC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D76420708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtgkPLXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBKVcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:32:02 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45463 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgBKVb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:31:59 -0500
Received: by mail-pg1-f202.google.com with SMTP id c2so5471206pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bX7NhEua2ERlz39Th9iBgSOUAYmxb/RK4PMlnkgxhw4=;
        b=BtgkPLXMThgu/syUKS8v1hUUBJzr5rr4sugkb9U9SmG8EucdUE3NmJbmN7UD6vglUU
         qDnC1J5nk/4LnxTOic1kCFOOGFJJRZ9V/O/kuWTyaiwnYfI3oObcxuAI04Fv/jq+WuEf
         Y6jvrEVvln+iEZM9lw3JUOpeFGyc+vVRpXSXva72q5J5WDe2JF3XPDxM+U6mXMReiu1D
         3n3fys+4aVKQKjoxjbpRbekY39o1sq+Gpb4CeLpVUdJHbfLd9CbY76o22Dpp3UGfd7aY
         CasIqzzCJj3ozmFDqINalnmQdPE1mexaVaklhVzoGmJA5x1NJsd0K69Sck/ut/8djAFQ
         MHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bX7NhEua2ERlz39Th9iBgSOUAYmxb/RK4PMlnkgxhw4=;
        b=IM2Tezd+y4PziCa9sdVAWtZdafvB6+xL5fSZE5YXb/WmirKmc54kgNcGdN41+O/X+K
         2u4O94zxj1nY9az1HOW4V9/dbNi+eNoyU5sGCpwJFJTjcNTOouSirRn44WoTEN0zzBBw
         FquyagtQudADEYrfTWRxFjLjlxnyYo7EJWr+cGe9i7W9b9sq3wOzSl13q6jnN+12lpC3
         iCj0LlXkV9yQOioFY1SDh36bgY0E04m5P+uUoIhbI6NtOjq+h8S1XHYPGP7bpGqlXjqB
         F6cU4hER8hNPkTsOCnrI0fVIpe69NzKtrsWO5a941Enrru9RjP8ARLI65gQZueHK1v6J
         6SlQ==
X-Gm-Message-State: APjAAAW5arytWkqjqXuhBkibk04cUZ8szFSDT5UeuxY8QbdQTagmFG9H
        2Gmx7bZ+CV5MoUDyLwcdjgG9/mDdISsBivDd1A==
X-Google-Smtp-Source: APXvYqx0QPMNZu65+W4/JoT3ENr3G6zoSw5leGNsERt3DujmNIf57u3bpNm6BKn3IwAszRlwDO81dHDN9qXxBtx6IQ==
X-Received: by 2002:a63:ed49:: with SMTP id m9mr8752932pgk.304.1581456718652;
 Tue, 11 Feb 2020 13:31:58 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:25 -0800
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
Message-Id: <20200211213128.73302-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 6/9] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support MAP_NORESERVE accounting as part of the new counter.

For each hugepage allocation, at allocation time we check if there is
a reservation for this allocation or not. If there is a reservation for
this allocation, then this allocation was charged at reservation time,
and we don't re-account it. If there is no reserevation for this
allocation, we charge the appropriate hugetlb_cgroup.

The hugetlb_cgroup to uncharge for this allocation is stored in
page[3].private. We use new APIs added in an earlier patch to set this
pointer.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v12:
- Minor rebase to new interface for readability.

Changes in v10:
- Refactored deferred_reserve check.

---
 mm/hugetlb.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a9171c3cbed6b..2d62dd35399db 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1342,6 +1342,8 @@ static void __free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
+	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
+					  pages_per_huge_page(h), page);
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2175,6 +2177,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long gbl_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
+	bool deferred_reserve;

 	idx = hstate_index(h);
 	/*
@@ -2212,9 +2215,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
+	if (deferred_reserve) {
+		ret = hugetlb_cgroup_charge_cgroup_rsvd(
+			idx, pages_per_huge_page(h), &h_cg);
+		if (ret)
+			goto out_subpool_put;
+	}
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
 	if (ret)
-		goto out_subpool_put;
+		goto out_uncharge_cgroup_reservation;

 	spin_lock(&hugetlb_lock);
 	/*
@@ -2237,6 +2250,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		/* Fall through */
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (deferred_reserve) {
+		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
+						  h_cg, page);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2261,6 +2282,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,

 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+out_uncharge_cgroup_reservation:
+	if (deferred_reserve)
+		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
+						    h_cg);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.25.0.225.g125e21ebc7-goog
