Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0109AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1512072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D458rqow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbgAXPmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:42:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44192 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388413AbgAXPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579880564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5bFuZ0SiT52ZPL/1PeCQU/YLgXCIyKTMGysNcGIN+4=;
        b=D458rqowUHJRcUYeXsG6VLg9LaHZ/PpxcmoLELWsB8WH6FbQ0WDFi8un0S5Ty3G1u4XFoG
        mlfJRk9ZtHn+XKkopB9slCDz99v1ox3shPYaTtNnub0GA0z0dQql6nEIKYgY6gJ3LperZM
        0ceRdKYyocBaIPRh5YERIwGQ5u2jQoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-QjC-qiKAOdqYKeXyG8sOhQ-1; Fri, 24 Jan 2020 10:42:27 -0500
X-MC-Unique: QjC-qiKAOdqYKeXyG8sOhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B1013C2B9;
        Fri, 24 Jan 2020 15:42:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id C81F15DA2C;
        Fri, 24 Jan 2020 15:42:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Jan 2020 16:42:19 +0100 (CET)
Date:   Fri, 24 Jan 2020 16:42:15 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20200124154215.GA14714@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20200122164612.GA19818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122164612.GA19818@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22, Oleg Nesterov wrote:
>
> To remind, scale_stime(stime, rtime, total) is not precise, to say at
> least. For example:
>
> 	stime = -1ul/33333; total = stime*3; rtime = total*5555555555;
>
> scale_stime() returns 9067034312525142184 while the correct result is
> 6148914688753325707.
>
> OK, these random numbers are not realistic, usually the relative error
> is small enough.
>
> However, even if the relative error is small, the absolute error can be
> huge. And this means that if you watch /proc/$pid/status incrementally
> to see how stime/utime grow, you can get the completely wrong numbers.
>
> Say, utime (or stime) can be frozen for unpredictably long time, as if
> the monitored application "hangs" in kernel mode, while the real split
> is 50/50.

See another test-case below. Arguments:

	start_time start_utime_percent inc_time inc_utime_percent

For example,

	$ ./test 8640000 50 600 50 | head

simulates process which runs 100 days 50/50 in user/kernel mode, then it
starts to check utime/stime every 600 seconds and print the difference.

The output:

               old               	               new
               0:600000000000    	    300000000000:300000000000
               0:600000000000    	    300000000000:300000000000
               0:600000000000    	    300000000000:300000000000
    600000000000:0               	    300000000000:300000000000
    499469920248:100530079752    	    300000000000:300000000000
               0:600000000000    	    300000000000:300000000000
               0:600000000000    	    300000000000:300000000000
    600000000000:0               	    300000000000:300000000000
    499490181588:100509818412    	    300000000000:300000000000


it looks as if this process can spend 20 minutes entirely in kernel mode.

Oleg.

-------------------------------------------------------------------------------
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#define   noinline                      __attribute__((__noinline__))

typedef unsigned long long u64;
typedef unsigned int u32;
typedef unsigned __int128 u128;

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

struct task_cputime {
	u64				stime;
	u64				utime;
	unsigned long long		sum_exec_runtime;
};
struct prev_cputime {
	u64				utime;
	u64				stime;
};

void cputime_adjust(int new, struct task_cputime *curr, struct prev_cputime *prev,
		    u64 *ut, u64 *st)
{
	u64 rtime, stime, utime;

	rtime = curr->sum_exec_runtime;

	if (prev->stime + prev->utime >= rtime)
		goto out;

	stime = curr->stime;
	utime = curr->utime;

	if (stime == 0) {
		utime = rtime;
		goto update;
	}

	if (utime == 0) {
		stime = rtime;
		goto update;
	}

	stime = (new ? new_scale_stime : scale_stime)(stime, rtime, stime + utime);

update:
	if (stime < prev->stime)
		stime = prev->stime;
	utime = rtime - stime;

	if (utime < prev->utime) {
		utime = prev->utime;
		stime = rtime - utime;
	}

	prev->stime = stime;
	prev->utime = utime;
out:
	*ut = prev->utime;
	*st = prev->stime;
}

void prdiff(int new, struct task_cputime *curr, struct prev_cputime *prev)
{
	struct prev_cputime __prev = *prev;
	u64 ut, st, ud, sd;

	cputime_adjust(new, curr, prev, &ut, &st);
	ud = ut - __prev.utime;
	sd = st - __prev.stime;

	printf("%16llu:%-16llu", ud, sd);
}

#define SEC	1000000000ULL

void parse_cputime(struct task_cputime *t, char **argv)
{
	double total = strtod(argv[0], NULL) * SEC;
	double utime = strtod(argv[1], NULL) / 100;

	utime *= total;
	t->utime = utime;
	t->stime = total - utime;
}

int main(int argc, char **argv)
{
	struct prev_cputime old_prev = {};
	struct prev_cputime new_prev = {};
	struct task_cputime curr, diff;
	u64 tmp;

	if (argc != 5) {
		printf("usage: %s start_time utime_percent inc_time utime_percent\n", argv[0]);
		return 0;
	}

	parse_cputime(&curr, argv+1);
	parse_cputime(&diff, argv+3);

	curr.sum_exec_runtime = curr.utime + curr.stime;
	cputime_adjust(0, &curr, &old_prev, &tmp, &tmp);
	cputime_adjust(1, &curr, &new_prev, &tmp, &tmp);

	printf("%18s%15s\t%18s\n", "old", "", "new");
	for (;;) {
		curr.utime += diff.utime;
		curr.stime += diff.stime;
		curr.sum_exec_runtime = curr.utime + curr.stime;

		prdiff(0, &curr, &old_prev);
		printf("\t");
		prdiff(1, &curr, &new_prev);
		printf("\n");
	}

	return 0;
}

