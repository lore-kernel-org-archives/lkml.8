Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E489207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbgEXV6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbgEXV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:58:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C0C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:58:02 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcycy-0007Zv-HD; Sun, 24 May 2020 23:57:52 +0200
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
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 7/7] zram: Use local lock to protect per-CPU data
Date:   Sun, 24 May 2020 23:57:39 +0200
Message-Id: <20200524215739.551568-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200524215739.551568-1-bigeasy@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Galbraith <umgwanakikbuti@gmail.com>

The zcomp driver uses per-CPU compression. The per-CPU data pointer is
acquired with get_cpu_ptr() which implicitly disables preemption.
It allocates memory inside the preempt disabled region which conflicts
with the PREEMPT_RT semantics.

Replace the implicit preemption control with an explicit local lock.
This allows RT kernels to substitute it with a real per CPU lock, which
serializes the access but keeps the code section preemptible. On non RT
kernels this maps to preempt_disable() as before, i.e. no functional
change.

[bigeasy: Use local_lock(), description, drop reordering]

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zcomp.c | 17 ++++++++++-------
 drivers/block/zram/zcomp.h |  2 ++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index ae6dc137a1ed8..fa3485309735e 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -42,11 +42,11 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 }
=20
 /*
- * allocate new zcomp_strm structure with ->tfm initialized by
- * backend, return NULL on error
+ * Initialize zcomp_strm structure with ->tfm initialized by
+ * backend, and ->buffer. Return a negative value on error.
  */
-static int zcomp_strm_alloc(struct zcomp_strm *zstrm,
-			    struct zcomp *comp)
+static int zcomp_strm_init(struct zcomp_strm *zstrm,
+			   struct zcomp *comp)
 {
 	zstrm->tfm =3D crypto_alloc_comp(comp->name, 0, 0);
 	/*
@@ -111,12 +111,13 @@ ssize_t zcomp_available_show(const char *comp, char *=
buf)
=20
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return get_cpu_ptr(comp->stream);
+	local_lock(&comp->stream->lock);
+	return this_cpu_ptr(comp->stream);
 }
=20
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	local_unlock(&comp->stream->lock);
 }
=20
 int zcomp_compress(struct zcomp_strm *zstrm,
@@ -160,7 +161,9 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist=
_node *node)
 	int ret;
=20
 	zstrm =3D per_cpu_ptr(comp->stream, cpu);
-	ret =3D zcomp_strm_alloc(zstrm, comp);
+	local_lock_init(&zstrm->lock);
+
+	ret =3D zcomp_strm_init(zstrm, comp);
 	if (ret) {
 		pr_err("Can't allocate a compression stream\n");
 		return -ENOMEM;
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 72c2ee4d843ed..45c4c1858e5a9 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -5,11 +5,13 @@
=20
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
+#include <linux/locallock.h>
=20
 struct zcomp_strm {
 	/* compression/decompression buffer */
 	void *buffer;
 	struct crypto_comp *tfm;
+	struct local_lock lock;
 };
=20
 /* dynamic per-device compression frontend */
--=20
2.27.0.rc0

