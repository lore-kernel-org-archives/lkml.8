Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34A7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777F0206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjcaBLBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGNUda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgGNUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:33:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89069C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:33:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so16899733qkn.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzLHGIDvFYHJRK00lx5d1fHBO119ugNEpP1rJkTYBEw=;
        b=pjcaBLBK2KM3BuVm4YgeDzBxTzWvlhvUfr6HXX1NRQVyp62Ez4msw5gQLmpbYQpck2
         LPn5h3Db24coHeE/8W1flkMytFpAksTTHIzgoDAm1TSqaA+2M0Hc/LJoSynWEWu6y3/E
         bArN1xiNUdfyoDrXeK+LOJZ+k+ybDCYzRswo1LlHjKy1idVU3LexJH0DnRH0gE2/oOSn
         q533r5QpjUbeNkJigsx5ueQxLOk9G3BgDQnlxLv7YTVMjhJUIe4shc5RUuV53QKJMAM/
         6Ep+JXqK4iZwR5y41z4w9FGZqifR8WcRgaq1c6ZG1dXTeQCE0XlKrWY9EvxUVfivauwq
         gaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gzLHGIDvFYHJRK00lx5d1fHBO119ugNEpP1rJkTYBEw=;
        b=SvJxtC5KK94QVBydm+4RBUgDt+wYHVVcQkZBgj/Kz/9quyCfh+bPUzio13/MJ4HV7x
         uhZ0sfYqUCWY/aA0lyzoc1gbs6dE35VCKgki7tidwRJ95ZlvYhr4q0S+2TCPN2Iscb9z
         NfjEd9+yCF+CXpAeLfv9xgbHqXrb4lWw7Eed22P1XPX9PcMCAcTr43HyzN7h/3/zn9zT
         5W85cXCgAXLMufZshcK20ngKkEUbFN9XuLQ1K6vnKP7Z6Tv6f0nbUp3UbWhPtq6BB3Bh
         +rmYWatKWsacRo8OQ9MkE3Xhy4wGE0fCOAHKo6WmT0NlFSyg3WC66m02i8mQ/SNXiRsM
         5cog==
X-Gm-Message-State: AOAM530d5CbKDaqhgxDNG3sDmQmyxu0VcsI3+78KJhh84k/2S9GESO5i
        H3C8KzJr/qV/ab9iBPrLHho=
X-Google-Smtp-Source: ABdhPJzHb7TEoOush8X0JhrUu/ZTPOJroXyZTF6eCulDekwEA+U4glrm0QkJ/IjcMNrgF25852DDxA==
X-Received: by 2002:a05:620a:121a:: with SMTP id u26mr6367055qkj.398.1594758808776;
        Tue, 14 Jul 2020 13:33:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w28sm21975428qkw.92.2020.07.14.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:33:28 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 16:33:26 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200714203326.GC902932@rani.riverdale.lan>
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
 <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan>
 <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
 <20200714202100.GB902932@rani.riverdale.lan>
 <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:24:07PM +0200, Sedat Dilek wrote:
> On Tue, Jul 14, 2020 at 10:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jul 14, 2020 at 10:08:04PM +0200, Sedat Dilek wrote:
> > > > >
> > > > > In any case, I think the right fix here would be to add -pie and
> > > > > --no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
> > > >
> > > > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> > > >
> > >
> > > We will need the "ifndef CONFIG_LD_IS_LLD" as -r and -pie cannot be
> > > used together.
> > > Is that the or not the fact when moving to LDFLAGS_vmlinux?
> >
> > LDFLAGS_vmlinux will only be used to link boot/compressed/vmlinux,
> > whereas KBUILD_LDFLAGS is used for all linker invocations, and in
> > particular the little link to do the modversions stuff ends up using it.
> >
> > So once we move -pie --no-dynamic-linker to the more correct
> > LDFLAGS_vmlinux and/or stop modversions running, we'll be fine. Being
> > able to use -pie with lld is one of the goals of this series.
> >
> 
> OK, I am doing a new full kernel build with:
> 
> $ git diff arch/x86/boot/compressed/Makefile
> diff --git a/arch/x86/boot/compressed/Makefile
> b/arch/x86/boot/compressed/Makefile
> index 789d5d14d8b0..056a738e47c6 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> -KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> +LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)
>  LDFLAGS_vmlinux := -T
> 
>  hostprogs      := mkpiggy
> 
> - Sedat -

That needs to be in just one line (or with the += on the -T line)
LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker) -T

Your second assignment will blow away the -pie.. flags.
