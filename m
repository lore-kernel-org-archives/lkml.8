Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31028C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C47621744
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TawhGh0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgEFSQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgEFSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:16:32 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992A7C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/AJAJr7B3QKjZ0nQt0tJ7+Ma9Ntv3JDslAMn5XoI8kM=; b=TawhGh0VxeA9YJluTQSDJtyYM8
        xX3NRY2qP1wiFVkW/WasVhIt/ypfsL11du7zkEQ+RA2FhGVBrwBtxLkggXwjz3tA/1TjKZDAdIMJu
        Krqk914HSWxBIJ+ck3r+C1TDilogeNCgKYF4Q+5HH59ymNICFzHEz95Y5Ecr4Pk0bYzFiCrRHxuM0
        uD59StN1Hw8sTvN/lDMdfidV2HSphlBuXJedhyU7ohyc64JJhZewP3dOAaAuGe2mDFQbgs1Uyz0P3
        h3s5Kk5vBVM3RG7MvYtgd1naiwktFag8uMl8Ps1MfR9Rt3FWTaNEsrqehvHZIbspESgynfBV6gYIV
        kVILN1BQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWOaS-0000vt-I2; Wed, 06 May 2020 18:16:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3ADB300739;
        Wed,  6 May 2020 20:16:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ADCA29DE2DED; Wed,  6 May 2020 20:16:02 +0200 (CEST)
Date:   Wed, 6 May 2020 20:16:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200506181602.GZ3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <20200506172455.ho5em2mtzn7qqfjl@treble>
 <20200506175852.GW3762@hirez.programming.kicks-ass.net>
 <20200506180924.tdn3zc7a3yte7kvv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506180924.tdn3zc7a3yte7kvv@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 01:09:24PM -0500, Josh Poimboeuf wrote:

> #define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns)			\
> 	asm(".pushsection .static_call.text, \"ax\"		\n"	\
> 	    ".align 4						\n"	\
> 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> 	    insns "						\n"	\
> 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> 	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> 	    ".popsection					\n")
> 
> #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
> 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp.d32 " # func)

Note that this one is now:

	.byte 0xe9; .long #func - (. + 4);

due to clang not actually understanding jmp.d32 :-(

> #define ARCH_DEFINE_STATIC_CALL_RETTRAMP(name, func)			\
> 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
> 
> I like it.  Makes it easy to see the differences between the tramps.

OK, ok.. changed :-)
