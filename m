Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE719C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEE92077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFAJwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgFAJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A487C03E96F;
        Mon,  1 Jun 2020 02:52:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7P-0003hk-I6; Mon, 01 Jun 2020 11:52:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 407221C0481;
        Mon,  1 Jun 2020 11:52:31 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:31 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] zram: Allocate struct zcomp_strm as per-CPU memory
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527201119.1692513-7-bigeasy@linutronix.de>
References: <20200527201119.1692513-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159100515114.17951.12481304789071396073.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ed19f19256be2949af1ab5634e62178d30a355c2
Gitweb:        https://git.kernel.org/tip/ed19f19256be2949af1ab5634e62178d30a355c2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 27 May 2020 22:11:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:31:10 +02:00

zram: Allocate struct zcomp_strm as per-CPU memory

zcomp::stream is a per-CPU pointer, pointing to struct zcomp_strm
which contains two pointers. Having struct zcomp_strm allocated
directly as per-CPU memory would avoid one additional memory
allocation and a pointer dereference. This also simplifies the
addition of a local_lock to struct zcomp_strm.

Allocate zcomp::stream directly as per-CPU memory.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200527201119.1692513-7-bigeasy@linutronix.de
---
 drivers/block/zram/zcomp.c | 41 ++++++++++++++-----------------------
 drivers/block/zram/zcomp.h |  2 +-
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1a8564a..912e3e6 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -37,19 +37,16 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
 	if (!IS_ERR_OR_NULL(zstrm->tfm))
 		crypto_free_comp(zstrm->tfm);
 	free_pages((unsigned long)zstrm->buffer, 1);
-	kfree(zstrm);
+	zstrm->tfm = NULL;
+	zstrm->buffer = NULL;
 }
 
 /*
- * allocate new zcomp_strm structure with ->tfm initialized by
- * backend, return NULL on error
+ * Initialize zcomp_strm structure with ->tfm initialized by backend, and
+ * ->buffer. Return a negative value on error.
  */
-static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *comp)
+static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 {
-	struct zcomp_strm *zstrm = kmalloc(sizeof(*zstrm), GFP_KERNEL);
-	if (!zstrm)
-		return NULL;
-
 	zstrm->tfm = crypto_alloc_comp(comp->name, 0, 0);
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
@@ -58,9 +55,9 @@ static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *comp)
 	zstrm->buffer = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
 	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
 		zcomp_strm_free(zstrm);
-		zstrm = NULL;
+		return -ENOMEM;
 	}
-	return zstrm;
+	return 0;
 }
 
 bool zcomp_available_algorithm(const char *comp)
@@ -113,7 +110,7 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	return get_cpu_ptr(comp->stream);
 }
 
 void zcomp_stream_put(struct zcomp *comp)
@@ -159,17 +156,13 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
 	struct zcomp_strm *zstrm;
+	int ret;
 
-	if (WARN_ON(*per_cpu_ptr(comp->stream, cpu)))
-		return 0;
-
-	zstrm = zcomp_strm_alloc(comp);
-	if (IS_ERR_OR_NULL(zstrm)) {
+	zstrm = per_cpu_ptr(comp->stream, cpu);
+	ret = zcomp_strm_init(zstrm, comp);
+	if (ret)
 		pr_err("Can't allocate a compression stream\n");
-		return -ENOMEM;
-	}
-	*per_cpu_ptr(comp->stream, cpu) = zstrm;
-	return 0;
+	return ret;
 }
 
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
@@ -177,10 +170,8 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
 	struct zcomp_strm *zstrm;
 
-	zstrm = *per_cpu_ptr(comp->stream, cpu);
-	if (!IS_ERR_OR_NULL(zstrm))
-		zcomp_strm_free(zstrm);
-	*per_cpu_ptr(comp->stream, cpu) = NULL;
+	zstrm = per_cpu_ptr(comp->stream, cpu);
+	zcomp_strm_free(zstrm);
 	return 0;
 }
 
@@ -188,7 +179,7 @@ static int zcomp_init(struct zcomp *comp)
 {
 	int ret;
 
-	comp->stream = alloc_percpu(struct zcomp_strm *);
+	comp->stream = alloc_percpu(struct zcomp_strm);
 	if (!comp->stream)
 		return -ENOMEM;
 
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 1806475..72c2ee4 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -14,7 +14,7 @@ struct zcomp_strm {
 
 /* dynamic per-device compression frontend */
 struct zcomp {
-	struct zcomp_strm * __percpu *stream;
+	struct zcomp_strm __percpu *stream;
 	const char *name;
 	struct hlist_node node;
 };
