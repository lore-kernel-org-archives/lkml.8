Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC16C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117F220661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApU/vVwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWNFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:05:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22953 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgAWNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579784749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOllmzIKdaxzfbLMtzGveFQrfLS3AwRoYSni7we4yEs=;
        b=ApU/vVwxo3RGxPqHKyAZdmAwHoBPAQbsMmhktHwMohlzCsSp0ApDQ2sRHFtv596kbJcmqh
        kR/U+mAgA30kFlJFVbYECUuprJ/UaSYWRSsjmI/UiEkmBD2fd08Dz+eeByrdZFdZ84DyH9
        DfdjdyejJEDlUvahp8Dh003F6avrlq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-GUzTr4qCM0yei0D7jldxbQ-1; Thu, 23 Jan 2020 08:05:47 -0500
X-MC-Unique: GUzTr4qCM0yei0D7jldxbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF7E107ACC7;
        Thu, 23 Jan 2020 13:05:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D37B1001902;
        Thu, 23 Jan 2020 13:05:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 23 Jan 2020 14:05:46 +0100 (CET)
Date:   Thu, 23 Jan 2020 14:05:41 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20200123130541.GA30620@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20200122164612.GA19818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122164612.GA19818@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22, Oleg Nesterov wrote:
>
> But there is another reason why I think it makes more sense. It is also
> faster on x86-64, much faster when the numbers are big. See the naive
> test code below. For example,
>
> 	$ ./test 553407856289849 18446744066259977121 1660223568869547
> 	553407856289849 * 18446744066259977121 / 1660223568869547 =
> 		(128) 6148914688753325707
> 		(asm) 6148914688753325707
> 		(new) 6148914691236512239
> 		(old) 9067034312525142184
>
> 	ticks:
> 		asm: 7183908591
> 		new: 4891383871
> 		old: 23585547775

Just for completeness, see the updated code which can be compiled with -m32.
As expected, my version is slower on 32-bit when the numbers are small,

	$ ./test 1 3 2
	1 * 3 / 2 =
		(new) 1
		(old) 1

	ticks:
		new: 3624344961
		old: 2514403456

But still faster when rtime is big enough:

	$ ./test 1 68719476736 2
	1 * 68719476736 / 2 =
		(new) 34359738368
		(old) 34359738368

	ticks:
		new: 5044284834
		old: 5347969883

	$ ./test 553407856289849 18446744066259977121 1660223568869547
	553407856289849 * 18446744066259977121 / 1660223568869547 =
		(new) 6148914691236512239
		(old) 9067034312525142184

	ticks:
		new: 11496181242
		old: 33622910386

Oleg.

------------------------------------------------------------------------------
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#define   noinline                      __attribute__((__noinline__))

typedef unsigned long long u64;
typedef unsigned int u32;

#ifdef __x86_64__
typedef unsigned __int128 u128;

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
#else // 32-bit
static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
{
	union {
		u64 v64;
		u32 v32[2];
	} d = { dividend };
	u32 upper;

	upper = d.v32[1];
	d.v32[1] = 0;
	if (upper >= divisor) {
		d.v32[1] = upper / divisor;
		upper %= divisor;
	}
	asm ("divl %2" : "=a" (d.v32[0]), "=d" (*remainder) :
		"rm" (divisor), "0" (d.v32[0]), "1" (upper));
	return d.v64;
}

static inline u64 div_u64(u64 dividend, u32 divisor)
{
	u32 remainder;
	return div_u64_rem(dividend, divisor, &remainder);
}

static inline int fls(unsigned int x)
{
	int r;

	asm("bsrl %1,%0\n\t"
	    "cmovzl %2,%0"
	    : "=&r" (r) : "rm" (x), "rm" (-1));

	return r + 1;
}
static inline int fls64(u64 x)
{
	u32 h = x >> 32;
	if (h)
		return fls(h) + 32;
	return fls(x);
}

u64 noinline div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
{
	u32 high = divisor >> 32;
	u64 quot;

	if (high == 0) {
		u32 rem32;
		quot = div_u64_rem(dividend, divisor, &rem32);
		*remainder = rem32;
	} else {
		int n = fls(high);
		quot = div_u64(dividend >> n, divisor >> n);

		if (quot != 0)
			quot--;

		*remainder = dividend - quot * divisor;
		if (*remainder >= divisor) {
			quot++;
			*remainder -= divisor;
		}
	}

	return quot;
}
u64 noinline div64_u64(u64 dividend, u64 divisor)
{
	u32 high = divisor >> 32;
	u64 quot;

	if (high == 0) {
		quot = div_u64(dividend, divisor);
	} else {
		int n = fls(high);
		quot = div_u64(dividend >> n, divisor >> n);

		if (quot != 0)
			quot--;
		if ((dividend - quot * divisor) >= divisor)
			quot++;
	}

	return quot;
}
#endif

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
#ifdef __x86_64__
		printf("\t(128) %lld\n", (u64)( ((u128)S)*((u128)R)/((u128)T) ));
		printf("\t(asm) %lld\n", mul_u64_u64_div_u64(S,R,T));
#endif
		printf("\t(new) %lld\n", new_scale_stime(S,R,T));
		printf("\t(old) %lld\n", scale_stime(S,R,T));
		printf("\n");
	}

	printf("ticks:\n");
#ifdef __x86_64__
	printf("\tasm: %lld\n", profile(mul_u64_u64_div_u64));
#endif
	printf("\tnew: %lld\n", profile(new_scale_stime));
	printf("\told: %lld\n", profile(scale_stime));

	return 0;
}

