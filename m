Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E8C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE1207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SG6VIgfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGMKfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgGMKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:35:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DCBC061755;
        Mon, 13 Jul 2020 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INXvaMVTxBym4z/fKJuakqyDRZOcv2j8dD0l03DIIOk=; b=SG6VIgfVujIJwV1bkl//5xt+9g
        GLP/+l5nCGy7FOXXJBltMRU67LYncxDKPW6XsBHqK5/7I+gwAZZAeIi4Fw+AU9EP/1AStl19tAaLC
        SfbNHamPt4X0L+rDd63gUKANJkUMuOF7Pl9RtdotmVNYk2uice1ic0JG1iXWOkPm+uBxb3DNG+iMu
        WBQD3crMEPQqSfLG0NJ363PhffAs9/YPu277+hE0NShjZJpTyx12XnfZwkkoHATqijESikkzytS65
        d4z7k9jTm4g7VM/nUtS3uougp6mu4u9g36XTFN6DBr/Hme/NNU3thCLE+pHtDGeIM5w+F+NxASdO6
        4MG6AvCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juvnM-0000vE-10; Mon, 13 Jul 2020 10:34:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FAA3300DB4;
        Mon, 13 Jul 2020 12:34:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 449F220D27C88; Mon, 13 Jul 2020 12:34:43 +0200 (CEST)
Date:   Mon, 13 Jul 2020 12:34:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH 00/18] Allow architectures to override __READ_ONCE()
Message-ID: <20200713103443.GE10769@hirez.programming.kicks-ass.net>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 05:51:44PM +0100, Will Deacon wrote:

> SeongJae Park (1):
>   Documentation/barriers/kokr: Remove references to
>     [smp_]read_barrier_depends()
> 
> Will Deacon (18):
>   tools: bpf: Use local copy of headers including uapi/linux/filter.h
>   compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
>   asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
>   alpha: Override READ_ONCE() with barriered implementation
>   asm/rwonce: Remove smp_read_barrier_depends() invocation
>   asm/rwonce: Don't pull <asm/barrier.h> into 'asm-generic/rwonce.h'
>   vhost: Remove redundant use of read_barrier_depends() barrier
>   alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
>   locking/barriers: Remove definitions for [smp_]read_barrier_depends()
>   Documentation/barriers: Remove references to
>     [smp_]read_barrier_depends()
>   tools/memory-model: Remove smp_read_barrier_depends() from informal
>     doc
>   include/linux: Remove smp_read_barrier_depends() from comments
>   checkpatch: Remove checks relating to [smp_]read_barrier_depends()
>   arm64: Reduce the number of header files pulled into vmlinux.lds.S
>   arm64: alternatives: Split up alternative.h
>   arm64: cpufeatures: Add capability for LDAPR instruction
>   arm64: alternatives: Remove READ_ONCE() usage during patch operation
>   arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
