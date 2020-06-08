Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A492074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H45ROcx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgFHVMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFHVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:12:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36BC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 14:12:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z64so9108198pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUU1SNwTPMMpa+RiYbTG49wUfrDQJr1PB29vhwz2Q0g=;
        b=H45ROcx2m8/Fp4W2R3H8CIendmXyLm8cS/6T+sQw/P/YNETxMiiAvCFWNlRqwVZ4+Q
         gzf4Mwg3YTqUOlezjkTaUXtCYAwc5hdEfpnqU5aRiGfIY2vu6GX1r4zKbjQFzu5FKa26
         lmzshDU4bynf0GqHI4qooZAhD6tx6hpM9oCtY+KjUK4/w8Yz9jg/sm+oMJ5cZ+RkUAQJ
         ek047CYsvcPG81V4QmREqxriPgJeFRtSbXcDFzxZAK/qmsqB0b3rGC+ZNC2iROHOMFDs
         PSuAx5mLfkztC+3KtBmalm/mzXSMbPkRjrx7/X0RWn2EhGSZy8KiEx8z639T8YFapwZW
         84yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUU1SNwTPMMpa+RiYbTG49wUfrDQJr1PB29vhwz2Q0g=;
        b=gDMi6OUwyUabL15Ni1r6Zd+aA8UOdv6B04BO+XUA79K/Wb2W2PqNsSl0TarxBDZyKo
         L3jGyWelRgaGC3xW2h9B7yKqDxEmJhW1i4LWgOnpfZkNMUYJVdf2xlRpEQOwYZy6DsvK
         KdrTLB/iy6t9eg7epgf2jWyrb8BR0CiTEi+/KJTvzaXuaroXiuyc2yRRu/CLWMFvX/3T
         zCI/wG1uG1ajvK5BX3dTS5hnsKYpqq29XfPhSg2JaDlUCsao2SK39ZYjspyhOwZ3YSd3
         aykOABZYPgeUkWx9I1gtS3MqgM4y6MbtdKCDjshvgYuQWBsk5aEry7wSm1l4EuRgbsBB
         ZQGA==
X-Gm-Message-State: AOAM532Jwzb3Scw+PDgk/+DFCNV2CNPuFB7PdjsmEAvRtKuBgUtZn9mv
        5ognnk9QSySjkDb8Xhv2fpFE0JNthqYwxsK/SF8EKA==
X-Google-Smtp-Source: ABdhPJzXkPo7LVG6P6GKNCGpQ0VxokdYjnH+v8Q6ff9g6ywx31UWDA/+Zqy0uxaup++lTsFaF3uxl3nfyOiW9SU9DNg=
X-Received: by 2002:a63:4f09:: with SMTP id d9mr21260207pgb.10.1591650763873;
 Mon, 08 Jun 2020 14:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135352.1198078-1-arnd@arndb.de>
In-Reply-To: <20200527135352.1198078-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Jun 2020 14:12:32 -0700
Message-ID: <CAKwvOdk=zO-VyYaQCjmgJK9MOGy=7Qv85RPr=qRYetOjWjU4Mg@mail.gmail.com>
Subject: Re: [PATCH] x86: math-emu: fix up 'cmp' insn for clang ias
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 6:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The clang integrated assembler requires the 'cmp' instruction to
> have a length prefix here:
>
> arch/x86/math-emu/wm_sqrt.S:212:2: error: ambiguous instructions require an explicit suffix (could be 'cmpb', 'cmpw', or 'cmpl')
>  cmp $0xffffffff,-24(%ebp)
>  ^
>
> Make this a 32-bit comparison, which it was clearly meant to be.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/math-emu/wm_sqrt.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/math-emu/wm_sqrt.S b/arch/x86/math-emu/wm_sqrt.S
> index 3b2b58164ec1..40526dd85137 100644
> --- a/arch/x86/math-emu/wm_sqrt.S
> +++ b/arch/x86/math-emu/wm_sqrt.S
> @@ -209,7 +209,7 @@ sqrt_stage_2_finish:
>
>  #ifdef PARANOID
>  /* It should be possible to get here only if the arg is ffff....ffff */
> -       cmp     $0xffffffff,FPU_fsqrt_arg_1
> +       cmpl    $0xffffffff,FPU_fsqrt_arg_1
>         jnz     sqrt_stage_2_error
>  #endif /* PARANOID */
>
> --

-- 
Thanks,
~Nick Desaulniers
