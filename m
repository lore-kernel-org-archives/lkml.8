Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0FCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC61920738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592906023;
	bh=aF/6q/ivbfsxT38l62GcRjPYd26HspNz8eCeGyH7VIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIraWrMpzzJo8o37J7oEQj76uZXDUhuhHQWG6gH8VUVER4yGmgvGOzCIPriWu7eBD
	 phJgyf1PZ+pMQpN8Q6jMiMEaZPM5UgSO/AXqyqzgIVR4Xy2Ze0U6cnlWTe0+drupXe
	 x6Fx5wTHAzGYqmTnIpBeXs+gNt9ePVjim2U2lIyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbgFWJxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbgFWJxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:09 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E65720771;
        Tue, 23 Jun 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905986;
        bh=aF/6q/ivbfsxT38l62GcRjPYd26HspNz8eCeGyH7VIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jd5HI0wyBSsN+fwHhgV1xrof7WCWXaAjHe5IU/ue1FqtryFJE5jpnmg3aTMIcXNY7
         +KKTVw1QisNHmMW7xWe/2sRGHMyL1d8X9JAc0FXBQ8rVxAI7/+sfBxkuTt1ccD1ieJ
         LY1el5ywl98I15UkWUaZD/mjT02vNQDA8CIlq4fM=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfc0-004C3N-9f; Tue, 23 Jun 2020 11:53:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 4/9] docs: trace: ring-buffer-design.txt: convert to ReST format
Date:   Tue, 23 Jun 2020 11:52:57 +0200
Message-Id: <1f0422ca3144c415fa5953b14fcbfae64e905bbb.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Just like some media documents, this file is dual licensed
  with GPL and GFDL. As right now the GFDL SPDX definition is
  bogus (as it doesn't tell anything about invariant parts),
  let's not use SPDX here. Let's use, instead, the same test
  as we have on media.
- Convert title to ReST format;
- use :field:  markup;
- Proper mark literal blocks as such;
- Add it to trace/index.rst file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/trace/index.rst                 |   1 +
 ...ffer-design.txt => ring-buffer-design.rst} | 778 +++++++++---------
 2 files changed, 404 insertions(+), 375 deletions(-)
 rename Documentation/trace/{ring-buffer-design.txt => ring-buffer-design.rst} (57%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index fa9e1c730f6a..7d83156c9ac1 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -22,6 +22,7 @@ Linux Tracing Technologies
    boottime-trace
    hwlat_detector
    intel_th
+   ring-buffer-design
    stm
    sys-t
    coresight/index
diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation/trace/ring-buffer-design.rst
similarity index 57%
rename from Documentation/trace/ring-buffer-design.txt
rename to Documentation/trace/ring-buffer-design.rst
index 2d53c6f25b91..27dbe818720e 100644
--- a/Documentation/trace/ring-buffer-design.txt
+++ b/Documentation/trace/ring-buffer-design.rst
@@ -1,11 +1,15 @@
-		Lockless Ring Buffer Design
-		===========================
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-only-no-invariants
+
+===========================
+Lockless Ring Buffer Design
+===========================
 
 Copyright 2009 Red Hat Inc.
-   Author:   Steven Rostedt <srostedt@redhat.com>
-  License:   The GNU Free Documentation License, Version 1.2
-               (dual licensed under the GPL v2)
-Reviewers:   Mathieu Desnoyers, Huang Ying, Hidetoshi Seto,
+
+:Author:   Steven Rostedt <srostedt@redhat.com>
+:License:  The GNU Free Documentation License, Version 1.2
+           (dual licensed under the GPL v2)
+:Reviewers:  Mathieu Desnoyers, Huang Ying, Hidetoshi Seto,
 	     and Frederic Weisbecker.
 
 
@@ -14,37 +18,50 @@ Written for: 2.6.31
 Terminology used in this Document
 ---------------------------------
 
-tail - where new writes happen in the ring buffer.
+tail
+	- where new writes happen in the ring buffer.
 
-head - where new reads happen in the ring buffer.
+head
+	- where new reads happen in the ring buffer.
 
-producer - the task that writes into the ring buffer (same as writer)
+producer
+	- the task that writes into the ring buffer (same as writer)
 
-writer - same as producer
+writer
+	- same as producer
 
-consumer - the task that reads from the buffer (same as reader)
+consumer
+	- the task that reads from the buffer (same as reader)
 
-reader - same as consumer.
+reader
+	- same as consumer.
 
-reader_page - A page outside the ring buffer used solely (for the most part)
-    by the reader.
+reader_page
+	- A page outside the ring buffer used solely (for the most part)
+	  by the reader.
 
-head_page - a pointer to the page that the reader will use next
+head_page
+	- a pointer to the page that the reader will use next
 
-tail_page - a pointer to the page that will be written to next
+tail_page
+	- a pointer to the page that will be written to next
 
-commit_page - a pointer to the page with the last finished non-nested write.
+commit_page
+	- a pointer to the page with the last finished non-nested write.
 
-cmpxchg - hardware-assisted atomic transaction that performs the following:
+cmpxchg
+	- hardware-assisted atomic transaction that performs the following::
 
-   A = B if previous A == C
+	    A = B if previous A == C
 
-   R = cmpxchg(A, C, B) is saying that we replace A with B if and only if
-      current A is equal to C, and we put the old (current) A into R
+	    R = cmpxchg(A, C, B) is saying that we replace A with B if and only
+		if current A is equal to C, and we put the old (current)
+		A into R
 
-   R gets the previous A regardless if A is updated with B or not.
+	    R gets the previous A regardless if A is updated with B or not.
 
-   To see if the update was successful a compare of R == C may be used.
+	  To see if the update was successful a compare of ``R == C``
+	  may be used.
 
 The Generic Ring Buffer
 -----------------------
@@ -64,7 +81,7 @@ No two writers can write at the same time (on the same per-cpu buffer),
 but a writer may interrupt another writer, but it must finish writing
 before the previous writer may continue. This is very important to the
 algorithm. The writers act like a "stack". The way interrupts works
-enforces this behavior.
+enforces this behavior::
 
 
   writer1 start
@@ -115,6 +132,8 @@ A sample of how the reader page is swapped: Note this does not
 show the head page in the buffer, it is for demonstrating a swap
 only.
 
+::
+
   +------+
   |reader|          RING BUFFER
   |page  |
@@ -172,21 +191,22 @@ only.
 It is possible that the page swapped is the commit page and the tail page,
 if what is in the ring buffer is less than what is held in a buffer page.
 
+::
 
-          reader page    commit page   tail page
-              |              |             |
-              v              |             |
-             +---+           |             |
-             |   |<----------+             |
-             |   |<------------------------+
-             |   |------+
-             +---+      |
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+            reader page    commit page   tail page
+                |              |             |
+                v              |             |
+               +---+           |             |
+               |   |<----------+             |
+               |   |<------------------------+
+               |   |------+
+               +---+      |
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 This case is still valid for this algorithm.
 When the writer leaves the page, it simply goes into the ring buffer
@@ -196,15 +216,19 @@ buffer.
 
 The main pointers:
 
-  reader page - The page used solely by the reader and is not part
-                of the ring buffer (may be swapped in)
+  reader page
+	    - The page used solely by the reader and is not part
+              of the ring buffer (may be swapped in)
 
-  head page - the next page in the ring buffer that will be swapped
+  head page
+	    - the next page in the ring buffer that will be swapped
               with the reader page.
 
-  tail page - the page where the next write will take place.
+  tail page
+	    - the page where the next write will take place.
 
-  commit page - the page that last finished a write.
+  commit page
+	    - the page that last finished a write.
 
 The commit page only is updated by the outermost writer in the
 writer stack. A writer that preempts another writer will not move the
@@ -219,7 +243,7 @@ transaction. If another write happens it must finish before continuing
 with the previous write.
 
 
-   Write reserve:
+   Write reserve::
 
        Buffer page
       +---------+
@@ -230,7 +254,7 @@ with the previous write.
       | empty   |
       +---------+
 
-   Write commit:
+   Write commit::
 
        Buffer page
       +---------+
@@ -242,7 +266,7 @@ with the previous write.
       +---------+
 
 
- If a write happens after the first reserve:
+ If a write happens after the first reserve::
 
        Buffer page
       +---------+
@@ -253,7 +277,7 @@ with the previous write.
       |reserved |
       +---------+ <--- tail pointer
 
-  After second writer commits:
+  After second writer commits::
 
 
        Buffer page
@@ -266,7 +290,7 @@ with the previous write.
       |commit   |
       +---------+ <--- tail pointer
 
-  When the first writer commits:
+  When the first writer commits::
 
        Buffer page
       +---------+
@@ -292,21 +316,22 @@ be several pages ahead. If the tail page catches up to the commit
 page then no more writes may take place (regardless of the mode
 of the ring buffer: overwrite and produce/consumer).
 
-The order of pages is:
+The order of pages is::
 
  head page
  commit page
  tail page
 
-Possible scenario:
-                             tail page
-  head page         commit page  |
-      |                 |        |
-      v                 v        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+Possible scenario::
+
+                               tail page
+    head page         commit page  |
+        |                 |        |
+        v                 v        v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 There is a special case that the head page is after either the commit page
 and possibly the tail page. That is when the commit (and tail) page has been
@@ -315,24 +340,25 @@ part of the ring buffer, but the reader page is not. Whenever there
 has been less than a full page that has been committed inside the ring buffer,
 and a reader swaps out a page, it will be swapping out the commit page.
 
+::
 
-          reader page    commit page   tail page
-              |              |             |
-              v              |             |
-             +---+           |             |
-             |   |<----------+             |
-             |   |<------------------------+
-             |   |------+
-             +---+      |
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
-                        ^
-                        |
-                    head page
+            reader page    commit page   tail page
+                |              |             |
+                v              |             |
+               +---+           |             |
+               |   |<----------+             |
+               |   |<------------------------+
+               |   |------+
+               +---+      |
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
+                          ^
+                          |
+                      head page
 
 
 In this case, the head page will not move when the tail and commit
@@ -347,42 +373,42 @@ When the tail meets the head page, if the buffer is in overwrite mode,
 the head page will be pushed ahead one. If the buffer is in producer/consumer
 mode, the write will fail.
 
-Overwrite mode:
+Overwrite mode::
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
-                        ^
-                        |
-                    head page
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
+                          ^
+                          |
+                      head page
 
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
-                                 ^
-                                 |
-                             head page
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
+                                   ^
+                                   |
+                               head page
 
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
-                                 ^
-                                 |
-                             head page
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
+                                   ^
+                                   |
+                               head page
 
 Note, the reader page will still point to the previous head page.
 But when a swap takes place, it will use the most recent head page.
@@ -397,7 +423,7 @@ State flags are placed inside the pointer to the page. To do this,
 each page must be aligned in memory by 4 bytes. This will allow the 2
 least significant bits of the address to be used as flags, since
 they will always be zero for the address. To get the address,
-simply mask out the flags.
+simply mask out the flags::
 
   MASK = ~3
 
@@ -405,24 +431,27 @@ simply mask out the flags.
 
 Two flags will be kept by these two bits:
 
-   HEADER - the page being pointed to is a head page
+   HEADER
+	- the page being pointed to is a head page
 
-   UPDATE - the page being pointed to is being updated by a writer
+   UPDATE
+	- the page being pointed to is being updated by a writer
           and was or is about to be a head page.
 
+::
 
-          reader page
-              |
-              v
-             +---+
-             |   |------+
-             +---+      |
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-H->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+	      reader page
+		  |
+		  v
+		+---+
+		|   |------+
+		+---+      |
+			    |
+			    v
+	+---+    +---+    +---+    +---+
+    <---|   |--->|   |-H->|   |--->|   |--->
+    --->|   |<---|   |<---|   |<---|   |<---
+	+---+    +---+    +---+    +---+
 
 
 The above pointer "-H->" would have the HEADER flag set. That is
@@ -430,24 +459,24 @@ the next page is the next page to be swapped out by the reader.
 This pointer means the next page is the head page.
 
 When the tail page meets the head pointer, it will use cmpxchg to
-change the pointer to the UPDATE state:
+change the pointer to the UPDATE state::
 
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-H->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-H->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 "-U->" represents a pointer in the UPDATE state.
 
@@ -462,7 +491,7 @@ head page does not have the HEADER flag set, the compare will fail
 and the reader will need to look for the new head page and try again.
 Note, the flags UPDATE and HEADER are never set at the same time.
 
-The reader swaps the reader page as follows:
+The reader swaps the reader page as follows::
 
   +------+
   |reader|          RING BUFFER
@@ -477,7 +506,7 @@ The reader swaps the reader page as follows:
                    +-----H-------------+
 
 The reader sets the reader page next pointer as HEADER to the page after
-the head page.
+the head page::
 
 
   +------+
@@ -495,7 +524,7 @@ the head page.
 
 It does a cmpxchg with the pointer to the previous head page to make it
 point to the reader page. Note that the new pointer does not have the HEADER
-flag set.  This action atomically moves the head page forward.
+flag set.  This action atomically moves the head page forward::
 
   +------+
   |reader|          RING BUFFER
@@ -511,7 +540,7 @@ flag set.  This action atomically moves the head page forward.
     +------------------------------------+
 
 After the new head page is set, the previous pointer of the head page is
-updated to the reader page.
+updated to the reader page::
 
   +------+
   |reader|          RING BUFFER
@@ -548,7 +577,7 @@ prev pointers may not.
 
 Note, the way to determine a reader page is simply by examining the previous
 pointer of the page. If the next pointer of the previous page does not
-point back to the original page, then the original page is a reader page:
+point back to the original page, then the original page is a reader page::
 
 
              +--------+
@@ -572,54 +601,54 @@ not be able to swap the head page from the buffer, nor will it be able to
 move the head page, until the writer is finished with the move.
 
 This eliminates any races that the reader can have on the writer. The reader
-must spin, and this is why the reader cannot preempt the writer.
+must spin, and this is why the reader cannot preempt the writer::
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-H->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-H->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-The following page will be made into the new head page.
+The following page will be made into the new head page::
 
-           tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+             tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 After the new head page has been set, we can set the old head page
-pointer back to NORMAL.
+pointer back to NORMAL::
 
-           tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+             tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-After the head page has been moved, the tail page may now move forward.
+After the head page has been moved, the tail page may now move forward::
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 
 The above are the trivial updates. Now for the more complex scenarios.
@@ -630,26 +659,26 @@ tail page may make it all the way around the buffer and meet the commit
 page. At this time, we must start dropping writes (usually with some kind
 of warning to the user). But what happens if the commit was still on the
 reader page? The commit page is not part of the ring buffer. The tail page
-must account for this.
+must account for this::
 
 
-          reader page    commit page
-              |              |
-              v              |
-             +---+           |
-             |   |<----------+
-             |   |
-             |   |------+
-             +---+      |
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-H->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
-               ^
-               |
-           tail page
+            reader page    commit page
+                |              |
+                v              |
+               +---+           |
+               |   |<----------+
+               |   |
+               |   |------+
+               +---+      |
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-H->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
+                 ^
+                 |
+             tail page
 
 If the tail page were to simply push the head page forward, the commit when
 leaving the reader page would not be pointing to the correct page.
@@ -676,7 +705,7 @@ the head page if the head page is the next page. If the head page
 is not the next page, the tail page is simply updated with a cmpxchg.
 
 Only writers move the tail page. This must be done atomically to protect
-against nested writers.
+against nested writers::
 
   temp_page = tail_page
   next_page = temp_page->next
@@ -684,54 +713,54 @@ against nested writers.
 
 The above will update the tail page if it is still pointing to the expected
 page. If this fails, a nested write pushed it forward, the current write
-does not need to push it.
+does not need to push it::
 
 
-           temp page
-               |
-               v
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+             temp page
+                 |
+                 v
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-Nested write comes in and moves the tail page forward:
+Nested write comes in and moves the tail page forward::
 
-                    tail page (moved by nested writer)
-            temp page   |
-               |        |
-               v        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page (moved by nested writer)
+              temp page   |
+                 |        |
+                 v        v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 The above would fail the cmpxchg, but since the tail page has already
 been moved forward, the writer will just try again to reserve storage
 on the new tail page.
 
-But the moving of the head page is a bit more complex.
+But the moving of the head page is a bit more complex::
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-H->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-H->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-The write converts the head page pointer to UPDATE.
+The write converts the head page pointer to UPDATE::
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 But if a nested writer preempts here, it will see that the next
 page is a head page, but it is also nested. It will detect that
@@ -739,217 +768,216 @@ it is nested and will save that information. The detection is the
 fact that it sees the UPDATE flag instead of a HEADER or NORMAL
 pointer.
 
-The nested writer will set the new head page pointer.
+The nested writer will set the new head page pointer::
 
-           tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+             tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 But it will not reset the update back to normal. Only the writer
 that converted a pointer from HEAD to UPDATE will convert it back
-to NORMAL.
+to NORMAL::
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 After the nested writer finishes, the outermost writer will convert
-the UPDATE pointer to NORMAL.
+the UPDATE pointer to NORMAL::
 
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 
 It can be even more complex if several nested writes came in and moved
-the tail page ahead several pages:
+the tail page ahead several pages::
 
 
-(first writer)
+  (first writer)
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-H->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-H->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-The write converts the head page pointer to UPDATE.
+The write converts the head page pointer to UPDATE::
 
-            tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+              tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 Next writer comes in, and sees the update and sets up the new
-head page.
+head page::
 
-(second writer)
+  (second writer)
 
-           tail page
-               |
-               v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+             tail page
+                 |
+                 v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 The nested writer moves the tail page forward. But does not set the old
-update page to NORMAL because it is not the outermost writer.
+update page to NORMAL because it is not the outermost writer::
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 Another writer preempts and sees the page after the tail page is a head page.
-It changes it from HEAD to UPDATE.
+It changes it from HEAD to UPDATE::
 
-(third writer)
+  (third writer)
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-U->|   |--->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-U->|   |--->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
-The writer will move the head page forward:
+The writer will move the head page forward::
 
 
-(third writer)
+  (third writer)
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-U->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-U->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 But now that the third writer did change the HEAD flag to UPDATE it
-will convert it to normal:
+will convert it to normal::
 
 
-(third writer)
+  (third writer)
 
-                    tail page
-                        |
-                        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                      tail page
+                          |
+                          v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 
-Then it will move the tail page, and return back to the second writer.
+Then it will move the tail page, and return back to the second writer::
 
 
-(second writer)
+  (second writer)
 
-                             tail page
-                                 |
-                                 v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                               tail page
+                                   |
+                                   v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 
 The second writer will fail to move the tail page because it was already
 moved, so it will try again and add its data to the new tail page.
-It will return to the first writer.
+It will return to the first writer::
 
 
-(first writer)
+  (first writer)
 
-                             tail page
-                                 |
-                                 v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                               tail page
+                                   |
+                                   v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 The first writer cannot know atomically if the tail page moved
 while it updates the HEAD page. It will then update the head page to
-what it thinks is the new head page.
+what it thinks is the new head page::
 
 
-(first writer)
+  (first writer)
 
-                             tail page
-                                 |
-                                 v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                               tail page
+                                   |
+                                   v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 Since the cmpxchg returns the old value of the pointer the first writer
 will see it succeeded in updating the pointer from NORMAL to HEAD.
 But as we can see, this is not good enough. It must also check to see
-if the tail page is either where it use to be or on the next page:
+if the tail page is either where it use to be or on the next page::
 
 
-(first writer)
+  (first writer)
 
-               A        B    tail page
-               |        |        |
-               v        v        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |-H->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                 A        B    tail page
+                 |        |        |
+                 v        v        v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |-H->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 If tail page != A and tail page != B, then it must reset the pointer
 back to NORMAL. The fact that it only needs to worry about nested
-writers means that it only needs to check this after setting the HEAD page.
+writers means that it only needs to check this after setting the HEAD page::
 
 
-(first writer)
+  (first writer)
 
-               A        B    tail page
-               |        |        |
-               v        v        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |-U->|   |--->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+                 A        B    tail page
+                 |        |        |
+                 v        v        v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |-U->|   |--->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
 
 Now the writer can update the head page. This is also why the head page must
 remain in UPDATE and only reset by the outermost writer. This prevents
-the reader from seeing the incorrect head page.
+the reader from seeing the incorrect head page::
 
 
-(first writer)
-
-               A        B    tail page
-               |        |        |
-               v        v        v
-    +---+    +---+    +---+    +---+
-<---|   |--->|   |--->|   |--->|   |-H->
---->|   |<---|   |<---|   |<---|   |<---
-    +---+    +---+    +---+    +---+
+  (first writer)
 
+                 A        B    tail page
+                 |        |        |
+                 v        v        v
+      +---+    +---+    +---+    +---+
+  <---|   |--->|   |--->|   |--->|   |-H->
+  --->|   |<---|   |<---|   |<---|   |<---
+      +---+    +---+    +---+    +---+
-- 
2.26.2

