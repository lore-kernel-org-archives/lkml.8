Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F538C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1EA206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kiZcWuNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHaHYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:24:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250C0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fkf4UIATb5EZes4VezGoivKPnnfaYymFxL/DkWsE154=; b=kiZcWuNLSRAMaVk9Ex3prG9ek1
        MNCPLCa5DTB2PnhTOn3QsqWf/WWPGCYPrCf1uJSWDmkMaxt/PIxwWtSjO5KjIT4KTWBW7+OUTamg1
        zkwuvy899N4s1MIH40WKukbCJJ0Ox7WlwtQvkxF6WHMBH+nEb3FueVwoRGhMnhjtJ8/qMYCa/gXpy
        9ehhK0T7I6YGWrtqbGT8LT35KGJ81yAqHUgnuODXJ2e+3h/7jWIZzNFM6GxO5w3OxOuOUu2wY18vA
        3b/1MDBbzBAKkFjc/2jtgHPdzQHDJE7R/WWzZu+80/fL+or3q4moWfJZK8rYROZpuD9wLGUz2n2z4
        llbAVewQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCeB3-0007lW-QA; Mon, 31 Aug 2020 07:24:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E60B43003E5;
        Mon, 31 Aug 2020 09:24:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBAA920598A34; Mon, 31 Aug 2020 09:24:27 +0200 (CEST)
Date:   Mon, 31 Aug 2020 09:24:27 +0200
From:   peterz@infradead.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [GIT pull] sched/urgent for v5.9-rc2
Message-ID: <20200831072427.GM1362448@hirez.programming.kicks-ass.net>
References: <159881061564.27993.11909051048930389391.tglx@nanos>
 <159881061804.27993.16119786735164087221.tglx@nanos>
 <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 11:54:19AM -0700, Linus Torvalds wrote:
> On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - Make is_idle_task() __always_inline to prevent the compiler from putting
> >    it out of line into the wrong section because it's used inside noinstr
> >    sections.
> 
> What completely broken compiler uninlined that single-instruction function?
> 
> I've obviously pulled this, but it sounds like there should be a
> compiler bug-report for this insane behavior.
> 
> Or is Marco building the kernel without optimizations or something
> like that? That has not been a supported model, for various good
> reasons..

I think that was Clang with KCSAN on, KCSAN obviously makes this
function a little bigger with the instrumentation for the load(s). But
yes...
