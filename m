Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0859620774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVk6G8vB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJjSVXYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHMR3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:29:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22ADC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:28:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597339737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11fDOoD89XYwtAI0PHZUjX+Yj9I0KxTiJv3RjtEDo3E=;
        b=QVk6G8vBi5xZpbbEh5oCRYi3g2VIeVrUdWVVFu0SFo5zxbzhNELy6r3DddXMnRkJ88uI84
        hJif/amrozMH1JapT/2OrxpCJ4R/koTofn8+TfLw8JEQDB9s6FSIy5tbJMljGF6jbVIiP7
        UxXjLHb/1wS3ptLKcOmtPQOree4COB9bVBU6/A4WunKTWgpQUZwZ5guDNsvgq4dFMjJnr8
        /SXjALm68UWrJemCH9J2g9dPWrPxsRolRId0NwDdKGZSxS2WmQYuYlr7eMhHAWarpcW2TA
        IBA92ilIaAKy19h95Kg367si1I9YpzaetOjBzwDYpGCz9CpvdRc+MG03NONoaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597339737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11fDOoD89XYwtAI0PHZUjX+Yj9I0KxTiJv3RjtEDo3E=;
        b=xJjSVXYUS3PXpK9xYeHKjIJczdzRd+rekKdmNlMKjRHuqwxBYe2V81F25SVPcZHH9kSXFN
        lUOqDQm0qxyRKxCg==
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
In-Reply-To: <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
References: <20200527135329.1172644-1-arnd@arndb.de> <878serh1b9.fsf@nanos.tec.linutronix.de> <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
Date:   Thu, 13 Aug 2020 19:28:57 +0200
Message-ID: <87h7t6tpye.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> On Thu, Aug 6, 2020 at 3:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > + *
>> > + * Clang sometimes fails to kill the reference to the dummy variable, so
>> > + * provide an actual copy.
>>
>> Can that compiler be fixed instead?
>
> I don't think so. The logic in the compiler whether to emit an

Forget that I asked. Heat induced brain damaged.

> I'd much rather remove all of __force_order.

Right.

> Not sure about the comment in arch/x86/include/asm/special_insns.h
> either; smells fishy like a bug with a compiler from a long time ago.
> It looks like it was introduced in:
> commit d3ca901f94b32 ("x86: unify paravirt parts of system.h")
> Lore has this thread:
> https://lore.kernel.org/lkml/4755A809.4050305@qumranet.com/
> Patch 4: https://lore.kernel.org/lkml/11967844071346-git-send-email-gcosta@redhat.com/
> It seems like there was a discussion about %cr8, but no one asked
> "what's going on here with __force_order, is that right?"

Correct and the changelog is uselss in this regard.

> Quick boot test of the below works for me, though I should probably
> test hosting a virtualized guest since d3ca901f94b32 refers to
> paravirt.  Thoughts?

Let me ask (hopefully) useful questions this time:

  Is a compiler allowed to reorder two 'asm volatile()'?

  Are there compilers (gcc >= 4.9 or other supported ones) which do that?

Thanks,

        tglx
