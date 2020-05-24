Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A21C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFF4208C9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbgEXV6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbgEXV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:57:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD9C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:57:54 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcycx-0007Zv-Ll; Sun, 24 May 2020 23:57:51 +0200
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
Subject: [PATCH v2 6/7] zram: Allocate struct zcomp_strm as per-CPU memory
Date:   Sun, 24 May 2020 23:57:38 +0200
Message-Id: <20200524215739.551568-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200524215739.551568-1-bigeasy@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zcomp::stream is per-CPU pointer, pointing to struct zcomp_strm which
contains two pointer. Having struct zcomp_strm allocated directly as
per-CPU memory would avoid one additional memory allocation and a
pointer dereference.
This also also simplifies adding a local_lock to struct zcomp_strm.

Allocate zcomp::stream directly as per-CPU memory.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zcomp.c | 34 ++++++++++++++--------------------
 drivers/block/zram/zcomp.h |  2 +-
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1a8564a79d8dc..ae6dc137a1ed8 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -37,19 +37,17 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 	if (!IS_ERR_OR_NULL(zstrm->tfm))
 		crypto_free_comp(zstrm->tfm);
 	free_pages((unsigned long)zstrm->buffer, 1);
-	kfree(zstrm);
+	zstrm->tfm =3D NULL;
+	zstrm->buffer =3D NULL;
 }
=20
 /*
  * allocate new zcomp_strm structure with ->tfm initialized by
  * backend, return NULL on error
  */
-static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *comp)
+static int zcomp_strm_alloc(struct zcomp_strm *zstrm,
+			    struct zcomp *comp)
 {
-	struct zcomp_strm *zstrm =3D kmalloc(sizeof(*zstrm), GFP_KERNEL);
-	if (!zstrm)
-		return NULL;
-
 	zstrm->tfm =3D crypto_alloc_comp(comp->name, 0, 0);
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
@@ -58,9 +56,9 @@ static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *=
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
@@ -113,7 +111,7 @@ ssize_t zcomp_available_show(const char *comp, char *bu=
f)
=20
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	return get_cpu_ptr(comp->stream);
 }
=20
 void zcomp_stream_put(struct zcomp *comp)
@@ -159,16 +157,14 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hli=
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
+	ret =3D zcomp_strm_alloc(zstrm, comp);
+	if (ret) {
 		pr_err("Can't allocate a compression stream\n");
 		return -ENOMEM;
 	}
-	*per_cpu_ptr(comp->stream, cpu) =3D zstrm;
 	return 0;
 }
=20
@@ -177,10 +173,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node=
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
@@ -188,7 +182,7 @@ static int zcomp_init(struct zcomp *comp)
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

