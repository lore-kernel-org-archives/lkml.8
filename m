Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D959C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BF92075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgESUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgESUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:20:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:20:13 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8ih-00012c-Cv; Tue, 19 May 2020 22:20:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 7/8] zram: Use local lock to protect per-CPU data
Date:   Tue, 19 May 2020 22:19:11 +0200
Message-Id: <20200519201912.1564477-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519201912.1564477-1-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
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
 drivers/block/zram/zcomp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1a8564a79d8dc..32854d460b299 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/crypto.h>
+#include <linux/locallock.h>
=20
 #include "zcomp.h"
=20
@@ -111,14 +112,17 @@ ssize_t zcomp_available_show(const char *comp, char *=
buf)
 	return sz;
 }
=20
+static DEFINE_LOCAL_LOCK(zcomp_lock);
+
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	local_lock(zcomp_lock);
+	return *this_cpu_ptr(comp->stream);
 }
=20
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	local_unlock(zcomp_lock);
 }
=20
 int zcomp_compress(struct zcomp_strm *zstrm,
--=20
2.26.2

