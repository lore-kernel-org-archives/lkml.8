Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE73C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38D122522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="q/z6+Bde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgATQjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:39:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33846 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:39:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so30707407qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjYtDUvLvMYlhIvuD1xMxndqXr35/jOrhQJr+DWUbRw=;
        b=q/z6+Bdex6ZDtkJAAhBIZaTdS8LZpO0r7h1LGwU22odEOD4YPNUzHhYmUEUm51DrrX
         fQ5OkfN/REx9CwH/khr/P8qOLs9o2qQgzHWbHPuOEgHwTJkY6/7A9WtBRlgA9J+eB6pg
         sUet/WbHIwgWWyZPTSL/wCQyXV9ajt3QP0jHHUfO+T0Xa5L5SLqj7vWMcAUD7BTtUnNo
         TmYgBWYG0ERAjmACwRIz7c2cUsVqtrEoPix2WcrGQP7/ceG+sukv2uRrq+79HBB6z+ji
         j1Ruxsmeu9laRNX99RFj9vAsDfDeH5PLaXV1H8LPUGYqYh+0NTDqwntN/NcPJ9bKL/Fg
         evWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjYtDUvLvMYlhIvuD1xMxndqXr35/jOrhQJr+DWUbRw=;
        b=BcaUfcF92OIipLfLZp+kIC9Bq00W33QpWJrugo8PrgNkJVHXb4PAPGV/NCughL3rLL
         GLmeg6q9JKypCoPltoddK8yKFVkJhrEn8CUQwtuLb2bBhaDAsaU968senQBpoNqD+djw
         29zEZvgDm1nQ2RsiT53pfYO6ycRleFwy6pascyj0YxMe7mXuX1LJf+FlITy+xnxDkVUX
         p285nBokFQvIHIQJCKlsSIeNUI5txVp8AVc2FxXokwIq5uW0XqroKRaXqnu7HbH7+hth
         1d6x7zEqJN7yI8ArLDLkf5ebqp8DSfg5wnA2eaiF15B9gCwspp/XA+U23+ITFaWVK7cT
         3eUw==
X-Gm-Message-State: APjAAAV44xTmCAkqrXOn9SOV79ozFkYEFTlELK225epcTYkzrp2MXKNd
        RBG0imo7E0qViTUY7UPWnIyxXQ==
X-Google-Smtp-Source: APXvYqz0GHpFOA+3eQ0vNIS6wz4J7l778/zehWDFokXO4lRATb+gC65IN8Rol5K3TJPnkqzPy7cLXA==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr332538qke.313.1579538362344;
        Mon, 20 Jan 2020 08:39:22 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g62sm15877601qkd.25.2020.01.20.08.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 08:39:21 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -mm v3] mm/page_isolation: fix potential warning from user
Date:   Mon, 20 Jan 2020 11:39:15 -0500
Message-Id: <20200120163915.1469-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
from start_isolate_page_range(), but should avoid triggering it from
userspace, i.e, from is_mem_section_removable() because it could crash
the system by a non-root user if warn_on_panic is set.

While at it, simplify the code a bit by removing an unnecessary jump
label.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Drop the page_isolation.c cleanup change.
v2: Improve the commit log.
    Warn for all start_isolate_page_range() users not just offlining.

 mm/page_alloc.c     | 11 ++++-------
 mm/page_isolation.c | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 621716a25639..3c4eb750a199 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		if (is_migrate_cma(migratetype))
 			return NULL;
 
-		goto unmovable;
+		return page;
 	}
 
 	for (; iter < pageblock_nr_pages; iter++) {
@@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		page = pfn_to_page(pfn + iter);
 
 		if (PageReserved(page))
-			goto unmovable;
+			return page;
 
 		/*
 		 * If the zone is movable and we have ruled out all reserved
@@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 			unsigned int skip_pages;
 
 			if (!hugepage_migration_supported(page_hstate(head)))
-				goto unmovable;
+				return page;
 
 			skip_pages = compound_nr(head) - (page - head);
 			iter += skip_pages - 1;
@@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * is set to both of a memory hole page and a _used_ kernel
 		 * page at boot.
 		 */
-		goto unmovable;
+		return page;
 	}
 	return NULL;
-unmovable:
-	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	return pfn_to_page(pfn + iter);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e70586523ca3..a9fd7c740c23 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -54,14 +54,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret)
+	if (!ret) {
 		drain_all_pages(zone);
-	else if ((isol_flags & REPORT_FAILURE) && unmovable)
-		/*
-		 * printk() with zone->lock held will guarantee to trigger a
-		 * lockdep splat, so defer it here.
-		 */
-		dump_page(unmovable, "unmovable page");
+	} else {
+		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
+
+		if ((isol_flags & REPORT_FAILURE) && unmovable)
+			/*
+			 * printk() with zone->lock held will likely trigger a
+			 * lockdep splat, so defer it here.
+			 */
+			dump_page(unmovable, "unmovable page");
+	}
 
 	return ret;
 }
-- 
2.21.0 (Apple Git-122.2)

