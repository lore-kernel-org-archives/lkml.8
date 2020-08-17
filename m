Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0459C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1D020708
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbp/7SbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgHQACK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgHQACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 20:02:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A702C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1TEuoPnjJ2oJE5dtaNlo66wPYcdn+UVcaaznXX1DJpw=; b=fbp/7SbFkglboMd4GTB4E9Q9LT
        bhPYAqv5UYSnXShIzxKXU3K2mlnSjaf2GHbm/w8czk7SUZZKMSLSbk60UrZ7H0My7NnDtLcl5sy6B
        CE94WGD3TV1BXOauHUG9Bl6vJvPEH4zsvhYn0hgDIQRr8tdO4rNCO4z/+9a5rzHFOqUgSE7/6qch+
        Y1jXBjWWOcgWJJDkOCVwkthcPgtsW7CvWHiNKsoCFybfZGNax5J3kqWzMHQbFyfteY43mITgCDHWh
        PyG49ZfnR9DsyCT0TriZVfOpxKo6DNpCkAcRw3n7SaBloHygvc+3HhV3VBKEd/sK42sCrdJ6xAEwl
        S0vGmL1Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7SbF-0008EY-8N; Mon, 17 Aug 2020 00:02:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] seqlock: <linux/seqlock.h>: fix multiple kernel-doc warnings
Date:   Sun, 16 Aug 2020 17:02:00 -0700
Message-Id: <20200817000200.20993-1-rdunlap@infradead.org>
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
Reported-by: kernel test robot <lkp@intel.com>
---
v2: do not move the definition of seqcount_LOCKNAME_init().
Fix build errors reported by kernel test robot.
Actually build a kernel with these changes.

 include/linux/seqlock.h |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

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
@@ -148,7 +148,7 @@ static inline void seqcount_lockdep_read
  * that the write side critical section is properly serialized.
  */
 
-/**
+/*
  * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
  * @s:		Pointer to the seqcount_LOCKNAME_t instance
  * @lock:	Pointer to the associated LOCKTYPE
@@ -173,7 +173,6 @@ seqcount_##lockname##_init(seqcount_##lo
 	seqcount_init(&s->seqcount);					\
 	__SEQ_LOCK(s->lock = lock);					\
 }									\
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
