Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FC620767
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipacoM1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbgFXD14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:27:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20778 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387985AbgFXD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592969272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LuTtoSGXJewNeG9sj4V/BG+fVb0iM20PQFKrLVPrSAI=;
        b=ipacoM1stEqjc/0SmMzYTQuYGyIdl9P7ArLtSeSRPKijV4ALW/LXqZJuxEKxuQbqgGN6Cn
        4yolIuc6tqnTJUD4bg9uCtkLSYPlJaouIuaLzwYzxZxTbDz172TQCh77dKwFgOuMOCJrWI
        cKd4Z/LZy+IFH7dbbSyF4gxCcnfCAjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-P7bqO8BOPtCyaMwSwRWzoQ-1; Tue, 23 Jun 2020 23:27:51 -0400
X-MC-Unique: P7bqO8BOPtCyaMwSwRWzoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DB65464;
        Wed, 24 Jun 2020 03:27:49 +0000 (UTC)
Received: from jsavitz.bos.com (ovpn-112-219.rdu2.redhat.com [10.10.112.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F115A60C1D;
        Wed, 24 Jun 2020 03:27:45 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
Subject: [PATCH] mm/page_alloc: fix documentation error and remove magic numbers
Date:   Tue, 23 Jun 2020 23:27:12 -0400
Message-Id: <20200624032712.23263-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I increased the upper bound of the min_free_kbytes value in
ee8eb9a5fe863, I forgot to tweak the above comment to reflect
the new value. This patch fixes that mistake.

In addition, this patch replaces the magic number bounds with symbolic
constants to clarify the logic.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/page_alloc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..f725addc2748 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7832,7 +7832,7 @@ void setup_per_zone_wmarks(void)
  * Initialise min_free_kbytes.
  *
  * For small machines we want it small (128k min).  For large machines
- * we want it large (64MB max).  But it is not linear, because network
+ * we want it large (256MB max).  But it is not linear, because network
  * bandwidth does not increase linearly with machine size.  We use
  *
  *	min_free_kbytes = 4 * sqrt(lowmem_kbytes), for better accuracy:
@@ -7852,6 +7852,9 @@ void setup_per_zone_wmarks(void)
  * 8192MB:	11584k
  * 16384MB:	16384k
  */
+static const int MIN_FREE_KBYTES_LOWER_BOUND = 1 << 7;
+static const int MIN_FREE_KBYTES_UPPER_BOUND = 1 << 18;
+
 int __meminit init_per_zone_wmark_min(void)
 {
 	unsigned long lowmem_kbytes;
@@ -7862,10 +7865,10 @@ int __meminit init_per_zone_wmark_min(void)
 
 	if (new_min_free_kbytes > user_min_free_kbytes) {
 		min_free_kbytes = new_min_free_kbytes;
-		if (min_free_kbytes < 128)
-			min_free_kbytes = 128;
-		if (min_free_kbytes > 262144)
-			min_free_kbytes = 262144;
+		if (min_free_kbytes < MIN_FREE_KBYTES_LOWER_BOUND)
+			min_free_kbytes = MIN_FREE_KBYTES_LOWER_BOUND;
+		if (min_free_kbytes > MIN_FREE_KBYTES_UPPER_BOUND)
+			min_free_kbytes = MIN_FREE_KBYTES_UPPER_BOUND;
 	} else {
 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
-- 
2.23.0

