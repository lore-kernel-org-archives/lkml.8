Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2348C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA02A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yu6ZPhnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgHUKTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:19:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBABC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mgh8GfKsrOrDT7qKfkxXyGihi2GN79kgkLGFle4IU/4=; b=Yu6ZPhnckWyVt1Ig7Nj3pDS2fc
        RLEVyjRR8IWIoNgeRm6dc/gpuiTtDlzmV/sDgQhWf01ezVdvTAf36FMTAdSCTxygOIwLCG7T1s0wn
        ifeDG9AuyR2S0PT3PztYYKr3Q25ChyGsmJDqr/y0sML67G+1RKXFNwaeLpKCvef3ysokxB/S3565M
        fW9e61SfQAeVrYnyf8xm3VL5IfeBxW4RY9FrfUQV6Rc9Dap6OxzmuaOUu4qv6/R9MKA+X+BV6E1pK
        B5Hx3TAn68qrjBiV76k+fBUgItJVjBxLE9o6COb4MIka/yau4vkwKFftyHEz5ENVkLo2REm1iYauv
        wt77PNKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k948X-00036r-SE; Fri, 21 Aug 2020 10:19:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5D43302526;
        Fri, 21 Aug 2020 12:19:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B41F2C8FF2DC; Fri, 21 Aug 2020 12:19:03 +0200 (CEST)
Date:   Fri, 21 Aug 2020 12:19:03 +0200
From:   peterz@infradead.org
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200821101903.GK1362448@hirez.programming.kicks-ass.net>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <20200820152828.tvluka3lvmzof5xt@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820152828.tvluka3lvmzof5xt@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 04:28:28PM +0100, Daniel Thompson wrote:

> Specifically I've entered the kdb in pretty much the simplest way
> possible: a direct call to kgdb_breakpoint() from a task context. I
> generate a backtrace to illustrate this, just to give you a better
> understanding of what might be happening) and then ran the single step.


> + make -C .. O=$PWD x86_64_defconfig
> + ../scripts/config --enable RUNTIME_TESTING_MENU
> + ../scripts/config --enable DEBUG_INFO --enable DEBUG_FS --enable KALLSYMS_ALL --enable MAGIC_SYSRQ --enable KGDB --enable KGDB_TESTS --enable KGDB_KDB --enable KDB_KEYBOARD --enable LKDTM
> + ../scripts/config --enable PROVE_LOCKING --enable DEBUG_ATOMIC_SLEEP
> + make olddefconfig


That asked me about a kgdb boottime selftest, which I figured was a good
idea, but even without my patches that seems to fail, and fail so that
it doesn't boot :/

> # echo g > /proc/sysrq-trigger

OK, I think I got that working with the latest set.

Thanks!
