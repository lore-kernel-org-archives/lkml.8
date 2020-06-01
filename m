Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5C420772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFAJxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgFAJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADEC061A0E;
        Mon,  1 Jun 2020 02:52:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7P-0003hh-4G; Mon, 01 Jun 2020 11:52:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C637B1C0244;
        Mon,  1 Jun 2020 11:52:30 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:30 -0000
From:   "tip-bot2 for Mike Galbraith" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] zram: Use local lock to protect per-CPU data
Cc:     Mike Galbraith <umgwanakikbuti@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527201119.1692513-8-bigeasy@linutronix.de>
References: <20200527201119.1692513-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159100515059.17951.4923007968333025082.tip-bot2@tip-bot2>
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

Commit-ID:     19f545b6e07f753c4dc639c2f0ab52345733b6a8
Gitweb:        https://git.kernel.org/tip/19f545b6e07f753c4dc639c2f0ab52345733b6a8
Author:        Mike Galbraith <umgwanakikbuti@gmail.com>
AuthorDate:    Wed, 27 May 2020 22:11:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:31:10 +02:00

zram: Use local lock to protect per-CPU data

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

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200527201119.1692513-8-bigeasy@linutronix.de
---
 drivers/block/zram/zcomp.c | 7 +++++--
 drivers/block/zram/zcomp.h | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 912e3e6..5ee8e3f 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -110,12 +110,13 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return get_cpu_ptr(comp->stream);
+	local_lock(&comp->stream->lock);
+	return this_cpu_ptr(comp->stream);
 }
 
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	local_unlock(&comp->stream->lock);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
@@ -159,6 +160,8 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 	int ret;
 
 	zstrm = per_cpu_ptr(comp->stream, cpu);
+	local_lock_init(&zstrm->lock);
+
 	ret = zcomp_strm_init(zstrm, comp);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 72c2ee4..40f6420 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -5,8 +5,11 @@
 
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
+#include <linux/local_lock.h>
 
 struct zcomp_strm {
+	/* The members ->buffer and ->tfm are protected by ->lock. */
+	local_lock_t lock;
 	/* compression/decompression buffer */
 	void *buffer;
 	struct crypto_comp *tfm;
