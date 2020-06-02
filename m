Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6A720734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n9ailRcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgFBJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:42:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63643C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f/FIn/xczaJeGePujbt0xf56oNTzmB6hv0F5AGXANOY=; b=n9ailRcxmwDHuN4y39t3uAcBWn
        4jijjsifTGp2bxjydLv6sdUvxJ30PH/t1EjdQAjky+LhhaliNE1cQIxCL9J8pJFhd4iFaXV0GYVx2
        KDDtA6F6Y/AmzJxoXlu5gva8zPXq9DuJmiLo0XQM140SJ88nimPYx7hEO+dRlvMs396mB70AZ3MUN
        3NIi6QfCe+K/BNhwhhJukY74bmW6GvDrN0dyHyITbstcKRjTLv24u9/zjB50lge9ey+5gF81I3iYr
        aF13PbWnReUkcA8jsLUNzroD04eNykXEVghK8X3aWbAA1juTRswfz+c4l0eCwaSmNqQw2upBfJI3q
        jVY3ySJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jg3QW-0000NT-IR; Tue, 02 Jun 2020 09:41:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52F053011B2;
        Tue,  2 Jun 2020 11:41:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34B1A2B9905AB; Tue,  2 Jun 2020 11:41:41 +0200 (CEST)
Date:   Tue, 2 Jun 2020 11:41:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
Message-ID: <20200602094141.GR706495@hirez.programming.kicks-ass.net>
References: <000000000000d2474c05a6c938fe@google.com>
 <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de>
 <20200529160711.GC706460@hirez.programming.kicks-ass.net>
 <20200529171104.GD706518@hirez.programming.kicks-ass.net>
 <CACT4Y+YB=J0+w7+SHBC3KpKOzxh1Xaarj1cXOPOLKPKQwAW6nQ@mail.gmail.com>
 <CANpmjNP7mKDaXE1=5k+uPK15TDAX+PsV03F=iOR77Pnczkueyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP7mKDaXE1=5k+uPK15TDAX+PsV03F=iOR77Pnczkueyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 02:40:31PM +0200, Marco Elver wrote:
> I think Peter wanted to send a patch to add __no_kcsan to noinstr:
> https://lkml.kernel.org/r/20200529170755.GN706495@hirez.programming.kicks-ass.net
> 
> In the same patch we can add __no_sanitize_address to noinstr. But:
> 
> - We're missing a definition for __no_sanitize_undefined and
> __no_sanitize_coverage.

Do those function attributes actually work? Because the last time I
played with some of that I didn't.

Specifically: unmarked __always_inline functions must not generate
instrumentation when they're inlined into a __no_*san function.

(and that fails to build on some GCC versions, and I think fails to
actually work on the rest of them, but I'd have to double check)

> - We still need the above blanket no-instrument for x86 because of
> GCC. We could guard it with "ifdef CONFIG_CC_IS_GCC".

Right; so all of GCC is broken vs that function attribute stuff? Any
plans of getting that fixed? Do we have GCC that care?

Does the GCC plugin approach sound like a viable alternative
implementation of all this?

Anyway, we can make it:

KASAN := SANITIZER_HAS_FUNCTION_ATTRIBUTES

or something, and only make that 'y' when the compiler is sane.

> Not sure what the best strategy is to minimize patch conflicts. For
> now I could send just the patches to add missing definitions. If you'd
> like me to send all patches (including modifying 'noinstr'), let me
> know.

If you're going to do patches anyway, might as well do that :-)
