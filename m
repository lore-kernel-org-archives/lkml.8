Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1043C20674
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594595090;
	bh=zItzV7tGTJkWNA/oxxQuc1H487Z0ZQDfb+cXJt6kZ4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fJpaXU8V8Y4HqVNG5z372YMccnO/idBH4bww3Zz+udLu6mR5mL9WbWycYRdaNceNB
	 SlX+sG6KZPTBkjCdjCF7Zt0KBtuqMhqRB+QPI0f0SH0BQWhzPl1AXaeuCGoLAp1zhU
	 iYxHLFgKu8aCmmyr1gXLipiD3ChbnRe+zOHI9Vik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgGLXEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGLXEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:04:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF62C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:04:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so13280439ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo0Mnk4z2ZKKeclS9nj/V3zBsAaD+8xk/39wn8faHH8=;
        b=JgbUYhmWzr+3//UqU1Ua64whjD+TQo14a7RmhB8c633RX/QOiKcCQbsyY/hFuqiEZ5
         BvLqBjYYHepAIfQNocZKo+mB3oyrODeGszIw3KMFLfUKLJ4N1S+uGMefleAq+uA7OUg5
         DLKYfe4ZuClUyfP06Vewwx33e/+3F2kX7EtpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo0Mnk4z2ZKKeclS9nj/V3zBsAaD+8xk/39wn8faHH8=;
        b=ee1ZJYydwWugLL9BB3kJA6Y0ANfu2UkH4pAsoIo7a+mgqt4a1QYs9D3fjXtYk+IG6i
         AlNOAA+f4bGOYk3A2nr1OpQAkROgy6tquZsRgWSrIp0MHfTHBm+B3MUZ4vp9GKFOPPWq
         JXwW7wyFOm37hkb1OlwAoTFJyYBd+n1kq1T5mfSfsdGLf0jE2JfxdQ6F7ZhD2YDOEGBw
         DKvtA+DKtLTmSZ+jlTk8C5EMTkB5HHmpcd17kW1NNhHVR8sax9DLRdJtgbNIJ+9HzZe7
         g8MNPPNqN4yZ7iy1plaMLXvmz5ycOKq/me0ptGEK/9LulAAYBOaL/Rv2YzDgpnEU/LrV
         cm/g==
X-Gm-Message-State: AOAM530+ummqK3lL/lPJlT4RwNeGFcBeV8jLCUUvrBHw+Zqs+hoBMLu2
        a/L/xwwWXnPw2ivORfF4GAGolFHQZag=
X-Google-Smtp-Source: ABdhPJzlD4QZKP6BRfbZRKyqXNE71wQ3tfIG7QXWY2uTG+Gk636OAfcNmnOvHrBuf5gqzbAJrsLuUw==
X-Received: by 2002:a17:906:6b0c:: with SMTP id q12mr70965968ejr.525.1594595085507;
        Sun, 12 Jul 2020 16:04:45 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id u8sm8337336ejm.65.2020.07.12.16.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 16:04:45 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id dg28so10358562edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:04:45 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr40507440lji.70.1594594702310;
 Sun, 12 Jul 2020 15:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com> <20200712215041.GA3644504@google.com>
In-Reply-To: <20200712215041.GA3644504@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jul 2020 15:58:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
Message-ID: <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 2:50 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> I reproduced Naresh's issue on a 32-bit x86 machine and the below patch fixes it.
> The issue is solely within execve() itself and the way it allocates/copies the
> temporary stack.
>
> It is actually indeed an overlapping case because the length of the
> stack is big enough to cause overlap. The VMA grows quite a bit because of
> all the page faults that happen due to the copy of the args/env. Then during
> the move of overlapped region, it finds that a PMD is already allocated.

Oh, ok, I think I see.

So the issue is that while move_normal_pmd() _itself_ will be clearing
the old pmd entries when it copies them, the 4kB copies that happened
_before_ this time will not have cleared the old pmd that they were
in.

So we've had a deeper stack, and we've already copied some of it one
page at a time, and we're done with those 4kB entries, but now we hit
a 2MB-aligned case and want to move that down. But when it does that,
it hits the (by now hopefully empty) pmd that used to contain the 4kB
entries we copied earlier.

So we've cleared the page table, but we've simply never called
pgtable_clear() here, because the page table got cleared in
move_ptes() when it did that

                pte = ptep_get_and_clear(mm, old_addr, old_pte);

on the previous old pte entries.

That makes sense to me. Does that match what you see? Because when I
said it wasn't overlapped, I was really talking about that one single
pmd move itself not being overlapped.

> The below patch fixes it and is not warning anymore in 30 minutes of testing
> so far.

So I'm not hugely happy with the patch, I have to admit.

Why?

Because:

> +       /* Ensure the temporary stack is shifted by atleast its size */
> +       if (stack_shift < (vma->vm_end - vma->vm_start))
> +               stack_shift = (vma->vm_end - vma->vm_start);

This basically overrides the random stack shift done by arch_align_stack().

Yeah, yeah, arch_align_stack() is kind of misnamed. It _used_ to do
what the name implies it does, which on x86 is to just give the
minimum ABI-specified 16-byte stack alignment.

But these days, what it really does is say "align the stack pointer,
but also shift it down by a random amount within 8kB so that the start
of the stack isn't some repeatable thing that an attacker can
trivially control with the right argv/envp size.."

I don't think it works right anyway because we then PAGE_ALIGN() it,
but whatever.

But it looks like what you're doing means that now the size of the
stack will override that shift, and that means that now the
randomization is entirely undone. No?

Plus you do it after we've also checked that we haven't grown the
stack down to below mmap_min_addr().

But maybe I misread that patch.

But I do feel like you figured out why the bug happened, now we're
just discussing whether the patch is the right thing to do.

Maybe saying "doing the pmd copies for the initial stack isn't
important, so let's just note this as a special case and get rid of
the WARN_ON()" might be an alternative solution.

The reason I worried was that I felt like we didn't understand why the
WARN_ON() happened. Now that I do, I think we could just say "ok,
don't warn, we know that this can happen, and it's harmless".

Anybody else have any opinions?

               Linus
