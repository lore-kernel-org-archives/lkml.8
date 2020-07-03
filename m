Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE308C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B1F20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593810736;
	bh=KMDl0z/p0U7Je8h+UdGSAHuuVBZOZgrxfJm9Z0zvuAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aOpp7MLUW4nKoP4CJITjUdZUing7pcQXHKrMDRUkgf6SVvL8wq1cHPd54eCX1zybb
	 scV/a0fZJl41OZ4/UNYkTVTQTiY5pgvd5CbFdnzLigGam/uG6ut2CHKWbVTChZURbU
	 nrh2ZVfUU9fHwi1EDBLuG+b737p7o6p5w5ZBjek4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGCVK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:10:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D887C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:10:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y18so19217988lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgsjBBBVVhmo4cduLfFueoI3YSDE6SkDv8XCpwuHNSE=;
        b=P71Y+HcGmg4OROjroEwKHfDWFYbqWVoWHZVrwtaylpdbxcHpTYuyxe41LuxzgKmdhs
         0FHNlgMfjdGKlIPmTamzTM/Ry0tNNM9gXk4EP1RBQtIgXoZvQd4duF3zzE7zZFJPJKI0
         nayPMttQHgQ8V5oxZiD61iFL/Wm9KqKJGBV5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgsjBBBVVhmo4cduLfFueoI3YSDE6SkDv8XCpwuHNSE=;
        b=FG8iS/JEhN+op4lkex+umVAhhUDYeZzc6naMhljd/UOWrGjfSI4NkipOgqgjXbwNR/
         tpOTg5w18xj8J6wqHsnxQuDYzqfxCPTHI57RiIe+NfCdGfr+VDtgeUdTWr9N8l/4kvr6
         dNsQZu2IY1Vx4KzSDcpxHtMGd/R8NgFPHiVfxy6PIF7DBkhI3QMDqxHiVfYm38ZiqnW8
         S0zOOu+m/S7nsJLFo08789uBx/hMLGL24Tc30aKs4leXEUK+KShPF1Q2cObFBojpMc9x
         DpwnoZqE/qULIqlV5PNERaY7lE0Lvr8Q349+BX/ZAeKxsB8S8w/GxjqH6SesMa5eioZV
         VH1Q==
X-Gm-Message-State: AOAM530+/MQuxbHclM4RPtTCFttWLN0VcKGU+6sEwl5K1xM01msZuiUC
        BC65MOyYreMmnrzaROZtgc45i7lGdCU=
X-Google-Smtp-Source: ABdhPJx8oZ1KD3dOWBCN0QtVPw6Nqg/yFW3OlOwrVXoh90xDWgzmivDUSQNDdmSUd2rtfwFCDD+2dA==
X-Received: by 2002:a19:e61a:: with SMTP id d26mr17634546lfh.96.1593810625820;
        Fri, 03 Jul 2020 14:10:25 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y69sm5060682lfa.86.2020.07.03.14.10.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 14:10:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id t25so33867644lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:10:24 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr17747719ljn.421.1593810624132;
 Fri, 03 Jul 2020 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk> <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk> <20200703210237.GS2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200703210237.GS2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 14:10:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
Message-ID: <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 2:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Actually, for more serious problem consider arch/x86/lib/copy_user_64.S

What? No.

> In case of an unhandled fault on attempt to read an (unaligned) word,
> the damn thing falls back to this:
> SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
>         movl %edx,%ecx
> 1:      rep movsb
> 2:      mov %ecx,%eax
>         ASM_CLAC
>         ret
>
>         _ASM_EXTABLE_UA(1b, 2b)
> SYM_CODE_END(.Lcopy_user_handle_tail)

In the case of "we did an unaligned word at the end of a page, we took
a fault, and now we have to start all over", the _least_ of our
problems is that part of "starting over" would now imply doing a
"stac" again.

Yeah, the "stac" instruction isn't hugely fast, and serializes the
pipeline, so it's a nasty 20 cycles or something.

But for chissake, this
 (a) happens approximately never
 (b) is after a fault that took a thousand cycles

so the trivial thing to do is to just say "yeah, you need to add the
STAC when your optimistic thing failed and you have to fall back to
the byte-at-a-time tail case".

It's particularly trivial since objtool would statically find all
these places, since it would warn about the ASM_CLAC without a STAC
(that's assuming Josh's patch, of course).

              Linus
