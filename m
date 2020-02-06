Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C742C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E21B214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDzqXbH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBFNP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:15:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34997 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:15:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so5434745otd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryGvaK7IdgWsNv1S2gpyspjnVMkTkjmubI6kwmTSrLk=;
        b=kDzqXbH0tYyEVf99zGl3eoyT6Nsn3nOP8W6PodjYpnd2lyosP0ffMCaLysyucPg8WL
         NN6N35Vag2viteeA/AWqyhf/PYw3nnCzF9oXjfBolLOFRGh3VhjPkJGHedpBfRH1CB0x
         OMKuv485yF9gCbiTuzJTDbBslBU9kMW61A9NzNf1j0O1ZoGNIU3ZrbzWdJzgmP/Ao6WR
         Q4B4m1YsesZjytlcnLa4JW4O8pEggwZK1uyzVmHIuL5fXTOlMj3N+dUV+8C5s7seau0C
         OkC/0A6TE7Qx8SBM8pYi3ovQO9+3mJqMsXz7kNZnDvZt2k7GlHFdZeWx3vWtVKrHi1/e
         1u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryGvaK7IdgWsNv1S2gpyspjnVMkTkjmubI6kwmTSrLk=;
        b=VT4NXRk6w8cAZ45ySem+X4oTW0VbJ3glLsJlxYkuOXBBCfWlCEtEiwSZlQAM40rk/H
         M5IO7B3u5wUQZa3ELKDw90ldfbzPnyziq688tnbVEG0DmYXnSUr2QUkbA6EHvtXasOqu
         M49HR/yN9Gzx+pCD2h7GEqjbo6gonoTc7hzfNzt9EHyssOJDDQDsg+6oeHhSxCT9z1tB
         UiAtQk7YuLVcvdbI/oDFFARU6UnnLymjTV2MTPzZIk4v6d115qa99bd5jH4DHlT6jE5b
         EubYPowF6hsX7gNg62nFMw8nylqml/GzoYB6AdCo+Iw1moel4ulNFSxSL1tkPucWfy+r
         uhIQ==
X-Gm-Message-State: APjAAAXjSzeU1GXktDuc2pT6ST4IP7fXfPFn4RRSlbj1t206duRl/4V5
        eFD461ApTRjLVSuQ1ZP5tvPAG05Sx4PD8s02iIoCuA==
X-Google-Smtp-Source: APXvYqwuG5V68sh4B1N3jPGb2RW5gkUg8aKU8ky++9pFGo4LmKCZq7xw0MiKzV76/GK+1L9i3rltjDyyjuVRbNTkhbE=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr18723352otl.228.1580994956896;
 Thu, 06 Feb 2020 05:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-7-kristen@linux.intel.com> <202002060408.84005CEFFD@keescook>
In-Reply-To: <202002060408.84005CEFFD@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Feb 2020 14:15:30 +0100
Message-ID: <CAG48ez19kRC_5+ykvQCnZxLq6Qg3xUy7fEMf3pYrG46vBZt6jQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function sections
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 1:26 PM Kees Cook <keescook@chromium.org> wrote:
> I know x86_64 stack alignment is 16 bytes.

That's true for the standard sysv ABI that is used in userspace; but
the kernel uses a custom ABI with 8-byte stack alignment. See
arch/x86/Makefile:

# For gcc stack alignment is specified with -mpreferred-stack-boundary,
# clang has the option -mstack-alignment for that purpose.
ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
      cc_stack_align4 := -mpreferred-stack-boundary=2
      cc_stack_align8 := -mpreferred-stack-boundary=3
else ifneq ($(call cc-option, -mstack-alignment=16),)
      cc_stack_align4 := -mstack-alignment=4
      cc_stack_align8 := -mstack-alignment=8
endif
[...]
        # By default gcc and clang use a stack alignment of 16 bytes for x86.
        # However the standard kernel entry on x86-64 leaves the stack on an
        # 8-byte boundary. If the compiler isn't informed about the actual
        # alignment it will generate extra alignment instructions for the
        # default alignment which keep the stack *mis*aligned.
        # Furthermore an alignment to the register width reduces stack usage
        # and the number of alignment instructions.
        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align8))

> I cannot find evidence for
> what function start alignment should be.

There is no architecturally required alignment for functions, but
Intel's Optimization Manual
(<https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf>)
recommends in section 3.4.1.5, "Code Alignment":

| Assembly/Compiler Coding Rule 12. (M impact, H generality)
| All branch targets should be 16-byte aligned.

AFAIK this is recommended because, as documented in section 2.3.2.1,
"Legacy Decode Pipeline" (describing the frontend of Sandy Bridge, and
used as the base for newer microarchitectures):

| An instruction fetch is a 16-byte aligned lookup through the ITLB
and into the instruction cache.
| The instruction cache can deliver every cycle 16 bytes to the
instruction pre-decoder.

AFAIK this means that if a branch ends close to the end of a 16-byte
block, the frontend is less efficient because it may have to run two
instruction fetches before the first instruction can even be decoded.
