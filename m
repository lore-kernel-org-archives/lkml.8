Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF458C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AFB20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITuPgh2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgFAVBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAVBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:01:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:01:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o6so4050072pgh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=et9c51hfkmjxQJUHJ+h4LoA+bjcYHy6qelWt4gDpXlg=;
        b=ITuPgh2ZuQ3W1x9laYkC5pG6uc3pQZdxsjlMI/1pNFsJBUefBwODF+/kk0exMpqKbP
         Rxk3MmSzpnTC5KmAffcqge1lGMv/UrNDTaZInx405H3+i5K61hSxzCbtnm/36EgwYvak
         /+cbNoLoFA516GECVXWyMKxM/oisbDks/0wW5+f59d2hidmB6MArhgYFJ1OxeQo/8YBV
         mOnpAaGOMpC0PrkYD3fvLg4uLn3bpy0chY/n//CNWksmudBanHhZiXrbW1q0CAe1nv1Z
         Kkl33/3ze7mXh7FqpcZxflSF+igBh6xg7rfj3oWqI7J48FrU4OOKOVdZ9dmoDuaBZEzV
         wwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=et9c51hfkmjxQJUHJ+h4LoA+bjcYHy6qelWt4gDpXlg=;
        b=q+95oFdfROcBJLCQKewr01wuVL8ok1S9oDuEVHoCx7dx9whymr2+Y20n0dNG0YQkD0
         nacIBaiwdN8pNW0Oziu+rL2MsNK6Ie0YOYndGzKqX4aJ1F4AIwJ2JxPsM1nYei24trag
         J0+8l9+PjfpC6bqUgwC5K/900r0NrSJJk6XaaQvXqfgTb+8+t0pk6Enf9Bf6YGMra30S
         yJ6TdMYnHn50qyNebegRkhKbgw0XusdLUxXhvIpB0wireSrcfjKOUWTPOlCetfJiEF/2
         Pl7/nUEUCBkJkcjFQ3Da/aSDH4FgeazaY9cUt5Vq4tRxggGMWN/MUsNg1xctksYfSxgW
         nxeg==
X-Gm-Message-State: AOAM532q0E5YsnsTxuTU/pUL9IZs9MWN4UVQMBlPgDQJcy+u3ZBU6Dwe
        WIsWhAV4aDgCYtYgq9j2Ut7rirh2FSB5j1SA8JAhZA==
X-Google-Smtp-Source: ABdhPJwBLVkPjJIdoG3rSsEI7VOHU5/R9fH/wf7hu0CmB3lrukSmuPPbOGEMmLofI2E2NIYxi+mzpmStQGupv+NyoGI=
X-Received: by 2002:a63:f00d:: with SMTP id k13mr21348706pgh.263.1591045262932;
 Mon, 01 Jun 2020 14:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 14:00:51 -0700
Message-ID: <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Golovin <dima@golovin.in>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> The core percpu operations already have a switch on the width of the
> data type, which resulted in an extra amount of dead code being
> generated with the x86 operations having another switch.  This patch set
> rewrites the x86 ops to remove the switch.  Additional cleanups are to
> use named assembly operands, and to cast variables to the width used in
> the assembly to make Clang happy.

Thanks for all of the work that went into this series.  I think I've
reviewed all of them.
With this series plus this hunk:
https://github.com/ClangBuiltLinux/continuous-integration/blob/master/patches/llvm-all/linux-next/x86/x86-support-i386-with-Clang.patch#L219-L237
I can build and boot i386_defconfig with Clang! So for the series:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Changes from v1:
> - Add separate patch for XADD constraint fix
> - Fixed sparse truncation warning
> - Add cleanup of percpu_stable_op()
> - Add patch to Remove PER_CPU()
>
> Brian Gerst (10):
>   x86/percpu: Introduce size abstraction macros
>   x86/percpu: Clean up percpu_to_op()
>   x86/percpu: Clean up percpu_from_op()
>   x86/percpu: Clean up percpu_add_op()
>   x86/percpu: Remove "e" constraint from XADD
>   x86/percpu: Clean up percpu_add_return_op()
>   x86/percpu: Clean up percpu_xchg_op()
>   x86/percpu: Clean up percpu_cmpxchg_op()
>   x86/percpu: Clean up percpu_stable_op()
>   x86/percpu: Remove unused PER_CPU() macro
>
>  arch/x86/include/asm/percpu.h | 510 ++++++++++++----------------------
>  1 file changed, 172 insertions(+), 338 deletions(-)
>
>
> base-commit: 229aaa8c059f2c908e0561453509f996f2b2d5c4
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers
