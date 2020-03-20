Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F8C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CE120722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1pT4FM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCTWbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:31:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+XgR8bK5ISHPikcqMQDWasfx7zO+8LmlcuPC1kRP4uw=; b=J1pT4FM3GM+DfmaZ6enSU1irqc
        QDdH2Xf722+a0ED5jlNz9egPzrx2Wx3oN+WYvkk3qd50Vjc3ESIiSyT6e+Q6u4fhmlZ8XgKuzg0lw
        f9igXUBbYEpU8kpl+ZblfI3OOlRm9YJ+GRQuzo3rkKMO1vkO8gZEgF3wSpeOuum42jhDgUCMV5NkM
        43enLL4S/bVqtbKfLJzN8cQE02QaOmuAs2omHgKmCAC1jczvFS/lor7NyJ+NLUFqJyWnQeN8TEKPf
        e+KayJs7rnczWVxyR5a+cg2B9l5u2VjBT2Ta8FZkwGW7ffYv5yFqaz1i1nHDG5fhmHmHIkAPB5A22
        sWGwTBEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFQB5-000523-N3; Fri, 20 Mar 2020 22:31:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E793C980FA6; Fri, 20 Mar 2020 23:31:41 +0100 (CET)
Date:   Fri, 20 Mar 2020 23:31:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 00/17] Add static_call()
Message-ID: <20200320223141.GC2452@worktop.programming.kicks-ass.net>
References: <20200320213844.817147179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320213844.817147179@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:38:44PM +0100, Peter Zijlstra wrote:
> static_call(), is the idea of static_branch() applied to indirect function
> calls. Remove a data load (indirection) by modifying the text.
> 
> The inline implementation still relies on objtool to generate the
> .static_call_sites section, mostly because this is a natural place for x86_64
> and works for both GCC and LLVM.  Other architectures can pick other means
> if/when they implement the inline patching. The out-of-line (aka. trampoline)
> variant doesn't require this.
> 
> Patches can also be found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call
> 
> 
> Comments?

*groan*, I got the lkml address wrong (again!), this series is cursed.
