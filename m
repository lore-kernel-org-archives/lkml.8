Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB94C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24999206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgESUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgESUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:20:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3BC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:20:14 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8ii-00012c-4u; Tue, 19 May 2020 22:20:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 8/8] mm/zswap: Use local lock to protect per-CPU data
Date:   Tue, 19 May 2020 22:19:12 +0200
Message-Id: <20200519201912.1564477-9-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519201912.1564477-1-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>

zwap uses per-CPU compression. The per-CPU data pointer is acquired with
get_cpu_ptr() which implicitly disables preemption. It allocates
memory inside the preempt disabled region which conflicts with the
PREEMPT_RT semantics.

Replace the implicit preemption control with an explicit local lock.
This allows RT kernels to substitute it with a real per CPU lock, which
serializes the access but keeps the code section preemptible. On non RT
kernels this maps to preempt_disable() as before, i.e. no functional
change.

[bigeasy: Use local_lock(), additional hunks, patch description]

Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/zswap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fbb782924ccc5..1db2ad941e501 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/locallock.h>
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/frontswap.h>
@@ -388,6 +389,8 @@ static struct zswap_entry *zswap_entry_find_get(struct =
rb_root *root,
 * per-cpu code
 **********************************/
 static DEFINE_PER_CPU(u8 *, zswap_dstmem);
+/* Used for zswap_dstmem and tfm */
+static DEFINE_LOCAL_LOCK(zswap_cpu_lock);
=20
 static int zswap_dstmem_prepare(unsigned int cpu)
 {
@@ -919,10 +922,11 @@ static int zswap_writeback_entry(struct zpool *pool, =
unsigned long handle)
 		dlen =3D PAGE_SIZE;
 		src =3D (u8 *)zhdr + sizeof(struct zswap_header);
 		dst =3D kmap_atomic(page);
-		tfm =3D *get_cpu_ptr(entry->pool->tfm);
+		local_lock(zswap_cpu_lock);
+		tfm =3D *this_cpu_ptr(entry->pool->tfm);
 		ret =3D crypto_comp_decompress(tfm, src, entry->length,
 					     dst, &dlen);
-		put_cpu_ptr(entry->pool->tfm);
+		local_unlock(zswap_cpu_lock);
 		kunmap_atomic(dst);
 		BUG_ON(ret);
 		BUG_ON(dlen !=3D PAGE_SIZE);
@@ -1074,12 +1078,12 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
 	}
=20
 	/* compress */
-	dst =3D get_cpu_var(zswap_dstmem);
-	tfm =3D *get_cpu_ptr(entry->pool->tfm);
+	local_lock(zswap_cpu_lock);
+	dst =3D *this_cpu_ptr(&zswap_dstmem);
+	tfm =3D *this_cpu_ptr(entry->pool->tfm);
 	src =3D kmap_atomic(page);
 	ret =3D crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
 	kunmap_atomic(src);
-	put_cpu_ptr(entry->pool->tfm);
 	if (ret) {
 		ret =3D -EINVAL;
 		goto put_dstmem;
@@ -1103,7 +1107,7 @@ static int zswap_frontswap_store(unsigned type, pgoff=
_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_cpu_var(zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
=20
 	/* populate entry */
 	entry->offset =3D offset;
@@ -1131,7 +1135,7 @@ static int zswap_frontswap_store(unsigned type, pgoff=
_t offset,
 	return 0;
=20
 put_dstmem:
-	put_cpu_var(zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1176,9 +1180,10 @@ static int zswap_frontswap_load(unsigned type, pgoff=
_t offset,
 	if (zpool_evictable(entry->pool->zpool))
 		src +=3D sizeof(struct zswap_header);
 	dst =3D kmap_atomic(page);
-	tfm =3D *get_cpu_ptr(entry->pool->tfm);
+	local_lock(zswap_cpu_lock);
+	tfm =3D *this_cpu_ptr(entry->pool->tfm);
 	ret =3D crypto_comp_decompress(tfm, src, entry->length, dst, &dlen);
-	put_cpu_ptr(entry->pool->tfm);
+	local_unlock(zswap_cpu_lock);
 	kunmap_atomic(dst);
 	zpool_unmap_handle(entry->pool->zpool, entry->handle);
 	BUG_ON(ret);
--=20
2.26.2

