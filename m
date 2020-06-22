Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFEEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC720767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhMXOA29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgFVXEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgFVXEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:04:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:04:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so8233950plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqNx5+2kiVG9gpFn3910S15vAkYBqDSSedKViD8vzv4=;
        b=PhMXOA29UjdzLB+31VLcjALbAfnuSCUduSik9FZHJh5NxaVg0Ze3ovaJuHS6uF5tOP
         BraZMyN9v0GrizeBmPjb+zv8Akwh25gsoP/yBmHWTJu61OLd+BYRA6M4+11FDOfmpb8R
         1oovTnRunpqHNHYygJvCh5+K/rrVDPOIAocDGPEKTab9E8fpHhzHI4F22vH11k2kWiOs
         QYJUl/zF2QvPUc3JTuCoS4rpwMK9ClrXFVhn37aTvwU/z2mwIqEzeuYKoF/1Sud3lFtS
         lew7XOE9/h8akBhb6Ty6i9DQ8T04WtAo+VzBd+qGy91923p+SFsaHaUiwiRNYJIDBiKo
         ddOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqNx5+2kiVG9gpFn3910S15vAkYBqDSSedKViD8vzv4=;
        b=q2Lyt2N52KariXaSJ1dyWomN8/nwmh2RH+UYjm8UwdB/0VOa+gvL+1wNb1tRoUws9e
         7ZfghI9n8xWGRvklqfmHDvOh8HQv7uGuc6I0NaK9kgfB/E92aHVsqd87ZqJaB52e0L8/
         PWg95Qd2t5QBJN3bNUWjMjs9pPdZPmJetSV4evMLdmo8z7bHbYSLh22yeE7igxzl2zNq
         BGzW2q/PUi5LBMj4TjKU5xHI7hSN5JOaAu9AXKBX4DHVBsMlxoF6VsRjkxmgQ/N186jj
         6JSaX9J3nCME0/F21mSVBrpJFL5pVTJy42yFVRtjAfAcQemBGdwuLsQPy3O8msTslTRS
         Ecmw==
X-Gm-Message-State: AOAM530POHvSU6drvHoKV0WHLfiklkkqsQPwQ66he2wvrlaIC3cOQZEp
        3tTZTcJK+3tN+q3AMYei1kSCS9TKgsV3zR62t3Id3g==
X-Google-Smtp-Source: ABdhPJyAXHvfGosb+Hbd1OCZD4musz44ks3XUKHwlc3h/XC8VXif5udxUpRvvtysGawHTGaOgDrNushmDeejEo/jrew=
X-Received: by 2002:a17:902:49:: with SMTP id 67mr21218818pla.205.1592867091804;
 Mon, 22 Jun 2020 16:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org> <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook> <20200622225237.ybol4qmz4mhkmlqc@google.com>
 <202006221555.45BB6412F@keescook>
In-Reply-To: <202006221555.45BB6412F@keescook>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 22 Jun 2020 16:04:40 -0700
Message-ID: <CAFP8O3KdGc9TtziFX7UzmxA-=wfPzm5oi6NCEwRiyyrp+JD3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 3:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > > And it's not in the output:
> > >
> > > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > > No version information found in this file.
> > >
> > > So... for the kernel we need to silence it right now.
> >
> > Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> > sections come from?
>
> It's not reporting it correctly:
>
> .gnu.version_d  0x00000000008966b0        0x0
>  .gnu.version_d
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version    0x00000000008966b0        0x0
>  .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version_r  0x00000000008966b0        0x0
>  .gnu.version_r
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> it just reports whatever file is listed on the link command line first.
>
> > If it is a bug, we should probably figure out which version of binutils
> > has fixed the bug.
>
> I see this with binutils 2.34...
>
> --
> Kees Cook

:( It deserves a binutils bug
(https://sourceware.org/bugzilla/enter_bug.cgi?product=binutils ) and
a comment..

With the description adjusted to say that this works around a bug

Reviewed-by: Fangrui Song <maskray@google.com>
