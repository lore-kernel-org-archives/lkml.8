Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE7C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D3218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lawWGfNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBCXXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:23:23 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43429 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCXXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:23:21 -0500
Received: by mail-qk1-f201.google.com with SMTP id f22so10612609qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gTAQ6DpOvbk9aFAmz/RHl3R2aBxncgiEKbaGpA5frS0=;
        b=lawWGfNg3coqzUxzW5tdwnM7JzKsxWVWyd9ZXeZ6oVEfozYZYeEfuerRe1iAJjbD3B
         nFZ22Sr44cgnTCoY2qCi8yFTrjm5FUtbXALgxMYmqHg5mrNGujJPgYVENxnn010VAOdz
         ajYKoq1V3qmlRxmoKlcyAB99zGipHVX3cVZ29iRJ8hRAPI5gz8qn1RA8u1YKfpxUJXHf
         y6bdAw5mzejzeuWC7XPEFxucoppFAm+GhlSUmtBSVtXgmSIX9fQasyqBikW8UNtiazuG
         eQcX3OuLuEv4OH19GaD7s/KkHqIpbuTaMm0pzHTn/9uVPCR6qtK3hWmd748N4Vtj1Z+Z
         ozJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gTAQ6DpOvbk9aFAmz/RHl3R2aBxncgiEKbaGpA5frS0=;
        b=FY+01a1DTor3bKcakNJPSRWAgQZCSgETK2g4M2cDWwl+cHnu4nggyPCubCOQg8qSL6
         gHqELYISpuXn1w6IRHhFK3yXPv7X6HvE1HTn/KNmv05c+9mrNUnehktJDudnVdH9/Yhh
         W6Dlej2296zJCIQNeyeIfkKDiX8ZlIpSkirPRKlhdEAj12noZHWwuFrFtgfoaYhhAf01
         x6SyA4NXLu4l4cdDlZONjNLaFe0TIpEiio6Y6qEAKZm4k44WUCCQwkBWi5sJm1WlkY/k
         FNGT42dWqzw2srUz8Xd3Ur9c/9sYJzRDWCP+aHE05UVSVzu5JGYDEvO/uUut1IHa/J0i
         TFNA==
X-Gm-Message-State: APjAAAXDbgfd5X8BE3V8VpFLuZlFVqA9aSivq2Nba/pV9RPucAwkrH0D
        D/VOyvfc0XKgS3d1gHzU07pKFLfIMY56GIblsg==
X-Google-Smtp-Source: APXvYqyZFRK2nwPrxgIM0lMsOI9GD3u259sj/EVTiSp7XQoeYTs2EoceYp2yKqu7UzsKjbmj74yv/rUcqDITUWzAXA==
X-Received: by 2002:a37:4d85:: with SMTP id a127mr7298741qkb.267.1580772200586;
 Mon, 03 Feb 2020 15:23:20 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:22:45 -0800
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Message-Id: <20200203232248.104733-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v11 6/9] hugetlb_cgroup: support noreserve mappings
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

Changes in v10:
- Refactored deferred_reserve check.

---
 mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33818ccaf7e89..ec0b55ea1506e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1339,6 +1339,9 @@ static void __free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2172,6 +2175,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long gbl_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
+	bool deferred_reserve;

 	idx = hstate_index(h);
 	/*
@@ -2209,10 +2213,20 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
+	if (deferred_reserve) {
+		ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h),
+						   &h_cg, true);
+		if (ret)
+			goto out_subpool_put;
+	}
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
 					   false);
 	if (ret)
-		goto out_subpool_put;
+		goto out_uncharge_cgroup_reservation;

 	spin_lock(&hugetlb_lock);
 	/*
@@ -2236,6 +2250,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (deferred_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2261,6 +2283,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
 				       false);
+out_uncharge_cgroup_reservation:
+	if (deferred_reserve)
+		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
+					       h_cg, true);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.25.0.341.g760bfbb309-goog
