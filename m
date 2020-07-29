Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B38C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C603A206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596055453;
	bh=qLclcthyaIVq9FHNhNz4KHXGIpoZhJNR9DipamyBoKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sFQKCjotSm/ZdbXkIOOnpBJKBfpPIuVI8d7ZNc07OJtRSxcfqZ9GCtoY65fQlzALW
	 qRplFEp0NZ4Ydc1lUlxbseyF2LXKFh1k4af41hmEe2tYhBvBES4Px27BJ+zR49nAum
	 eF4cjWC/q+zZrikkW5JdN+ABonCGgK2mBzO+rNrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgG2UoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2UoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:44:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67B12068F;
        Wed, 29 Jul 2020 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596055452;
        bh=qLclcthyaIVq9FHNhNz4KHXGIpoZhJNR9DipamyBoKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0g8GExDae9GS3BIIs6kvFVJgTAVyo+67M9muKbxaUqwvLHI9Tre4FMpm1NFb35TKR
         YMHzBO380YchTaVZtXt0Y+s2nysOI83rUzggkpTFQCHb6x8RtNXXGoMwluFsi7uJVT
         YDA+HE5ppQfwDSM2HjKdd3GxYTqW6ZPO1prAwg8c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4546340E6B; Wed, 29 Jul 2020 17:44:09 -0300 (-03)
Date:   Wed, 29 Jul 2020 17:44:09 -0300
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
Message-ID: <20200729204409.GF433799@kernel.org>
References: <20200724071959.3110510-1-irogers@google.com>
 <20200728115152.GB3328@kernel.org>
 <20200729195918.GE433799@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729195918.GE433799@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 29, 2020 at 04:59:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jul 28, 2020 at 08:51:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jul 24, 2020 at 12:19:59AM -0700, Ian Rogers escreveu:
> > > for_each_set_bit, or similar functions like for_each_cpu, may be hot
> > > within the kernel. If many bits were set then one could imagine on
> > > Intel a "bt" instruction with every bit may be faster than the function
> > > call and word length find_next_bit logic. Add a benchmark to measure
> > > this.
> > 
> > Thanks, applied.

> > > This benchmark on AMD rome and Intel skylakex shows "bt" is not a good
> > > option except for very small bitmaps.
> 
> > > +++ b/tools/perf/bench/find-bit-bench.c
> 
> > > +#if defined(__i386__) || defined(__x86_64__)
> > > +static bool asm_test_bit(long nr, const unsigned long *addr)
> > > +{
> > > +	bool oldbit;
> > > +
> > > +	asm volatile("bt %2,%1"
> > > +		     : "=@ccc" (oldbit)
> > > +		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> > > +
> > > +	return oldbit;
> 
> Some old clang versions are not liking this:

Failed with:

  clang version 3.8.0 (tags/RELEASE_380/final)
  clang version 3.8.1 (tags/RELEASE_381/final)
  clang version 4.0.0 (tags/RELEASE_400/final)
  Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
  Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
  Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
  Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)

Worked with:

  Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  Alpine clang version 10.0.0 (git://git.alpinelinux.org/aports 7445adce501f8473efdb93b17b5eaf2f1445ed4c)


Also failed for;

# grep FAIL dm.log/summary  | grep -v alpine
 alt:p8: FAIL
   clang version 3.8.0 (tags/RELEASE_380/final)
 alt:p9: FAIL
   clang version 7.0.1
 amazonlinux:1: FAIL
   clang version 3.6.2 (tags/RELEASE_362/final)
 amazonlinux:2: FAIL
   clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
#
