Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7652076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hcTf9sVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2LLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2LLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:11:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1119C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/4UVzO6/pt+sWOpUFWJZhxoXijPadOzKX6cBV5BoYo4=; b=hcTf9sVp6162AIpmShRCKxyVPV
        6tAOPO6k7fTQQU8rujn8GwQwh+lh8SLc3Y6foQE+0LeXaqG4hnUzk0Wh4WMhZSOV7jx2GiNO8z3cZ
        pGG/19/c4sZCqmcJoXrB9zcachhxWRuyfsxiTqr7l1r1Xt9IZHk7kNqhm8WHMFIgAynPabCKezLGP
        V4Lm1G0HNeLF+s9X2drhnwHSa9JfXu6HjDhx6W1Yg7BAblqNMaFIiwquIY/UbWiQS8f9sBUJeKMPb
        cZQq3VenK9vvV9zE3gFaTVsdYVjQ0FxWZhFGES/DE2ot5X5UFm3mM37acRql+jDeo3M6BGdR58+cp
        pkbYE1yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0jzW-000170-OT; Wed, 29 Jul 2020 11:11:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 725C830411F;
        Wed, 29 Jul 2020 13:11:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D2EC21411B81; Wed, 29 Jul 2020 13:11:20 +0200 (CEST)
Date:   Wed, 29 Jul 2020 13:11:20 +0200
From:   peterz@infradead.org
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain the
 old value
Message-ID: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
References: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
 <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
 <3211866.1595933798@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3211866.1595933798@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 11:56:38AM +0100, David Howells wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Please do not _undo_ the changes; just add the API you need.
> > 
> > add_return and sub_return are horrible interface for refcount, which is
> > the problem.
> > 
> > If you meant: refcount_dec(), but want the old value for tracing, you
> > want a different ordering than if you wanted to do
> > refcount_dec_and_test(); dec_return can't know this.
> > 
> > David, would something like a __refcount_*() API work where there is a
> > 3rd argument (int *), which, if !NULL, will be assigned the old value?
> 
> That would be fine, though the number needs to be something I can interpret
> easily when looking through the traces.  It would also be okay if there was an
> interpretation function that I could use in the trace point when setting the
> variable.

I'm not entirely sure what you mean with interpret, provided you don't
trigger a refcount fail, the number will be just what you expect and
would get from refcount_read(). If you do trigger a fail, you'll get a
negative value.

How's the below? I didn't provide __refcount versions for the external
functions, I suppose that can be done too, but wondered if you really
needed those.

---
Subject: locking/refcount: Provide __refcount API to obtain the old value
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jul 29 13:00:57 CEST 2020

David requested means to obtain the old/previous value from the
refcount API for tracing purposes.

Duplicate (most of) the API as __refcount*() with an additional
'int *' argument into which, if !NULL, the old value will be stored.

Requested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/refcount.h |   65 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 8 deletions(-)

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -165,7 +165,7 @@ static inline unsigned int refcount_read
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
+static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
 {
 	int old = refcount_read(r);
 
@@ -174,12 +174,20 @@ static inline __must_check bool refcount
 			break;
 	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
 
+	if (oldp)
+		*oldp = old;
+
 	if (unlikely(old < 0 || old + i < 0))
 		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
 
 	return old;
 }
 
+static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
+{
+	return __refcount_add_not_zero(i, r, NULL);
+}
+
 /**
  * refcount_add - add a value to a refcount
  * @i: the value to add to the refcount
@@ -196,16 +204,24 @@ static inline __must_check bool refcount
  * cases, refcount_inc(), or one of its variants, should instead be used to
  * increment a reference count.
  */
-static inline void refcount_add(int i, refcount_t *r)
+static inline void __refcount_add(int i, refcount_t *r, int *oldp)
 {
 	int old = atomic_fetch_add_relaxed(i, &r->refs);
 
+	if (oldp)
+		*oldp = old;
+
 	if (unlikely(!old))
 		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
 	else if (unlikely(old < 0 || old + i < 0))
 		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
 }
 
+static inline void refcount_add(int i, refcount_t *r)
+{
+	__refcount_add(i, r, NULL);
+}
+
 /**
  * refcount_inc_not_zero - increment a refcount unless it is 0
  * @r: the refcount to increment
@@ -219,9 +235,14 @@ static inline void refcount_add(int i, r
  *
  * Return: true if the increment was successful, false otherwise
  */
+static inline __must_check bool __refcount_inc_not_zero(refcount_t *r, int *oldp)
+{
+	return __refcount_add_not_zero(1, r, oldp);
+}
+
 static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 {
-	return refcount_add_not_zero(1, r);
+	return __refcount_inc_not_zero(r, NULL);
 }
 
 /**
@@ -236,9 +257,14 @@ static inline __must_check bool refcount
  * Will WARN if the refcount is 0, as this represents a possible use-after-free
  * condition.
  */
+static inline void __refcount_inc(refcount_t *r, int *oldp)
+{
+	__refcount_add(1, r, oldp);
+}
+
 static inline void refcount_inc(refcount_t *r)
 {
-	refcount_add(1, r);
+	__refcount_inc(r, NULL);
 }
 
 /**
@@ -261,10 +287,13 @@ static inline void refcount_inc(refcount
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
+static inline __must_check bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
 {
 	int old = atomic_fetch_sub_release(i, &r->refs);
 
+	if (oldp)
+		*oldp = old;
+
 	if (old == i) {
 		smp_acquire__after_ctrl_dep();
 		return true;
@@ -276,6 +305,11 @@ static inline __must_check bool refcount
 	return false;
 }
 
+static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
+{
+	return __refcount_sub_and_test(i, r, NULL);
+}
+
 /**
  * refcount_dec_and_test - decrement a refcount and test if it is 0
  * @r: the refcount
@@ -289,9 +323,14 @@ static inline __must_check bool refcount
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
+static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp)
+{
+	return __refcount_sub_and_test(1, r, oldp);
+}
+
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
-	return refcount_sub_and_test(1, r);
+	return __refcount_dec_and_test(r, NULL);
 }
 
 /**
@@ -304,12 +343,22 @@ static inline __must_check bool refcount
  * Provides release memory ordering, such that prior loads and stores are done
  * before.
  */
-static inline void refcount_dec(refcount_t *r)
+static inline void __refcount_dec(refcount_t *r, int *oldp)
 {
-	if (unlikely(atomic_fetch_sub_release(1, &r->refs) <= 1))
+	int old = atomic_fetch_sub_release(1, &r->refs);
+
+	if (oldp)
+		*oldp = old;
+
+	if (unlikely(old <= 1))
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 
+static inline void refcount_dec(refcount_t *r)
+{
+	__refcount_dec(r, NULL);
+}
+
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
