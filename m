Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5536CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FA6206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6QGp6Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgEVLiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:38:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgEVLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XH1Yj5aOcR07TnTGoIfuiVoH/MNimUictOSMhtQ2KiY=; b=d6QGp6XmaKNFEj/c8MOhRbc7Nb
        gE6pY2ftZhVxSAmjrHj4IBZb0jGA8vL8TlrtWe3b3GC8FnQfCob4DPQRbu7+kOrx+c/PmkrfyJKF0
        8ZmVja26AcPbSozSalm8CS5xdX8gUp+S9auKcN5/tMzGQANGIuqHFHumwazARBiSwsaJwjaBTY3yo
        hFPlFEoNQbOiwH7hJG9X8sE9v89b1UW31jicK0B0Dpju0EEs0aNxYynZ5DZNgXgK4X/Fr88R2p2pq
        S+NeJaQlXngxq890AVlcdgdbxeilPkb6uHy2fP1A5TU6gUhnaI9aBEwM2dOSyRhiX5XGcL+4zwGnH
        PTTMiacw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc5xy-0007dX-JN; Fri, 22 May 2020 11:35:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D6EE300478;
        Fri, 22 May 2020 13:35:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2D12201479A0; Fri, 22 May 2020 13:35:47 +0200 (CEST)
Date:   Fri, 22 May 2020 13:35:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        will@kernel.org, clang-built-linux@googlegroups.com, bp@alien8.de
Subject: Re: [PATCH -tip v3 00/11] Fix KCSAN for new ONCE (require Clang 11)
Message-ID: <20200522113547.GL325280@hirez.programming.kicks-ass.net>
References: <20200521142047.169334-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:20:36PM +0200, Marco Elver wrote:
> Arnd Bergmann (1):
>   ubsan, kcsan: don't combine sanitizer with kcov on clang
> 
> Marco Elver (10):
>   kcsan: Avoid inserting __tsan_func_entry/exit if possible
>   kcsan: Support distinguishing volatile accesses
>   kcsan: Pass option tsan-instrument-read-before-write to Clang
>   kcsan: Remove 'noinline' from __no_kcsan_or_inline
>   kcsan: Restrict supported compilers
>   kcsan: Update Documentation to change supported compilers
>   READ_ONCE, WRITE_ONCE: Remove data_race() and unnecessary checks
>   data_race: Avoid nested statement expression
>   compiler.h: Move function attributes to compiler_types.h
>   compiler_types.h, kasan: Use __SANITIZE_ADDRESS__ instead of
>     CONFIG_KASAN to decide inlining
> 
>  Documentation/dev-tools/kcsan.rst |  9 +-----
>  include/linux/compiler.h          | 54 ++++---------------------------
>  include/linux/compiler_types.h    | 32 ++++++++++++++++++
>  kernel/kcsan/core.c               | 43 ++++++++++++++++++++++++
>  lib/Kconfig.kcsan                 | 20 +++++++++++-
>  lib/Kconfig.ubsan                 | 11 +++++++
>  scripts/Makefile.kcsan            | 15 ++++++++-
>  7 files changed, 127 insertions(+), 57 deletions(-)

LTGM

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
