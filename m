Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C46C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D1C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Li+x/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAVQq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:46:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgAVQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579711582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FabGVuxKiHCbNvVbTG0gCOELRL1g4LHkA7e8I9ZEE0=;
        b=h2Li+x/QoJc4+DwB0b6E67XiBtKsrpivRdU0kVKfn7C3mOKnJIVPre9BpBG4aLpxpAUqM5
        lWixlUPe995hfP9QzsmHLk2F8zwnUq7Kjxacxn2eUYiLL+f8j7rWCRAnRGGAOeXClk0lXH
        pxhGfdR4sadjc8mBqgTSMRkLMbOOI3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-ZVz3XBbRMDWfk6DxCOJ7eQ-1; Wed, 22 Jan 2020 11:46:18 -0500
X-MC-Unique: ZVz3XBbRMDWfk6DxCOJ7eQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B013A477;
        Wed, 22 Jan 2020 16:46:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7C5110016EB;
        Wed, 22 Jan 2020 16:46:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 22 Jan 2020 17:46:17 +0100 (CET)
Date:   Wed, 22 Jan 2020 17:46:12 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20200122164612.GA19818@redhat.com>
References: <20190718131834.GA22211@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718131834.GA22211@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, et al.

On 07/18, Oleg Nesterov wrote:
>
> People report that utime and stime from /proc/<pid>/stat become very wrong
> when the numbers are big enough. In particular, the monitored application
> can run all the time in user-space but only stime grows.

Let me reanimate this discussion and try again to convince you that
scale_stime() needs changes and this patch makes sense.

To remind, scale_stime(stime, rtime, total) is not precise, to say at
least. For example:

	stime = -1ul/33333; total = stime*3; rtime = total*5555555555;

scale_stime() returns 9067034312525142184 while the correct result is
6148914688753325707.

OK, these random numbers are not realistic, usually the relative error
is small enough.

However, even if the relative error is small, the absolute error can be
huge. And this means that if you watch /proc/$pid/status incrementally
to see how stime/utime grow, you can get the completely wrong numbers.

Say, utime (or stime) can be frozen for unpredictably long time, as if
the monitored application "hangs" in kernel mode, while the real split
is 50/50. The test-case from the changelog tries to demonstrate this,
see https://lore.kernel.org/lkml/20190718131834.GA22211@redhat.com/

Yes, yes, there are no 'real' stime and utime numbers. But still, why we
can't improve scale_stime()?

-------------------------------------------------------------------------------
Lets look at simplified (but less accurate) version I mentioned in
https://lore.kernel.org/lkml/20190718145549.GA22902@redhat.com

	u64 scale_stime(u64 stime, u64 rtime, u64 total)
	{
		u64 res = 0, div, rem;

		if (ilog2(stime) + ilog2(rtime) > 62) {
			div = div64_u64_rem(rtime, total, &rem);
			res = div * stime;
			rtime = rem;

			int shift = ilog2(stime) + ilog2(rtime) - 62;
			if (shift > 0) {
				rtime >>= shift;
				total >>= shift;
				if (!total)
					return res;
			}
		}

		return res + div64_u64(stime * rtime, total);
	}

It is much more accurate than the current version, in fact I think it
should be 100% accurate "in practice".

But there is another reason why I think it makes more sense. It is also
faster on x86-64, much faster when the numbers are big. See the naive
test code below. For example,

	$ ./test 553407856289849 18446744066259977121 1660223568869547
	553407856289849 * 18446744066259977121 / 1660223568869547 =
		(128) 6148914688753325707
		(asm) 6148914688753325707
		(new) 6148914691236512239
		(old) 9067034312525142184

	ticks:
		asm: 7183908591
		new: 4891383871
		old: 23585547775

(I am surprised it works faster than asm mul_u64_u64_div_u64() version
 on my machine, I don't understand why divq is so slow when rdx != 0).

I am going to send V2, I need to rewrite the changelog and comments.
But if you still think this doesn't worth fixing, please tell me right
now.

What do you think?

Oleg.

-------------------------------------------------------------------------------
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#define   noinline                      __attribute__((__noinline__))

typedef unsigned __int128 u128;
typedef unsigned long long u64;
typedef unsigned int u32;

u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
{
	u64 q;
	asm ("mulq %2; divq %3" : "=a" (q) : "a" (a), "rm" (b), "rm" (c) : "rdx");
	return q;
}

static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
{
	*remainder = dividend % divisor;
	return dividend / divisor;
}
static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
{
	*remainder = dividend % divisor;
	return dividend / divisor;
}
static inline u64 div64_u64(u64 dividend, u64 divisor)
{
	return dividend / divisor;
}
static inline u64 div_u64(u64 dividend, u32 divisor)
{
	u32 remainder;
	return div_u64_rem(dividend, divisor, &remainder);
}

static inline int fls64(u64 x)
{
	int bitpos = -1;
	/*
	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64 says the
	 * dest reg is undefined if x==0, but their CPU architect says its
	 * value is written to set it to the same as before.
	 */
	asm("bsrq %1,%q0"
	    : "+r" (bitpos)
	    : "rm" (x));
	return bitpos + 1;
}

static inline int ilog2(u64 n)
{
	return fls64(n) - 1;
}

#define swap(a, b) \
	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)

u64 scale_stime(u64 stime, u64 rtime, u64 total)
{
	u64 scaled;

	for (;;) {
		/* Make sure "rtime" is the bigger of stime/rtime */
		if (stime > rtime)
			swap(rtime, stime);

		/* Make sure 'total' fits in 32 bits */
		if (total >> 32)
			goto drop_precision;

		/* Does rtime (and thus stime) fit in 32 bits? */
		if (!(rtime >> 32))
			break;

		/* Can we just balance rtime/stime rather than dropping bits? */
		if (stime >> 31)
			goto drop_precision;

		/* We can grow stime and shrink rtime and try to make them both fit */
		stime <<= 1;
		rtime >>= 1;
		continue;

drop_precision:
		/* We drop from rtime, it has more bits than stime */
		rtime >>= 1;
		total >>= 1;
	}

	/*
	 * Make sure gcc understands that this is a 32x32->64 multiply,
	 * followed by a 64/32->64 divide.
	 */
	scaled = div_u64((u64) (u32) stime * (u64) (u32) rtime, (u32)total);
	return scaled;
}

u64 new_scale_stime(u64 stime, u64 rtime, u64 total)
{
	u64 res = 0, div, rem;

	if (ilog2(stime) + ilog2(rtime) > 62) {
		div = div64_u64_rem(rtime, total, &rem);
		res = div * stime;
		rtime = rem;

		int shift = ilog2(stime) + ilog2(rtime) - 62;
		if (shift > 0) {
			rtime >>= shift;
			total >>= shift;
			if (!total)
				return res;
		}
	}

	return res + div64_u64(stime * rtime, total);
}

static inline u64 rdtsc(void)
{
	unsigned low, high;
	asm volatile("rdtsc" : "=a" (low), "=d" (high));
	return ((low) | ((u64)(high) << 32));
}

u64 S, R, T;

u64 noinline profile(u64 (*f)(u64,u64,u64))
{
//	u64 s = S, r = R, t = T;
	u64 tsc1, tsc2;
	int i;

	tsc1 = rdtsc();

	for (i = 0; i < 100*1000*1000; ++i)
//		f(s++, r++, t++);
		f(S,R,T);

	tsc2 = rdtsc();

	return tsc2 - tsc1;
}


int main(int argc, char **argv)
{
	if (argc != 4) {
		printf("usage: %s stime rtime total\n", argv[0]);
		return 1;
	}

	S = strtoull(argv[1], NULL, 0);
	R = strtoull(argv[2], NULL, 0);
	T = strtoull(argv[3], NULL, 0);
	assert(S < T);
	assert(T < R);

	if (1) {
		printf("%llu * %llu / %llu =\n", S,R,T);
		printf("\t(128) %lld\n", (u64)( ((u128)S)*((u128)R)/((u128)T) ));
		printf("\t(asm) %lld\n", mul_u64_u64_div_u64(S,R,T));
		printf("\t(new) %lld\n", new_scale_stime(S,R,T));
		printf("\t(old) %lld\n", scale_stime(S,R,T));
		printf("\n");
	}

	printf("ticks:\n");
	printf("\tasm: %lld\n", profile(mul_u64_u64_div_u64));
	printf("\tnew: %lld\n", profile(new_scale_stime));
	printf("\told: %lld\n", profile(scale_stime));

	return 0;
}

