Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CDE20659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osLbuie/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbgENAvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgENAvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:51:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:51:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so498031pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbWGZjtybDfcEI3YIw2tpOyVCftS9qbkOqtHtAr39Dw=;
        b=osLbuie/2ncAMEeXy93/D+AgzeoiKpAc38GwDoktN1YDNYry3qpjzCvcGIXEyxDd4I
         zoMIYuuAXowXZNIrhAKRbI7IYWJBvByyxeOh0PwWtnN+0FTyndVCAcyp+SZ+84HhAwpu
         5biP7eOGGtXb6DlTkqv5SJXlPCzC2I3Wny8HMqjD274TQgaL2NJF+EWyGVz6xr28ZN1j
         mXhq5vGsIRbiK6Gvfe944+PiHDoXLQbKv1rk4EYkCdm9pyONyoA4LyG+BBk40lQWzVTi
         4aJONNZFjJkFmZ8DDGH/U4fyssQqINUIZXs3MXspQxAI1mvc+Frmp1AKj2iH9pOf4BKc
         tGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbWGZjtybDfcEI3YIw2tpOyVCftS9qbkOqtHtAr39Dw=;
        b=gpmW1Duk7XDyMpyUZoGag0Bx3AfLhNVTHBYvsQunk2+FSVP2aCPh4u+PUnXdgVs+oW
         6ZI2djMh+3JxXoeQKih5giy5ITiRixdUIZtzqZRLN4bZcCgJwMpISxaFryvypNMAhENh
         njd5afQoxp4OSxbTs3HYamav6qmV/s96HzrJo+lor8hLRc2f54DuwvceoncQA8qmXhtQ
         eZGjNV63yG6DmiGlnSO7bwVz7oBIfiESKJrJVxVaW6L0gfb8nEUcHY8jkqc5FKao03sj
         0vBXFzmES31HvgL+g7VjMW8LsEAVTka/O061oM3iUqu3BXEp8G1WXpvb4XRM16UIrRLx
         ni+Q==
X-Gm-Message-State: AOAM531m6bAvWFWKFWa5Ue/atY6V4OfNVTq85WcIE7h4UgndG+INfe3H
        6+nP3p14k+xlYXA9QlCFr2oJQKDeMfEkdHVtTfvskg==
X-Google-Smtp-Source: ABdhPJxjlEbKRxEvhhabZXB1Qqxy18qboWidG9h/nWiHChhpsrWu+W/q6pNtkqJMweyMUa5XhkhHgz0efk86iWYITao=
X-Received: by 2002:a17:902:a401:: with SMTP id p1mr1684088plq.223.1589417471261;
 Wed, 13 May 2020 17:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic> <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
In-Reply-To: <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 May 2020 17:51:00 -0700
Message-ID: <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 5:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 13, 2020 at 4:36 PM Borislav Petkov <bp@suse.de> wrote:
> >
> >
> > Looking at them, they do have an mb() too so how about this then
> > instead?
> >
> > #define prevent_tail_call_optimization()        mb()
>
> Yeah, I think a full mb() is likely safe, because that's pretty much
> always going to be a real instruction with real semantics, and no
> amount of link-time optimizations can move it around a call
> instruction.

Are you sure LTO treats empty asm statements differently than full
memory barriers in regards to preventing tail calls?  (I'll take your
word for it, I don't actually know, but seeing an example of real code
run through a production compiler is much much more convincing).

The TL;DR of the very long thread is that
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722 is a proper fix, on
the GCC side.  Adding arbitrary empty asm statements to work around
it? Hacks.  Full memory barriers? Hacks.

I'm happy that GCC does an optimization that Clang does not.  At the
same time, it sucks to pay a penalty for a bug we don't trigger.  This
is the same reason why `asm_volatile_goto` expands differently between
GCC and Clang (and why I tried to undo that like a year ago).

If Clang realizes the same optimization GCC is doing here (related to
tailcalls) tomorrow, well we already support
__attribute__((no_stack_protector)) which can be added to the callees
we don't want tail called in this case (i.e. allowing tail calls).  I
should send a patch adding that to include/linux/compiler_attributes.h
and annotate the callees in question, before we forget about this
issue.

Sprinkling empty asm statements or full memory barriers should be
treated with the same hesitancy as adding sleep()s to "work around"
concurrency bugs.  Red flag.

And LTO is fun; we've been shipping it in Android for years (and need
to attempt upstreaming again).  Just today we found an ODR violation
in one of the most important symbols in the kernel.  Will be sending a
patch for that tomorrow.

>
> I could imagine some completely UP in-order CPU that doesn't need to
> serialize with anything at all, and even "mb()" might be empty.  I
> think you can compile old ARM kernels for that. But realistically I
> think we can ignore them at least for now - I'm not sure the link-time
> optimization will even do things like that tailcall conversion, and
> I'm not convinced that old pre-ARMv7 systems will be relevant by the
> time (if) it ever does.
>
>                    Linus



-- 
Thanks,
~Nick Desaulniers
