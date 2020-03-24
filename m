Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F20C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACA72076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m46TPzI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCXRaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:30:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38632 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCXRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:30:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id z25so5298195pfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kq+FYdniWIla4pk5nZSbH7cg3uuV8JkCybEVH1HaxnI=;
        b=m46TPzI0nrj30YVTG7qLQejHAv7snUYYtbN2Pdjv2gzb4sBZajt9MO/hkb9Y9uEqWh
         qa4JiXYKikVNjVFlogSQb4lcN4+OycFM6og456ZiK4VuXHyVK6vqVD2IKbLZp8L+8udE
         g9nOq7xk0uimdDmZPVa1XV3YcU9UW6FUrEcffLo6Hs8fuCImxoDAP7YN+xrZanoeKywK
         BwlDpHyNkycj77W9BZUyAl3PfnbNNyz+lMse/iogu/pe8JseEPhAovXxnHBUXZuRRgsT
         rvPZQbC1wQiPwpphWmzKrmz4CdeUHnHGry/FMvkA+OdWCdXpFVwCnM2O20JyX1CiODsb
         Juqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kq+FYdniWIla4pk5nZSbH7cg3uuV8JkCybEVH1HaxnI=;
        b=fepIUG9yE4gIT7MWkF0DRFOZyPD74yhabYM8mPvfharAHA/nsUQRDe//Sd+LVR0q4i
         peD9YmLbWujun9q4TdCGs3fVczbu9ubho3JtZ39CnG+/rd6qKvBAGvjGWvKMyzH6dUbc
         FXtVXVV2IhzdrgsYlLM0uHyAWfeh19obeGHRzPmT/la+9c2QRMO3g/bkHvq6kbNqbQof
         mwiFhbs9kgbL8hZuAP28tFKjXudOgf7G1Kxk+A8zRPElaWKVYQx4SuILTl2jIHyarLo8
         mxiTPEYORwQT00nuQEmCX3DG+WMmJd/+dxL6juxrPxplOUI1DZmkR/Duf7WefH3gx3xa
         J+jA==
X-Gm-Message-State: ANhLgQ0jFFxNgJSJByFJ9tp5sjflcbS2ksB0vcIdnjh/7fHQO8Cd1NB5
        VhOWzfprgVQlzV2GCRoHOBik+J3mXuXclzG99L2k3g==
X-Google-Smtp-Source: ADFU+vsKpVcyMN7SHaU5E8bZ8b6YqqyPsLUiZ2gvHBO0FlZ4uEXUmmLB4IgRNlvnII9SZxMoTSrz6TwW9egAt+ohX00=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr29126500pgb.263.1585070999349;
 Tue, 24 Mar 2020 10:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com> <20200324140639.70079-1-courbet@google.com>
In-Reply-To: <20200324140639.70079-1-courbet@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 10:29:47 -0700
Message-ID: <CAKwvOdm6GH4nqMkK99g5y5q0VfE9J70AdBP4C-xkxQbgJf_tzw@mail.gmail.com>
Subject: Re: [PATCH] x86: Alias memset to __builtin_memset.
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 7:06 AM Clement Courbet <courbet@google.com> wrote:
>
> Thanks for the comments. Answers below.
>
> > This ifdef is unnecessary
> > This needs to be within #ifndef CONFIG_FORTIFY_SOURCE
>
> Thanks, fixed.
>
> > shouldn't this just be done universally ?
>
> It looks like every architecture does its own magic with memory
> functions. I'm not very familiar with how the linux kernel is
> organized, do you have a pointer for where this would go if enabled
> globally ?
>
> > Who's adding it for 64b?
> > Any idea where it's coming from in your
> > build? Maybe a local modification to be removed?
>
> Actually this is from our local build configuration. Apparently this

Not sure we should modify this for someone's downstream tree to work
around an issue they introduced.  If you want to file a bug
internally, I'd be happy to comment on it.

Does __builtin_memset detect support for `rep stosb`, then patch the
kernel to always use it or not?  The kernel is limited in that we use
-mno-sse and friends to avoid saving/restoring vector registers on
context switch unless kernel_fpu_{begin|end}() is called, which the
compiler doesn't insert for memcpy's.

Did you verify what this change does for other compilers?

> is needed to build on some architectures that redefine common
> symbols, but the authors seemed to feel strongly that this should be

Sounds like a linkage error or issue with symbol visibility; I don't
see how -ffreestanding should have any bearing on that.

> on for all architectures. I've reached out to the authors for an
> extended rationale.
> On the other hand I think that there is no reason to prevent people
> from building with freestanding if we can easily allow them to.

I disagree.  The codegen in the kernel is very tricky to get right;
it's somewhat an embedded system, yet provides many symbols that would
have been provided by libc, yet it doesn't use vector operations for
the general case.  Adding -ffreestanding to optimize one hot memset in
one function is using a really big hammer to solve the wrong problem.
-- 
Thanks,
~Nick Desaulniers
