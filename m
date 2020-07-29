Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FC22065C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596052762;
	bh=BNXktmbwVk5D9L+Ni47QkQesqnGuRuU7dGbygDQCcrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lyn3TZUrfhb72cxS+E0zSaMRSebJ3LleWQbxTF15SGex8c2E2PAkDZCgIjAauhiTw
	 TxoW9CflUBn7vyJDbEOn4C5C/M7wlUYrcVml5CxIKDb1hnExaoHKJ4c5JoQsRW8LHG
	 oMnH3S5Owl07FPgimy5R6aHDGKVTn/puOv9nhy40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG2T7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgG2T7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:59:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEB520658;
        Wed, 29 Jul 2020 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052760;
        bh=BNXktmbwVk5D9L+Ni47QkQesqnGuRuU7dGbygDQCcrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu5z6okqzB/oCiK3RUvV2s93bzvSawGJ8g3CmznI7JZO0f2ZcKBf+eVwlCrucRnqv
         m1V6xgpihgmJsFuWTrhcOuaM/T58aZ3RAxoXfKSogC0QwDTX6P6fQwhdNEN0OslJlM
         4l7ZwqdMbLfrhlzsVpWfu3Tr45vEPRjWBN2EyhEQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E7B840E6B; Wed, 29 Jul 2020 16:59:18 -0300 (-03)
Date:   Wed, 29 Jul 2020 16:59:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bench: Add benchmark of find_next_bit
Message-ID: <20200729195918.GE433799@kernel.org>
References: <20200724071959.3110510-1-irogers@google.com>
 <20200728115152.GB3328@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728115152.GB3328@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 28, 2020 at 08:51:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 24, 2020 at 12:19:59AM -0700, Ian Rogers escreveu:
> > for_each_set_bit, or similar functions like for_each_cpu, may be hot
> > within the kernel. If many bits were set then one could imagine on
> > Intel a "bt" instruction with every bit may be faster than the function
> > call and word length find_next_bit logic. Add a benchmark to measure
> > this.
> 
> Thanks, applied.
> 
> - Arnaldo
>  
> > This benchmark on AMD rome and Intel skylakex shows "bt" is not a good
> > option except for very small bitmaps.

> > +++ b/tools/perf/bench/find-bit-bench.c

> > +#if defined(__i386__) || defined(__x86_64__)
> > +static bool asm_test_bit(long nr, const unsigned long *addr)
> > +{
> > +	bool oldbit;
> > +
> > +	asm volatile("bt %2,%1"
> > +		     : "=@ccc" (oldbit)
> > +		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> > +
> > +	return oldbit;

Some old clang versions are not liking this:

clang version 3.8.0 (tags/RELEASE_380/final)
Target: x86_64-alpine-linux-musl
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-alpine-linux-musl/5.3.0
Found candidate GCC installation: /usr/lib/gcc/x86_64-alpine-linux-musl/5.3.0
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-alpine-linux-musl/5.3.0
Candidate multilib: .;@m64
Selected multilib: .;@m64
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C /git/linux/tools/perf O=/tmp/build/perf CC=clang


  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
bench/find-bit-bench.c:46:10: error: invalid output constraint '=@ccc' in asm
                     : "=@ccc" (oldbit)
                       ^
1 error generated.
mv: can't rename '/tmp/build/perf/bench/.find-bit-bench.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/bench/find-bit-bench.o' failed
make[4]: *** [/tmp/build/perf/bench/find-bit-bench.o] Error 1
/git/linux/tools/build/Makefile.build:139: recipe for target 'bench' failed
make[3]: *** [bench] Error 2
make[3]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/arch/x86/tests/


Also:

clang version 3.8.1 (tags/RELEASE_381/final)
clang version 4.0.0 (tags/RELEASE_400/final)


- Arnaldo
