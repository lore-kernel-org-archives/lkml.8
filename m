Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C9020825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5MRA59w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQXb9cwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgH0H47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgH0Hy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:26 -0400
Date:   Thu, 27 Aug 2020 07:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az18AKM6BT8dn3vLckngVOwJYbF7d4EKE80ICkYF9xk=;
        b=Y5MRA59w9Y5BXsMDUMM4gd0HGr0OdtEV+Yty6SGej+oVMEuGS+iQzsZjns1FtlqMLbzeJz
        SFbieKXh0dTeFu4FZjjueiju0tkw4gr6wk3tuwTjxg56CgF5STDqu109BQcSV+ONxCYn2N
        R0x4O7zCUCy/FWwK8F6JYp4Bye7nLz/iBYozWyNbqjTPV1C1zTVt4cHDKcE8Dn40Sfn0J8
        +WoHf/l0HAbjUSmwXnrqGTG7zoyEbU4jYJ+yW2u7zMNTMz/WTH5MoJS4nHVeJnXoO87e7c
        lBLt9nAay5wEezNk62M64eWmQ+o1FXtPn9EuG9QyuvXiL/ZDcmTeL3opkDXRPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az18AKM6BT8dn3vLckngVOwJYbF7d4EKE80ICkYF9xk=;
        b=DQXb9cwE/EVZ+CnBWsWbyU9vp8zzYk8xe5uURy65EX4yNUvkLjUbr5kBG5hwN5Ap4uDp8r
        FA+u/i9pHokPUWBw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Fix multiple kernel-doc warnings
Cc:     kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817000200.20993-1-rdunlap@infradead.org>
References: <20200817000200.20993-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486318.20229.14949275173019468028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a28e884b966e713da29caefbb347efea77367d22
Gitweb:        https://git.kernel.org/tip/a28e884b966e713da29caefbb347efea77367d22
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 16 Aug 2020 17:02:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:02 +02:00

seqlock: Fix multiple kernel-doc warnings

Fix kernel-doc warnings in <linux/seqlock.h>.

../include/linux/seqlock.h:152: warning: Incorrect use of kernel-doc format:  * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
../include/linux/seqlock.h:164: warning: Incorrect use of kernel-doc format:  * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKNAME_t and helpers
../include/linux/seqlock.h:229: warning: Function parameter or member 'seq_name' not described in 'SEQCOUNT_LOCKTYPE_ZERO'
../include/linux/seqlock.h:229: warning: Function parameter or member 'assoc_lock' not described in 'SEQCOUNT_LOCKTYPE_ZERO'
../include/linux/seqlock.h:229: warning: Excess function parameter 'name' description in 'SEQCOUNT_LOCKTYPE_ZERO'
../include/linux/seqlock.h:229: warning: Excess function parameter 'lock' description in 'SEQCOUNT_LOCKTYPE_ZERO'
../include/linux/seqlock.h:695: warning: duplicate section name 'NOTE'

Demote kernel-doc notation for the macros "seqcount_LOCKNAME_init()" and
"SEQCOUNT_LOCKTYPE()"; scripts/kernel-doc does not handle them correctly.

Rename function parameters in SEQCNT_LOCKNAME_ZERO() documentation
to match the macro's argument names. Change the macro name in the
documentation to SEQCOUNT_LOCKTYPE_ZERO() to match the macro's name.

For raw_write_seqcount_latch(), rename the second NOTE: to NOTE2:
to prevent a kernel-doc warning. However, the generated output is not
quite as nice as it could be for this.

Fix a typo: s/LOCKTYPR/LOCKTYPE/

Fixes: 0efc94c5d15c ("seqcount: Compress SEQCNT_LOCKNAME_ZERO()")
Fixes: e4e9ab3f9f91 ("seqlock: Fold seqcount_LOCKNAME_init() definition")
Fixes: a8772dccb2ec ("seqlock: Fold seqcount_LOCKNAME_t definition")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200817000200.20993-1-rdunlap@infradead.org
---
 include/linux/seqlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 962d976..300cbf3 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -138,7 +138,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #endif
 
 /**
- * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPR associated
+ * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPE associated
  * @seqcount:	The real sequence counter
  * @lock:	Pointer to the associated spinlock
  *
@@ -148,7 +148,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * that the write side critical section is properly serialized.
  */
 
-/**
+/*
  * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
  * @s:		Pointer to the seqcount_LOCKNAME_t instance
  * @lock:	Pointer to the associated LOCKTYPE
@@ -217,7 +217,7 @@ SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		false,	s->lock)
 SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
 SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 
-/**
+/*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
  * @name:	Name of the seqcount_LOCKNAME_t instance
  * @lock:	Pointer to the associated LOCKTYPE
@@ -688,7 +688,7 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *	to miss an entire modification sequence, once it resumes it might
  *	observe the new entry.
  *
- * NOTE:
+ * NOTE2:
  *
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
