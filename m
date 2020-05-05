Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1575C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF512068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588704983;
	bh=PdQpdNxjqmIC/2YRAqZNGAKFlA5zkFAy+Pvp2pJ381g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VvrpPn7V3a5/aC4iJVqjCf1jfQR7+d8B30Z8cR5fCdRJhsZycNp+00kf5qIvaRX32
	 323fm8c8op9xTfBMpAV40bhaSPdJfsh9jGclnDdA7cjZp176miK6jjQCt8Pd1mTEHz
	 E0ZQr0OExeN5EAq+jWIvZD9DXvod7gi6xQn4N8LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgEES4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEES4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:56:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA73C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:56:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so2662460edv.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aeZoygCkgdrdhCxkXT0t0qKXTgK7qHp5yzHDFCrrt4=;
        b=OrJoG2wV8NG38EDX42NRpQ3EMDSZgAZf0hVOcarbH8A4++ycqW8Y9x/9hb4ZNBZlqN
         dBkmuhTl6HbYw63JIBeijQn6SIb61l3l6ZRUEMNPIwYceF2Qq58dZcj35hiyFqu2rx7R
         OenyZW/iEsgRhBpi0c1mDGw5mrptZx2nvvV+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aeZoygCkgdrdhCxkXT0t0qKXTgK7qHp5yzHDFCrrt4=;
        b=OWImQP7AJ4lW9ATQtZsiOuL2jtKy8CRaN563KJW+IvbJkJnuv7cZTs6JGeUo3K5G0D
         2Ad/3R1EyyTwfWkDqClWFeGDb1S7UxEqOEw9rL5IY5/J10+6A3xLxqzue03rMR7qDvkr
         bEXGlv9S0Rqt9S/Eq/KZvYsSFZw1GQUEDyg1A7woRPg5iUUtXDbyIeLCF6Ela2XZZBrW
         /hfNeSkyKuG5fECzzrM54iUeJfLgf169Pegbn6ZbCDX066U4BUR4wHwoM5HXtzvercWv
         p1vhZYjPZU1d9b+NTQyIKdLRbDFPiWtU5e0lIk4eCrRAZQ7wzmwbkUfqNvbrFl3Cs8Tl
         EmGA==
X-Gm-Message-State: AGi0PuZqlCG5p/Dse1jgBQRN/MpN2VVI8qRpcxNn3+dhaJZwc+GQuAzH
        wQHI0NBInwDiNitGf1DkwAiF9ORdXnA=
X-Google-Smtp-Source: APiQypJwFG2E5fw75bLhroRoVpYqh9ST6I66f+9lenp//FEM/cBZW3/cpm8/FiDpKsFsqo4lnJ3d+g==
X-Received: by 2002:a50:a7e4:: with SMTP id i91mr3837997edc.381.1588704978715;
        Tue, 05 May 2020 11:56:18 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id s18sm343391ejm.63.2020.05.05.11.56.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 11:56:18 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id y4so3776511wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:56:18 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr2492888lfe.152.1588704525320;
 Tue, 05 May 2020 11:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200501202849.647891881@infradead.org> <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk> <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk> <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
 <20200505093625.GE5298@hirez.programming.kicks-ass.net> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
 <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 May 2020 11:48:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com>
Message-ID: <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 11:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Changing
> void *func = READ_ONCE(name.func); \
> to
> void *func = &READ_ONCE(name.func); \

What? That makes no sense.

Yes,

    void *func = foo;

and

   void *func = &foo;

are the same thing, _if_ "foo" is an actual function, because then
"foo" degrades from a function to a pointer to a function as part of C
type semantics.

But that's not the case here. READ_ONCE(name.func) isn't a function -
it's a pointer to a function. So it doesn't degrade to anything at
all, and adding a '&' in front ot it completely changes the meaning of
the expression. So now the '&' changes it from "pointer to a function"
to "pointer to a pointer to a function", and the end result is not the
same thing any more.

Without the "&" it will call the function "bar" (which is the function
pointer that was assigned).

With the "&", it will not not call a function at all, it will do a
call to an address that is actually data of type "struct
static_call_key".

That's also why the NULL pointer check goes away: now the pointer is a
pointer to static data, which can never be NULL.

That said, I found it interesting that the volatile read also goes
away. That struck me as strange. But then I thought about it somem
more, and realized that the '&' basically just peels off the '*', so
now there isn't any actual volatile access any more, which is why the
read went away too.

Anyway, adding that '&' completely changes the meaning of the test.

Your initial reaction that "you can't compile away the read and the
test of NULL" was correct, I think.

                   Linus
