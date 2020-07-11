Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6ADC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3AE206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OcB4vLbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGKKMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGKKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:12:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50240C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/ZZkHjnUQiwzKzc49pjz9+DN0KmiX6rc0tKOJ/e9x7U=; b=OcB4vLbZPsjjDuG3qcTlYR8x3y
        6Ez4rFtH+E/r+Tpy/oXEQbQDmCvwvC/NT0/FVXHI+03BprdCLd7W/TbIsyCZ9D0lEjeBBOx8Ooov5
        M3BVcQePcNmuiO0FrG4rgc+q/rumNoRzmgDhcVnotXWYhCFFIOa7CbJ+vJWKFGlREW72wQOIc1UfH
        rq4vVJMDNOhevGtcBi7CUpN8JB5nxuVnsbcOrUvrUnCPlnMjHbZMBRqdn1PEKW8Np7422sRXJIClp
        akHSAiE2iYsWova/qayuvdzMJPRl2QztFPs39rvq0Im/NFbKLC3vySdhd1ucHVeA6gebwgg6uLMp5
        dCV/ZV+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juCTx-0007Aq-8J; Sat, 11 Jul 2020 10:11:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DACAC304D28;
        Sat, 11 Jul 2020 12:11:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B936A2367CF59; Sat, 11 Jul 2020 12:11:43 +0200 (CEST)
Date:   Sat, 11 Jul 2020 12:11:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 09/17] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20200711101143.GB597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.679277058@infradead.org>
 <20200710181331.1ad69ef6@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710181331.1ad69ef6@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:13:31PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Add the x86 out-of-line static call implementation.  For each key, a
> > permanent trampoline is created which is the destination for all static
> > calls for the given key.  The trampoline has a direct jump which gets
> > patched by static_call_update() when the destination function changes.
> 
> FYI, I get the following warnings after applying this patch.
> 
> /work/git/linux-test.git/arch/x86/kernel/static_call.c: In function ‘__static_call_transform’:
> /work/git/linux-test.git/arch/x86/kernel/static_call.c:9:43: warning: passing argument 2 of ‘text_gen_insn’ makes pointer from integer without a cast [-Wint-conversion]
>     9 |  const void *code = text_gen_insn(opcode, (long)insn, (long)func);
>       |                                           ^~~~~~~~~~
>       |                                           |
>       |                                           long int

Hurmph, shows I haven't build the individual patches in a while I
suppose. It was fixed in the next patch.

Fixed it up, thanks!
