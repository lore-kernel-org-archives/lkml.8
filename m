Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D4BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D4720784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6DEi+1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgDVL5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgDVL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:57:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB9C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5EdoJCMzSX8ObFId59V+/EeQTDjOONNPRUBS6ekIMo=; b=H6DEi+1Fr4K+9SCI+mpSPESOEV
        41xscm2AjknStl6+QwcYRh8sNFcQ+gDAX161vMzB9njCXtM2xD5Yrrva7FWre1UPiKWsnMTBo9XRl
        QNcz9owv5+k3mJYjWZLu5+km3R0lPhvq8VcgzK9lt9YmfkaQbKR/bblGBHfqzfJ7wxIgz7ynrt5Jk
        WdRQGpBp2enCxa6/uHeQZdroztoSu+GND4l7S1bNJG+KrFHDyli742oCvoDQFrUqtpIgfpNehFT4Y
        g9VCR6uyt0Hooq8GlXann3rTeqILFTfULmwRveBE3I9ohPfNtYUIPhIcpKt/5Hp9INoTWxUOCb38m
        6zVDx3Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDzw-0008T1-Vi; Wed, 22 Apr 2020 11:57:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58714304CFD;
        Wed, 22 Apr 2020 13:56:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F1AC2028047D; Wed, 22 Apr 2020 13:56:59 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:56:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200422115659.GF20730@hirez.programming.kicks-ass.net>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
 <20200420082728.GA20696@hirez.programming.kicks-ass.net>
 <20200422074512.GA19309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422074512.GA19309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:45:12AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Apr 20, 2020 at 09:48:45AM +0200, Ingo Molnar wrote:
> > > Fortunately, much of what objtool does against vmlinux.o can be 
> > > parallelized in a rather straightforward fashion I believe, if we build 
> > > with -ffunction-sections.
> > 
> > So that FGKASLR is going to get us -ffunction-sections, but
> > parallelizing objtool isn't going to be trivial, it's data structures
> > aren't really build for that, esp. decode_instructions() which actively
> > generates data.
> > 
> > Still, it's probably doable.
> 
> So AFAICS in the narrow code section I identified as the main overhead, 
> only the instruction hash needs threading, i.e. this step:
> 
>                         hash_add(file->insn_hash, &insn->hash, insn->offset);
>                         list_add_tail(&insn->list, &file->insn_list);
> 
> Objtool can still be single-threaded before and after generating the 
> instruction hash.
> 
> 99% of the overhead within decode_instructions() is in 
> arch_decode_instruction(), which is fully thread-safe AFAICS.

Correct; I suppose you can farm out the sections to N threads for
arch_decode_instruction() and then have the main thread collect decoded
sections and frob them in the global data structures.

Another pass you can probably parallize fairly easily is
validate_functions() / validate_unwind_hints(). While that modifies
state, the state it modifies should be local to the section at hand.

That needs an audit of course, but it should be entirely doable.
