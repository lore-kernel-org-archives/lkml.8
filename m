Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86104C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CB320760
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnYy2yXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgGNSN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgGNSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:13:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93012C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:13:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f23so18305995iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DkaDz2vQpSy5XI1g9Hw7BaXUJBJ+MBpnR3NMIQZfDRQ=;
        b=XnYy2yXleZye8c+VETEcwH80zwMNR3nr9eif0Wzo7JSdEClHNSE12TUJ1PbAwivEye
         2zRCazYW0wztkcByTKdsg7Wh8JR0X8qZuRD43vBWCUsVRPykqNSY38hDq4sHNvm7e91L
         hlZFRkX0eLcoCCtCBZjmD0+Sl3vN+E6hRowfOFlBP/1H7ppKql0wtAnIyhOROmGmxp93
         tEL6m0i/F/faqSrh3Eb4dTZ6epUQSfDpTuG3Z+L6jow044fRrO2eaw/D9WNtqMYhcpxf
         PcJzaHNXo4l7wCq7pkHOKSC/tcav1qJ/28Um26umY/bOAMQ1zZCBGvfROInM/0WhcjLj
         Dc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DkaDz2vQpSy5XI1g9Hw7BaXUJBJ+MBpnR3NMIQZfDRQ=;
        b=udUeRWb0v146vq2u1Xm6BRTDHEXk/q1pXrgMSRzCWU6glKr11OxxvXO6Q7rDVLHATW
         COQBkgrSLsBu+1rfm25nfPZOy90s+Y2Qk+dNhKFUQyu5a0aoSXYmrjy6X075seQwg+Fj
         0UPYneI4dch+LLX337Dt6/rT5K1MbIxIZkA1a9afw85POmPeoLjE7Th9zFmBgOa9iRTw
         l6DQr/KuBQadQtHGpvGSA/6QuNo71JAXrISmPUL8OsK+kVZw24ebkz/+k1AgTLoT1yBp
         WFXfAp4xLvJBH7UgzDSN1nJ5eu505prwhrJgMab4JdveCruStwiAEWVLOSMNgdmJl3JA
         05dw==
X-Gm-Message-State: AOAM530ajUg7jugVx6ee2hAn2kR0BTqIvp5ed6ikXgGe8UcdnGiT2agW
        QFE1QTP1KQBY8e5Qzud4fOzV/gXZhbMR+L/2bXs=
X-Google-Smtp-Source: ABdhPJzBJvCjQCUWkrn9IEwod7frezCfISaypAwCT64tMY71YH+PE51CXhhpH621VDCfOOdld75CMnv/xSGc8eMeG1c=
X-Received: by 2002:a02:a909:: with SMTP id n9mr7259618jam.70.1594750405993;
 Tue, 14 Jul 2020 11:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
In-Reply-To: <20200714141550.GA329060@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 20:13:14 +0200
Message-ID: <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 4:15 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jul 14, 2020 at 03:15:49PM +0200, Sedat Dilek wrote:
> >
> > How to test this series without building a full new kernel?
> >
> > make $make_opts vmlinux
> >
> > - Sedat -
> >
>
> Not sure I understood the question: you do have to build a full new
> kernel with this patch series to test it. Since the changes are to the
> compressed kernel, you would need to make bzImage, which is the end
> product of the full kernel build.
>
> Thanks.
>

Thanks for the informations.

make bzImage

...was the last I tried - gasped 15mins on this - after gasping 30mins on

make vmlinux

I did a full new build...

...and it fails with ld.lld-11 as linker:

ld.lld-11 -m elf_x86_64 -pie  --no-dynamic-linker -r -o
arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o
-T arch/x86/boot/compressed/.tmp_misc.ver; mv -f
arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o;
rm -f arch/x86/boot/compressed/.tmp_misc.ver; fi
*** ld.lld-11: error: -r and -pie may not be used together ***
make[5]: *** [scripts/Makefile.build:281:
arch/x86/boot/compressed/misc.o] Error 1

It's annoying to fail on the last minutes of a build.
Sorry for being very honest.

- Sedat -
