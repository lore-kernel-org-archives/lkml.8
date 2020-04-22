Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2FC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9752098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WU6VTXSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgDVTVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgDVTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:21:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93C6C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:21:22 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DC10061F884AD77E9675A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:61f8:84ad:77e9:675a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9767C1EC0D41;
        Wed, 22 Apr 2020 21:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587583280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uwppnCchAiG8ZwLKxdIRMiSv5cSPYMqUKzvWQTerwHo=;
        b=WU6VTXSf04lYkmozCkK5w5zhDZykha3Z6APpkq0CZgzMF+2U4teiuYnzU+maYFnlx6Qbrv
        8AmuzpPScOyq8sIsCk9nwTGzABklMDoNUu1EJ3jS32gma6IXJqy5J9Tyu483Hn31cuHv1S
        1AjAwAsCdf/beHQz5pr8WjHQjleLkUA=
Date:   Wed, 22 Apr 2020 21:21:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200422192113.GG26846@zn.tnic>
References: <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:55:50AM -0700, Nick Desaulniers wrote:
> Can you add by whom?  It's not clear to me which function call in
> start_secondary modifies the stack protector guard.

How's that

        /*
         * Prevent tail call to cpu_startup_entry() because the stack protector
         * guard has been changed a couple of functions up, in
         * boot_init_stack_canary() and must not be checked before tail calling
         * another function.
         */
        asm ("");

?

> Another question.  Do we not want a stack protector at all in this
> function?  I'm not super familiar with how they work; do we not want
> them at all, or simply not to check the guard?

Not to check the guard. See the beginning of
arch/x86/include/asm/stackprotector.h about how they work.

> But if we're not going to check it, I think
> __attribute__((no_stack_protector)) applied to start_secondary might
> be a more precise fix.

No such attribute in gcc yet. But yes, this came up a bit upthread, you
can go back in time for details. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
