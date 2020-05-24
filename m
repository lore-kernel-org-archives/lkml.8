Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9783C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2126207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgEXV56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbgEXV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:57:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD3C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:57:54 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcycw-0007Zv-AU; Sun, 24 May 2020 23:57:50 +0200
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
        Julia Cartwright <julia@ni.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/7] squashfs: make use of local lock in multi_cpu decompressor
Date:   Sun, 24 May 2020 23:57:36 +0200
Message-Id: <20200524215739.551568-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200524215739.551568-1-bigeasy@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
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
 fs/squashfs/decompressor_multi_percpu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompre=
ssor_multi_percpu.c
index 2a2a2d106440e..bac511cdebdb0 100644
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
@@ -20,7 +21,8 @@
  */
=20
 struct squashfs_stream {
-	void		*stream;
+	void			*stream;
+	struct local_lock	lock;
 };
=20
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
@@ -41,6 +43,7 @@ void *squashfs_decompressor_create(struct squashfs_sb_inf=
o *msblk,
 			err =3D PTR_ERR(stream->stream);
 			goto out;
 		}
+		local_lock_init(&stream->lock);
 	}
=20
 	kfree(comp_opts);
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
+	local_lock(&msblk->stream->lock);
+	stream =3D this_cpu_ptr(msblk->stream);
+
+	res =3D msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	local_unlock(&msblk->stream->lock);
=20
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
--=20
2.27.0.rc0

