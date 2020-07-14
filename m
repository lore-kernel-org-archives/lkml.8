Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFCEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A03320657
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA8lDs80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGNU2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGNU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:28:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2553FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:21:04 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t7so8112170qvl.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNqqoUWNmRxmdTmC2H241F4+woK6j4Lxw/jD+n5ASO0=;
        b=aA8lDs80uNY9ngYTDCOapy6ub7nOBQNxCJlX/AZU4bi9eLCOy8jKPiKZDVty7/dTRR
         WjyYlA8jVYTa9AcVZD3bML6mMCYjntZevep8CYf5gX2mQPY2yY9CFpR8rSC2gxoklEzv
         k8XBFiLxyHNR6arup/PPCrlyR4ZQ5DFYRti7eyo/MsCWauHe5Tuo/Fxu5k/lu/9SG1G2
         GwQxcAVezJc6tIxQR26MmoTQgdTFXLi69wOMKdkrc9OjeOHWOz3RtotWJac+F9nrM6Qq
         7JD0eKiZO1RfZ9/3toFRf3qbLCQsn/5jGNgV+RpbdTFoP77hwZj3AJK5iRuNS0EH979K
         i+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dNqqoUWNmRxmdTmC2H241F4+woK6j4Lxw/jD+n5ASO0=;
        b=JsIzrkfjEyegaNaVGJQfJDjr5RKkewjo8VBhlLiJK59LUxrT5KxCrOsBkiGfnuaKgb
         JQ5yTJo/lGvirpukFzPmgDohZA+ArZ3xe2kWznYAKwPIMxYXm+DWnDdvIY16dUXCQ/Yc
         70ltftP/xnXbCF3lYxhBoZbZkgKop1c0A/100VdO/hDzU/gzBXHsbtU/7+mWSnj1V5cF
         mU7FeEdlUtFZWPKPx0TFT/RYl5XTAe7IRGm63HP6cFAHjjhhWHBtVw6PteFh7bsEQ1hG
         EagjYiSjIIrhe/wscUxNscrnYFbEbgVnuRmJJ6wL7p1D0y1ankaRU5CbnuyMsaB9wlad
         fKKQ==
X-Gm-Message-State: AOAM533KEQkOGfTBz1xOJpwkvush83LniVCMd10vIDHQgDu3gEAMxf8q
        5zHqVKBJVS4uizY8W1VyhUA=
X-Google-Smtp-Source: ABdhPJwb1I0p4bOMKtLajLgcNEbmG1Q0OY/t2sel9rmpa1wxid9tfL1gZ+7fk6XPzyZ+YZ4ujjS0FQ==
X-Received: by 2002:a0c:f842:: with SMTP id g2mr6506941qvo.181.1594758063273;
        Tue, 14 Jul 2020 13:21:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x36sm45154qtb.78.2020.07.14.13.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:21:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 16:21:00 -0400
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
Message-ID: <20200714202100.GB902932@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
 <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan>
 <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:08:04PM +0200, Sedat Dilek wrote:
> > >
> > > In any case, I think the right fix here would be to add -pie and
> > > --no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
> >
> > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> >
> 
> We will need the "ifndef CONFIG_LD_IS_LLD" as -r and -pie cannot be
> used together.
> Is that the or not the fact when moving to LDFLAGS_vmlinux?

LDFLAGS_vmlinux will only be used to link boot/compressed/vmlinux,
whereas KBUILD_LDFLAGS is used for all linker invocations, and in
particular the little link to do the modversions stuff ends up using it.

So once we move -pie --no-dynamic-linker to the more correct
LDFLAGS_vmlinux and/or stop modversions running, we'll be fine. Being
able to use -pie with lld is one of the goals of this series.

> 
> I cannot test as I modified my local Git and re-invoking my
> build-script is doing a whole new build-dance.
> 
> - Sedat -
