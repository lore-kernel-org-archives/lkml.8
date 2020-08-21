Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA028C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927D7207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGFoHPFj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4gBM/DW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHUAhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgHUAhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:37:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94776C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:37:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597970269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRUgKcuRN8v1rgG8LJcASrlT3NFsgPKqmdOa0BdAnwU=;
        b=cGFoHPFj92uODRSX/MEXULlkNMAm1AmYWbdPKF4s0zwciS1yQWuWYwSHkoEYqvjaO4Ad4I
        ztoX+2Q94CW3h5wE5qrRYVtAkcVS5mMfrTA6XTrKZfiaKrnkrUlEhb7aJ+1yEHYfmn9PJO
        rGoUbmLiAXM9bIrxDgYAa5Cnw2BRRauHu7HAt5J8EWRtTdOzgdIatS7RLEIdxI0sOGhfHv
        b48htNrKUmyRIYchp94zxZ7FV2MfAGHoJYjn2A0BayQ7Di3NG1VvGC5iJ+XX7iuh3TUowo
        4r73p1nV1kmP26x2ep7hXnSGE6vJNpMKdWpuS0roNaEHWq1+Ry+qi3zUDhx3pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597970269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRUgKcuRN8v1rgG8LJcASrlT3NFsgPKqmdOa0BdAnwU=;
        b=t4gBM/DWFQEksA55Z7a7bVN5PkFdmzG1sCUArUl19hqmnycS1no3KeuRHmXMcps3b54Vj/
        fZbHwBb6zcpwOSAg==
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
In-Reply-To: <20200820130641.GA536306@rani.riverdale.lan>
References: <20200527135329.1172644-1-arnd@arndb.de> <878serh1b9.fsf@nanos.tec.linutronix.de> <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com> <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72> <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de> <20200820130641.GA536306@rani.riverdale.lan>
Date:   Fri, 21 Aug 2020 02:37:48 +0200
Message-ID: <87zh6ohm03.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20 2020 at 09:06, Arvind Sankar wrote:
> I don't think that's an issue, or at least, not one where force_order
> helps.
>
> If the source for foo() is not visible to the compiler, the only reason
> force_order prevents the reordering is because foo() might have
> references to it, but equally foo() might have volatile asm, so the
> reordering isn't possible anyway.
>
> If the source is visible, force_order won't prevent any reordering
> except across references to force_order, but the only references are
> from the volatile asm's which already prevent reordering.
>
> I think force_order can only help with buggy compilers, and for those it
> should really have been an input-output operand -- it wouldn't currently
> do anything to prevent cr writes from being reordered.

Fair enough. Care to provide a patch which has the collected wisdom of
this thread in the changelog?

Thanks,

        tglx
