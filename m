Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AFAC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33610205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiE/mrB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgHOWAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgHOVvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630FC03B3CB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 01:23:48 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t7so9480458otp.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5ZdA3YbzFyuiBEZEvu/DHmwuAZEanF9AbrLkGxCCiGY=;
        b=XiE/mrB9nNyL6m6Ayayjly1A/Rz+rKewJb7JYlLNaP1ST+WCAr/70G4ZKh3/NWgUUr
         ddOiWE1MmCAw37YZR+CxBupx59x4N2hN53GkPpFvSmmZPXu1CO0yqV27scq3IKgSToum
         /gp3utKXhE4jp4VJ6vTIyC5RVcOTfDF0McJfykHautJxpGuOdMklwG+PB1vyABAJ4INt
         Y/zIK5JuxgwP0doj6Lob2OmS0nMDR7CCmi4ZYc6ac9hmVYrKtkcxwaEiuTcT3Pmkg5Us
         wFBLQStuX7Z7C80zX0Vu0zsHgnbQTCKFHG4WtZrD78/XbGNOlWjHoaSoOSsqprmEmTTU
         f0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5ZdA3YbzFyuiBEZEvu/DHmwuAZEanF9AbrLkGxCCiGY=;
        b=JNvSCFD2c7GGK5D2S06pwnvpoZ7s5KFEe+21OqH4zhxXlCP2Ot/6oXuRbT1dpVw9iS
         M5eATcyFOF1IXRfO4LpQdNzbuQGk2zALHqYcbUnqZImjZXH7t3WyqzEhcY59NMYhTQSo
         OMkgy2ChkRXfUkT4uwDBm9kPEuH55AhhogFVtWVkifriC7tr9I++jo1amOMFRh055b+B
         5j/oGn58r61djaztTEinY4r1EaTV3Vj4PkzQkABuHpn1wPo1iByjawzvxzsVTrt4FLuN
         gsZ0vvvqHaoxiLfjV4qUAdM8wNT/QZB2JBdqepi3RvWBzMNLGp1GCTfeTvEBHlgXk415
         gCXg==
X-Gm-Message-State: AOAM532PSkji7h3DH3nP+02AXD8mm6P1EnJsgs7EEjkHP7w0VlhOP4tl
        HxGD5CkBpS8HSCF8vYFed9ycWz2uJ3kg6OFM628=
X-Google-Smtp-Source: ABdhPJxCiyEhC5G3jIT+CvyxgGvFalmOrlYAjt7DA5HbzKYB80D32aUM0mqtwbGrsYh57v/gqvmNpqlC/ZmniF50fPI=
X-Received: by 2002:a9d:48d:: with SMTP id 13mr4914607otm.9.1597479828223;
 Sat, 15 Aug 2020 01:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
 <CA+icZUUjtu3fCNTngY52h3uRL+eUaimNJb0UNwj5v-QwKggs5A@mail.gmail.com>
 <CA+icZUWH5f4B_6eYy2_OOi45VjUkE_kN9akqvcOxxmmmM3TSrg@mail.gmail.com>
 <CAKwvOdnj6ObdpsdVYkDxWp-dVTTg=xMkBm84y419SNtLuAqfMg@mail.gmail.com>
 <CAKwvOdnahyqQQMdWhzpaYkJNi21Ux=8qyBmRnPidiT_RAn0YFw@mail.gmail.com> <CA+icZUVKBsp4cJV5V=ZtywEi=Ary5w-fNSijkNknU+U9xiKRRg@mail.gmail.com>
In-Reply-To: <CA+icZUVKBsp4cJV5V=ZtywEi=Ary5w-fNSijkNknU+U9xiKRRg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 15 Aug 2020 10:23:36 +0200
Message-ID: <CA+icZUV5m+kPWpk0ovoWD+DK0Tn8=c0MdWnr2XTxStwXf_VF0g@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 5:28 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Aug 15, 2020 at 2:27 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Aug 14, 2020 at 3:57 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 2:19 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 14, 2020 at 7:29 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > Thanks for the proposal.
> > > > >
> > > > > I have adapted it to fit my patchset against Linux v5.8.
> > > > >
> > > > > Both Debian's GCC-10 and a snapshot version of LLVM toolchain
> > > > > v11.0.0-rc1+ seems to be OK.
> > > > >
> > > >
> > > > Yupp, OK.
> > > >
> > > > I was able to boot FreeDOS 1.2 VM in VirtualBox GUI.
> > >
> > > Hi Sedat,
> > > Apologies, but it's not clear to me precisely which patch you tested.
> > > Can you please confirm whether you tested:
> > > 1. Arnd's patch that started this thread.
> > > 2. My proposed diff adding -fno-addrsig to CFLAGS_powernow-k6.o.
> > > 3. My proposed diff removing __force_order from the kernel.
> > >
> > > I'm hoping you were referring to testing 3., but it's not clear to me.
> >
> > Ah, sorry, I missed your comment on github:
> > https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674282107
> >
> > Ok, I will look at more disassembly next week and hopefully have a
> > patch ready, with your tested by tag.
> >
>
> Sorry for not being precise - I tested with solution (3.).
> Later I added the diff I used as mentioned in your above comment.
>
> See [1]:
>
> > In a 2nd run building with a selfmade clang-11 and LLVM "bin"utils is fine, too.
>
> I cannot say much to older versions of GCC and/or LLVM/Clang if
> removing "__force_order" works fine.
>
> Another (4.) solution:
> Sami tried successfully by adding "__weak" declaration with
> CONFIG_LKDTM=m (see [2]).
> I am OK if this works, too.
>
> Please, see my attachments.
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674340760
> [2] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674182703

Unfortunately, the diff from Sami does not work together with Arvind's
patchset...

x86/boot: Remove run-time relocations from compressed kernel

...which got included in <tip.git#x86/boot> recently.

I see the following:

  ld.lld-11 -m elf_x86_64  -pie  --no-dynamic-linker -T
arch/x86/boot/compressed/vmlinux.lds
arch/x86/boot/compressed/kernel_info.o
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o
arch/x86/boot/compressed/cpuflags.o
arch/x86/boot/compressed/early_serial_console.o
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o
arch/x86/boot/compressed/mem_encrypt.o
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o
arch/x86/boot/compressed/efi_thunk_64.o
drivers/firmware/efi/libstub/lib.a -o arch/x86/boot/compressed/vmlinux
ld.lld-11: error: Unexpected GOT entries detected!
ld.lld-11: error: Unexpected run-time relocations detected!
ld.lld-11: error: Unexpected GOT entries detected!
ld.lld-11: error: Unexpected run-time relocations detected!
make[5]: *** [arch/x86/boot/compressed/Makefile:91:
arch/x86/boot/compressed/vmlinux] Error 1

When you need further informations, please let me know.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674182703
