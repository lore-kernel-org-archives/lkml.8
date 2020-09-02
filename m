Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987ADC2BBD0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9820773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+psS0pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgIBO0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:26:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726285AbgIBOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599056170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xUmKgg4xwWqmh+xeFrCeVaIW4I5DLAbupfKnbPLRKZg=;
        b=E+psS0pHu6QA1gb2hqMsujDsp3fMdFEHD9V4Kj6S726ytk+uPXKI1miAb8qfZDu+vD81kQ
        JhYsvAaedEXP+eNb4iOpDbMLX1N+kdoOwN0gNqo2BvykpD2TVJhFo2nm0Bb2/14uBeBatk
        ZiSIKypiPA29UvOCXjSaBWzHO83YFNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-6g7IpWajN7SOUrTJYe_W1Q-1; Wed, 02 Sep 2020 10:16:06 -0400
X-MC-Unique: 6g7IpWajN7SOUrTJYe_W1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA03A425E2;
        Wed,  2 Sep 2020 14:16:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE2427DA4A;
        Wed,  2 Sep 2020 14:16:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] Fix khugepaged's request size in collapse_file()
From:   David Howells <dhowells@redhat.com>
To:     akpm@linux-foundation.org
Cc:     Song Liu <songliubraving@fb.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 15:16:02 +0100
Message-ID: <159905616280.521200.12444250032673650063.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

collapse_file() in khugepaged passes PAGE_SIZE as the number of pages to be
read ahead to page_cache_sync_readahead().  It seems this was expressed as a
number of bytes rather than a number of pages.

Fix it to use the number of pages to the end of the window instead.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

 mm/khugepaged.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6d199c353281..f2d243077b74 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1706,7 +1706,7 @@ static void collapse_file(struct mm_struct *mm,
 				xas_unlock_irq(&xas);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
-							  PAGE_SIZE);
+							  end - index);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);


