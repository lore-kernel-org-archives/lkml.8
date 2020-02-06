Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3070C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A349D20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgBFQjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:39:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:5660 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgBFQjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:39:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="311743046"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2020 08:39:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47FD9FC; Thu,  6 Feb 2020 18:39:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/4] kernel.h: Split out mathematical helpers
Date:   Thu,  6 Feb 2020 18:39:38 +0200
Message-Id: <20200206163940.1940-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206163940.1940-1-andriy.shevchenko@linux.intel.com>
References: <20200206163940.1940-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt to start cleaning it up by splitting out mathematical
helpers.

At the same time convert users in header and lib folder to use new header.
Though for time being include new header back to kernel.h to avoid twisted
indirected includes for existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: fix compilation error (kbuild test robot)
 fs/nfs/callback_proc.c        |   5 +
 include/linux/bitops.h        |  11 ++-
 include/linux/dcache.h        |   1 +
 include/linux/iommu-helper.h  |   4 +-
 include/linux/kernel.h        | 174 +--------------------------------
 include/linux/math.h          | 177 ++++++++++++++++++++++++++++++++++
 include/linux/rcu_node_tree.h |   2 +
 include/linux/units.h         |   2 +-
 lib/errname.c                 |   1 +
 lib/find_bit.c                |   3 +-
 lib/math/div64.c              |   3 +-
 lib/math/int_pow.c            |   2 +-
 lib/math/int_sqrt.c           |   3 +-
 lib/math/reciprocal_div.c     |   8 +-
 14 files changed, 212 insertions(+), 184 deletions(-)
 create mode 100644 include/linux/math.h

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index cd4c6bc81cae..146cf0a5cbf8 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -6,10 +6,15 @@
  *
  * NFSv4 callback procedures
  */
+
+#include <linux/errno.h>
+#include <linux/math.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
 #include <linux/slab.h>
 #include <linux/rcupdate.h>
+#include <linux/types.h>
+
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 47f54b459c26..21696ea359d1 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -1,9 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
+
 #include <asm/types.h>
 #include <linux/bits.h>
 
+#include <uapi/linux/kernel.h>
+
 /* Set bits in the first 'n' bytes when loaded from memory */
 #ifdef __LITTLE_ENDIAN
 #  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
@@ -12,10 +15,10 @@
 #endif
 
 #define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
-#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
-#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
-#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
+#define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..096e04b7f38d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/list.h>
+#include <linux/math.h>
 #include <linux/rculist.h>
 #include <linux/rculist_bl.h>
 #include <linux/spinlock.h>
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 70d01edcbf8b..74be34f3a20a 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -3,7 +3,9 @@
 #define _LINUX_IOMMU_HELPER_H
 
 #include <linux/bug.h>
-#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/math.h>
+#include <linux/types.h>
 
 static inline unsigned long iommu_device_max_index(unsigned long size,
 						   unsigned long offset,
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 062d86f946c5..3ca18547af01 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
-
 #include <stdarg.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
@@ -11,14 +10,15 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
+
 #include <asm/byteorder.h>
-#include <asm/div64.h>
+
 #include <uapi/linux/kernel.h>
-#include <asm/div64.h>
 
 #define STACK_MAGIC	0xdeadbeef
 
@@ -54,125 +54,11 @@
 }					\
 )
 
-/*
- * This looks more complex than it should be. But we need to
- * get the type for the ~ right in round_down (it needs to be
- * as wide as the result!), and we want to evaluate the macro
- * arguments just once each.
- */
-#define __round_mask(x, y) ((__typeof__(x))((y)-1))
-/**
- * round_up - round up to next specified power of 2
- * @x: the value to round
- * @y: multiple to round up to (must be a power of 2)
- *
- * Rounds @x up to next multiple of @y (which must be a power of 2).
- * To perform arbitrary rounding up, use roundup() below.
- */
-#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
-/**
- * round_down - round down to next specified power of 2
- * @x: the value to round
- * @y: multiple to round down to (must be a power of 2)
- *
- * Rounds @x down to next multiple of @y (which must be a power of 2).
- * To perform arbitrary rounding down, use rounddown() below.
- */
-#define round_down(x, y) ((x) & ~__round_mask(x, y))
-
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
-#define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
-
-#define DIV_ROUND_DOWN_ULL(ll, d) \
-	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
-
-#define DIV_ROUND_UP_ULL(ll, d) \
-	DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
-
-#if BITS_PER_LONG == 32
-# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
-#else
-# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP(ll,d)
-#endif
-
-/**
- * roundup - round up to the next specified multiple
- * @x: the value to up
- * @y: multiple to round up to
- *
- * Rounds @x up to next multiple of @y. If @y will always be a power
- * of 2, consider using the faster round_up().
- */
-#define roundup(x, y) (					\
-{							\
-	typeof(y) __y = y;				\
-	(((x) + (__y - 1)) / __y) * __y;		\
-}							\
-)
-/**
- * rounddown - round down to next specified multiple
- * @x: the value to round
- * @y: multiple to round down to
- *
- * Rounds @x down to next multiple of @y. If @y will always be a power
- * of 2, consider using the faster round_down().
- */
-#define rounddown(x, y) (				\
-{							\
-	typeof(x) __x = (x);				\
-	__x - (__x % (y));				\
-}							\
-)
-
-/*
- * Divide positive or negative dividend by positive or negative divisor
- * and round to closest integer. Result is undefined for negative
- * divisors if the dividend variable type is unsigned and for negative
- * dividends if the divisor variable type is unsigned.
- */
-#define DIV_ROUND_CLOSEST(x, divisor)(			\
-{							\
-	typeof(x) __x = x;				\
-	typeof(divisor) __d = divisor;			\
-	(((typeof(x))-1) > 0 ||				\
-	 ((typeof(divisor))-1) > 0 ||			\
-	 (((__x) > 0) == ((__d) > 0))) ?		\
-		(((__x) + ((__d) / 2)) / (__d)) :	\
-		(((__x) - ((__d) / 2)) / (__d));	\
-}							\
-)
-/*
- * Same as above but for u64 dividends. divisor must be a 32-bit
- * number.
- */
-#define DIV_ROUND_CLOSEST_ULL(x, divisor)(		\
-{							\
-	typeof(divisor) __d = divisor;			\
-	unsigned long long _tmp = (x) + (__d) / 2;	\
-	do_div(_tmp, __d);				\
-	_tmp;						\
-}							\
-)
-
-/*
- * Multiplies an integer by a fraction, while avoiding unnecessary
- * overflow or loss of precision.
- */
-#define mult_frac(x, numer, denom)(			\
-{							\
-	typeof(x) quot = (x) / (denom);			\
-	typeof(x) rem  = (x) % (denom);			\
-	(quot * (numer)) + ((rem * (numer)) / (denom));	\
-}							\
-)
-
-
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
 
-#define sector_div(a, b) do_div(a, b)
-
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
@@ -258,48 +144,6 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
-/**
- * abs - return absolute value of an argument
- * @x: the value.  If it is unsigned type, it is converted to signed type first.
- *     char is treated as if it was signed (regardless of whether it really is)
- *     but the macro's return type is preserved as char.
- *
- * Return: an absolute value of x.
- */
-#define abs(x)	__abs_choose_expr(x, long long,				\
-		__abs_choose_expr(x, long,				\
-		__abs_choose_expr(x, int,				\
-		__abs_choose_expr(x, short,				\
-		__abs_choose_expr(x, char,				\
-		__builtin_choose_expr(					\
-			__builtin_types_compatible_p(typeof(x), char),	\
-			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
-			((void)0)))))))
-
-#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
-	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
-	__builtin_types_compatible_p(typeof(x), unsigned type),		\
-	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
-
-/**
- * reciprocal_scale - "scale" a value into range [0, ep_ro)
- * @val: value
- * @ep_ro: right open interval endpoint
- *
- * Perform a "reciprocal multiplication" in order to "scale" a value into
- * range [0, @ep_ro), where the upper interval endpoint is right-open.
- * This is useful, e.g. for accessing a index of an array containing
- * @ep_ro elements, for example. Think of it as sort of modulus, only that
- * the result isn't that of modulo. ;) Note that if initial input is a
- * small value, then result will return 0.
- *
- * Return: a result based on @val in interval [0, @ep_ro).
- */
-static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
-{
-	return (u32)(((u64) val * ep_ro) >> 32);
-}
-
 #if defined(CONFIG_MMU) && \
 	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
 #define might_fault() __might_fault(__FILE__, __LINE__)
@@ -502,18 +346,6 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
-u64 int_pow(u64 base, unsigned int exp);
-unsigned long int_sqrt(unsigned long);
-
-#if BITS_PER_LONG < 64
-u32 int_sqrt64(u64 x);
-#else
-static inline u32 int_sqrt64(u64 x)
-{
-	return (u32)int_sqrt(x);
-}
-#endif
-
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
diff --git a/include/linux/math.h b/include/linux/math.h
new file mode 100644
index 000000000000..53674a327e39
--- /dev/null
+++ b/include/linux/math.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MATH_H
+#define _LINUX_MATH_H
+
+#include <asm/div64.h>
+#include <uapi/linux/kernel.h>
+
+/*
+ * This looks more complex than it should be. But we need to
+ * get the type for the ~ right in round_down (it needs to be
+ * as wide as the result!), and we want to evaluate the macro
+ * arguments just once each.
+ */
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+
+/**
+ * round_up - round up to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round up to (must be a power of 2)
+ *
+ * Rounds @x up to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding up, use roundup() below.
+ */
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+
+/**
+ * round_down - round down to next specified power of 2
+ * @x: the value to round
+ * @y: multiple to round down to (must be a power of 2)
+ *
+ * Rounds @x down to next multiple of @y (which must be a power of 2).
+ * To perform arbitrary rounding down, use rounddown() below.
+ */
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
+#define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
+
+#define DIV_ROUND_DOWN_ULL(ll, d) \
+	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
+
+#define DIV_ROUND_UP_ULL(ll, d) \
+	DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
+
+#if BITS_PER_LONG == 32
+# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
+#else
+# define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP(ll,d)
+#endif
+
+/**
+ * roundup - round up to the next specified multiple
+ * @x: the value to up
+ * @y: multiple to round up to
+ *
+ * Rounds @x up to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_up().
+ */
+#define roundup(x, y) (					\
+{							\
+	typeof(y) __y = y;				\
+	(((x) + (__y - 1)) / __y) * __y;		\
+}							\
+)
+/**
+ * rounddown - round down to next specified multiple
+ * @x: the value to round
+ * @y: multiple to round down to
+ *
+ * Rounds @x down to next multiple of @y. If @y will always be a power
+ * of 2, consider using the faster round_down().
+ */
+#define rounddown(x, y) (				\
+{							\
+	typeof(x) __x = (x);				\
+	__x - (__x % (y));				\
+}							\
+)
+
+/*
+ * Divide positive or negative dividend by positive or negative divisor
+ * and round to closest integer. Result is undefined for negative
+ * divisors if the dividend variable type is unsigned and for negative
+ * dividends if the divisor variable type is unsigned.
+ */
+#define DIV_ROUND_CLOSEST(x, divisor)(			\
+{							\
+	typeof(x) __x = x;				\
+	typeof(divisor) __d = divisor;			\
+	(((typeof(x))-1) > 0 ||				\
+	 ((typeof(divisor))-1) > 0 ||			\
+	 (((__x) > 0) == ((__d) > 0))) ?		\
+		(((__x) + ((__d) / 2)) / (__d)) :	\
+		(((__x) - ((__d) / 2)) / (__d));	\
+}							\
+)
+/*
+ * Same as above but for u64 dividends. divisor must be a 32-bit
+ * number.
+ */
+#define DIV_ROUND_CLOSEST_ULL(x, divisor)(		\
+{							\
+	typeof(divisor) __d = divisor;			\
+	unsigned long long _tmp = (x) + (__d) / 2;	\
+	do_div(_tmp, __d);				\
+	_tmp;						\
+}							\
+)
+
+/*
+ * Multiplies an integer by a fraction, while avoiding unnecessary
+ * overflow or loss of precision.
+ */
+#define mult_frac(x, numer, denom)(			\
+{							\
+	typeof(x) quot = (x) / (denom);			\
+	typeof(x) rem  = (x) % (denom);			\
+	(quot * (numer)) + ((rem * (numer)) / (denom));	\
+}							\
+)
+
+#define sector_div(a, b) do_div(a, b)
+
+/**
+ * abs - return absolute value of an argument
+ * @x: the value.  If it is unsigned type, it is converted to signed type first.
+ *     char is treated as if it was signed (regardless of whether it really is)
+ *     but the macro's return type is preserved as char.
+ *
+ * Return: an absolute value of x.
+ */
+#define abs(x)	__abs_choose_expr(x, long long,				\
+		__abs_choose_expr(x, long,				\
+		__abs_choose_expr(x, int,				\
+		__abs_choose_expr(x, short,				\
+		__abs_choose_expr(x, char,				\
+		__builtin_choose_expr(					\
+			__builtin_types_compatible_p(typeof(x), char),	\
+			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
+			((void)0)))))))
+
+#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
+	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
+	__builtin_types_compatible_p(typeof(x), unsigned type),		\
+	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
+
+/**
+ * reciprocal_scale - "scale" a value into range [0, ep_ro)
+ * @val: value
+ * @ep_ro: right open interval endpoint
+ *
+ * Perform a "reciprocal multiplication" in order to "scale" a value into
+ * range [0, @ep_ro), where the upper interval endpoint is right-open.
+ * This is useful, e.g. for accessing a index of an array containing
+ * @ep_ro elements, for example. Think of it as sort of modulus, only that
+ * the result isn't that of modulo. ;) Note that if initial input is a
+ * small value, then result will return 0.
+ *
+ * Return: a result based on @val in interval [0, @ep_ro).
+ */
+static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
+{
+	return (u32)(((u64) val * ep_ro) >> 32);
+}
+
+u64 int_pow(u64 base, unsigned int exp);
+unsigned long int_sqrt(unsigned long);
+
+#if BITS_PER_LONG < 64
+u32 int_sqrt64(u64 x);
+#else
+static inline u32 int_sqrt64(u64 x)
+{
+	return (u32)int_sqrt(x);
+}
+#endif
+
+#endif	/* _LINUX_MATH_H */
diff --git a/include/linux/rcu_node_tree.h b/include/linux/rcu_node_tree.h
index b8e094b125ee..78feb8ba7358 100644
--- a/include/linux/rcu_node_tree.h
+++ b/include/linux/rcu_node_tree.h
@@ -20,6 +20,8 @@
 #ifndef __LINUX_RCU_NODE_TREE_H
 #define __LINUX_RCU_NODE_TREE_H
 
+#include <linux/math.h>
+
 /*
  * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
  * CONFIG_RCU_FANOUT_LEAF.
diff --git a/include/linux/units.h b/include/linux/units.h
index aaf716364ec3..5c115c809507 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_UNITS_H
 #define _LINUX_UNITS_H
 
-#include <linux/kernel.h>
+#include <linux/math.h>
 
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
diff --git a/lib/errname.c b/lib/errname.c
index 0c4d3e66170e..05cbf731545f 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -3,6 +3,7 @@
 #include <linux/errno.h>
 #include <linux/errname.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 
 /*
  * Ensure these tables do not accidentally become gigantic if some
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 4a8751010d59..f67f86fd2f62 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -15,8 +15,9 @@
 #include <linux/bitops.h>
 #include <linux/bitmap.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
+#include <linux/swab.h>
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) ||			\
 	!defined(find_next_bit_le) || !defined(find_next_zero_bit_le) ||	\
diff --git a/lib/math/div64.c b/lib/math/div64.c
index 368ca7fd0d82..259303233610 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -18,8 +18,9 @@
  * or by defining a preprocessor macro in arch/include/asm/div64.h.
  */
 
+#include <linux/bitops.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/math64.h>
 
 /* Not needed on 64bit architectures */
diff --git a/lib/math/int_pow.c b/lib/math/int_pow.c
index 622fc1ab3c74..0cf426e69bda 100644
--- a/lib/math/int_pow.c
+++ b/lib/math/int_pow.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/types.h>
 
 /**
diff --git a/lib/math/int_sqrt.c b/lib/math/int_sqrt.c
index 30e0f9770f88..a8170bb9142f 100644
--- a/lib/math/int_sqrt.c
+++ b/lib/math/int_sqrt.c
@@ -6,9 +6,10 @@
  *  square root from Guy L. Steele.
  */
 
-#include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/bitops.h>
+#include <linux/limits.h>
+#include <linux/math.h>
 
 /**
  * int_sqrt - computes the integer square root
diff --git a/lib/math/reciprocal_div.c b/lib/math/reciprocal_div.c
index 32436dd4171e..65ee372d9d06 100644
--- a/lib/math/reciprocal_div.c
+++ b/lib/math/reciprocal_div.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
 #include <linux/bug.h>
-#include <linux/kernel.h>
-#include <asm/div64.h>
-#include <linux/reciprocal_div.h>
 #include <linux/export.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
+#include <linux/types.h>
+
+#include <linux/reciprocal_div.h>
 
 /*
  * For a description of the algorithm please have a look at
-- 
2.24.1

