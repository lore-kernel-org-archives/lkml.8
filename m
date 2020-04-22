Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC5FC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185262076C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k53gcYui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgDVVF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:05:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8ACC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:05:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s10so1445692plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUKNu7tEP2Ew6mpJstVWpghTc6pfH8SZlsjBVVy2IUE=;
        b=k53gcYuiX1USwy+BW91kJIwRsEU6oXQm3/UpxGhd1ktKmz2KU5yUG3TA7f3WqtMUEO
         FcNIStlDZmO/lZc2LN/LwPsUdOVD39uJwLS76s49B9en/geQBSRycOdCeVERCU5wGwaD
         JmSw5WpCaajNnFmrl9SSTTuBhCT3sZIYje7Y4lVQW0cakWgyRLkbtYzE45G8H1tcXDda
         vyiQt0dWXV8N6AMyIr1/GoYDTI/pGphlqDWGFwhve1LMMm3Bky4uZzUW0F8kLCAPq5gb
         JUx8V1IS0rOvS0RIqO9priwIMoW5HBEePhMyTceBphZOxdB+GxHj21Kyu1R51omB8ZaN
         m1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUKNu7tEP2Ew6mpJstVWpghTc6pfH8SZlsjBVVy2IUE=;
        b=ZaFIf8X6Kdp6R7WAFW/W8Oj+71So0cwUQRaee4ATpLp0zidtsOv+0eD7sw7bHkMykS
         +KELSYuVwRCot/IQQJ6qQqN2ObSgwJzQG8fjcwuVNQq8WWebvJ9LieIyGsSv/AI52TcW
         K8EibtTkBfh48I60x5xkIOtU5yJnS8apKgQh7FIbOeyKpaaf0LB4zNQLwNTyyrTH/bhi
         zpLBQli1X7mi7Bxa9i47VbJZyhyhE7p95Z7/pP4MQflDGA8XJJeFHcT/kRPgWyKT88d+
         RTJ1y0ESWQyN0kDU2gaXst974dUVMTISoj6hgaaJpizyzJ0143LIeJITLz68bDff6hTO
         ec7w==
X-Gm-Message-State: AGi0PubERAr/WliEgf46CYMCDtlLb1QRvTyok00RFBtQF3bRlVNanawJ
        cUbqz3ivKZze9oDCntqYofDAMo/vptp47GFrOXSq8Q==
X-Google-Smtp-Source: APiQypJuNmxit6aHwS/kRGsdzJHNuQJ1C/ioEexuaDDfNUIbezMMXmIvKOdkY6SbxZB+saLLq7excV9+8tBRqxyUpHk=
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr616512pje.186.1587589525583;
 Wed, 22 Apr 2020 14:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200417084224.GB7322@zn.tnic> <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic> <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak> <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de> <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com> <20200422192113.GG26846@zn.tnic>
In-Reply-To: <20200422192113.GG26846@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Apr 2020 14:05:13 -0700
Message-ID: <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Borislav Petkov <bp@alien8.de>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Apr 22, 2020 at 11:55:50AM -0700, Nick Desaulniers wrote:
> > Can you add by whom?  It's not clear to me which function call in
> > start_secondary modifies the stack protector guard.
>
> How's that
>
>         /*
>          * Prevent tail call to cpu_startup_entry() because the stack protector
>          * guard has been changed a couple of functions up, in

s/functions/statements/
or
s/functions/function calls/

Sorry to be pedantic and bikeshed a comment! *ducks*

With that you can add my:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


>          * boot_init_stack_canary() and must not be checked before tail calling
>          * another function.
>          */
>         asm ("");
>
> ?
>
> > Another question.  Do we not want a stack protector at all in this
> > function?  I'm not super familiar with how they work; do we not want
> > them at all, or simply not to check the guard?
>
> Not to check the guard. See the beginning of
> arch/x86/include/asm/stackprotector.h about how they work.
>
> > But if we're not going to check it, I think
> > __attribute__((no_stack_protector)) applied to start_secondary might
> > be a more precise fix.
>
> No such attribute in gcc yet. But yes, this came up a bit upthread, you
> can go back in time for details. :)

Filed: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722
(Maybe a link to that might be helpful in the comment, for future
travelers? But I don't feel strongly about that either way, and
trust+defer to your judgement).
--
Thanks,
~Nick Desaulniers
