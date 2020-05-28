Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BC0207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1jtgxnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgE1AUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 20:20:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgE1AUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590625251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3NfM/YRWw8tWtCVntluiCugDqJX5J7Mi6y5RyulO5Co=;
        b=h1jtgxnAzQph09mJabMY9jcpazYEL6ChAclXRyCVqvk48TUdURDvVLybKR2meXwzlrcDd9
        MognWJ/M1FsGJrY4zUKWE4ffh7RjKWYAOjBNXcAf7zvgMgokqj9pOjguI3N62SODbJSRF0
        08MFNT7zwUxvvkyf2sbdXlUcg7yXw4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262--4PlExgtPwKJVseeIiuy9A-1; Wed, 27 May 2020 20:20:44 -0400
X-MC-Unique: -4PlExgtPwKJVseeIiuy9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D96EC460;
        Thu, 28 May 2020 00:20:40 +0000 (UTC)
Received: from redhat.com (ovpn-119-19.rdu2.redhat.com [10.10.119.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FCE85D9CC;
        Thu, 28 May 2020 00:20:35 +0000 (UTC)
Date:   Wed, 27 May 2020 20:20:33 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steven Capper <steve.capper@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rabin Vincent <rabinv@axis.com>,
        linux-arm-kernel@lists.infradead.org, rmk+kernel@arm.linux.org.uk,
        Guo Ren <guoren@kernel.org>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>
Subject: Cache flush issue with page_mapping_file() and swap back shmem page ?
Message-ID: <20200528002033.GB1992500@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

So any arch code which uses page_mapping_file() might get the wrong
answer, this function will return NULL for a swap backed page which
can be a shmem pages. But shmem pages can still be shared among
multiple process (and possibly at different virtual addresses if
mremap was use).

Attached is a patch that changes page_mapping_file() to return the
shmem mapping for swap backed shmem page. I have not tested it (no
way for me to test all those architecture) and i spotted this while
working on something else. So i hope someone can take a closer look.

Cheers,
Jérôme

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment;
	filename="0001-mm-fix-cache-flush-for-shmem-page-that-are-swap-back.patch"
Content-Transfer-Encoding: 8bit

From 6c76b9f8baa87ff872f6be5a44805a74c1e07fea Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Date: Wed, 27 May 2020 20:18:59 -0400
Subject: [PATCH] mm: fix cache flush for shmem page that are swap backed.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This might be a shmem page that is in a sense a file that
can be mapped multiple times in different processes at
possibly different virtual addresses (fork + mremap). So
return the shmem mapping that will allow any arch code to
find all mappings of the page.

Note that even if page is not anonymous then the page might
have a NULL page->mapping field if it is being truncated,
but then it is fine as each pte poiting to the page will be
remove and cache flushing should be handled properly by that
part of the code.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
---
 mm/util.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..ec8739ab0cc3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -685,8 +685,24 @@ EXPORT_SYMBOL(page_mapping);
  */
 struct address_space *page_mapping_file(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
+	if (unlikely(PageSwapCache(page))) {
+		/*
+		 * This might be a shmem page that is in a sense a file that
+		 * can be mapped multiple times in different processes at
+		 * possibly different virtual addresses (fork + mremap). So
+		 * return the shmem mapping that will allow any arch code to
+		 * find all mappings of the page.
+		 *
+		 * Note that even if page is not anonymous then the page might
+		 * have a NULL page->mapping field if it is being truncated,
+		 * but then it is fine as each pte poiting to the page will be
+		 * remove and cache flushing should be handled properly by that
+		 * part of the code.
+		 */
+		if (!PageAnon(page))
+			return page->mapping;
 		return NULL;
+	}
 	return page_mapping(page);
 }
 
-- 
2.26.2


--/04w6evG8XlLl3ft--

