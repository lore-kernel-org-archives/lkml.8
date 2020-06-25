Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B729BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F51B20702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tib7I4PB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405248AbgFYOLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbgFYOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:11:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FFEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4ShlP391OskakrqKRHOTFTXpAtarNT2q3T5BGG6YgM=; b=tib7I4PBKChMdfExC0tPWDU5m9
        YKQb3OsFLiVFqos0joBrGLOUZGAkPhOyDlW062H6aqLKjse6I3JD0auhucp9J9UcIPlyDXZqipG+x
        kYuQQZHEAhjlH7vr7C7p4U4oe4fEG3s+ozZbfgAT1uayZIa+j4uY4VBy5NTfpYFAg7Jz6h+v/51El
        aTEatXUI35JdTpuDA74q1BPfrW9BOJJ72wJGjqItHAtyzdWlXW8THFW3sSoyGfdcuohqim1xNlGW2
        ZpOD05/ccrbouGqUU4XukjUQav1gceYbb5mTmJRoBuN87Izzi0BWT+sbsxa8/zL7sQcueaerYQBHP
        vf3HWcXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joSbB-0001lY-CN; Thu, 25 Jun 2020 14:11:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E80BB3007CD;
        Thu, 25 Jun 2020 16:11:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AD3520CF218A; Thu, 25 Jun 2020 16:11:25 +0200 (CEST)
Date:   Thu, 25 Jun 2020 16:11:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [rcu:rcu/next 35/35] kernel/rcu/tree.c:251:8: error: implicit
 declaration of function 'arch_atomic_add_return'; did you mean
Message-ID: <20200625141125.GE117543@hirez.programming.kicks-ass.net>
References: <202006250300.ic32FsdY%lkp@intel.com>
 <20200624203025.GJ9247@paulmck-ThinkPad-P72>
 <CANpmjNO5uBSZj0gHy0t+O2VhD+UjG58+zON0AFX8i7MNSO5a6Q@mail.gmail.com>
 <20200625112926.GO4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625112926.GO4781@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 01:29:26PM +0200, Peter Zijlstra wrote:
> I fear the same. Let me see if I can quickly modify the atomic scripts
> to generate the required fallbacks.

Something like so ought to work, I suppose.

---
Subject: locking/atomics: Provide the arch_atomic_ interface to generic code
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jun 25 15:55:14 CEST 2020

Architectures with instrumented (KASAN/KCSAN) atomic operations
natively provide arch_atomic_ variants that are not instrumented.

It turns out that some generic code also requires arch_atomic_ in
order to avoid instrumentation, so provide the arch_atomic_ interface
as a direct map into the regular atomic_ interface for
non-instrumented architectures.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic-fallback.h       |  236 +++++++++++++++++++++++++++++++++-
 scripts/atomic/gen-atomic-fallback.sh |   31 ++++
 2 files changed, 266 insertions(+), 1 deletion(-)

--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -77,6 +77,9 @@
 
 #endif /* cmpxchg64_relaxed */
 
+#define arch_atomic_read atomic_read
+#define arch_atomic_read_acquire atomic_read_acquire
+
 #ifndef atomic_read_acquire
 static __always_inline int
 atomic_read_acquire(const atomic_t *v)
@@ -86,6 +89,9 @@ atomic_read_acquire(const atomic_t *v)
 #define atomic_read_acquire atomic_read_acquire
 #endif
 
+#define arch_atomic_set atomic_set
+#define arch_atomic_set_release atomic_set_release
+
 #ifndef atomic_set_release
 static __always_inline void
 atomic_set_release(atomic_t *v, int i)
@@ -95,6 +101,13 @@ atomic_set_release(atomic_t *v, int i)
 #define atomic_set_release atomic_set_release
 #endif
 
+#define arch_atomic_add atomic_add
+
+#define arch_atomic_add_return atomic_add_return
+#define arch_atomic_add_return_acquire atomic_add_return_acquire
+#define arch_atomic_add_return_release atomic_add_return_release
+#define arch_atomic_add_return_relaxed atomic_add_return_relaxed
+
 #ifndef atomic_add_return_relaxed
 #define atomic_add_return_acquire atomic_add_return
 #define atomic_add_return_release atomic_add_return
@@ -137,6 +150,11 @@ atomic_add_return(int i, atomic_t *v)
 
 #endif /* atomic_add_return_relaxed */
 
+#define arch_atomic_fetch_add atomic_fetch_add
+#define arch_atomic_fetch_add_acquire atomic_fetch_add_acquire
+#define arch_atomic_fetch_add_release atomic_fetch_add_release
+#define arch_atomic_fetch_add_relaxed atomic_fetch_add_relaxed
+
 #ifndef atomic_fetch_add_relaxed
 #define atomic_fetch_add_acquire atomic_fetch_add
 #define atomic_fetch_add_release atomic_fetch_add
@@ -179,6 +197,13 @@ atomic_fetch_add(int i, atomic_t *v)
 
 #endif /* atomic_fetch_add_relaxed */
 
+#define arch_atomic_sub atomic_sub
+
+#define arch_atomic_sub_return atomic_sub_return
+#define arch_atomic_sub_return_acquire atomic_sub_return_acquire
+#define arch_atomic_sub_return_release atomic_sub_return_release
+#define arch_atomic_sub_return_relaxed atomic_sub_return_relaxed
+
 #ifndef atomic_sub_return_relaxed
 #define atomic_sub_return_acquire atomic_sub_return
 #define atomic_sub_return_release atomic_sub_return
@@ -221,6 +246,11 @@ atomic_sub_return(int i, atomic_t *v)
 
 #endif /* atomic_sub_return_relaxed */
 
+#define arch_atomic_fetch_sub atomic_fetch_sub
+#define arch_atomic_fetch_sub_acquire atomic_fetch_sub_acquire
+#define arch_atomic_fetch_sub_release atomic_fetch_sub_release
+#define arch_atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
+
 #ifndef atomic_fetch_sub_relaxed
 #define atomic_fetch_sub_acquire atomic_fetch_sub
 #define atomic_fetch_sub_release atomic_fetch_sub
@@ -263,6 +293,8 @@ atomic_fetch_sub(int i, atomic_t *v)
 
 #endif /* atomic_fetch_sub_relaxed */
 
+#define arch_atomic_inc atomic_inc
+
 #ifndef atomic_inc
 static __always_inline void
 atomic_inc(atomic_t *v)
@@ -272,6 +304,11 @@ atomic_inc(atomic_t *v)
 #define atomic_inc atomic_inc
 #endif
 
+#define arch_atomic_inc_return atomic_inc_return
+#define arch_atomic_inc_return_acquire atomic_inc_return_acquire
+#define arch_atomic_inc_return_release atomic_inc_return_release
+#define arch_atomic_inc_return_relaxed atomic_inc_return_relaxed
+
 #ifndef atomic_inc_return_relaxed
 #ifdef atomic_inc_return
 #define atomic_inc_return_acquire atomic_inc_return
@@ -353,6 +390,11 @@ atomic_inc_return(atomic_t *v)
 
 #endif /* atomic_inc_return_relaxed */
 
+#define arch_atomic_fetch_inc atomic_fetch_inc
+#define arch_atomic_fetch_inc_acquire atomic_fetch_inc_acquire
+#define arch_atomic_fetch_inc_release atomic_fetch_inc_release
+#define arch_atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
+
 #ifndef atomic_fetch_inc_relaxed
 #ifdef atomic_fetch_inc
 #define atomic_fetch_inc_acquire atomic_fetch_inc
@@ -434,6 +476,8 @@ atomic_fetch_inc(atomic_t *v)
 
 #endif /* atomic_fetch_inc_relaxed */
 
+#define arch_atomic_dec atomic_dec
+
 #ifndef atomic_dec
 static __always_inline void
 atomic_dec(atomic_t *v)
@@ -443,6 +487,11 @@ atomic_dec(atomic_t *v)
 #define atomic_dec atomic_dec
 #endif
 
+#define arch_atomic_dec_return atomic_dec_return
+#define arch_atomic_dec_return_acquire atomic_dec_return_acquire
+#define arch_atomic_dec_return_release atomic_dec_return_release
+#define arch_atomic_dec_return_relaxed atomic_dec_return_relaxed
+
 #ifndef atomic_dec_return_relaxed
 #ifdef atomic_dec_return
 #define atomic_dec_return_acquire atomic_dec_return
@@ -524,6 +573,11 @@ atomic_dec_return(atomic_t *v)
 
 #endif /* atomic_dec_return_relaxed */
 
+#define arch_atomic_fetch_dec atomic_fetch_dec
+#define arch_atomic_fetch_dec_acquire atomic_fetch_dec_acquire
+#define arch_atomic_fetch_dec_release atomic_fetch_dec_release
+#define arch_atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
+
 #ifndef atomic_fetch_dec_relaxed
 #ifdef atomic_fetch_dec
 #define atomic_fetch_dec_acquire atomic_fetch_dec
@@ -605,6 +659,13 @@ atomic_fetch_dec(atomic_t *v)
 
 #endif /* atomic_fetch_dec_relaxed */
 
+#define arch_atomic_and atomic_and
+
+#define arch_atomic_fetch_and atomic_fetch_and
+#define arch_atomic_fetch_and_acquire atomic_fetch_and_acquire
+#define arch_atomic_fetch_and_release atomic_fetch_and_release
+#define arch_atomic_fetch_and_relaxed atomic_fetch_and_relaxed
+
 #ifndef atomic_fetch_and_relaxed
 #define atomic_fetch_and_acquire atomic_fetch_and
 #define atomic_fetch_and_release atomic_fetch_and
@@ -647,6 +708,8 @@ atomic_fetch_and(int i, atomic_t *v)
 
 #endif /* atomic_fetch_and_relaxed */
 
+#define arch_atomic_andnot atomic_andnot
+
 #ifndef atomic_andnot
 static __always_inline void
 atomic_andnot(int i, atomic_t *v)
@@ -656,6 +719,11 @@ atomic_andnot(int i, atomic_t *v)
 #define atomic_andnot atomic_andnot
 #endif
 
+#define arch_atomic_fetch_andnot atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
+#define arch_atomic_fetch_andnot_release atomic_fetch_andnot_release
+#define arch_atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
+
 #ifndef atomic_fetch_andnot_relaxed
 #ifdef atomic_fetch_andnot
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot
@@ -737,6 +805,13 @@ atomic_fetch_andnot(int i, atomic_t *v)
 
 #endif /* atomic_fetch_andnot_relaxed */
 
+#define arch_atomic_or atomic_or
+
+#define arch_atomic_fetch_or atomic_fetch_or
+#define arch_atomic_fetch_or_acquire atomic_fetch_or_acquire
+#define arch_atomic_fetch_or_release atomic_fetch_or_release
+#define arch_atomic_fetch_or_relaxed atomic_fetch_or_relaxed
+
 #ifndef atomic_fetch_or_relaxed
 #define atomic_fetch_or_acquire atomic_fetch_or
 #define atomic_fetch_or_release atomic_fetch_or
@@ -779,6 +854,13 @@ atomic_fetch_or(int i, atomic_t *v)
 
 #endif /* atomic_fetch_or_relaxed */
 
+#define arch_atomic_xor atomic_xor
+
+#define arch_atomic_fetch_xor atomic_fetch_xor
+#define arch_atomic_fetch_xor_acquire atomic_fetch_xor_acquire
+#define arch_atomic_fetch_xor_release atomic_fetch_xor_release
+#define arch_atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
+
 #ifndef atomic_fetch_xor_relaxed
 #define atomic_fetch_xor_acquire atomic_fetch_xor
 #define atomic_fetch_xor_release atomic_fetch_xor
@@ -821,6 +903,11 @@ atomic_fetch_xor(int i, atomic_t *v)
 
 #endif /* atomic_fetch_xor_relaxed */
 
+#define arch_atomic_xchg atomic_xchg
+#define arch_atomic_xchg_acquire atomic_xchg_acquire
+#define arch_atomic_xchg_release atomic_xchg_release
+#define arch_atomic_xchg_relaxed atomic_xchg_relaxed
+
 #ifndef atomic_xchg_relaxed
 #define atomic_xchg_acquire atomic_xchg
 #define atomic_xchg_release atomic_xchg
@@ -863,6 +950,11 @@ atomic_xchg(atomic_t *v, int i)
 
 #endif /* atomic_xchg_relaxed */
 
+#define arch_atomic_cmpxchg atomic_cmpxchg
+#define arch_atomic_cmpxchg_acquire atomic_cmpxchg_acquire
+#define arch_atomic_cmpxchg_release atomic_cmpxchg_release
+#define arch_atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
+
 #ifndef atomic_cmpxchg_relaxed
 #define atomic_cmpxchg_acquire atomic_cmpxchg
 #define atomic_cmpxchg_release atomic_cmpxchg
@@ -905,6 +997,11 @@ atomic_cmpxchg(atomic_t *v, int old, int
 
 #endif /* atomic_cmpxchg_relaxed */
 
+#define arch_atomic_try_cmpxchg atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
+#define arch_atomic_try_cmpxchg_release atomic_try_cmpxchg_release
+#define arch_atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
+
 #ifndef atomic_try_cmpxchg_relaxed
 #ifdef atomic_try_cmpxchg
 #define atomic_try_cmpxchg_acquire atomic_try_cmpxchg
@@ -1002,6 +1099,8 @@ atomic_try_cmpxchg(atomic_t *v, int *old
 
 #endif /* atomic_try_cmpxchg_relaxed */
 
+#define arch_atomic_sub_and_test atomic_sub_and_test
+
 #ifndef atomic_sub_and_test
 /**
  * atomic_sub_and_test - subtract value from variable and test result
@@ -1020,6 +1119,8 @@ atomic_sub_and_test(int i, atomic_t *v)
 #define atomic_sub_and_test atomic_sub_and_test
 #endif
 
+#define arch_atomic_dec_and_test atomic_dec_and_test
+
 #ifndef atomic_dec_and_test
 /**
  * atomic_dec_and_test - decrement and test
@@ -1037,6 +1138,8 @@ atomic_dec_and_test(atomic_t *v)
 #define atomic_dec_and_test atomic_dec_and_test
 #endif
 
+#define arch_atomic_inc_and_test atomic_inc_and_test
+
 #ifndef atomic_inc_and_test
 /**
  * atomic_inc_and_test - increment and test
@@ -1054,6 +1157,8 @@ atomic_inc_and_test(atomic_t *v)
 #define atomic_inc_and_test atomic_inc_and_test
 #endif
 
+#define arch_atomic_add_negative atomic_add_negative
+
 #ifndef atomic_add_negative
 /**
  * atomic_add_negative - add and test if negative
@@ -1072,6 +1177,8 @@ atomic_add_negative(int i, atomic_t *v)
 #define atomic_add_negative atomic_add_negative
 #endif
 
+#define arch_atomic_fetch_add_unless atomic_fetch_add_unless
+
 #ifndef atomic_fetch_add_unless
 /**
  * atomic_fetch_add_unless - add unless the number is already a given value
@@ -1097,6 +1204,8 @@ atomic_fetch_add_unless(atomic_t *v, int
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 #endif
 
+#define arch_atomic_add_unless atomic_add_unless
+
 #ifndef atomic_add_unless
 /**
  * atomic_add_unless - add unless the number is already a given value
@@ -1115,6 +1224,8 @@ atomic_add_unless(atomic_t *v, int a, in
 #define atomic_add_unless atomic_add_unless
 #endif
 
+#define arch_atomic_inc_not_zero atomic_inc_not_zero
+
 #ifndef atomic_inc_not_zero
 /**
  * atomic_inc_not_zero - increment unless the number is zero
@@ -1131,6 +1242,8 @@ atomic_inc_not_zero(atomic_t *v)
 #define atomic_inc_not_zero atomic_inc_not_zero
 #endif
 
+#define arch_atomic_inc_unless_negative atomic_inc_unless_negative
+
 #ifndef atomic_inc_unless_negative
 static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
@@ -1147,6 +1260,8 @@ atomic_inc_unless_negative(atomic_t *v)
 #define atomic_inc_unless_negative atomic_inc_unless_negative
 #endif
 
+#define arch_atomic_dec_unless_positive atomic_dec_unless_positive
+
 #ifndef atomic_dec_unless_positive
 static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
@@ -1163,6 +1278,8 @@ atomic_dec_unless_positive(atomic_t *v)
 #define atomic_dec_unless_positive atomic_dec_unless_positive
 #endif
 
+#define arch_atomic_dec_if_positive atomic_dec_if_positive
+
 #ifndef atomic_dec_if_positive
 static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
@@ -1184,6 +1301,9 @@ atomic_dec_if_positive(atomic_t *v)
 #include <asm-generic/atomic64.h>
 #endif
 
+#define arch_atomic64_read atomic64_read
+#define arch_atomic64_read_acquire atomic64_read_acquire
+
 #ifndef atomic64_read_acquire
 static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
@@ -1193,6 +1313,9 @@ atomic64_read_acquire(const atomic64_t *
 #define atomic64_read_acquire atomic64_read_acquire
 #endif
 
+#define arch_atomic64_set atomic64_set
+#define arch_atomic64_set_release atomic64_set_release
+
 #ifndef atomic64_set_release
 static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
@@ -1202,6 +1325,13 @@ atomic64_set_release(atomic64_t *v, s64
 #define atomic64_set_release atomic64_set_release
 #endif
 
+#define arch_atomic64_add atomic64_add
+
+#define arch_atomic64_add_return atomic64_add_return
+#define arch_atomic64_add_return_acquire atomic64_add_return_acquire
+#define arch_atomic64_add_return_release atomic64_add_return_release
+#define arch_atomic64_add_return_relaxed atomic64_add_return_relaxed
+
 #ifndef atomic64_add_return_relaxed
 #define atomic64_add_return_acquire atomic64_add_return
 #define atomic64_add_return_release atomic64_add_return
@@ -1244,6 +1374,11 @@ atomic64_add_return(s64 i, atomic64_t *v
 
 #endif /* atomic64_add_return_relaxed */
 
+#define arch_atomic64_fetch_add atomic64_fetch_add
+#define arch_atomic64_fetch_add_acquire atomic64_fetch_add_acquire
+#define arch_atomic64_fetch_add_release atomic64_fetch_add_release
+#define arch_atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
+
 #ifndef atomic64_fetch_add_relaxed
 #define atomic64_fetch_add_acquire atomic64_fetch_add
 #define atomic64_fetch_add_release atomic64_fetch_add
@@ -1286,6 +1421,13 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 
 #endif /* atomic64_fetch_add_relaxed */
 
+#define arch_atomic64_sub atomic64_sub
+
+#define arch_atomic64_sub_return atomic64_sub_return
+#define arch_atomic64_sub_return_acquire atomic64_sub_return_acquire
+#define arch_atomic64_sub_return_release atomic64_sub_return_release
+#define arch_atomic64_sub_return_relaxed atomic64_sub_return_relaxed
+
 #ifndef atomic64_sub_return_relaxed
 #define atomic64_sub_return_acquire atomic64_sub_return
 #define atomic64_sub_return_release atomic64_sub_return
@@ -1328,6 +1470,11 @@ atomic64_sub_return(s64 i, atomic64_t *v
 
 #endif /* atomic64_sub_return_relaxed */
 
+#define arch_atomic64_fetch_sub atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
+#define arch_atomic64_fetch_sub_release atomic64_fetch_sub_release
+#define arch_atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
+
 #ifndef atomic64_fetch_sub_relaxed
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub
 #define atomic64_fetch_sub_release atomic64_fetch_sub
@@ -1370,6 +1517,8 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 
 #endif /* atomic64_fetch_sub_relaxed */
 
+#define arch_atomic64_inc atomic64_inc
+
 #ifndef atomic64_inc
 static __always_inline void
 atomic64_inc(atomic64_t *v)
@@ -1379,6 +1528,11 @@ atomic64_inc(atomic64_t *v)
 #define atomic64_inc atomic64_inc
 #endif
 
+#define arch_atomic64_inc_return atomic64_inc_return
+#define arch_atomic64_inc_return_acquire atomic64_inc_return_acquire
+#define arch_atomic64_inc_return_release atomic64_inc_return_release
+#define arch_atomic64_inc_return_relaxed atomic64_inc_return_relaxed
+
 #ifndef atomic64_inc_return_relaxed
 #ifdef atomic64_inc_return
 #define atomic64_inc_return_acquire atomic64_inc_return
@@ -1460,6 +1614,11 @@ atomic64_inc_return(atomic64_t *v)
 
 #endif /* atomic64_inc_return_relaxed */
 
+#define arch_atomic64_fetch_inc atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
+#define arch_atomic64_fetch_inc_release atomic64_fetch_inc_release
+#define arch_atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
+
 #ifndef atomic64_fetch_inc_relaxed
 #ifdef atomic64_fetch_inc
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc
@@ -1541,6 +1700,8 @@ atomic64_fetch_inc(atomic64_t *v)
 
 #endif /* atomic64_fetch_inc_relaxed */
 
+#define arch_atomic64_dec atomic64_dec
+
 #ifndef atomic64_dec
 static __always_inline void
 atomic64_dec(atomic64_t *v)
@@ -1550,6 +1711,11 @@ atomic64_dec(atomic64_t *v)
 #define atomic64_dec atomic64_dec
 #endif
 
+#define arch_atomic64_dec_return atomic64_dec_return
+#define arch_atomic64_dec_return_acquire atomic64_dec_return_acquire
+#define arch_atomic64_dec_return_release atomic64_dec_return_release
+#define arch_atomic64_dec_return_relaxed atomic64_dec_return_relaxed
+
 #ifndef atomic64_dec_return_relaxed
 #ifdef atomic64_dec_return
 #define atomic64_dec_return_acquire atomic64_dec_return
@@ -1631,6 +1797,11 @@ atomic64_dec_return(atomic64_t *v)
 
 #endif /* atomic64_dec_return_relaxed */
 
+#define arch_atomic64_fetch_dec atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
+#define arch_atomic64_fetch_dec_release atomic64_fetch_dec_release
+#define arch_atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
+
 #ifndef atomic64_fetch_dec_relaxed
 #ifdef atomic64_fetch_dec
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec
@@ -1712,6 +1883,13 @@ atomic64_fetch_dec(atomic64_t *v)
 
 #endif /* atomic64_fetch_dec_relaxed */
 
+#define arch_atomic64_and atomic64_and
+
+#define arch_atomic64_fetch_and atomic64_fetch_and
+#define arch_atomic64_fetch_and_acquire atomic64_fetch_and_acquire
+#define arch_atomic64_fetch_and_release atomic64_fetch_and_release
+#define arch_atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
+
 #ifndef atomic64_fetch_and_relaxed
 #define atomic64_fetch_and_acquire atomic64_fetch_and
 #define atomic64_fetch_and_release atomic64_fetch_and
@@ -1754,6 +1932,8 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 
 #endif /* atomic64_fetch_and_relaxed */
 
+#define arch_atomic64_andnot atomic64_andnot
+
 #ifndef atomic64_andnot
 static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
@@ -1763,6 +1943,11 @@ atomic64_andnot(s64 i, atomic64_t *v)
 #define atomic64_andnot atomic64_andnot
 #endif
 
+#define arch_atomic64_fetch_andnot atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
+#define arch_atomic64_fetch_andnot_release atomic64_fetch_andnot_release
+#define arch_atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
+
 #ifndef atomic64_fetch_andnot_relaxed
 #ifdef atomic64_fetch_andnot
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot
@@ -1844,6 +2029,13 @@ atomic64_fetch_andnot(s64 i, atomic64_t
 
 #endif /* atomic64_fetch_andnot_relaxed */
 
+#define arch_atomic64_or atomic64_or
+
+#define arch_atomic64_fetch_or atomic64_fetch_or
+#define arch_atomic64_fetch_or_acquire atomic64_fetch_or_acquire
+#define arch_atomic64_fetch_or_release atomic64_fetch_or_release
+#define arch_atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
+
 #ifndef atomic64_fetch_or_relaxed
 #define atomic64_fetch_or_acquire atomic64_fetch_or
 #define atomic64_fetch_or_release atomic64_fetch_or
@@ -1886,6 +2078,13 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 
 #endif /* atomic64_fetch_or_relaxed */
 
+#define arch_atomic64_xor atomic64_xor
+
+#define arch_atomic64_fetch_xor atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
+#define arch_atomic64_fetch_xor_release atomic64_fetch_xor_release
+#define arch_atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
+
 #ifndef atomic64_fetch_xor_relaxed
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor
 #define atomic64_fetch_xor_release atomic64_fetch_xor
@@ -1928,6 +2127,11 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 
 #endif /* atomic64_fetch_xor_relaxed */
 
+#define arch_atomic64_xchg atomic64_xchg
+#define arch_atomic64_xchg_acquire atomic64_xchg_acquire
+#define arch_atomic64_xchg_release atomic64_xchg_release
+#define arch_atomic64_xchg_relaxed atomic64_xchg_relaxed
+
 #ifndef atomic64_xchg_relaxed
 #define atomic64_xchg_acquire atomic64_xchg
 #define atomic64_xchg_release atomic64_xchg
@@ -1970,6 +2174,11 @@ atomic64_xchg(atomic64_t *v, s64 i)
 
 #endif /* atomic64_xchg_relaxed */
 
+#define arch_atomic64_cmpxchg atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
+#define arch_atomic64_cmpxchg_release atomic64_cmpxchg_release
+#define arch_atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
+
 #ifndef atomic64_cmpxchg_relaxed
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg
 #define atomic64_cmpxchg_release atomic64_cmpxchg
@@ -2012,6 +2221,11 @@ atomic64_cmpxchg(atomic64_t *v, s64 old,
 
 #endif /* atomic64_cmpxchg_relaxed */
 
+#define arch_atomic64_try_cmpxchg atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
+#define arch_atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
+#define arch_atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
+
 #ifndef atomic64_try_cmpxchg_relaxed
 #ifdef atomic64_try_cmpxchg
 #define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg
@@ -2109,6 +2323,8 @@ atomic64_try_cmpxchg(atomic64_t *v, s64
 
 #endif /* atomic64_try_cmpxchg_relaxed */
 
+#define arch_atomic64_sub_and_test atomic64_sub_and_test
+
 #ifndef atomic64_sub_and_test
 /**
  * atomic64_sub_and_test - subtract value from variable and test result
@@ -2127,6 +2343,8 @@ atomic64_sub_and_test(s64 i, atomic64_t
 #define atomic64_sub_and_test atomic64_sub_and_test
 #endif
 
+#define arch_atomic64_dec_and_test atomic64_dec_and_test
+
 #ifndef atomic64_dec_and_test
 /**
  * atomic64_dec_and_test - decrement and test
@@ -2144,6 +2362,8 @@ atomic64_dec_and_test(atomic64_t *v)
 #define atomic64_dec_and_test atomic64_dec_and_test
 #endif
 
+#define arch_atomic64_inc_and_test atomic64_inc_and_test
+
 #ifndef atomic64_inc_and_test
 /**
  * atomic64_inc_and_test - increment and test
@@ -2161,6 +2381,8 @@ atomic64_inc_and_test(atomic64_t *v)
 #define atomic64_inc_and_test atomic64_inc_and_test
 #endif
 
+#define arch_atomic64_add_negative atomic64_add_negative
+
 #ifndef atomic64_add_negative
 /**
  * atomic64_add_negative - add and test if negative
@@ -2179,6 +2401,8 @@ atomic64_add_negative(s64 i, atomic64_t
 #define atomic64_add_negative atomic64_add_negative
 #endif
 
+#define arch_atomic64_fetch_add_unless atomic64_fetch_add_unless
+
 #ifndef atomic64_fetch_add_unless
 /**
  * atomic64_fetch_add_unless - add unless the number is already a given value
@@ -2204,6 +2428,8 @@ atomic64_fetch_add_unless(atomic64_t *v,
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 #endif
 
+#define arch_atomic64_add_unless atomic64_add_unless
+
 #ifndef atomic64_add_unless
 /**
  * atomic64_add_unless - add unless the number is already a given value
@@ -2222,6 +2448,8 @@ atomic64_add_unless(atomic64_t *v, s64 a
 #define atomic64_add_unless atomic64_add_unless
 #endif
 
+#define arch_atomic64_inc_not_zero atomic64_inc_not_zero
+
 #ifndef atomic64_inc_not_zero
 /**
  * atomic64_inc_not_zero - increment unless the number is zero
@@ -2238,6 +2466,8 @@ atomic64_inc_not_zero(atomic64_t *v)
 #define atomic64_inc_not_zero atomic64_inc_not_zero
 #endif
 
+#define arch_atomic64_inc_unless_negative atomic64_inc_unless_negative
+
 #ifndef atomic64_inc_unless_negative
 static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
@@ -2254,6 +2484,8 @@ atomic64_inc_unless_negative(atomic64_t
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
 #endif
 
+#define arch_atomic64_dec_unless_positive atomic64_dec_unless_positive
+
 #ifndef atomic64_dec_unless_positive
 static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
@@ -2270,6 +2502,8 @@ atomic64_dec_unless_positive(atomic64_t
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
 #endif
 
+#define arch_atomic64_dec_if_positive atomic64_dec_if_positive
+
 #ifndef atomic64_dec_if_positive
 static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
@@ -2288,4 +2522,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 #endif
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 1fac0941c79bf0ae100723cc2ac9b94061f0b67a
+// 9d95b56f98d82a2a26c7b79ccdd0c47572d50a6f
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -58,6 +58,21 @@ cat << EOF
 EOF
 }
 
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local arch="$1"
+	local atomic="$2"
+
+	local basename="${arch}${atomic}_${pfx}${name}${sfx}"
+
+	printf "#define arch_${basename}${order} ${basename}${order}\n"
+}
+
 #gen_proto_order_variants(meta, pfx, name, sfx, arch, atomic, int, args...)
 gen_proto_order_variants()
 {
@@ -72,6 +87,22 @@ gen_proto_order_variants()
 
 	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
+	if [ -z "$arch" ]; then
+		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+
+		if meta_has_acquire "${meta}"; then
+			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+		fi
+		if meta_has_release "${meta}"; then
+			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+		fi
+		if meta_has_relaxed "${meta}"; then
+			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" "$@"
+		fi
+
+		echo ""
+	fi
+
 	# If we don't have relaxed atomics, then we don't bother with ordering fallbacks
 	# read_acquire and set_release need to be templated, though
 	if ! meta_has_relaxed "${meta}"; then
