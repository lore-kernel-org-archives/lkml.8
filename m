Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EB3C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82B8206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8cQhN9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD0CDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 22:03:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgD0CDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587952982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=v8IFSlr9wk6PnyUzpFzR48ViDPJ0s7W1u3H0V53GluQ=;
        b=d8cQhN9hOKBk09jvHvC9RP4DkL5y6/+9I16xp2ph0JPNmTisFiWdX9sfG1lvpXFJlwVSEA
        k6dr2UOONTyIUJoZAIUKZbI8u8wZa+J2d06lsQqcWq0FYSyNgpezFmQTG9igaxWTInEUKv
        e8nTvpR/vW2a+2OKsfI68hj7M5NEppA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-N7-FcSTOP6ivGEwrnC56Ig-1; Sun, 26 Apr 2020 22:02:28 -0400
X-MC-Unique: N7-FcSTOP6ivGEwrnC56Ig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0417C835B40;
        Mon, 27 Apr 2020 02:02:27 +0000 (UTC)
Received: from llong.com (ovpn-112-228.rdu2.redhat.com [10.10.112.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D351610B0;
        Mon, 27 Apr 2020 02:02:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/slub: Fix incorrect checkings of s->offset
Date:   Sun, 26 Apr 2020 22:02:12 -0400
Message-Id: <20200427020212.5222-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places in the slub memory allocator, the code uses
"s->offset" as a check to see if the free pointer is put right after the
object. That check is no longer true with commit 3202fa62fb43 ("slub:
relocate freelist pointer to middle of object").

As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
may cause a bunch of "Freepointer corrupt" error reports to appear with
the system in panic afterwards.

To fix it, use the check "s->offset == s->inuse" instead.

Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slub.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0e736d66bb42..99952d01e7e0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -556,10 +556,8 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 {
 	struct track *p;
 
-	if (s->offset)
-		p = object + s->offset + sizeof(void *);
-	else
-		p = object + s->inuse;
+	p = object + s->inuse +
+	    ((s->offset == s->inuse) ? sizeof(void *) : 0);
 
 	return p + alloc;
 }
@@ -693,10 +691,8 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 		print_section(KERN_ERR, "Redzone ", p + s->object_size,
 			s->inuse - s->object_size);
 
-	if (s->offset)
-		off = s->offset + sizeof(void *);
-	else
-		off = s->inuse;
+	off = s->inuse +
+	      ((s->offset == s->inuse) ? sizeof(void *) : 0);
 
 	if (s->flags & SLAB_STORE_USER)
 		off += 2 * sizeof(struct track);
@@ -790,7 +786,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
  * object address
  * 	Bytes of the object to be managed.
  * 	If the freepointer may overlay the object then the free
- * 	pointer is the first word of the object.
+ *	pointer is at the middle of the object.
  *
  * 	Poisoning uses 0x6b (POISON_FREE) and the last byte is
  * 	0xa5 (POISON_END)
@@ -826,7 +822,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct page *page, u8 *p)
 {
 	unsigned long off = s->inuse;	/* The end of info */
 
-	if (s->offset)
+	if (s->offset == s->inuse)
 		/* Freepointer is placed after the object. */
 		off += sizeof(void *);
 
@@ -915,7 +911,7 @@ static int check_object(struct kmem_cache *s, struct page *page,
 		check_pad_bytes(s, page, p);
 	}
 
-	if (!s->offset && val == SLUB_RED_ACTIVE)
+	if ((s->offset != s->inuse) && val == SLUB_RED_ACTIVE)
 		/*
 		 * Object and freepointer overlap. Cannot check
 		 * freepointer while object is allocated.
-- 
2.18.1

