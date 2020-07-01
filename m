Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B59CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9D1208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593637384;
	bh=snTyeY63qTGUw29voMUg3c3I3UJoKbQgVp+Tgu7nsjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VSLywsOb3E+bP7NhnhbPbgdV9yWpAEj6XabuDeZtl6Ei3KELXY29r8P9hHp/HavYk
	 orWz5351/ZtdEFRrt+4Qw0/jH7HcSMVVJBpfWQT3DYDklHZB4BNqaD0C7/dp7hcFbb
	 MQ/ovfCgnN8/KQvHbx/lIRPur9FWWlkeHR1Y7n/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgGAVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgGAVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:03:02 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA716C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 14:03:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id t25so24327666lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJJQ0JuSWbNincDMm+mwtyZQMnCdEroZXX8CnDea68I=;
        b=gZ8TD+jnU7OaD3x3gkybCeHrYMmT6lBf9QwEBW7+9DFLrbf4hlFHHJJHNCDWMDKt9O
         sqy39UJQbL13e7j9qdt/YVfX3zmsz9bdW9dqOW6xdFcJugF9ujGAHU91OUIRJKiiaD0+
         cHqU1KIT5fVviHAZ90mmMkvOVj7MOn+ogU+eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJJQ0JuSWbNincDMm+mwtyZQMnCdEroZXX8CnDea68I=;
        b=CHJJ2qpbsvo6BnKVmA56rt9Iu/EH6pVvUa14TmWd6rR2jm+9Gb3z6q8W6qqkz7m9v5
         3rjGN+FT+E6FJ3MU34iKYJXof3z1wkuKi+DLZQFqTziTTSX2x2o1Fr/+lm9iweWEntR7
         V+c1OhaUkuQaZjdfsjhfC8QQnhYTlN89llC0tUWijOW9aY2IZKzd0W5CGxGacFXoxwTK
         UazTMSAD2LUXwBUTaABmXJFxJzUOMTbJAw9Oebddb+P5w2Yv8DkRJKiRKHUn9lQJYLmq
         7eK0DSJyBnliqqnclN2GZ5A5ThbqbYLUDTNvDq5BPljjTaObNMwEjzXDDVjO+Fyf1ocW
         EWlA==
X-Gm-Message-State: AOAM533JemgQWkcyO30PrfMelT6DEHHqyI4uXJwieKEPPbaSjdtimWvW
        a0sWtkukM149EqiE3/sl80dTUshYTQw=
X-Google-Smtp-Source: ABdhPJz9fOnGXLKvwjSHWLyYt6/Icm4Z4jLs+pvvcoZR0k9Vyfsfr2nS8UReKYNScaNQypoU+ARzGA==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr9877796ljj.424.1593637379763;
        Wed, 01 Jul 2020 14:02:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2sm2445032lfr.48.2020.07.01.14.02.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 14:02:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h22so21758484lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:02:58 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr15024788ljj.312.1593637378147;
 Wed, 01 Jul 2020 14:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net> <20200701205108.wtgfnijav7lgfiqe@treble>
In-Reply-To: <20200701205108.wtgfnijav7lgfiqe@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 14:02:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY-67yt4kGd2EW-7kChQgnLHZ_2aJ+=ps7i7rCz894PQ@mail.gmail.com>
Message-ID: <CAHk-=wiY-67yt4kGd2EW-7kChQgnLHZ_2aJ+=ps7i7rCz894PQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 1:51 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Yeah.  Peter's more of the expert here, but I think we'd at least need
> to annotate the code which expects an implicit CLAC so objtool knows
> what to expect.  It's not trivial, but it might be doable.

In both C and asm code, it's the "_ASM_EXTABLE_UA" cases that would do
this ("UA" being for "User Access").

In fact, it should be quite easy to see: the thing that distinguishes
those things is that the exception handler is "ex_handler_uaccess". So
objtool should be able to see that quite easily as it follows the
exception tables.

It's a special case for entirely unrelated reasons (reasons objtool
doesn't care about): a user access exception can be either due to a
page fault (normal) or due to a misformed non-canonical address, and
we warn about the latter case.

That said, I wouldn't necessarily object to making the rule be that
*any* exception handler invocation will always do the
user_access_end().

It sounds dangerous/wrong to me to do anything that can fault (other
than the user access itself, of course) within a STAC/CLAC region.

So the objtool rule might be:

 - in a STAC region, no exception handlers at all except for that
ex_handler_uaccess case

 - and that case will clear AC if it triggers.

and maybe such an objtool check would show some case where I'm wrong,
and we do some MSR read other other fault thing within a STAC region.
That _sounds_ wrong to me, but maybe we have reason to do so that I
just can't think or right now?

               Linus
