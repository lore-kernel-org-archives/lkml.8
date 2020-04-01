Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6034BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6FF206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dzsjusu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgDASuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:50:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbgDASuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5gIoccWgwG0UTBdqO685OvdtFiV1jZqp8Lt6I3tMn5E=; b=Dzsjusu5pglcXVvT6J0lYNgX8V
        RcGUXFdinq9nGxJ/EvCtHdxS8HYBkhhbMsQLBLXpMjjUl8Yzc7xriIRnIsUYlZ9aK983GjBjfClXW
        2gr8CAJdmi2r+tTyspmOYEZT1TCP48oE6tRDXZAyeanOrmVcdwZG4Vme10GReLvdHs4cQZF132M51
        Yg7pOabZoT6Dd3jHfswrkgZcBzesXzMgQDQkxIJjvJ51Th9XGB7en6rnK1KVB7iDvJURyhyJxSnno
        JXEKmHXzx8A3nCVLxSqZsGJkCT3HRGhVAxTaWD7eghcZEKFh8CMQsm0U2O2ahs3/wwFwoSxmOGFwA
        8lLHCdiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJiR1-0007PY-Jy; Wed, 01 Apr 2020 18:49:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 495AA3025C3;
        Wed,  1 Apr 2020 20:49:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2299920418979; Wed,  1 Apr 2020 20:49:53 +0200 (CEST)
Date:   Wed, 1 Apr 2020 20:49:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/5] objtool: Support Clang non-section symbols in ORC
 generation
Message-ID: <20200401184953.GZ20730@hirez.programming.kicks-ass.net>
References: <cover.1585761021.git.jpoimboe@redhat.com>
 <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:23:27PM -0500, Josh Poimboeuf wrote:

> @@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
>  	}
>  	memset(rela, 0, sizeof(*rela));
>  
> -	rela->sym = insn_sec->sym;
> -	rela->addend = insn_off;
> +	if (insn_sec->sym) {
> +		rela->sym = insn_sec->sym;
> +		rela->addend = insn_off;
> +	} else {
> +		/*
> +		 * The Clang assembler doesn't produce section symbols, so we
> +		 * have to reference the function symbol instead:
> +		 */
> +		rela->sym = find_symbol_containing(insn_sec, insn_off);

It's a good thing I made that a lot faster I suppose ;-)

> +		if (!rela->sym) {
> +			/*
> +			 * Hack alert.  This happens when we need to reference
> +			 * the NOP pad insn immediately after the function.
> +			 */
> +			rela->sym = find_symbol_containing(insn_sec,
> +							   insn_off - 1);

Urgh, when does that happen? 

> +		}
> +		if (!rela->sym) {
> +			WARN("missing symbol for insn at offset 0x%lx\n",
> +			     insn_off);
> +			return -1;
> +		}
> +
> +		rela->addend = insn_off - rela->sym->offset;
> +	}
> +
>  	rela->type = R_X86_64_PC32;
>  	rela->offset = idx * sizeof(int);
>  	rela->sec = ip_relasec;
> -- 
> 2.21.1
> 
