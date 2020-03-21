Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F4C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D906220732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgCUQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:50:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgCUQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:50:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFhKh-0006U1-Q8; Sat, 21 Mar 2020 17:50:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 48BAC1C001A;
        Sat, 21 Mar 2020 17:50:47 +0100 (CET)
Date:   Sat, 21 Mar 2020 16:50:46 -0000
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] threads: Update PID limit comment according to
 futex UAPI change
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302112939.8068-1-jannh@google.com>
References: <20200302112939.8068-1-jannh@google.com>
MIME-Version: 1.0
Message-ID: <158480944688.28353.2744740796955783682.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9c40365a65d62d7c06a95fb331b3442cb02d2fd9
Gitweb:        https://git.kernel.org/tip/9c40365a65d62d7c06a95fb331b3442cb02d2fd9
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Mon, 02 Mar 2020 12:29:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 17:48:13 +01:00

threads: Update PID limit comment according to futex UAPI change

The futex UAPI changed back in commit 76b81e2b0e22 ("[PATCH] lightweight
robust futexes updates 2"), which landed in v2.6.17: FUTEX_TID_MASK is now
0x3fffffff instead of 0x1fffffff. Update the corresponding comment in
include/linux/threads.h.

Documentation mentions that only the lower 29 bits are available for TID
storage, but as the UAPI header released the bit already via
FUTEX_TID_MASK, this is moot as well. Fix it up.

[ tglx: Fixed up documentation ]

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200302112939.8068-1-jannh@google.com

---
 Documentation/robust-futex-ABI.txt | 14 ++++++--------
 include/linux/threads.h            |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/robust-futex-ABI.txt b/Documentation/robust-futex-ABI.txt
index 8a5d34a..f24904f 100644
--- a/Documentation/robust-futex-ABI.txt
+++ b/Documentation/robust-futex-ABI.txt
@@ -61,8 +61,8 @@ setup that list.
   address of the associated 'lock entry', plus or minus, of what will
   be called the 'lock word', from that 'lock entry'.  The 'lock word'
   is always a 32 bit word, unlike the other words above.  The 'lock
-  word' holds 3 flag bits in the upper 3 bits, and the thread id (TID)
-  of the thread holding the lock in the bottom 29 bits.  See further
+  word' holds 2 flag bits in the upper 2 bits, and the thread id (TID)
+  of the thread holding the lock in the bottom 30 bits.  See further
   below for a description of the flag bits.
 
   The third word, called 'list_op_pending', contains transient copy of
@@ -128,7 +128,7 @@ that thread's robust_futex linked lock list a given time.
 A given futex lock structure in a user shared memory region may be held
 at different times by any of the threads with access to that region. The
 thread currently holding such a lock, if any, is marked with the threads
-TID in the lower 29 bits of the 'lock word'.
+TID in the lower 30 bits of the 'lock word'.
 
 When adding or removing a lock from its list of held locks, in order for
 the kernel to correctly handle lock cleanup regardless of when the task
@@ -141,7 +141,7 @@ On insertion:
  1) set the 'list_op_pending' word to the address of the 'lock entry'
     to be inserted,
  2) acquire the futex lock,
- 3) add the lock entry, with its thread id (TID) in the bottom 29 bits
+ 3) add the lock entry, with its thread id (TID) in the bottom 30 bits
     of the 'lock word', to the linked list starting at 'head', and
  4) clear the 'list_op_pending' word.
 
@@ -155,7 +155,7 @@ On removal:
 
 On exit, the kernel will consider the address stored in
 'list_op_pending' and the address of each 'lock word' found by walking
-the list starting at 'head'.  For each such address, if the bottom 29
+the list starting at 'head'.  For each such address, if the bottom 30
 bits of the 'lock word' at offset 'offset' from that address equals the
 exiting threads TID, then the kernel will do two things:
 
@@ -180,7 +180,5 @@ any point:
     future kernel configuration changes) elements.
 
 When the kernel sees a list entry whose 'lock word' doesn't have the
-current threads TID in the lower 29 bits, it does nothing with that
+current threads TID in the lower 30 bits, it does nothing with that
 entry, and goes on to the next entry.
-
-Bit 29 (0x20000000) of the 'lock word' is reserved for future use.
diff --git a/include/linux/threads.h b/include/linux/threads.h
index 3086dba..18d5a74 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -29,7 +29,7 @@
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
- * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
+ * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
 #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
