Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16CBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8364F2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uhizln0e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9nyzqCGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHXKg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgHXKfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:35:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA155C061795
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:35:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598265343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prA/vLQEsiZ7uXnqSNXvQyzJMtp7/FtGt3ot4cMtouU=;
        b=uhizln0etLKA9/yJP5n4CIoLs9zLj0ecov1nHHqQ7aZLPizs59y2pk5J3uorGrDRoZpI6m
        WTsMRIQllFt4Q8dJwB4Ryu1n/n6CT0Qq7gxmN9QE4D3eykdVwde9mtgTf3QvLXxRMcTJUF
        R4IoApYtYoLHVKWh89NfqbxHHZDeUIIeI0HlDFReedKmQHrJ4+aZcRQ2ebbdvaXdFVvn25
        qZFrixDPmgt9jpgA4n8gPcfSTHhrMHZP3jsakVxI3f2fP3zoAOHiffi7rEok2V8WZNTRn7
        W1GhZpcTe+cfyYLUjBX30/+YTkxAyZC0Ozh2PqMBwBEEUnwaDrkPcDOdYjDg7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598265343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prA/vLQEsiZ7uXnqSNXvQyzJMtp7/FtGt3ot4cMtouU=;
        b=9nyzqCGYU3Ir1Q/GMCBYaqxo7BcmPn6KBbEg95s76/6I2cmFM02y4b6BOstJjE8PWS3wAu
        TMPx4PIzf7KdwuAQ==
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
Subject: [PATCH v2 7/7][next] scripts/gdb: support printk finalized records
Date:   Mon, 24 Aug 2020 12:41:38 +0206
Message-Id: <20200824103538.31446-8-john.ogness@linutronix.de>
In-Reply-To: <20200824103538.31446-1-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
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
index 6025534c6c14..1ccc811c82ad 100644
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

