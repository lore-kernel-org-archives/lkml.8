Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB0C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156072076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="215vA/Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgCZQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:07:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57152 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsDiwlASoZZdDT3N6KqjBazor5NikxhCT9Uq7utc1xE=; b=215vA/Au9ukZn1clgQ0ownTRzr
        etYRrycPvW0fAGoRwAxMd4hEDsakZ2YVhISMu7ZThRwiXW/qS9gZKKqbQvjmlajDtp19EbJdKAcGA
        uAR35e4gY5y43JiH8OXjL28QH37xhNo3qBlC3kMffYkhV97DLuOh5YcZeTClDMzn+C+uUUoLgDr3c
        m7FtZx5JI+P+xP14jMIdK8OQfD/1dOXgGjmX5LuaVES8i2qnI0RZmVr0JI3fOt44Gn9PTpUz/hC6b
        REjVQFNv02ybQ5Xbq7PFJiaR9g54WDwDEjc7R9obKfa8If6k3+HIgy+P2xobD0dlLkn4XCgKDHxx+
        Ch5LvwpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHV1w-0005io-9f; Thu, 26 Mar 2020 16:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96D663010C1;
        Thu, 26 Mar 2020 17:06:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CD2A29C75A60; Thu, 26 Mar 2020 17:06:50 +0100 (CET)
Date:   Thu, 26 Mar 2020 17:06:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 10/17] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20200326160650.GP20713@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.880990363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324142245.880990363@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:56:13PM +0100, Peter Zijlstra wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Add the inline static call implementation for x86-64. The generated code
> is identical to the out-of-line case, except we move the trampoline into
> it's own section.
> 
> Then objtool uses the trampoline section to detect all the call sites,
> which it writes into the .static_call_sites section.
> 
> During boot (and module init), the call sites are patched to call
> directly into the destination function.  The temporary trampoline is
> then no longer used.

> +static int read_static_call_tramps(struct objtool_file *file)
> +{
> +	struct section *sec, *sc_sec = find_section_by_name(file->elf, ".static_call.text");
> +	struct symbol *func;
> +
> +	for_each_sec(file, sec) {
> +		list_for_each_entry(func, &sec->symbol_list, list) {
> +			if (func->sec == sc_sec)
> +				func->static_call_tramp = true;
> +		}
> +	}
> +
> +	return 0;
> +}

While talking Boris through this stuff, I just realized that if you use
a static_call object defined in another translation-unit, IOW. the:

	STATIC_CALL_TRAMP(name)(...);

call is an external call, the above objtool rule will not detect it and
it'll stay using the trampoline...

Back to using a naming prefix I suppose.
