Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2D2C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3143D2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch+ZzZ5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgEAVQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:16:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588367758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TwVeJRda5LXDJE4kjcBYfmqq13SV7B4dqiJ51LZW9+E=;
        b=ch+ZzZ5EcP9fFNlbrX17tAGR8CkMCzKusCqP8LzQhPEeuCUmJcIzOtl68MN8UGLLvird1P
        DA3HWsE3ZGP91hLlniGeTqfAP8PFri7vXgGZRRo894bCK5Rd5t6XdBV/yqHXLAY/gHBFOS
        zWHK1dGm501pj/ZmG2zLATyhxijbNsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-hRavvBV7MceEKvU9Y_G19A-1; Fri, 01 May 2020 17:15:54 -0400
X-MC-Unique: hRavvBV7MceEKvU9Y_G19A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7011B100CCC0;
        Fri,  1 May 2020 21:15:53 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B966927072;
        Fri,  1 May 2020 21:15:50 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Subject: [PATCH] mm: slub: add panic_on_error to the debug facilities
Date:   Fri,  1 May 2020 17:15:40 -0400
Message-Id: <20200501211540.71216-1-aquini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it is desirable to override SLUB's debug facilities
default behavior upon stumbling on a cache or object error
and just stop the execution in order to grab a coredump, at
the error-spotting time, instead of trying to fix the issue
and report in an attempt to keep the system rolling.

This patch introduces a new debug flag SLAB_PANIC_ON_ERROR,
along with its related SLUB-machinery, in order to extend
current slub_debug facilites and provide the aforementioned
behavior override.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 Documentation/vm/slub.rst |  2 ++
 include/linux/slab.h      |  2 ++
 mm/slab.h                 |  3 ++-
 mm/slub.c                 | 44 ++++++++++++++++++++++++++++++---------
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 933ada4368ff..51b18c28ec78 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -54,6 +54,8 @@ Possible debug options are::
 			caused higher minimum slab orders
 	-		Switch all debugging off (useful if the kernel is
 			configured with CONFIG_SLUB_DEBUG_ON)
+	C		Toggle panic on error (crash) to allow for post-mortem
+			analysis of a coredump taken at the error-spotting time
=20
 F.e. in order to boot just with sanity checks and red zoning one would s=
pecify::
=20
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6d454886bcaf..e3496ad7859f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -25,6 +25,8 @@
  */
 /* DEBUG: Perform (expensive) checks on alloc/free */
 #define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
+/* DEBUG: panic on error (forced crash) */
+#define SLAB_PANIC_ON_ERROR	((slab_flags_t __force)0x00000200U)
 /* DEBUG: Red zone objs in a cache */
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
diff --git a/mm/slab.h b/mm/slab.h
index 207c83ef6e06..27116f8683a1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -198,7 +198,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned =
int object_size,
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
 #elif defined(CONFIG_SLUB_DEBUG)
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
-			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
+			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS | \
+			  SLAB_PANIC_ON_ERROR)
 #else
 #define SLAB_DEBUG_FLAGS (0)
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 9bf44955c4f1..8b4fc002b865 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -700,8 +700,6 @@ static void print_trailer(struct kmem_cache *s, struc=
t page *page, u8 *p)
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding ", p + off,
 			      size_from_object(s) - off);
-
-	dump_stack();
 }
=20
 void object_err(struct kmem_cache *s, struct page *page,
@@ -709,6 +707,9 @@ void object_err(struct kmem_cache *s, struct page *pa=
ge,
 {
 	slab_bug(s, "%s", reason);
 	print_trailer(s, page, object);
+	if (unlikely(s->flags & SLAB_PANIC_ON_ERROR))
+		panic("BUG: %s: %s", s->name, reason);
+	dump_stack();
 }
=20
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *p=
age,
@@ -722,6 +723,8 @@ static __printf(3, 4) void slab_err(struct kmem_cache=
 *s, struct page *page,
 	va_end(args);
 	slab_bug(s, "%s", buf);
 	print_page_info(page);
+	if (unlikely(s->flags & SLAB_PANIC_ON_ERROR))
+		panic("BUG: %s: %s", s->name, buf);
 	dump_stack();
 }
=20
@@ -771,7 +774,7 @@ static int check_bytes_and_report(struct kmem_cache *=
s, struct page *page,
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
-
+	dump_stack();
 	restore_bytes(s, what, value, fault, end);
 	return 0;
 }
@@ -1173,13 +1176,14 @@ static inline int free_consistency_checks(struct =
kmem_cache *s,
 		if (!PageSlab(page)) {
 			slab_err(s, page, "Attempt to free object(0x%p) outside of slab",
 				 object);
-		} else if (!page->slab_cache) {
-			pr_err("SLUB <none>: no slab for object 0x%p.\n",
-			       object);
-			dump_stack();
-		} else
-			object_err(s, page, object,
-					"page slab pointer corrupt.");
+		} else {
+			char reason[80];
+
+			snprintf(reason, sizeof(reason),
+				 "page slab pointer corruption: 0x%p (0x%p expected)",
+				 page->slab_cache, s);
+			object_err(s, page, object, reason);
+		}
 		return 0;
 	}
 	return 1;
@@ -1291,6 +1295,9 @@ static int __init setup_slub_debug(char *str)
 			 */
 			disable_higher_order_debug =3D 1;
 			break;
+		case 'c':
+			slub_debug |=3D SLAB_PANIC_ON_ERROR;
+			break;
 		default:
 			pr_err("slub_debug option '%c' unknown. skipped\n",
 			       *str);
@@ -5312,6 +5319,22 @@ static ssize_t free_calls_show(struct kmem_cache *=
s, char *buf)
 	return list_locations(s, buf, TRACK_FREE);
 }
 SLAB_ATTR_RO(free_calls);
+
+static ssize_t
+panic_on_error_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(s->flags & SLAB_PANIC_ON_ERROR));
+}
+
+static ssize_t
+panic_on_error_store(struct kmem_cache *s, const char *buf, size_t lengt=
h)
+{
+	s->flags &=3D ~SLAB_PANIC_ON_ERROR;
+	if (buf[0] =3D=3D '1')
+		s->flags |=3D SLAB_PANIC_ON_ERROR;
+	return length;
+}
+SLAB_ATTR(panic_on_error);
 #endif /* CONFIG_SLUB_DEBUG */
=20
 #ifdef CONFIG_FAILSLAB
@@ -5486,6 +5509,7 @@ static struct attribute *slab_attrs[] =3D {
 	&validate_attr.attr,
 	&alloc_calls_attr.attr,
 	&free_calls_attr.attr,
+	&panic_on_error_attr.attr,
 #endif
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
--=20
2.25.4

