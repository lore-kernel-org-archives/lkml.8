Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E063C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC90204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2vZo1Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIBJsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIBJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:48:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6898FC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdyL13Uvjv1pNVjDzDIXoAmUHsG+84egfwplSg5ntaw=; b=o2vZo1AfY48tpgHHFsroW+RLQh
        ExcPZ60NefC3QI5EeH72sz0ZrETHcn3vv5nfbwR7X0LNTpza99hUfxzENoF/f876x0aWMplE0rxmx
        1LxSlShA+O0G26QIWv07Po1Z0iIeD/+Mv6x33pCNxJMdR8+znBiC8Dsx7BHWe5wgr9i2W4ukyg/2W
        UxphiKAPp07eF1VrFdDnc6JnJB75h/u4dN9LXpji3W69vvm24uvEtijBW10FW+5t8046RCFSwgFib
        +u4XWl2Au3Yui9HQQv0O16kRkAhnOSQbwAgJeIb4AFqbGlSXYy3ZBt5ch5HHPU+Qdnie8aqcl3RtK
        1MtzhkCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDPNP-0002Zo-4z; Wed, 02 Sep 2020 09:48:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F46C304B92;
        Wed,  2 Sep 2020 11:48:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01BC123D3D72C; Wed,  2 Sep 2020 11:48:20 +0200 (CEST)
Date:   Wed, 2 Sep 2020 11:48:20 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v7 08/18] static_call: Avoid kprobes on inline
 static_call()s
Message-ID: <20200902094820.GA1362448@hirez.programming.kicks-ass.net>
References: <20200818135735.948368560@infradead.org>
 <20200818135804.744920586@infradead.org>
 <20200902103508.2872d92709fc8de7c6bffe08@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902103508.2872d92709fc8de7c6bffe08@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:35:08AM +0900, Masami Hiramatsu wrote:
> On Tue, 18 Aug 2020 15:57:43 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Similar to how we disallow kprobes on any other dynamic text
> > (ftrace/jump_label) also disallow kprobes on inline static_call()s.
> 
> Looks good to me. 
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> BTW, here we already have 5 subsystems which reserves texts
> (ftrace, alternatives, jump_label, static_call and kprobes.)
> 
> Except for the kprobes and ftrace, we can generalize the reserved-text
> code because those are section-based static address-areas (or lists).

Doesn't ftrace also have a section where it lists all the mcount
locations?

On top of that ftrace probably registers its trampolines.

Do we support adding kprobes to BPF-JIT'ed code or should we blacklist
them too?
