Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB5C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52758207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0L8enuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgIBSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:19:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B36EC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:19:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y11so331893lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UOQrf/1Zuzh+bE0/siV6+xA8AEKujMA/kbnLKMMbYE=;
        b=S0L8enuhf0rblLouu8TzfTWlxrEfFtsBaukqEHzPXCMsnPPkHfqx2B5lhfOBH4Y1dp
         OS6eKvRVq7pHrnJg2iDw+kFEyA0yMb2GYevHYR6eLRg6yW5pWyPEd1qqvaX38pLOGrkx
         oBEFq14DIcUd9FTycvG7PD8HTSJVm2Fz8Uh/fYKNL1IxIoGjKvEQo4QHJoC0w12yw1Du
         2r72o2ZSp/cepht/QKjhKEp30RORtY5gkWn2mh38SRUsqpBdd2HWMIuqWDnhnKk2vuVw
         0COx77sts5iz0dkm9PTir7u+yKcV9n7kk3nOdRCjU70Pnybq28GcyX5wnPaUTNJjfLWb
         Du5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UOQrf/1Zuzh+bE0/siV6+xA8AEKujMA/kbnLKMMbYE=;
        b=r9LPgmxlsaLHcVphGF3VWAMsxkbt1InJ+oTMqloN0GV+hviwXJYe90aSW2/aBOhyy7
         kgK+A/EVKn+MkaX+RuOLHh5yHV8rSLKqIm/44oP1qtzN2k985M5uz/rRUvXUO5nWYMPe
         H/aEarO0fkXynKw8DcOn3W+p02x9WQGpB19NlNJsq0tMcsj9pe/F/1NMxdh5+ZvKTInE
         kYed46pbwPHfSBlsDxg/SSZXB57lLgP9mwzs9WZZyc8iEE4hzqQtIGj0EyMl2AAsb0xL
         I5TfKaeZKtzadjDU7YTEj0GyjChCU32CYXNfjsDgEQQZoooxcI0yPwbXubfPHo8Syvf6
         /Tmg==
X-Gm-Message-State: AOAM530F7h0tQKmcxdub8tVh0T6yzwgyHO7GYUtAyXA9jrl8+gGE1XcS
        OdYMzrD0K/blmC3wPex2+1UfluOXJxfeLXtt0LQ=
X-Google-Smtp-Source: ABdhPJwSHno7OsbhLnJ+OIt8i5OEtU8zgNQDmD01hPbOslBRByfSKa4JsB4q6UQKOFYAn7hpjEq2qR7VtOklr00Q344=
X-Received: by 2002:a19:7e02:: with SMTP id z2mr3938053lfc.130.1599070776561;
 Wed, 02 Sep 2020 11:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200823212550.3377591-1-nivedita@alum.mit.edu> <20200902153346.3296117-1-nivedita@alum.mit.edu>
In-Reply-To: <20200902153346.3296117-1-nivedita@alum.mit.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Sep 2020 20:19:25 +0200
Message-ID: <CANiq72=jwj0xocJ7iAkntbnHDQphL79XcPREz1qpW0yqrMsz4g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: Replace __force_order with memory clobber
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:33 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> + * The compiler should not reorder volatile asm, however older versions of GCC
> + * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes
> + * reorder volatile asm. The write functions are not a problem since they have
> + * memory clobbers preventing reordering. To prevent reads from being reordered
> + * with respect to writes, use a dummy memory operand.

I see you added the information to the commit message, but I'd still
reword this to something like:

"The compiler should not reorder volatile asm, however GCC 4.9.x and
5.x have a bug where they could sometimes reorder volatile asm. The
bug was fixed in 8.1, 7.3 and 6.5. The write functions are not a
problem since they have memory clobbers preventing reordering. To
prevent reads from being reordered with respect to writes, use a dummy
memory operand."

The important point is that 4.9.x and 5.x *have* the bug and that is
the reason for having the hack. In the old wording it seems like the
bug is no more. Then one wonders why the hack is still there (i.e.
perhaps because we don't trust it, perhaps to support the rest of the
minor versions which are newer, perhaps to avoid regressions, perhaps
only the comment was updated, etc.).

Cheers,
Miguel
