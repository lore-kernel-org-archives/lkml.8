Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF51C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A68206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgESUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgESUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:20:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:20:13 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8ig-00012c-HJ; Tue, 19 May 2020 22:20:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Cartwright <julia@ni.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/8] squashfs: make use of local lock in multi_cpu decompressor
Date:   Tue, 19 May 2020 22:19:09 +0200
Message-Id: <20200519201912.1564477-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519201912.1564477-1-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Cartwright <julia@ni.com>

The squashfs multi CPU decompressor makes use of get_cpu_ptr() to
acquire a pointer to per-CPU data. get_cpu_ptr() implicitly disables
preemption which serializes the access to the per-CPU data.

But decompression can take quite some time depending on the size. The
observed preempt disabled times in real world scenarios went up to 8ms,
causing massive wakeup latencies. This happens on all CPUs as the
decompression is fully parallelized.

Replace the implicit preemption control with an explicit local lock.
This allows RT kernels to substitute it with a real per CPU lock, which
serializes the access but keeps the code section preemptible. On non RT
kernels this maps to preempt_disable() as before, i.e. no functional
change.

[ bigeasy: Use local_lock(), patch description]

Cc: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 fs/squashfs/decompressor_multi_percpu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompre=
ssor_multi_percpu.c
index 2a2a2d106440e..8a77a2741c176 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
=20
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -23,6 +24,8 @@ struct squashfs_stream {
 	void		*stream;
 };
=20
+static DEFINE_LOCAL_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -75,12 +78,16 @@ void squashfs_decompressor_destroy(struct squashfs_sb_i=
nfo *msblk)
 int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head=
 **bh,
 	int b, int offset, int length, struct squashfs_page_actor *output)
 {
-	struct squashfs_stream __percpu *percpu =3D
-			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream =3D get_cpu_ptr(percpu);
-	int res =3D msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	local_lock(stream_lock);
+	stream =3D this_cpu_ptr(msblk->stream);
+
+	res =3D msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	local_unlock(stream_lock);
=20
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
--=20
2.26.2

