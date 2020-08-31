Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A927AC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D1920782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYK6WQus";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jLKj6mdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgHaBLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHaBLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:05 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neNIyeqixbmc4iI91QgdbnxFUzdVIo+Wg/5VPzEIeg8=;
        b=kYK6WQus7uHm57T37PVN4qJIJUJxXPMOVh2u/9uzhAEw+3JCsOf+GvaSFDiT7UCsqpID+T
        Ml9gVr4LpTlxwpKZqj2rfZLd2HP3wyVNxJQScX5UtSgM/5gCt6LWyB/0AdNU/L5o+oC4Rh
        zOx1SgmDV6pcL0x6uIkpcgSl1qo9UzuR1tC28AVokLQSx1RsDk8+a8B/hcV9sT05t8g00u
        FUwfDpXqMsjnaxUZ+/jKngELzSv+5kmr0AjtlktQNw39J5GDe1gtNUdOQZqDXjtYpo0d40
        KgDtFXdT3Q9bOEZ1htLkuA+9gggx9UP6ibIGFaiSJjN4EUCnKQ2OLiQLZtxElg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neNIyeqixbmc4iI91QgdbnxFUzdVIo+Wg/5VPzEIeg8=;
        b=jLKj6mdU1rDQMbXwaTcxOxgj9MOHyqHnVRE5fC/arnvV6W+0XfmC3ZUGK/ZPYEYwq5ImbF
        duE//Ly0SKvl3OBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 8/8] scripts/gdb: support printk finalized records
Date:   Mon, 31 Aug 2020 03:16:58 +0206
Message-Id: <20200831011058.6286-9-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit ("printk: ringbuffer: add finalization/extension support")
a new state bit for finalized records was added. This not only changed
the bit representation of committed records, but also reduced the size
for record IDs.

Update the gdb scripts to correctly interpret the state variable.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Documentation/admin-guide/kdump/gdbmacros.txt | 10 +++++++---
 scripts/gdb/linux/dmesg.py                    | 10 ++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kdump/gdbmacros.txt b/Documentation/admin-guide/kdump/gdbmacros.txt
index 7adece30237e..bcb78368b381 100644
--- a/Documentation/admin-guide/kdump/gdbmacros.txt
+++ b/Documentation/admin-guide/kdump/gdbmacros.txt
@@ -295,8 +295,11 @@ document dump_record
 end
 
 define dmesg
-	set var $desc_committed = 1UL << ((sizeof(long) * 8) - 1)
-	set var $flags_mask = 3UL << ((sizeof(long) * 8) - 2)
+	# definitions from kernel/printk/printk_ringbuffer.h
+	set var $desc_commit = 1UL << ((sizeof(long) * 8) - 1)
+	set var $desc_final = 1UL << ((sizeof(long) * 8) - 2)
+	set var $desc_reuse = 1UL << ((sizeof(long) * 8) - 3)
+	set var $flags_mask = $desc_commit | $desc_final | $desc_reuse
 	set var $id_mask = ~$flags_mask
 
 	set var $desc_count = 1U << prb->desc_ring.count_bits
@@ -309,7 +312,8 @@ define dmesg
 		set var $desc = &prb->desc_ring.descs[$id % $desc_count]
 
 		# skip non-committed record
-		if (($desc->state_var.counter & $flags_mask) == $desc_committed)
+		# (note that commit+!final records will be displayed)
+		if (($desc->state_var.counter & $desc_commit) == $desc_commit)
 			dump_record $desc $prev_flags
 			set var $prev_flags = $desc->info.flags
 		end
diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index 6c6022012ea8..367523c5c270 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -79,9 +79,10 @@ class LxDmesg(gdb.Command):
 
         # definitions from kernel/printk/printk_ringbuffer.h
         desc_sv_bits = utils.get_long_type().sizeof * 8
-        desc_committed_mask = 1 << (desc_sv_bits - 1)
-        desc_reuse_mask = 1 << (desc_sv_bits - 2)
-        desc_flags_mask = desc_committed_mask | desc_reuse_mask
+        desc_commit_mask = 1 << (desc_sv_bits - 1)
+        desc_final_mask = 1 << (desc_sv_bits - 2)
+        desc_reuse_mask = 1 << (desc_sv_bits - 3)
+        desc_flags_mask = desc_commit_mask | desc_final_mask | desc_reuse_mask
         desc_id_mask = ~desc_flags_mask
 
         # read in tail and head descriptor ids
@@ -96,8 +97,9 @@ class LxDmesg(gdb.Command):
             desc_off = desc_sz * ind
 
             # skip non-committed record
+            # (note that commit+!final records will be displayed)
             state = utils.read_u64(descs, desc_off + sv_off + counter_off) & desc_flags_mask
-            if state != desc_committed_mask:
+            if state & desc_commit_mask != desc_commit_mask:
                 if did == head_id:
                     break
                 did = (did + 1) & desc_id_mask
-- 
2.20.1

