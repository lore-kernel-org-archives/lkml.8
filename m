Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E356C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FADC20639
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fJFa3FKK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqQzoAgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgHTKon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731871AbgHTKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:44:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393BC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:44:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597920247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLWA2FzepFQDF+V/YhX0IJ79bp9VAkXafLwZ2xRN6/g=;
        b=fJFa3FKKIQeRv4J0N16FZqeUYlTc7OC303z+nw+wglNo4fQdRztgWeGlDcjv0itTFBDyCd
        dLt8Gq+u1jHvN46pTQOXL9TnwenMeVnCZsARor2Pn8fNvn9f9PVpvIivlDNRNx7Q5tyF/8
        QOrZH/pfBhBXdHSU8IIyr3QxMXTZoCNcXXG1mnVhFgovyZi3rbgNhR/mshB2GaqoV3u8m8
        3+qNbniIc51dJerNfGbsMYHF6TufaKhqZVuVvMSrcNHwwQS0ScnsRMj+zLD1F7DpXv/XMB
        UjNY6TBkBn08C20P9V8no0IWei9dirR8uvN40zZBXvcIJaTtN3UnkbqgVH67pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597920247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLWA2FzepFQDF+V/YhX0IJ79bp9VAkXafLwZ2xRN6/g=;
        b=sqQzoAgci1OIfkv+FS0qV2QXi1IUvtydMYUSAT7segZbbQiSm21J1JciDWunW6LatF7Wb8
        2dYYDRqNN1x90cDQ==
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
In-Reply-To: <20200813180933.GA532283@rani.riverdale.lan>
References: <20200527135329.1172644-1-arnd@arndb.de> <878serh1b9.fsf@nanos.tec.linutronix.de> <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com> <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72> <20200813180933.GA532283@rani.riverdale.lan>
Date:   Thu, 20 Aug 2020 12:44:06 +0200
Message-ID: <875z9dioll.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13 2020 at 14:09, Arvind Sankar wrote:
> On Thu, Aug 13, 2020 at 10:37:01AM -0700, Paul E. McKenney wrote:
>> > Let me ask (hopefully) useful questions this time:
>> > 
>> >   Is a compiler allowed to reorder two 'asm volatile()'?
>> > 
>> >   Are there compilers (gcc >= 4.9 or other supported ones) which do that?
>> 
>> I would hope that the answer to both of these questions is "no"!
>> 
>> But I freely confess that I have been disappointed before on this sort
>> of thing.  :-/
>> 
>> 							Thanx, Paul
>
> Ok, I found this, so gcc developers consider re-ordering volatile asm
> wrt each other a bug at least.
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602

Yes. It prevents reordering of volatiles, but it does not necessarily
prevent reorder of something like this:

        asm volatile(...);
        foo();
        asm volatile(...);

it might turn that into

        foo();
        asm volatile(...);
        asm volatile(...);

if I understood their discussion correctly. So removing this magic is
not really straight forward.

Thanks,

        tglx


