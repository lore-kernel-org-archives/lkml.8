Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDFFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763F72074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV65ZGn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHXTNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:13:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9956C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:13:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so10945614ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIo/OMGOZUKbLvU8KZnqtxEPhcYdwmaMGDjLYphHlDo=;
        b=OV65ZGn7Ue51KMsxhKY9Pw9yYHazdrP5PyzZj/Ix2mk+Xz5KoKMA6Anus8fGGxZ1Bg
         RDHPuZMKh0eMRn7ruzxM/nmbmGCuNRf5sR5tIY/AN4TpFBBKo2nUaGctozRd4tByfixN
         FKRCy427RzyMIQjD1powMOuQzn67sx27XfAYvydH7w+m3PLoz9ujYOZD284oQRaeWf/s
         lQzM+zyQrjiCYNQDiPTsNSq2OCp8i50faAYkFwJiu3KtlraiWlmMEuZljsEgLVlWObMP
         0EOZcIG0Y0mcBXc7VwngsrOB5SN43Mi+rdmFIkKry9JgzEz6Iw1eCivnwW05FNLaWhQd
         fRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIo/OMGOZUKbLvU8KZnqtxEPhcYdwmaMGDjLYphHlDo=;
        b=UErdTPTx1R6Lzi+JdnT/mqZRvwjt1cWVh/YzPo/Lm/S3QNqZpwgNBBll3+k35poDp8
         Ul4E2i44Kl+aRWcTShtxq+yTQwhbQb0lpIDNev/pI66mkkpuWvruOLU7ZOyfd+zzZ0N0
         93bn8mU0dmC556LwOubbvZdl83cTc29c5PcOmTEyl62fW0JgSlkNPNFg/lGotnsYIGO5
         6QTlX2fzG7b5p5MEuN/sBY3oCSFUixF5HIsG0WHtdpTErsM0pLanXNXdqrMle+gvlqIM
         zr4Fh+Gn027EiAZCGe4a4FkQrskklAJ/Yymy0/p7AEQW/3GVyxv530cvGt7so2HmPI3R
         +uPA==
X-Gm-Message-State: AOAM532493vL6LtMRTELqJrc9awSvzFpGUFd0G6HmgewRu7X345RAMC6
        7jj1mzyvTiyNvSMEg776euufO5nISYJdwLtBFHQ=
X-Google-Smtp-Source: ABdhPJxO7lcsPV8QuGvnkqDfj+pm7bwayzOyWDabhiE08EBjv/MKCOqF7QWXVJIJOURs+bPWk/yMIsUO9GBATMeuiAE=
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr2881162ljg.95.1598296426138;
 Mon, 24 Aug 2020 12:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200823011652.GA1910689@rani.riverdale.lan> <20200823212550.3377591-1-nivedita@alum.mit.edu>
In-Reply-To: <20200823212550.3377591-1-nivedita@alum.mit.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 24 Aug 2020 21:13:34 +0200
Message-ID: <CANiq72kWaS=8rDQ81cCY3021=1J5yFfJk8FHBQEjhtssRFoVcQ@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Replace __force_order with memory clobber
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

On Sun, Aug 23, 2020 at 11:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.

Assuming no surprises from compilers, this looks better than dealing
with different code for each compiler.

> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602

A lore link to the other discussion would be nice here for context.

> + * The compiler should not reorder volatile asm, however older versions of GCC
> + * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes

I'd mention the state of GCC 5 here.

> + * reorder volatile asm. The write functions are not a problem since they have
> + * memory clobbers preventing reordering. To prevent reads from being reordered
> + * with respect to writes, use a dummy memory operand.
>   */
> -extern unsigned long __force_order;
> +

Spurious newline?

Cheers,
Miguel
