Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B18C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA4E2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ri6oB0rF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poB4mWhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHNVdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHNVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:33:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E74C061385;
        Fri, 14 Aug 2020 14:33:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597440796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OwWBY4TEuHm2fQz9DnZzdQZIEjLqr3kBQSAnQO+mIdk=;
        b=Ri6oB0rFeS/gNC8OmjvJ203za9nGNqjt8we/eB8BJYdTcDlVv8AiNuL/d5W0bZH2ZHnSM+
        lFLv4M45OMigTIGDwZsgt6+QzC7SqaLZm49CwGz3tLnYzKXFcFqXbWybO2eQ2XodoqqZqO
        aQOzXltl7FWLKh4IoeDx3A4q9xO4F2KC+Xizv65rTDuXFyRc+b1YnlCFc+fj4FzH/7bZ1R
        E2QTUoq7qFfjzg7PR4WIl7ZZpm6QUy7EMBXntXk0BSNcglxWPEhcIp49gF0HM8aK9Qlbaa
        dc6fJ/it2AlXK+sIOovOjg7Udq14HNy/SlgVvGuqXreJXsUC9pRbqopOECurcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597440796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OwWBY4TEuHm2fQz9DnZzdQZIEjLqr3kBQSAnQO+mIdk=;
        b=poB4mWhwcYOKh3TENL6PbdDGc0fnsTyhWS1EzEC9xFZZQTyoPK+PdzB89DV4bFzDnvzo6o
        i7y5adb64i0/ctCA==
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH][next] docs: vmcoreinfo: add lockless printk ringbuffer vmcoreinfo
Date:   Fri, 14 Aug 2020 23:39:16 +0206
Message-Id: <20200814213316.6394-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of the lockless printk ringbuffer, the
VMCOREINFO relating to the kernel log buffer was changed. Update the
documentation to match those changes.

Fixes: ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
---
 based on next-20200814

 .../admin-guide/kdump/vmcoreinfo.rst          | 131 ++++++++++++++----
 1 file changed, 102 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 2baad0bfb09d..eb116905c31c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -189,50 +189,123 @@ from this.
 Free areas descriptor. User-space tools use this value to iterate the
 free_area ranges. MAX_ORDER is used by the zone buddy allocator.
 
-log_first_idx
+prb
+---
+
+A pointer to the printk ringbuffer (struct printk_ringbuffer). This
+may be pointing to the static boot ringbuffer or the dynamically
+allocated ringbuffer, depending on when the the core dump occurred.
+Used by user-space tools to read the active kernel log buffer.
+
+printk_rb_static
+----------------
+
+A pointer to the static boot printk ringbuffer. If @prb has a
+different value, this is useful for viewing the initial boot messages,
+which may have been overwritten in the dynamically allocated
+ringbuffer.
+
+clear_seq
+---------
+
+The sequence number of the printk() record after the last clear
+command. It indicates the first record after the last
+SYSLOG_ACTION_CLEAR, like issued by 'dmesg -c'. Used by user-space
+tools to dump a subset of the dmesg log.
+
+printk_ringbuffer
+-----------------
+
+The size of a printk_ringbuffer structure. This structure contains all
+information required for accessing the various components of the
+kernel log buffer.
+
+(printk_ringbuffer, desc_ring|text_data_ring|dict_data_ring|fail)
+-----------------------------------------------------------------
+
+Offsets for the various components of the printk ringbuffer. Used by
+user-space tools to view the kernel log buffer without requiring the
+declaration of the structure.
+
+prb_desc_ring
 -------------
 
-Index of the first record stored in the buffer log_buf. Used by
-user-space tools to read the strings in the log_buf.
+The size of the prb_desc_ring structure. This structure contains
+information about the set of record descriptors.
 
-log_buf
--------
+(prb_desc_ring, count_bits|descs|head_id|tail_id)
+-------------------------------------------------
+
+Offsets for the fields describing the set of record descriptors. Used
+by user-space tools to be able to traverse the descriptors without
+requiring the declaration of the structure.
+
+prb_desc
+--------
+
+The size of the prb_desc structure. This structure contains
+information about a single record descriptor.
+
+(prb_desc, info|state_var|text_blk_lpos|dict_blk_lpos)
+------------------------------------------------------
+
+Offsets for the fields describing a record descriptors. Used by
+user-space tools to be able to read descriptors without requiring
+the declaration of the structure.
+
+prb_data_blk_lpos
+-----------------
+
+The size of the prb_data_blk_lpos structure. This structure contains
+information about where the text or dictionary data (data block) is
+located within the respective data ring.
+
+(prb_data_blk_lpos, begin|next)
+-------------------------------
 
-Console output is written to the ring buffer log_buf at index
-log_first_idx. Used to get the kernel log.
+Offsets for the fields describing the location of a data block. Used
+by user-space tools to be able to locate data blocks without
+requiring the declaration of the structure.
 
-log_buf_len
+printk_info
 -----------
 
-log_buf's length.
+The size of the printk_info structure. This structure contains all
+the meta-data for a record.
 
-clear_idx
----------
+(printk_info, seq|ts_nsec|text_len|dict_len|caller_id)
+------------------------------------------------------
 
-The index that the next printk() record to read after the last clear
-command. It indicates the first record after the last SYSLOG_ACTION
-_CLEAR, like issued by 'dmesg -c'. Used by user-space tools to dump
-the dmesg log.
+Offsets for the fields providing the meta-data for a record. Used by
+user-space tools to be able to read the information without requiring
+the declaration of the structure.
 
-log_next_idx
-------------
+prb_data_ring
+-------------
 
-The index of the next record to store in the buffer log_buf. Used to
-compute the index of the current buffer position.
+The size of the prb_data_ring structure. This structure contains
+information about a set of data blocks.
 
-printk_log
-----------
+(prb_data_ring, size_bits|data|head_lpos|tail_lpos)
+---------------------------------------------------
 
-The size of a structure printk_log. Used to compute the size of
-messages, and extract dmesg log. It encapsulates header information for
-log_buf, such as timestamp, syslog level, etc.
+Offsets for the fields describing a set of data blocks. Used by
+user-space tools to be able to access the data blocks without
+requiring the declaration of the structure.
 
-(printk_log, ts_nsec|len|text_len|dict_len)
--------------------------------------------
+atomic_long_t
+-------------
+
+The size of the atomic_long_t structure. Used by user-space tools to
+be able to copy the full structure, regardless of its
+architecture-specific implementation.
+
+(atomic_long_t, counter)
+------------------------
 
-It represents field offsets in struct printk_log. User space tools
-parse it and check whether the values of printk_log's members have been
-changed.
+Offset for the long value of an atomic_long_t variable. Used by
+user-space tools to access the long value without requiring the
+architecture-specific declaration.
 
 (free_area.free_list, MIGRATE_TYPES)
 ------------------------------------
-- 
2.20.1

