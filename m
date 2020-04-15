Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C42BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E536520737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408534AbgDOKlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:41:32 -0400
Received: from mx.sdf.org ([205.166.94.20]:55862 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406608AbgDOKlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:41:08 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 03FAewKx008805
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Wed, 15 Apr 2020 10:40:58 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 03FAevoY025706;
        Wed, 15 Apr 2020 10:40:57 GMT
Date:   Wed, 15 Apr 2020 10:40:57 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        lkml@sdf.org
Subject: Additional get_random_* ideas
Message-ID: <20200415104057.GA13003@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=m
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've done a bunch of hacking on get_random_uXX, and I recently
thought of another possible way to reduce its cost.  I'd like to
ask for some second opinions on whether it's worth pursuing.

It takes around 1716 cycles to perform a chacha_block_generic()
operation (without SSE) on my machine.  That's 3.35 cycles per bit,
so reducing the number of bits consumed per output is worth something.

It's not too difficult to extend my technique for merging the u32 and
u64 batch pools into one that can return an arbitrary number of bits.  
This has a secondary benefit of merging a lot of duplicate code in 
get_random_u32() and get_random_u64().

There are a few direct applications for this (several places in the 
infiniband code want 24 bits), and get_random_max() can ask for an
appropriate number of bits.

I've worked out the math for the most efficient way to generate random 
numbers in an arbitrary range.  E.g. to generate a number uniformly 
distributed mod 5, we can generate 3 random bits and retry with 
probability 3/8 (expected # of bits = 3 * 8/5 = 4.8), or 4 random bits and 
retry with probability 1/16 (expected # of bits 4 * 16/15 = 4.266).  
Generating 7 random bits and retrying with probability 3/128 is not worth 
it (expected # of bits 7 * 128/125 = 7.168), but increasing the cost per 
attempt to account for other overhead might change that.

(Of course, this level of fine-tuning is only practical when the range
is a compile-time constant.  I have yet to figure out how much
is worth doing with non-constant ranges,)

I've also worked out that Lemire's multiplicative method can ignore extra 
low-order bits in the input random number.  If we want to use 12 bits to 
generate a random number mod K, use 32 bits to generate a random number 
mod K << (32 - 12), then shift the result right 32 - 12 = 20 bits.  The 
final output depends only on the high 12 bits of the random input.


Anyway, the core function looks like this.  Any opinions on whether this
is worth pursuing?

#define CHACHA_BIT_SIZE (CHACHA_BLOCK_SIZE * 8)
#define LONG_AT(base,offset) *(unsigned long *)((void *)(base) + (offset))
/*
 * Return an unsigned long, with the most significant nbits holding
 * batched entropy.  The lsbits must be ignored, and must NOT be leaked.
 *
 * (This odd convention turns out to be convenient for both
 * get_random_bits() and get_random_max().  It's unfortunately
 * not convenient for get_random_u32().)
 *
 * This uses an XOR trick to read from an arbitrary bit position in the
 * batch buffer.  A fresh random bit is defined as one uncorrelated with
 * anything except the (carefully-guarded) ChaCha key.  Once a fresh
 * bit is output, it becomes stale, and we assume an attacker knows
 * it completely.
 *
 * If *either* X or Y are fresh random bits, then X^Y is a fresh random
 * bit.  If *both* X and Y are fresh random bits, then after disclosing
 * X^Y, one of X and Y is stale, but not both.
 *
 * If X is fresh, then X^Y is fresh, X is now stale, and Y is unchanged.
 * If X is stale, then X^Y is fresh, and Y is now stale.
 *
 * Now apply this 64x across two words.  The first word (X) is consumed
 * msbit-first, so consists of 1..64 stale msbits. followed by 0..63
 * fresh lsbits.  The second word Y is all fresh.
 *
 * To get n bits, we XOR that word with the following (all-fresh) word,
 * and rotate the result left by the number of stale bits in X, so that
 * the fresh bits in X start at bit 63.  To the right of the fresh bits
 * in X are the stale msbits, XORed with the fresh msbits of Y.
 *
 * The result is 64 fresh bits, but the accounting assumes the lsbits past
 * the requested number will not be exposed, so remain fresh.
 *
 * The one exception occurs if X is the last word in the batch buffer,
 * and the number of bits required is not enough to warrant refilling.
 * In that case, Y is the stale word past the end of the buffer
 * (containing the ChaCha sequence number), but the returnd msbits are
 * all fresh because they've been XORed with the fresh lsbits of X.
 */
unsigned long __get_random_bits(unsigned nbits)
{
	unsigned long flags, ret;
	unsigned pos;	/* Bit offset in entropy array */
	size_t offset;	/* Byte offset */
	struct batched_entropy *batch;
	static void *previous;

	WARN_ON(nbits > BITS_PER_LONG);

	warn_unseeded_randomness(&previous);

	local_irq_save(flags);	/* Disables preemption */
	batch = this_cpu_ptr(&batched_entropy);
	pos = batch->position;
	if (unlikely(batch->crng_init != crng_init)) {
		batch->seqno = raw_smp_processor_id() + 1;
		batch->crng_init = crng_init;
		pos = CHACHA_BIT_SIZE - 1;
	}
	/* Convert to byte offset and round down to previous word */
	offset = pos / 8 & -sizeof(ret);
	/* First word, 0..63 lsbits fresh */
	ret = LONG_AT(batch->entropy8, offset);
	offset += sizeof(ret);
	pos += nbits;
	batch->position = pos & (CHACHA_BIT_SIZE - 1);
	/* GCC optimizes assuming <=10% taken, true if avg nbits <= 51 */
	if (unlikely(pos >= CHACHA_BIT_SIZE)) {
		batch_refill(batch);
		offset = 0;
	}
	/* Second word, all-fresh (with one exception described above) */
	ret ^= LONG_AT(batch->entropy8, offset);
	local_irq_restore(flags);

	/* Rotate to msbits */
	pos &= BITS_PER_LONG - 1;
	return ret << pos | ret >> (BITS_PER_LONG - pos);
}
EXPORT_SYMBOL(__get_random_bits);

/**
 * get_random_bits() - Return some strong random bits
 * @nbits:	The number of bits to return (1 <= @nbits <= %BITS_PER_LONG)
 *
 * This is cryptographically secure, but significantly faster than
 * get_random_bytes() because it generates output in laarge batches and
 * divides it up as required.
 *
 * This requires omitting backtracking protection.  For most applications
 * of secure random numbers, this is ...FIXME: Keep writing...
 *
 * Context: Any context except NMI as long as crng_ready() is true.
 *          Does not sleep.
 * Return: A random value between 0 and 1ul << @nbits - 1.
 *         The valus is cryptographically secure, but not backtrack-
 *         resistant; if you need a value to remain secret after
 *	   memxero_explicit(), use get_random_bytes().
 */
unsigned long get_random_bits(unsigned nbits)
{
	return __get_random_bits(nbits) >> (BITS_PER_LONG - nbits);
}
EXPORT_SYMBOL(get_random_bits);

u32 get_random_u32(void)
{
	return __get_random_bits(32) >> (BITS_PER_LONG - 32);
}
EXPORT_SYMBOL(get_random_u32);

u64 get_random_u64(void)
{
#if BITS_PER_LONG == 64
	return __get_random_bits(64);
#elif BITS_PER_LONG == 32
	/*
	 * This is inefficient, but get_random_u64() is rarely used
	 * on 32-bit machines.
	 */
	return (u64)__get_random_bits(32) << 32 | __get_random_bits(32);
#endif
}
EXPORT_SYMBOL(get_random_u64);

