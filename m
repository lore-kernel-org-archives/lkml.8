Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A91C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C83D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEYMCQK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGNU1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGNU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:27:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:27:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so18691308iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=S61ooPbjIf+07WwP1E03FOEq3OylQk5m8w2sALNuVy0=;
        b=XEYMCQK/E2f2HZFifidSVNUV/R2S0M4uHUl/nHp0fiNRmQMUqid5WGsmAFtR8l3/nj
         Z7dYO7nPXns1vXLMab8s1T2Fk6vE/yzO7i694SaNzSlp4JHOBEZbV6RlGRY8wLkyJ271
         SjJozge+bFuFBHUzpJbgizGBvkPAMaDL0IG4vVANMR6ej9n7t7fDrLlsV5ber9+SoIpm
         mKJg86poUsz3VTF5RDgdtuwU1vkI1AU0T4iGWzx9sY8Ak2gMFzbGHrwD7B7aRYh/0lXy
         sdvyX9499f21mj0fgiR+NaQxZ8bSYA8G4cw6Drptb7j0sLoS9oNci+rwViaqktouq5cT
         pKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=S61ooPbjIf+07WwP1E03FOEq3OylQk5m8w2sALNuVy0=;
        b=FhqyugyU8S7qNqNU9SEpVtb8Uh+sCZiMUVxncrzM0J3k2q3bBfst0XdUm/olEQ/OAs
         7OWHenjy5ZuGpY0n/Q6xwiX9CCS06HaVBLbadNJWqUnitp3gcrdAHWF/0XespTIz5loF
         vjrYFiq0pO5UPAnNABF1sXjt46p41U6Nn5VKRaG+Hf6XnCyhyUjM+ms4d0M9+8VM6jCp
         YR4LYi8jbk/7deJBl1LiSbTvjWia1XG+uVj7UPmIC1ej2sO+SxoTjppjTHtqCvLMMvSf
         i9p3yq5H0UzQgraok+V1H+9m5gcrO2SPq66nsVi4yShDZjihfjjE7ahpcPjIXpFPkMwC
         Y76A==
X-Gm-Message-State: AOAM532CxE+Ulu0VcZrQ+1yh1AKCw2hx1isO4WAOn6J5TGcTQhL/KvQV
        Fc9EnIIUR2X8Of5KZDd4r4nSYyiQfKBnmWlN9Ao=
X-Google-Smtp-Source: ABdhPJzbwbY357Kp2IrdkZVTTXABy0b014XphlwespLZ2euprU7Ke4Ajfsu2xQzi1k1IdnsHfO+6EneDXDXmjhGx0AQ=
X-Received: by 2002:a02:ce9a:: with SMTP id y26mr8005981jaq.121.1594758459500;
 Tue, 14 Jul 2020 13:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan> <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
 <20200714202100.GB902932@rani.riverdale.lan> <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
In-Reply-To: <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 22:27:25 +0200
Message-ID: <CA+icZUUtcQhzO=1KToJyhL0-kWFvV6Ow49u_28Ez9AhvkVjWEw@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 10:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
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

Not my day - today.

$ git diff arch/x86/boot/compressed/Makefile
diff --git a/arch/x86/boot/compressed/Makefile
b/arch/x86/boot/compressed/Makefile
index 789d5d14d8b0..9784ed37a5d7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -51,8 +51,8 @@ UBSAN_SANITIZE :=n
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
-KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
 LDFLAGS_vmlinux := -T
+LDFLAGS_vmlinux += -pie $(call ld-option, --no-dynamic-linker)

 hostprogs      := mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include

- Sedat -
