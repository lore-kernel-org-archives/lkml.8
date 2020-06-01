Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22874C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B4B20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgFAJwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgFAJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F1CC03E96F;
        Mon,  1 Jun 2020 02:52:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7Q-0003iS-KH; Mon, 01 Jun 2020 11:52:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 44FFF1C0481;
        Mon,  1 Jun 2020 11:52:32 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:32 -0000
From:   "tip-bot2 for Julia Cartwright" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] squashfs: Make use of local lock in multi_cpu
 decompressor
Cc:     Alexander Stein <alexander.stein@systec-electronic.com>,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527201119.1692513-5-bigeasy@linutronix.de>
References: <20200527201119.1692513-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159100515208.17951.8993424688184541941.tip-bot2@tip-bot2>
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

Commit-ID:     fd56200a16c72c7c3ec3e54e06160dfaa5b8dee8
Gitweb:        https://git.kernel.org/tip/fd56200a16c72c7c3ec3e54e06160dfaa5b8dee8
Author:        Julia Cartwright <julia@ni.com>
AuthorDate:    Wed, 27 May 2020 22:11:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:31:10 +02:00

squashfs: Make use of local lock in multi_cpu decompressor

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

Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200527201119.1692513-5-bigeasy@linutronix.de
---
 fs/squashfs/decompressor_multi_percpu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 2a2a2d1..e206ebf 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/local_lock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -20,7 +21,8 @@
  */
 
 struct squashfs_stream {
-	void		*stream;
+	void			*stream;
+	local_lock_t	lock;
 };
 
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
@@ -41,6 +43,7 @@ void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 			err = PTR_ERR(stream->stream);
 			goto out;
 		}
+		local_lock_init(&stream->lock);
 	}
 
 	kfree(comp_opts);
@@ -75,12 +78,16 @@ void squashfs_decompressor_destroy(struct squashfs_sb_info *msblk)
 int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 	int b, int offset, int length, struct squashfs_page_actor *output)
 {
-	struct squashfs_stream __percpu *percpu =
-			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	local_lock(&msblk->stream->lock);
+	stream = this_cpu_ptr(msblk->stream);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	local_unlock(&msblk->stream->lock);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
