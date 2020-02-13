Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C1DC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C2620848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XGX91zDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgBMI6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:58:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgBMI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cSINIGEzeX/CUP3TaQ2VxJhKGWx9x1IfWDs8UzeGCQk=; b=XGX91zDZAYlOdqN6Bf6OTpZ9RI
        maPP2pzK+Xxc8QgxZr9iOxVj179dx3RZHw9+NlH9381EkLOZ1x7szqFSOTgqmyhzQqdSK+UmwvJsp
        gEBe6Rtc/hOHNTSg2oprmZ5S9JgKGaj+uttUE9gRxsuGUqH9OZkp+jYAEmaWqWBHhA7GwF2HXWrFn
        W4I6NFtTkhE5qLymQ+cc7sstNfrd2B9mAfygRcPobbQuVOS8ovdAq1Qp2rGsV2Mik0sevbLsH15v8
        c4ZMkpxOzCz6u3yNJ9hLbDWAZuMZTQTtsr/YQrQxNGMYOEz2+2LLLVXmQrfeD1aUboRhdoVLmB1mV
        5N7XHSuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2AKi-000634-04; Thu, 13 Feb 2020 08:58:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 442E33012D8;
        Thu, 13 Feb 2020 09:57:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C74072040AD15; Thu, 13 Feb 2020 09:58:49 +0100 (CET)
Date:   Thu, 13 Feb 2020 09:58:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, paulmck@kernel.org
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213085849.GL14897@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:06:24AM +0100, Michal Simek wrote:
> On 12. 02. 20 16:55, Peter Zijlstra wrote:
> > On Wed, Feb 12, 2020 at 04:42:29PM +0100, Michal Simek wrote:

> >> +static inline void atomic_set(atomic_t *v, int i)
> >> +{
> >> +	int result, tmp;
> >> +
> >> +	__asm__ __volatile__ (
> >> +		/* load conditional address in %2 to %0 */
> >> +		"1:	lwx	%0, %2, r0;\n"
> >> +		/* attempt store */
> >> +		"	swx	%3, %2, r0;\n"
> >> +		/* checking msr carry flag */
> >> +		"	addic	%1, r0, 0;\n"
> >> +		/* store failed (MSR[C] set)? try again */
> >> +		"	bnei	%1, 1b;\n"
> >> +		/* Outputs: result value */
> >> +		: "=&r" (result), "=&r" (tmp)
> >> +		/* Inputs: counter address */
> >> +		: "r" (&v->counter), "r" (i)
> >> +		: "cc", "memory"
> >> +	);
> >> +}
> >> +#define atomic_set	atomic_set
> > 
> > Uuuuhh.. *what* ?!?
> > 
> > Are you telling me your LL/SC implementation is so bugger that
> > atomic_set() being a WRITE_ONCE() does not in fact work?
> 
> Just keep in your mind that this code was written long time ago and
> there could be a lot of things/technique used at that time by IIRC
> powerpc and I hope that review process will fix these things and I
> really appreciation your comments.

I don't think I've ever seen Power do this, but I've not checked the git
history.

> Stefan is the right person to say if we really need to use exclusive
> loads/stores instructions or use what I see in include/linux/compiler.h.
> 
> Please correct me if I am wrong.
> WRITE_ONCE is __write_once_size which is normal write in C which I
> expect will be converted in asm to non exclusive writes. And barrier is
> called only for cases above 8bytes.
> 
> READ_ONCE is normal read follow by barrier all the time.

Right:

WRITE_ONCE() is something like:

  *(volatile typeof(var)*)(&(var)) = val;

And should translate to just a regular store; the volatile just tells
the C compiler it should not do funny things with it.

READ_ONCE() is something like:

  val = *(volatile typeof(var)*)(&(var));

And should translate to just a regular load; the volatile again tells
the compiler to not be funny about it.

No memory barriers what so ever, not even a compiler barrier as such.

The thing is, your bog standard LL/SC _SHOULD_ fail the SC if someone
else does a regular store to the same variable. See the example in
Documentation/atomic_t.txt.

That is, a competing SW/SWI should result in the interconnect responding
with something other than EXOKAY, the SWX should fail and MSR[C] <- 1.

> Also is there any testsuite I should run to verify all these atomics
> operations? That would really help but I haven't seen any tool (but also
> didn't try hard to find it out).

Will, Paul; can't this LKMM thing generate kernel modules to run? And do
we have a 'nice' collection of litmus tests that cover atomic_t ?

The one in atomic_t.txt should cover this one at least.
