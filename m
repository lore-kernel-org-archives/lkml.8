Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDECCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B80207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HdpYrxEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHSJZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgHSJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:25:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Tmew4iAwtBYwVZISs1GtiPEnJ/BkpieLAisaLIoEYI=; b=HdpYrxEBp+Dr+hT7QoXbk8xJfU
        S3b9yoRSQagVkLGDmt/cDenSdmM9XYws2b3wu90KlmoJ32x1eyuepgl4LjuLGgXGp/3VoeRJURblg
        vZVAMVoJMNPCdSQJT0CFIFWSsiu9ZOLRc4J3jRWmUALnrNk7TVgyjVdCyYIxZsdovbAbR56LXbAdT
        vZGqZgswXHmlw0TTHx9Sf8DE9KRRok98kuo6VO5mgu9jT5T3V9HlwfStCDGUpCfpQ2yJuA1voPWQU
        WBxsUOxCKP5I9bVAGD8HNl09ovZdl8yf8Mt+ahwtSvquFBh0ap9K1GVs+vQrD7CY/y29uhSToM//z
        v6fEcKmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8KLJ-0002s0-1q; Wed, 19 Aug 2020 09:25:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8A64301A66;
        Wed, 19 Aug 2020 11:25:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6552BA27CF9; Wed, 19 Aug 2020 11:25:11 +0200 (CEST)
Date:   Wed, 19 Aug 2020 11:25:11 +0200
From:   peterz@infradead.org
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] seqlock: <linux/seqlock.h>: fix multiple kernel-doc
 warnings
Message-ID: <20200819092511.GA2674@hirez.programming.kicks-ass.net>
References: <20200817000200.20993-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817000200.20993-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 05:02:00PM -0700, Randy Dunlap wrote:

> --- lnx-59-rc1.orig/include/linux/seqlock.h
> +++ lnx-59-rc1/include/linux/seqlock.h

> @@ -173,7 +173,6 @@ seqcount_##lockname##_init(seqcount_##lo
>  	seqcount_init(&s->seqcount);					\
>  	__SEQ_LOCK(s->lock = lock);					\
>  }									\
> -									\
>  static __always_inline seqcount_t *					\
>  __seqcount_##lockname##_ptr(seqcount_##lockname##_t *s)			\
>  {									\

I think I'd rather like that empty line there..

> @@ -218,9 +217,9 @@ SEQCOUNT_LOCKTYPE(struct mutex,		mutex,
>  SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
>  
>  /**
> - * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
> - * @name:	Name of the seqcount_LOCKNAME_t instance
> - * @lock:	Pointer to the associated LOCKTYPE
> + * SEQCOUNT_LOCKTYPE_ZERO - static initializer for seqcount_LOCKNAME_t
> + * @seq_name:	Name of the seqcount_LOCKNAME_t instance
> + * @assoc_lock:	Pointer to the associated LOCKTYPE
>   */
>  
>  #define SEQCOUNT_LOCKTYPE_ZERO(seq_name, assoc_lock) {			\

And this hunk seems wrong, SEQCOUNT_LOCKTYPE_ZERO() is not the intended
API, SEQCNT_*_ZERO() are.


I've edited the patch like below, is that OK with you?

---
Subject: seqlock: Fix multiple kernel-doc warnings
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 16 Aug 2020 17:02:00 -0700

From: Randy Dunlap <rdunlap@infradead.org>

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
v2: do not move the definition of seqcount_LOCKNAME_init().
Fix build errors reported by kernel test robot.
Actually build a kernel with these changes.

 include/linux/seqlock.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
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
@@ -217,7 +217,7 @@ SEQCOUNT_LOCKTYPE(rwlock_t,		rwlock,		fa
 SEQCOUNT_LOCKTYPE(struct mutex,		mutex,		true,	s->lock)
 SEQCOUNT_LOCKTYPE(struct ww_mutex,	ww_mutex,	true,	&s->lock->base)
 
-/**
+/*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
  * @name:	Name of the seqcount_LOCKNAME_t instance
  * @lock:	Pointer to the associated LOCKTYPE
@@ -688,7 +688,7 @@ static inline int raw_read_seqcount_t_la
  *	to miss an entire modification sequence, once it resumes it might
  *	observe the new entry.
  *
- * NOTE:
+ * NOTE2:
  *
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
