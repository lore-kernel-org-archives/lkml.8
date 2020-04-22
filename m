Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2F4C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFE62098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeTZHVtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgDVS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDVS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:56:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF66C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:56:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so1301002plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sa/gVNaip+9XRbdoEuhfmV9mpmTLztLhq1CX0xqZKM=;
        b=TeTZHVtryc/TNpZDkEHi8Lap8iCWQeAkNNt/EuK6exhX8Ba2jVVcA+bTbQcnJEr0df
         HX3BkrkG7XxP18JV0chyW5cvhKlzBfw1uD3ir1HuhEPwgY1NiKy6jxedoB+JOAZBH9CY
         1zlHtkyCOlKm3Lxhb6wBA1DtYNVYUuH7SyT4HeoNl71o7u/TIbtCAXHs0EOAMdfu9Ljh
         4lnUJJzKrdrxUaNaORwXM4rQTDm3sFB7k/LP3fZ6D/GeFO5PDSQ/Q3TSboJHODxkJkw+
         SGjDEDsPK1YBKM0xZIQ/B0EKTw2gfFzM5jOJIcz3bip2lC33xt2FOdb28x85B9kWp60R
         bg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sa/gVNaip+9XRbdoEuhfmV9mpmTLztLhq1CX0xqZKM=;
        b=TGE+VQ3XkC0qZ6l5Ejrz5mLRTDNTMORZrqmp5nKHfgeQIhIdaNbzI0aZYt8WWGaDnH
         qELHMjRvxSyyOEnYHlK+a26OSCWYF3eeuGCxSCwd0A91cTGiq8cifEVZ4EYmnO1zLgia
         vKCTHGLNqAzfLaBhAUldv53Mh6l3fCNmQ+jdzOtgLpyRvKQ/oHUKud42cSR0szwj47BR
         yifJaVv8H0CSxROk0lU90eGVZmVuCxEKlWtyRIQhbvgRkXm+3zgB/+QgxTdMN0SC9nzP
         ZY8/3E1af5eoieWnOqK4djmscQ/F78dgvM4+veDglOvs8G8EQhHSSEhe4RtE3BqIWwsZ
         3Ngw==
X-Gm-Message-State: AGi0PubrlVvpxp6U462kLCGU6uIib6c0lHnYXWgFc4kdoVSrE49nD5b0
        nXPwQ0NgNvuPUiusE4/9OBPBHMmgjoxKkJQSmgiJCA==
X-Google-Smtp-Source: APiQypJVmgo8hMpt6SVbdHV0tTZqVK+VaZWQoCa2kBRNcaeP/pRK1RcWMRMS4sqwvHIMgMI0YN5Mz3aCQcVNvE+dYVc=
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr69738plr.223.1587581763189;
 Wed, 22 Apr 2020 11:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200417075739.GA7322@zn.tnic> <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic> <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic> <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak> <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de> <20200422102309.GA26846@zn.tnic>
In-Reply-To: <20200422102309.GA26846@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Apr 2020 11:55:50 -0700
Message-ID: <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
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

On Wed, Apr 22, 2020 at 3:23 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> let's try the simple and clean fix first. Nick, would that work on LLVM
> too?
>
> And I hope this will remain working and the compiler won't jump over an
> inline asm and go nuts.
>
> Thx.
>
> ---
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 3b9bf8c7e29d..06d2e16bedbb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -266,6 +266,13 @@ static void notrace start_secondary(void *unused)
>
>         wmb();
>         cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> +
> +       /*
> +        * Prevent tail call to cpu_startup_entry() because the stack protector
> +        * guard has been changed in the middle of this function and must not be
> +        * checked before tail calling another function.

Can you add by whom?  It's not clear to me which function call in
start_secondary modifies the stack protector guard.

Another question.  Do we not want a stack protector at all in this
function?  I'm not super familiar with how they work; do we not want
them at all, or simply not to check the guard?

But if we're not going to check it, I think
__attribute__((no_stack_protector)) applied to start_secondary might
be a more precise fix.  Though the empty asm statement may be the most
portable at this time, and with a well specified comment, I can live
with it.

> +        */
> +        asm ("");
>  }
>
>  /**
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Thanks,
~Nick Desaulniers
