Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA808C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C940720B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgE0ULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgE0ULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:11:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E87C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:11:29 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je2Oc-0005ku-SH; Wed, 27 May 2020 22:11:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH v3 6/7] zram: Allocate struct zcomp_strm as per-CPU memory
Date:   Wed, 27 May 2020 22:11:18 +0200
Message-Id: <20200527201119.1692513-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527201119.1692513-1-bigeasy@linutronix.de>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zcomp::stream is a per-CPU pointer, pointing to struct zcomp_strm
which contains two pointers. Having struct zcomp_strm allocated
directly as per-CPU memory would avoid one additional memory
allocation and a pointer dereference. This also simplifies the
addition of a local_lock to struct zcomp_strm.

Allocate zcomp::stream directly as per-CPU memory.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zcomp.c | 41 +++++++++++++++-----------------------
 drivers/block/zram/zcomp.h |  2 +-
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1a8564a79d8dc..912e3e63d8a09 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -37,19 +37,16 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 	if (!IS_ERR_OR_NULL(zstrm->tfm))
 		crypto_free_comp(zstrm->tfm);
 	free_pages((unsigned long)zstrm->buffer, 1);
-	kfree(zstrm);
+	zstrm->tfm =3D NULL;
+	zstrm->buffer =3D NULL;
 }
=20
 /*
- * allocate new zcomp_strm structure with ->tfm initialized by
- * backend, return NULL on error
+ * Initialize zcomp_strm structure with ->tfm initialized by backend, and
+ * ->buffer. Return a negative value on error.
  */
-static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *comp)
+static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 {
-	struct zcomp_strm *zstrm =3D kmalloc(sizeof(*zstrm), GFP_KERNEL);
-	if (!zstrm)
-		return NULL;
-
 	zstrm->tfm =3D crypto_alloc_comp(comp->name, 0, 0);
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
@@ -58,9 +55,9 @@ static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *=
comp)
 	zstrm->buffer =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
 	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
 		zcomp_strm_free(zstrm);
-		zstrm =3D NULL;
+		return -ENOMEM;
 	}
-	return zstrm;
+	return 0;
 }
=20
 bool zcomp_available_algorithm(const char *comp)
@@ -113,7 +110,7 @@ ssize_t zcomp_available_show(const char *comp, char *bu=
f)
=20
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	return get_cpu_ptr(comp->stream);
 }
=20
 void zcomp_stream_put(struct zcomp *comp)
@@ -159,17 +156,13 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hli=
st_node *node)
 {
 	struct zcomp *comp =3D hlist_entry(node, struct zcomp, node);
 	struct zcomp_strm *zstrm;
+	int ret;
=20
-	if (WARN_ON(*per_cpu_ptr(comp->stream, cpu)))
-		return 0;
-
-	zstrm =3D zcomp_strm_alloc(comp);
-	if (IS_ERR_OR_NULL(zstrm)) {
+	zstrm =3D per_cpu_ptr(comp->stream, cpu);
+	ret =3D zcomp_strm_init(zstrm, comp);
+	if (ret)
 		pr_err("Can't allocate a compression stream\n");
-		return -ENOMEM;
-	}
-	*per_cpu_ptr(comp->stream, cpu) =3D zstrm;
-	return 0;
+	return ret;
 }
=20
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
@@ -177,10 +170,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node=
 *node)
 	struct zcomp *comp =3D hlist_entry(node, struct zcomp, node);
 	struct zcomp_strm *zstrm;
=20
-	zstrm =3D *per_cpu_ptr(comp->stream, cpu);
-	if (!IS_ERR_OR_NULL(zstrm))
-		zcomp_strm_free(zstrm);
-	*per_cpu_ptr(comp->stream, cpu) =3D NULL;
+	zstrm =3D per_cpu_ptr(comp->stream, cpu);
+	zcomp_strm_free(zstrm);
 	return 0;
 }
=20
@@ -188,7 +179,7 @@ static int zcomp_init(struct zcomp *comp)
 {
 	int ret;
=20
-	comp->stream =3D alloc_percpu(struct zcomp_strm *);
+	comp->stream =3D alloc_percpu(struct zcomp_strm);
 	if (!comp->stream)
 		return -ENOMEM;
=20
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 1806475b919df..72c2ee4d843ed 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -14,7 +14,7 @@ struct zcomp_strm {
=20
 /* dynamic per-device compression frontend */
 struct zcomp {
-	struct zcomp_strm * __percpu *stream;
+	struct zcomp_strm __percpu *stream;
 	const char *name;
 	struct hlist_node node;
 };
--=20
2.27.0.rc0

