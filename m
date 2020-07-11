Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07173C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 09:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D469820720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 09:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jM+J7fUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGKJ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 05:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgGKJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 05:57:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C4C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=niDCXs/S/0K/HhfYJH2N5gZeWdgGAh4gJDBS5G7mzgM=; b=jM+J7fUNV5aS1zyzSw+Pi9rF9f
        kfsCqKAysJRlEw7XbNUDXneLrthLBgxQayuasgcuTjNOSIk2zulMXTLB2DxdIF7Xq+pQkhkHOkqcR
        O6oL52u6RKwTLvoG/GhoKugkJKIjTqZBGRe61eApetPLJ84NdEWvR+k6eVUMyaKhpvPe4CKvTY0SF
        muFMOXV1eJbq6mOUNFcQljoYfWG9T5/atzf7oJXqKSeIZx8q8eK+0hfOcYEYGjhZiAlGe5W6RL40z
        xTur1aUgZzth7DUj0TJdpCnVUGrke7h8fFeOEWy9yQhvUPL1R4SakK5pj2o6hTb+Z/oNqiacbT8NU
        ce8O731g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juCFR-0006o6-6z; Sat, 11 Jul 2020 09:56:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0C26304E03;
        Sat, 11 Jul 2020 11:56:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19D7F203C9680; Sat, 11 Jul 2020 11:56:39 +0200 (CEST)
Date:   Sat, 11 Jul 2020 11:56:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 10/17] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20200711095639.GA597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.739394269@infradead.org>
 <20200710183155.05eae629@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710183155.05eae629@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:31:55PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:41 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > +		/* find key symbol */
> > +		key_name = strdup(insn->call_dest->name);
> 
> Should check for failed allocation of strdup().

Rigt, I'll go add the perror and exit.

> > +		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
> > +			    strlen(STATIC_CALL_TRAMP_PREFIX_STR))) {
> > +			WARN("static_call: trampoline name malformed: %s", key_name);
> > +			return -1;
> > +		}
> > +		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
> > +		memcpy(tmp, STATIC_CALL_KEY_PREFIX_STR, STATIC_CALL_KEY_PREFIX_LEN);
> > +
> > +		key_sym = find_symbol_by_name(file->elf, tmp);
> > +		if (!key_sym) {
> > +			WARN("static_call: can't find static_call_key symbol: %s", tmp);
> > +			return -1;
> > +		}
> > +		free(key_name);
> > +
> > +		/* populate reloc for 'key' */
> > +		reloc = malloc(sizeof(*reloc));
> > +		if (!reloc) {
> > +			perror("malloc");
> > +			return -1;
> > +		}
> > +		memset(reloc, 0, sizeof(*reloc));
> > +		reloc->sym = key_sym;
> > +		reloc->addend = 0;
> > +		reloc->type = R_X86_64_PC32;
> 
> How easy would this be for other architectures to implement this? That
> is how much of this function is x86 specific?

I'm not sure; I think it's fairly generic except for the reloc types. So
ARM64 for example might need to use SHT_REL and R_AARCH64_PREL32
instead. But I suppose we'll see that if/when someone tries to make it
work.


