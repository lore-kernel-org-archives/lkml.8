Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FCC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3602051A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9XvPwZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgD0OIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:08:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbgD0OIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587996533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=vwkVlBvgQUCTQoKNdaFgr/X8X7je3qN7klAliwiFuU8=;
        b=T9XvPwZcUteyJC14f+/Fe7tYYgbPYW+uNsfGY0MJ2TDkKuExI5Au4QDoM+aiY+Rg6qO9Oe
        7IcJTI7+qBka8dFxDumJA11/lITeEriSHt7X9W9EG/1RPR3d+JwiSsSBWlpE66RVd7f45m
        OJLZ7l/olj11GoWdILjnbiDqWE8h3Ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-pO6NlNGKO12NwOUKC-6Lfg-1; Mon, 27 Apr 2020 10:08:51 -0400
X-MC-Unique: pO6NlNGKO12NwOUKC-6Lfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2425835B8D;
        Mon, 27 Apr 2020 14:08:49 +0000 (UTC)
Received: from llong.com (ovpn-118-57.rdu2.redhat.com [10.10.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D13EE6062E;
        Mon, 27 Apr 2020 14:08:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] mm/slub: Fix incorrect interpretation of s->offset
Date:   Mon, 27 Apr 2020 10:08:22 -0400
Message-Id: <20200427140822.18619-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places in the slub memory allocator, the code uses
"s->offset" as a check to see if the free pointer is put right after the
object. That check is no longer true with commit 3202fa62fb43 ("slub:
relocate freelist pointer to middle of object").

As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
may cause a bunch of "Freepointer corrupt" error reports like the
following to appear with the system in panic afterwards.

[   38.579769] =============================================================================
[   38.580845] BUG dentry(666:pmcd.service) (Tainted: G    B): Freepointer corrupt
[   38.581948] -----------------------------------------------------------------------------

To fix it, use the check "s->offset == s->inuse" in the new helper
function freeptr_after_object() instead. Also add another helper function
get_info_end() to return the end of info block (inuse + free pointer
if not overlapping with object).

Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slub.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0e736d66bb42..68f1b4b1c309 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -551,15 +551,29 @@ static void print_section(char *level, char *text, u8 *addr,
 	metadata_access_disable();
 }
 
+static inline bool freeptr_after_object(struct kmem_cache *s)
+{
+	return s->offset == s->inuse;
+}
+
+/*
+ * Return offset of the end of info block which is inuse + free pointer if
+ * not overlapping with object.
+ */
+static inline unsigned int get_info_end(struct kmem_cache *s)
+{
+	if (freeptr_after_object(s))
+		return s->inuse + sizeof(void *);
+	else
+		return s->inuse;
+}
+
 static struct track *get_track(struct kmem_cache *s, void *object,
 	enum track_item alloc)
 {
 	struct track *p;
 
-	if (s->offset)
-		p = object + s->offset + sizeof(void *);
-	else
-		p = object + s->inuse;
+	p = object + get_info_end(s);
 
 	return p + alloc;
 }
@@ -693,10 +707,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 		print_section(KERN_ERR, "Redzone ", p + s->object_size,
 			s->inuse - s->object_size);
 
-	if (s->offset)
-		off = s->offset + sizeof(void *);
-	else
-		off = s->inuse;
+	off = get_info_end(s);
 
 	if (s->flags & SLAB_STORE_USER)
 		off += 2 * sizeof(struct track);
@@ -790,7 +801,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
  * object address
  * 	Bytes of the object to be managed.
  * 	If the freepointer may overlay the object then the free
- * 	pointer is the first word of the object.
+ *	pointer is at the middle of the object.
  *
  * 	Poisoning uses 0x6b (POISON_FREE) and the last byte is
  * 	0xa5 (POISON_END)
@@ -824,11 +835,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 
 static int check_pad_bytes(struct kmem_cache *s, struct page *page, u8 *p)
 {
-	unsigned long off = s->inuse;	/* The end of info */
-
-	if (s->offset)
-		/* Freepointer is placed after the object. */
-		off += sizeof(void *);
+	unsigned long off = get_info_end(s);	/* The end of info */
 
 	if (s->flags & SLAB_STORE_USER)
 		/* We also have user information there */
@@ -915,7 +922,7 @@ static int check_object(struct kmem_cache *s, struct page *page,
 		check_pad_bytes(s, page, p);
 	}
 
-	if (!s->offset && val == SLUB_RED_ACTIVE)
+	if (!freeptr_after_object(s) && val == SLUB_RED_ACTIVE)
 		/*
 		 * Object and freepointer overlap. Cannot check
 		 * freepointer while object is allocated.
-- 
2.18.1

