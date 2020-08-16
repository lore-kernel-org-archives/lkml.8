Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C0BC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3C9207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Mf5dUxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgHPW0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgHPW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:26:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC6DC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4ZuT//Bl6b4PkV8plA/Jjn+LXh3a1tN96gpxdoPboSI=; b=0Mf5dUxFI9lgALKHP9FyWeaaEV
        EjRKCQWsFJBVXjsnRO37G+ZqCuiRxTW+x54I0vpXvt4ZveINQYBiNt1KsV5ATn+MAf+nxM8E73zYr
        VcEZCo7zXqNMyXel7ryqpv2drW4zNQq2Kc6JX7k2HIHqH4uPxVdwx+TH2YBclWCt+7dnjowOpTEUu
        lWH68S4fLqK0yY0EqpzkYljSKa0U3htFpnyE+NLK7hKFRr+sATKYoEfhISKYo84lCoARM5yVJ6RNr
        P2azTvWyVLIm5iJ0orpxJn+olJQQBuZA+dnAldeYWJcQQOm75nyLw3ss8XGxpmpRAI8qaOOAaAoAS
        sH4qo32Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7R6L-0002Pe-Ta; Sun, 16 Aug 2020 22:26:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] seqlock: <linux/seqlock.h>: fix multiple kernel-doc warnings
Date:   Sun, 16 Aug 2020 15:26:02 -0700
Message-Id: <20200816222602.437-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Move the definition of seqcount_LOCKNAME_init() to just after its
documentation instead of having them separated by SEQCOUNT_LOCKTYPE().

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
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/seqlock.h |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- lnx-59-rc1.orig/include/linux/seqlock.h
+++ lnx-59-rc1/include/linux/seqlock.h
@@ -138,7 +138,7 @@ static inline void seqcount_lockdep_read
 #endif
 
 /**
- * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPR associated
+ * typedef seqcount_LOCKNAME_t - sequence counter with LOCKTYPE associated
  * @seqcount:	The real sequence counter
  * @lock:	Pointer to the associated spinlock
  *
@@ -148,11 +148,17 @@ static inline void seqcount_lockdep_read
  * that the write side critical section is properly serialized.
  */
 
-/**
+/*
  * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
  * @s:		Pointer to the seqcount_LOCKNAME_t instance
  * @lock:	Pointer to the associated LOCKTYPE
  */
+static __always_inline void						\
+seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
+{									\
+	seqcount_init(&s->seqcount);					\
+	__SEQ_LOCK(s->lock = lock);					\
+}									\
 
 /*
  * SEQCOUNT_LOCKTYPE() - Instantiate seqcount_LOCKNAME_t and helpers
@@ -167,13 +173,6 @@ typedef struct seqcount_##lockname {
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
-static __always_inline void						\
-seqcount_##lockname##_init(seqcount_##lockname##_t *s, locktype *lock)	\
-{									\
-	seqcount_init(&s->seqcount);					\
-	__SEQ_LOCK(s->lock = lock);					\
-}									\
-									\
 static __always_inline seqcount_t *					\
 __seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -218,9 +217,9 @@ SEQCOUNT_LOCKTYPE(struct mutex,		mutex,
 SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 
 /**
- * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
- * @name:	Name of the seqcount_LOCKNAME_t instance
- * @lock:	Pointer to the associated LOCKTYPE
+ * SEQCOUNT_LOCKTYPE_ZERO - static initializer for seqcount_LOCKNAME_t
+ * @seq_name:	Name of the seqcount_LOCKNAME_t instance
+ * @assoc_lock:	Pointer to the associated LOCKTYPE
  */
 
 #define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\
@@ -688,7 +687,7 @@ static inline int raw_read_seqcount_t_la
  *	to miss an entire modification sequence, once it resumes it might
  *	observe the new entry.
  *
- * NOTE:
+ * NOTE2:
  *
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
