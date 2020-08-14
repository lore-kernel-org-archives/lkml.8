Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E39BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B62206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gI3oBjET";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ap8q2s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHNVZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgHNVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:25:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED01C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:25:30 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597440328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXN1ujGUCcJiDsH2Yq/2W1z2Lm1ymuFzoQlqn5kHDaU=;
        b=gI3oBjETNnwbTfS2WgWGwyxp0qAdziyuyjLzI5X1BzhiiyujQZAz119UyASqOpXna0sg1g
        yG7GFFolqw8ZwVNsW1x5Vx3WjfHP5ogxPa9R0lbzrFwzQHHSLft+tsV/6kq60IXICYbBLF
        e59XrTbHTE0SB5g4VI27e3okwSY238TlZo8J9lEAvphWql4C0IrNf3LDKgLsZb7Z7mFKoy
        skUW1A7rqHzojcMqY8TjCx6lBIbvPUJJhaRW4ePW+b8xNlhJBOrVswVOtJnEOnIIXWykfX
        ywkQyt/e/mXfsu3OgBMxJXiHYPtWry4Io7D09JvLKKjnwbqzSvgpHicEa3n5ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597440328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXN1ujGUCcJiDsH2Yq/2W1z2Lm1ymuFzoQlqn5kHDaU=;
        b=/ap8q2s+llapM8V/6PbtJyM6YhCJa32IU2cJmprNyI0mfBz3NXs6YvfIIg9xrKAN4zVeXa
        DGgixD7l8vHbtFCw==
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][next] scripts/gdb: update for lockless printk ringbuffer
Date:   Fri, 14 Aug 2020 23:31:25 +0206
Message-Id: <20200814212525.6118-3-john.ogness@linutronix.de>
In-Reply-To: <20200814212525.6118-1-john.ogness@linutronix.de>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of the lockless printk ringbuffer, the data
structure for the kernel log buffer was changed. Update the gdb
scripts to be able to parse/print the new log buffer structure.

Fixes: ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
---

 based on next-20200814

 Documentation/admin-guide/kdump/gdbmacros.txt | 153 ++++++++++++------
 scripts/gdb/linux/dmesg.py                    | 139 +++++++++++-----
 2 files changed, 209 insertions(+), 83 deletions(-)

diff --git a/Documentation/admin-guide/kdump/gdbmacros.txt b/Documentation/admin-guide/kdump/gdbmacros.txt
index 220d0a80ca2c..6025534c6c14 100644
--- a/Documentation/admin-guide/kdump/gdbmacros.txt
+++ b/Documentation/admin-guide/kdump/gdbmacros.txt
@@ -170,57 +170,111 @@ document trapinfo
 	address the kernel panicked.
 end
 
-define dump_log_idx
-	set $idx = $arg0
+define dump_record
+	set var $desc = $arg0
 	if ($argc > 1)
-		set $prev_flags = $arg1
+		set var $prev_flags = $arg1
 	else
-		set $prev_flags = 0
+		set var $prev_flags = 0
 	end
-	set $msg = ((struct printk_log *) (log_buf + $idx))
-	set $prefix = 1
-	set $newline = 1
-	set $log = log_buf + $idx + sizeof(*$msg)
-
-	# prev & LOG_CONT && !(msg->flags & LOG_PREIX)
-	if (($prev_flags & 8) && !($msg->flags & 4))
-		set $prefix = 0
+
+	set var $info = &$desc->info
+	set var $prefix = 1
+	set var $newline = 1
+
+	set var $begin = $desc->text_blk_lpos.begin % (1U << prb->text_data_ring.size_bits)
+	set var $next = $desc->text_blk_lpos.next % (1U << prb->text_data_ring.size_bits)
+
+	# handle data-less record
+	if ($begin & 1)
+		set var $text_len = 0
+		set var $log = ""
+	else
+		# handle wrapping data block
+		if ($begin > $next)
+			set var $begin = 0
+		end
+
+		# skip over descriptor id
+		set var $begin = $begin + sizeof(long)
+
+		# handle truncated message
+		if ($next - $begin < $info->text_len)
+			set var $text_len = $next - $begin
+		else
+			set var $text_len = $info->text_len
+		end
+
+		set var $log = &prb->text_data_ring.data[$begin]
+	end
+
+	# prev & LOG_CONT && !(info->flags & LOG_PREIX)
+	if (($prev_flags & 8) && !($info->flags & 4))
+		set var $prefix = 0
 	end
 
-	# msg->flags & LOG_CONT
-	if ($msg->flags & 8)
+	# info->flags & LOG_CONT
+	if ($info->flags & 8)
 		# (prev & LOG_CONT && !(prev & LOG_NEWLINE))
 		if (($prev_flags & 8) && !($prev_flags & 2))
-			set $prefix = 0
+			set var $prefix = 0
 		end
-		# (!(msg->flags & LOG_NEWLINE))
-		if (!($msg->flags & 2))
-			set $newline = 0
+		# (!(info->flags & LOG_NEWLINE))
+		if (!($info->flags & 2))
+			set var $newline = 0
 		end
 	end
 
 	if ($prefix)
-		printf "[%5lu.%06lu] ", $msg->ts_nsec / 1000000000, $msg->ts_nsec % 1000000000
+		printf "[%5lu.%06lu] ", $info->ts_nsec / 1000000000, $info->ts_nsec % 1000000000
 	end
-	if ($msg->text_len != 0)
-		eval "printf \"%%%d.%ds\", $log", $msg->text_len, $msg->text_len
+	if ($text_len)
+		eval "printf \"%%%d.%ds\", $log", $text_len, $text_len
 	end
 	if ($newline)
 		printf "\n"
 	end
-	if ($msg->dict_len > 0)
-		set $dict = $log + $msg->text_len
-		set $idx = 0
-		set $line = 1
-		while ($idx < $msg->dict_len)
+
+	# handle dictionary data
+
+	set var $begin = $desc->dict_blk_lpos.begin % (1U << prb->dict_data_ring.size_bits)
+	set var $next = $desc->dict_blk_lpos.next % (1U << prb->dict_data_ring.size_bits)
+
+	# handle data-less record
+	if ($begin & 1)
+		set var $dict_len = 0
+		set var $dict = ""
+	else
+		# handle wrapping data block
+		if ($begin > $next)
+			set var $begin = 0
+		end
+
+		# skip over descriptor id
+		set var $begin = $begin + sizeof(long)
+
+		# handle truncated message
+		if ($next - $begin < $info->dict_len)
+			set var $dict_len = $next - $begin
+		else
+			set var $dict_len = $info->dict_len
+		end
+
+		set var $dict = &prb->dict_data_ring.data[$begin]
+	end
+
+	if ($dict_len > 0)
+		set var $idx = 0
+		set var $line = 1
+		while ($idx < $dict_len)
 			if ($line)
 				printf " "
-				set $line = 0
+				set var $line = 0
 			end
-			set $c = $dict[$idx]
+			set var $c = $dict[$idx]
 			if ($c == '\0')
 				printf "\n"
-				set $line = 1
+				set var $line = 1
 			else
 				if ($c < ' ' || $c >= 127 || $c == '\\')
 					printf "\\x%02x", $c
@@ -228,33 +282,40 @@ define dump_log_idx
 					printf "%c", $c
 				end
 			end
-			set $idx = $idx + 1
+			set var $idx = $idx + 1
 		end
 		printf "\n"
 	end
 end
-document dump_log_idx
-	Dump a single log given its index in the log buffer.  The first
-	parameter is the index into log_buf, the second is optional and
-	specified the previous log buffer's flags, used for properly
-	formatting continued lines.
+document dump_record
+	Dump a single record. The first parameter is the descriptor
+	sequence number, the the second is optional and specifies the
+	previous record's flags, used for properly formatting
+	continued lines.
 end
 
 define dmesg
-	set $i = log_first_idx
-	set $end_idx = log_first_idx
-	set $prev_flags = 0
+	set var $desc_committed = 1UL << ((sizeof(long) * 8) - 1)
+	set var $flags_mask = 3UL << ((sizeof(long) * 8) - 2)
+	set var $id_mask = ~$flags_mask
+
+	set var $desc_count = 1U << prb->desc_ring.count_bits
+	set var $prev_flags = 0
+
+	set var $id = prb->desc_ring.tail_id.counter
+	set var $end_id = prb->desc_ring.head_id.counter
 
 	while (1)
-		set $msg = ((struct printk_log *) (log_buf + $i))
-		if ($msg->len == 0)
-			set $i = 0
-		else
-			dump_log_idx $i $prev_flags
-			set $i = $i + $msg->len
-			set $prev_flags = $msg->flags
+		set var $desc = &prb->desc_ring.descs[$id % $desc_count]
+
+		# skip non-committed record
+		if (($desc->state_var.counter & $flags_mask) == $desc_committed)
+			dump_record $desc $prev_flags
+			set var $prev_flags = $desc->info.flags
 		end
-		if ($i == $end_idx)
+
+		set var $id = ($id + 1) & $id_mask
+		if ($id == $end_id)
 			loop_break
 		end
 	end
diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index 2fa7bb83885f..6c6022012ea8 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -16,8 +16,13 @@ import sys
 
 from linux import utils
 
-printk_log_type = utils.CachedType("struct printk_log")
-
+printk_info_type = utils.CachedType("struct printk_info")
+prb_data_blk_lpos_type = utils.CachedType("struct prb_data_blk_lpos")
+prb_desc_type = utils.CachedType("struct prb_desc")
+prb_desc_ring_type = utils.CachedType("struct prb_desc_ring")
+prb_data_ring_type = utils.CachedType("struct prb_data_ring")
+printk_ringbuffer_type = utils.CachedType("struct printk_ringbuffer")
+atomic_long_type = utils.CachedType("atomic_long_t")
 
 class LxDmesg(gdb.Command):
     """Print Linux kernel log buffer."""
@@ -26,44 +31,102 @@ class LxDmesg(gdb.Command):
         super(LxDmesg, self).__init__("lx-dmesg", gdb.COMMAND_DATA)
 
     def invoke(self, arg, from_tty):
-        log_buf_addr = int(str(gdb.parse_and_eval(
-            "(void *)'printk.c'::log_buf")).split()[0], 16)
-        log_first_idx = int(gdb.parse_and_eval("'printk.c'::log_first_idx"))
-        log_next_idx = int(gdb.parse_and_eval("'printk.c'::log_next_idx"))
-        log_buf_len = int(gdb.parse_and_eval("'printk.c'::log_buf_len"))
-
         inf = gdb.inferiors()[0]
-        start = log_buf_addr + log_first_idx
-        if log_first_idx < log_next_idx:
-            log_buf_2nd_half = -1
-            length = log_next_idx - log_first_idx
-            log_buf = utils.read_memoryview(inf, start, length).tobytes()
-        else:
-            log_buf_2nd_half = log_buf_len - log_first_idx
-            a = utils.read_memoryview(inf, start, log_buf_2nd_half)
-            b = utils.read_memoryview(inf, log_buf_addr, log_next_idx)
-            log_buf = a.tobytes() + b.tobytes()
-
-        length_offset = printk_log_type.get_type()['len'].bitpos // 8
-        text_len_offset = printk_log_type.get_type()['text_len'].bitpos // 8
-        time_stamp_offset = printk_log_type.get_type()['ts_nsec'].bitpos // 8
-        text_offset = printk_log_type.get_type().sizeof
-
-        pos = 0
-        while pos < log_buf.__len__():
-            length = utils.read_u16(log_buf, pos + length_offset)
-            if length == 0:
-                if log_buf_2nd_half == -1:
-                    gdb.write("Corrupted log buffer!\n")
+
+        # read in prb structure
+        prb_addr = int(str(gdb.parse_and_eval("(void *)'printk.c'::prb")).split()[0], 16)
+        sz = printk_ringbuffer_type.get_type().sizeof
+        prb = utils.read_memoryview(inf, prb_addr, sz).tobytes()
+
+        # read in descriptor ring structure
+        off = printk_ringbuffer_type.get_type()['desc_ring'].bitpos // 8
+        addr = prb_addr + off
+        sz = prb_desc_ring_type.get_type().sizeof
+        desc_ring = utils.read_memoryview(inf, addr, sz).tobytes()
+
+        # read in descriptor array
+        off = prb_desc_ring_type.get_type()['count_bits'].bitpos // 8
+        desc_ring_count = 1 << utils.read_u32(desc_ring, off)
+        desc_sz = prb_desc_type.get_type().sizeof
+        off = prb_desc_ring_type.get_type()['descs'].bitpos // 8
+        addr = utils.read_ulong(desc_ring, off)
+        descs = utils.read_memoryview(inf, addr, desc_sz * desc_ring_count).tobytes()
+
+        # read in text data ring structure
+        off = printk_ringbuffer_type.get_type()['text_data_ring'].bitpos // 8
+        addr = prb_addr + off
+        sz = prb_data_ring_type.get_type().sizeof
+        text_data_ring = utils.read_memoryview(inf, addr, sz).tobytes()
+
+        # read in text data
+        off = prb_data_ring_type.get_type()['size_bits'].bitpos // 8
+        text_data_sz = 1 << utils.read_u32(text_data_ring, off)
+        off = prb_data_ring_type.get_type()['data'].bitpos // 8
+        addr = utils.read_ulong(text_data_ring, off)
+        text_data = utils.read_memoryview(inf, addr, text_data_sz).tobytes()
+
+        counter_off = atomic_long_type.get_type()['counter'].bitpos // 8
+
+        sv_off = prb_desc_type.get_type()['state_var'].bitpos // 8
+
+        off = prb_desc_type.get_type()['text_blk_lpos'].bitpos // 8
+        begin_off = off + (prb_data_blk_lpos_type.get_type()['begin'].bitpos // 8)
+        next_off = off + (prb_data_blk_lpos_type.get_type()['next'].bitpos // 8)
+
+        off = prb_desc_type.get_type()['info'].bitpos // 8
+        ts_off = off + printk_info_type.get_type()['ts_nsec'].bitpos // 8
+        len_off = off + printk_info_type.get_type()['text_len'].bitpos // 8
+
+        # definitions from kernel/printk/printk_ringbuffer.h
+        desc_sv_bits = utils.get_long_type().sizeof * 8
+        desc_committed_mask = 1 << (desc_sv_bits - 1)
+        desc_reuse_mask = 1 << (desc_sv_bits - 2)
+        desc_flags_mask = desc_committed_mask | desc_reuse_mask
+        desc_id_mask = ~desc_flags_mask
+
+        # read in tail and head descriptor ids
+        off = prb_desc_ring_type.get_type()['tail_id'].bitpos // 8
+        tail_id = utils.read_u64(desc_ring, off + counter_off)
+        off = prb_desc_ring_type.get_type()['head_id'].bitpos // 8
+        head_id = utils.read_u64(desc_ring, off + counter_off)
+
+        did = tail_id
+        while True:
+            ind = did % desc_ring_count
+            desc_off = desc_sz * ind
+
+            # skip non-committed record
+            state = utils.read_u64(descs, desc_off + sv_off + counter_off) & desc_flags_mask
+            if state != desc_committed_mask:
+                if did == head_id:
                     break
-                pos = log_buf_2nd_half
+                did = (did + 1) & desc_id_mask
                 continue
 
-            text_len = utils.read_u16(log_buf, pos + text_len_offset)
-            text_start = pos + text_offset
-            text = log_buf[text_start:text_start + text_len].decode(
-                encoding='utf8', errors='replace')
-            time_stamp = utils.read_u64(log_buf, pos + time_stamp_offset)
+            begin = utils.read_ulong(descs, desc_off + begin_off) % text_data_sz
+            end = utils.read_ulong(descs, desc_off + next_off) % text_data_sz
+
+            # handle data-less record
+            if begin & 1 == 1:
+                text = ""
+            else:
+                # handle wrapping data block
+                if begin > end:
+                    begin = 0
+
+                # skip over descriptor id
+                text_start = begin + utils.get_long_type().sizeof
+
+                text_len = utils.read_u16(descs, desc_off + len_off)
+
+                # handle truncated message
+                if end - text_start < text_len:
+                    text_len = end - text_start
+
+                text = text_data[text_start:text_start + text_len].decode(
+                    encoding='utf8', errors='replace')
+
+            time_stamp = utils.read_u64(descs, desc_off + ts_off)
 
             for line in text.splitlines():
                 msg = u"[{time:12.6f}] {line}\n".format(
@@ -75,7 +138,9 @@ class LxDmesg(gdb.Command):
                     msg = msg.encode(encoding='utf8', errors='replace')
                 gdb.write(msg)
 
-            pos += length
+            if did == head_id:
+                break
+            did = (did + 1) & desc_id_mask
 
 
 LxDmesg()
-- 
2.20.1

