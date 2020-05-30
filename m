Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ECFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C24C20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="kkINKxaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgE3J20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:28:26 -0400
Received: from sender4-pp-o92.zoho.com ([136.143.188.92]:25214 "EHLO
        sender4-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE3J2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:28:25 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 May 2020 05:28:24 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1590829994; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=PggdZzSuWvDLbJNw7atcX3+Vis4QfQyB5zHK60v/6V0wGFFt6QygPJGBwAOSXaPbiZcSDn1YJix5Xd5Qqmvj6Ywr0pdWYZd1Kt4SZHSHwiQRMbluVafI0gYO7bjbOtvHc2J7nDOQPRuSpDT57uZaDK/bIlwarV4JGypnWu+QPOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1590829994; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=XrokKC4/ImgUPNlyH2Qxcoogw6p4iOQ8UZ6MGI2SebE=; 
        b=eQQeZ/7s2gUwLjvdbSrNaJnac6hXeLwCD6bxRTQW1BNfwNlPbJGQ45Yw0JYJCpwIUJFLZqcIdWGUW8RtMIfUGLoiuPuxm0MTA6LDgxvrGgkRVVFvY3RBgDVEqIfnASY3+QkH4U08XkfKlMLISnz7tFE1FYEjr74FLyU4DTw1MMA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=InSRFFHZIqX5BX2gNEKPbW6KoxBQbmgcqpQKevNkSbLk3Rp/XFOi4xHgQMXIFTpOVJSsXvYqF+w7
    cCkb6XYMW+vTeqt0AdF5HHBhOC4uJZsDaLTpct4MtdqpwwAr0+LN  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590829994;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=XrokKC4/ImgUPNlyH2Qxcoogw6p4iOQ8UZ6MGI2SebE=;
        b=kkINKxaS0BwMRbFunXXhCFrS000X9pH8wU9qXEsolDTTjx/1IXDixQVY7kXTJGDG
        oYYcoZZ7XgLXW2pRhbmoIsmpnjfdBkjiF4siqcYvWpcctjUe/jfZOi6C+wuUZWmaVNL
        q1HzwW10flfKE8xbVEqwAaNPqogbYwZwIRtghc7I=
Received: from YEHS1XPF1D05WL.lenovo.com (111.197.250.66 [111.197.250.66]) by mx.zohomail.com
        with SMTPS id 1590829993582376.40498152393263; Sat, 30 May 2020 02:13:13 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm writecache: reinitialize lru in writeback instead of endio
Date:   Sat, 30 May 2020 17:12:50 +0800
Message-Id: <20200530091250.58420-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

When wc_entry has been removed from wbl->list in writeback, it will
be not used again except waiting to be set free in writecache_free_entry.

That is a little of annoying, it has to reinitialize lru of wc_entry
in endio before calling writecache_free_entry.

Using list_del_init instead of list_del in writeback for simpler code.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 7bbc21b..66f3a3b 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1519,7 +1519,6 @@ static void __writecache_endio_pmem(struct dm_writecache *wc, struct list_head *
 			e = wb->wc_list[i];
 			BUG_ON(!e->write_in_progress);
 			e->write_in_progress = false;
-			INIT_LIST_HEAD(&e->lru);
 			if (!writecache_has_error(wc))
 				writecache_free_entry(wc, e);
 			BUG_ON(!wc->writeback_size);
@@ -1555,7 +1554,6 @@ static void __writecache_endio_ssd(struct dm_writecache *wc, struct list_head *l
 		do {
 			BUG_ON(!e->write_in_progress);
 			e->write_in_progress = false;
-			INIT_LIST_HEAD(&e->lru);
 			if (!writecache_has_error(wc))
 				writecache_free_entry(wc, e);
 
@@ -1654,7 +1652,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 	while (wbl->size) {
 		wbl->size--;
 		e = container_of(wbl->list.prev, struct wc_entry, lru);
-		list_del(&e->lru);
+		list_del_init(&e->lru);
 
 		max_pages = e->wc_list_contiguous;
 
@@ -1685,7 +1683,7 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 			if (!wc_add_block(wb, f, GFP_NOWAIT | __GFP_NOWARN))
 				break;
 			wbl->size--;
-			list_del(&f->lru);
+			list_del_init(&f->lru);
 			wb->wc_list[wb->wc_list_n++] = f;
 			e = f;
 		}
@@ -1712,7 +1710,7 @@ static void __writecache_writeback_ssd(struct dm_writecache *wc, struct writebac
 
 		wbl->size--;
 		e = container_of(wbl->list.prev, struct wc_entry, lru);
-		list_del(&e->lru);
+		list_del_init(&e->lru);
 
 		n_sectors = e->wc_list_contiguous << (wc->block_size_bits - SECTOR_SHIFT);
 
@@ -1732,7 +1730,7 @@ static void __writecache_writeback_ssd(struct dm_writecache *wc, struct writebac
 			wbl->size--;
 			f = container_of(wbl->list.prev, struct wc_entry, lru);
 			BUG_ON(f != e + 1);
-			list_del(&f->lru);
+			list_del_init(&f->lru);
 			e = f;
 		}
 
-- 
1.8.3.1

