Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87F0C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08EF20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCLLii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:38:38 -0400
Received: from mx.sdf.org ([205.166.94.20]:49663 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLLii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:38:38 -0400
Received: from sdf.org (IDENT:lkml@rie.sdf.org [205.166.94.4])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02CBcCeQ020700
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Thu, 12 Mar 2020 11:38:12 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02CBcAI3021715;
        Thu, 12 Mar 2020 11:38:10 GMT
Date:   Thu, 12 Mar 2020 11:38:10 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     chris@chris-wilson.co.uk
Cc:     Lukas Wunner <lukas@wunner.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, lkml@sdf.org
Subject: [CODE] lib/math/prime_numbers.c: halve memory usage
Message-ID: <20200312113810.GA11889@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran across the prime number generator, and after wondering WTF it was 
doing in the kernel (it turns out it's used by some of the GPU self-tests
and not routine kernel operation), noticed it could use some optimization.

In particular, a tiny bit of special-case code to handle the prime 2
lets you limit the bitmap to odd numbers, which halves the memory usage.

There are ways to do better; if you special-case 2, 3 and 5, then you
can halve memory usage again because all other primes fall into 8 residue 
classes mod 30, but that comes with a significant code-size increase.

Two other optimizations I folded in:
- Start clearing the sieve at p**2, since any smaller composite
  has smaller factors than p and has already been excluded.
- In slow_is_prime_number(), do trial division starting with the
  smallest divisors, since they are most likely to terminate
  the loop.

What follows is my current code, in a test harness for user-space testing.
The "#if 0" sections comment out kernel-only code, and the #else
sections provide the necessary stubs to let the code be compiled
as a standalone executable.  Changing that to #if 1 produces a kernel
source file.

Comments?

One change I'm thinking of making is choosing the array sizes  
so sizeof(struct primes) + bitmap_size(primes->sz) is a power of
2 in size.  That's slightly more than doubling each iteration.

--- 8< --- cut here --- 8< ---
// SPDX-License-Identifier: GPL-2.0-only
#define pr_fmt(fmt) "prime numbers: " fmt "\n"

# if 0
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/prime_numbers.h>
#include <linux/slab.h>
#else
#include <assert.h>
#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#if ULONG_MAX == 0xffffffff
#define BITS_PER_LONG 32
#else
#define BITS_PER_LONG 64
#endif
#define BITS_TO_LONGS(x) ((size_t)((x) + BITS_PER_LONG - 1)/BITS_PER_LONG)
struct rcu_head { };

#define DEFINE_MUTEX(lock) struct rcu_head lock;
#define mutex_lock(lock) (void)(lock)
#define mutex_unlock(lock) (void)(lock)
#define __rcu /*nothing*/
#define RCU_INITIALIZER(x) (x)
#define rcu_read_lock() (void)0
#define rcu_read_unlock() (void)0
#define rcu_dereference(x) (x)
#define rcu_dereference_protected(p, c) (p)
#define rcu_assign_pointer(ptr, new) ((ptr) = (new))

static inline unsigned long __fls(unsigned long word)
{
        return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
}
static inline unsigned long __ffs(unsigned long word)
{
        return __builtin_ctzl(word);
}


static unsigned long int_sqrt(unsigned long x)
{
        unsigned long b, m, y = 0;

        if (x <= 1)
                return x;

        m = 1UL << (__fls(x) & ~1UL);
        while (m != 0) {
                b = y + m;
                y >>= 1;

                if (x >= b) {
                        x -= b;
                        y += m;
                }
                m >>= 2;
        }

        return y;
}

#define BUG_ON(x) assert(!(x))
#define round_up(x, y) ((((x) - 1) | ((unsigned long)(y) - 1)) + 1)
#define round_down(x, y) ((x)  & ~((unsigned long)(y) - 1))
#define roundup(x, y) (((x) + ((y) - 1)) / (y) * (y))
#define kmalloc(size, flags) malloc(size)
#define kfree free
#define kfree_rcu(ptr, rcu) free(ptr)

#define BIT(x) (1ul << (x))
#define BIT_MASK(b) BIT((b) & (BITS_PER_LONG - 1))
#define BIT_WORD(b) ((b) / BITS_PER_LONG)
static inline void __clear_bit(int nr, volatile unsigned long *addr)
{
        unsigned long mask = BIT_MASK(nr);
        unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

        *p &= ~mask;
}
static inline int test_bit(int nr, const volatile unsigned long *addr)
{
        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}


static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
{
        unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
        memset(dst, 0xff, len);
}

static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
                        unsigned int nbits)
{
        unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
        memcpy(dst, src, len);
}

#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
#define unlikely(x)     __builtin_expect(x, 0)
#define likely(x)       __builtin_expect(!!(x), 1)

static unsigned long min(unsigned long x, unsigned long y)
{
	return x < y ? x : y;
}
static inline unsigned long find_next_bit(const unsigned long *addr1,
                unsigned long nbits, unsigned long start)
{
        unsigned long tmp;

        if (unlikely(start >= nbits))
                return nbits;

        tmp = addr1[start / BITS_PER_LONG];

        /* Handle 1st word. */
        tmp &= BITMAP_FIRST_WORD_MASK(start);
        start = round_down(start, BITS_PER_LONG);

        while (!tmp) {
                start += BITS_PER_LONG;
                if (start >= nbits)
                        return nbits;

                tmp = addr1[start / BITS_PER_LONG];
        }

        return min(start + __ffs(tmp), nbits);
}

#define EXPORT_SYMBOL(x) /*nothing*/

#endif

#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))

struct primes {
	struct rcu_head rcu;
	unsigned long last, sz;
	unsigned long primes[];
};

/*
 * The bitmap stores odd numbers.  Bit i corresponds to
 * the integer 2*i+1.  sz is the number of bits in the array.
 * last is the index of the last set bit (greatest prime).
 */
static const struct primes small_primes = {
	.last = (127-1)/2,
	.sz = 64,
	.primes = {
		BIT((3 - 1)/2) |
		BIT((5 - 1)/2) |
		BIT((7 - 1)/2) |
		BIT((11 - 1)/2) |
		BIT((13 - 1)/2) |
		BIT((17 - 1)/2) |
		BIT((19 - 1)/2) |
		BIT((23 - 1)/2) |
		BIT((29 - 1)/2) |
		BIT((31 - 1)/2) |
		BIT((37 - 1)/2) |
		BIT((41 - 1)/2) |
		BIT((43 - 1)/2) |
		BIT((47 - 1)/2) |
		BIT((53 - 1)/2) |
		BIT((59 - 1)/2) |
#if BITS_PER_LONG == 64
		BIT((61 - 1)/2) |
		BIT((67 - 1)/2) |
		BIT((71 - 1)/2) |
		BIT((73 - 1)/2) |
		BIT((79 - 1)/2) |
		BIT((83 - 1)/2) |
		BIT((89 - 1)/2) |
		BIT((97 - 1)/2) |
		BIT((101 - 1)/2) |
		BIT((103 - 1)/2) |
		BIT((107 - 1)/2) |
		BIT((109 - 1)/2) |
		BIT((113 - 1)/2) |
		BIT((127 - 1)/2)
#elif BITS_PER_LONG == 32
		BIT((61 - 1)/2),
		BIT((67 - 65)/2) |
		BIT((71 - 65)/2) |
		BIT((73 - 65)/2) |
		BIT((79 - 65)/2) |
		BIT((83 - 65)/2) |
		BIT((89 - 65)/2) |
		BIT((97 - 65)/2) |
		BIT((101 - 65)/2) |
		BIT((103 - 65)/2) |
		BIT((107 - 65)/2) |
		BIT((109 - 65)/2) |
		BIT((113 - 65)/2) |
		BIT((127 - 65)/2)
#else
#error "unhandled BITS_PER_LONG"
#endif
	}
};

static DEFINE_MUTEX(lock);
static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);

static unsigned long selftest_max;

/*
 * Fallback test if we can't allocate a sieve.
 * The argument is guaranteed odd, and larger than
 * the small_primes limit.
 */
static bool slow_is_prime_number(unsigned long x)
{
	unsigned i, y = int_sqrt(x);

	assert(0);

	for (i = 3; i < y; i += 2)
		if (x % i == 0)
			return false;
	return true;
}

/*
 * Fallback test if we can't allocate a sieve.
 * The argument is guaranteed odd, and larger than
 * the small_primes limit.
 */
static unsigned long slow_next_prime_number(unsigned long x)
{
	while (x < ULONG_MAX && !slow_is_prime_number(x += 2))
		;

	return x;
}

/*
 * Return the index of the last set bit in the region.  The bit is
 * guaranteed to exist, so there's no need to check for array underrun.
 */
static unsigned long
find_last_bit(const unsigned long *addr, unsigned long size)
{
	unsigned long x, idx = BIT_WORD(size);

	do
		x = addr[--idx];
	while (!x);
	return idx * BITS_PER_LONG + __fls(x);
}

/*
 * Generate a new, larger, prime bitmap.
 * @x: the index of the number we're trying to look up.
 *
 * Called with rcu_read_lock held.  Drops it internally.
 * Returns true with it reacquired on success.
 * Returns false with it dropped on failure.
 */
static bool expand_to_next_prime(unsigned long x)
{
	const struct primes *p;
	struct primes *new;
	unsigned long sz, y;

	rcu_read_unlock();

	/* Betrand's Postulate (or Chebyshev's theorem) states that if n > 3,
	 * there is always at least one prime p between n and 2n - 2.
	 * Equivalently, if n > 1, then there is always at least one prime p
	 * such that n < p < 2n.
	 *
	 * http://mathworld.wolfram.com/BertrandsPostulate.html
	 * https://en.wikipedia.org/wiki/Bertrand's_postulate
	 */
	sz = 2 * x;
	if (sz < x)
		return false;

	sz = round_up(sz, BITS_PER_LONG);
	new = kmalloc(sizeof(*new) + bitmap_size(sz),
		      GFP_KERNEL | __GFP_NOWARN);
	if (!new)
		return false;

	mutex_lock(&lock);
	p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
	if (x < p->last) {	/* Recheck under lock */
		kfree(new);
		goto unlock;
	}

	new->sz = sz;
	bitmap_fill(new->primes, sz);
	bitmap_copy(new->primes, p->primes, p->sz);
	/*
	 * This is where all the magic happens.  For each prime z in
	 * the bitmap, starting at max(z**2, p->sz*2+1), clear the bits
	 * corresponding to multiples of z.  When z**2 exceeds the new
	 * size, we're done.
	 */
	y = 0;
	for (;;) {
		unsigned long z, m;

		y = find_next_bit(new->primes, sz, y + 1);
		m = 2 * y * (y + 1);	/* The index of (2*y+1)**2 */

		if (m >= sz)
			break;
		z = 2 * y + 1;	/* The prime corresponding to index y */
		if (m < p->sz)
			m = roundup(p->sz - y, z) + y;
		do {
			__clear_bit(m, new->primes);
			m += z;
		} while (m < sz);
	}
	new->last = find_last_bit(new->primes, sz);

	BUG_ON(new->last <= x);

	rcu_assign_pointer(primes, new);
	if (p != &small_primes)
		kfree_rcu((struct primes *)p, rcu);

unlock:
	mutex_unlock(&lock);
	rcu_read_lock();
	return true;
}

static void free_primes(void)
{
	const struct primes *p;

	mutex_lock(&lock);
	p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
	if (p != &small_primes) {
		rcu_assign_pointer(primes, &small_primes);
		kfree_rcu((struct primes *)p, rcu);
	}
	mutex_unlock(&lock);
}

/**
 * next_prime_number - return the next prime number
 * @x: the starting point for searching to test
 *
 * A prime number is an integer greater than 1 that is only divisible by
 * itself and 1.  The set of prime numbers is computed using the sieve of
 * Eratosthenes (on finding a prime, all multiples of that prime are removed
 * from the set) enabling a fast lookup of the next prime number larger than
 * @x. If the sieve fails (memory limitation), the search falls back to using
 * slow trial-divison, up to the value of ULONG_MAX (which is reported as the
 * final prime as a sentinel).
 *
 * Returns: the next prime number larger than @x
 */
unsigned long next_prime_number(unsigned long x)
{
	const struct primes *p;

	if (x < 2)
		return 2;
	x = (x - 1) >> 1;

	rcu_read_lock();
	while (x >= (p = rcu_dereference(primes))->last)
		if (!expand_to_next_prime(x))
			return slow_next_prime_number(2*x+3);
	x = find_next_bit(p->primes, p->last, x + 1);
	rcu_read_unlock();

	return 2*x+1;
}
EXPORT_SYMBOL(next_prime_number);

/**
 * is_prime_number - test whether the given number is prime
 * @x: the number to test
 *
 * A prime number is an integer greater than 1 that is only divisible by
 * itself and 1. Internally a cache of prime numbers is kept (to speed up
 * searching for sequential primes, see next_prime_number()), but if the number
 * falls outside of that cache, its primality is tested using trial-divison.
 *
 * Returns: true if @x is prime, false for composite numbers.
 */
bool is_prime_number(unsigned long x)
{
	const struct primes *p;
	bool result;

	if (x % 2 == 0)
		return x == 2;
	x >>= 1;

	rcu_read_lock();
	while (x >= (p = rcu_dereference(primes))->sz)
		if (!expand_to_next_prime(x))
			return slow_is_prime_number(2*x+1);
	result = test_bit(x, p->primes);
	rcu_read_unlock();

	return result;
}
EXPORT_SYMBOL(is_prime_number);

#if 0
static void dump_primes(void)
{
	const struct primes *p;
	char *buf;

	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);

	rcu_read_lock();
	p = rcu_dereference(primes);

	if (buf)
		bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s",
		p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);

	rcu_read_unlock();

	kfree(buf);
}

static int selftest(unsigned long max)
{
	unsigned long x, last;

	if (!max)
		return 0;

	for (last = 0, x = 2; x < max; x++) {
		bool slow = slow_is_prime_number(x);
		bool fast = is_prime_number(x);

		if (slow != fast) {
			pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!",
			       x, slow ? "yes" : "no", fast ? "yes" : "no");
			goto err;
		}

		if (!slow)
			continue;

		if (next_prime_number(last) != x) {
			pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu",
			       last, x, next_prime_number(last));
			goto err;
		}
		last = x;
	}

	pr_info("selftest(%lu) passed, last prime was %lu", x, last);
	return 0;

err:
	dump_primes();
	return -EINVAL;
}

static int __init primes_init(void)
{
	return selftest(selftest_max);
}

static void __exit primes_exit(void)
{
	free_primes();
}

module_init(primes_init);
module_exit(primes_exit);

module_param_named(selftest, selftest_max, ulong, 0400);

MODULE_AUTHOR("Intel Corporation");
MODULE_LICENSE("GPL");
#else
int
main(void)
{
	unsigned long x;

	for (x = 0; x < 1<<24; x = next_prime_number(x))
		printf("%lu\n", x);
	free_primes();
	return 0;
}
#endif
