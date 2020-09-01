Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E14C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4369D206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERPDUKbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgIAQ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:29:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728289AbgIAQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FL08+vWWj3quE65ajNi5b46OkqhFrRGb41bV5AnZLQw=;
        b=ERPDUKbiPR5FVuNiuVEzVVqisPVM1AXybDncVMqJZcK0eAkuvYXuiHeYK7TtlVDfwbIfI1
        IKZgET3CbKO89G2i/oxOZhtFd5MbwurD3t8auJJwMVRtTiCVm5c3X1CJfccGfyfSlzHQTJ
        gUsggv7cURyLLI6fO6GUL7fBxzh077M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-dCtNfjpfN_W8gxPWXNEBUg-1; Tue, 01 Sep 2020 12:29:02 -0400
X-MC-Unique: dCtNfjpfN_W8gxPWXNEBUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EABB8014D9;
        Tue,  1 Sep 2020 16:29:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E1D11002D6F;
        Tue,  1 Sep 2020 16:29:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 6/7] mm: Fold ra_submit() into do_sync_mmap_readahead()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:59 +0100
Message-ID: <159897773980.405783.13680099265521545037.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold ra_submit() into its last remaining user and pass the previously added
readahead_control struct down into __do_page_cache_readahead().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/filemap.c  |    6 +++---
 mm/internal.h |   11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f2f99db7318..c22bb01e8ba6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2502,10 +2502,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
+	ra->start = rac._index    = max_t(long, 0, offset - ra->ra_pages / 2);
+	ra->size  = rac._nr_pages = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
-	ra_submit(ra, mapping, file);
+	__do_page_cache_readahead(&rac, ra->async_size);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index e1d296e76fb0..de3b2ce2743a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -52,17 +52,6 @@ void unmap_page_range(struct mmu_gather *tlb,
 void force_page_cache_readahead(struct readahead_control *);
 void __do_page_cache_readahead(struct readahead_control *, unsigned long);
 
-/*
- * Submit IO for the read-ahead request in file_ra_state.
- */
-static inline void ra_submit(struct file_ra_state *ra,
-		struct address_space *mapping, struct file *file)
-{
-	DEFINE_READAHEAD(rac, file, mapping, ra->start);
-	rac._nr_pages = ra->size;
-	__do_page_cache_readahead(&rac, ra->async_size);
-}
-
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test


