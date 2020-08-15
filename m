Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD40C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630F62053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiP8z+2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgHOWEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgHOVvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:03 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE23C02B8CF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:46:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so9621470otp.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=GRcLG1hja9nyh1fAE/jsb695u7dtTiGxHg8x1K2Uuqo=;
        b=jiP8z+2gLo7Lpj7GIMEtNfbrUfZSS5wrDDkKNpJrLKPZUkcXHzqyz5f82N5CPLA9+W
         /LVBVdfYI6CZkqgklcv1Op/D1oMQxfyiDmU/bY5maDH2tjNNDNTL4ZyXZ34ox75zVFXj
         szcrVC6hSL3hlhI5vP5gRCfevuF4LI4Gw+CXiWT19pR7dmvU36Ne3Q2/mT/4OsbQREM1
         aCguYJZQbXlrCNpjCYoMrd0HDVina2SHzf6cCRZFdEgQ9eIprGHWaYJe7O5Sx/04WYhY
         zmBbRYU+/6D2sxb/tTQQwah5rt44KNoIdD+H+I6QYHauBUGFyd/+l74y1Z0KcKoTWZ70
         lptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=GRcLG1hja9nyh1fAE/jsb695u7dtTiGxHg8x1K2Uuqo=;
        b=FlCMfPxFzimMDuJujBtdvaxMslEHrBHZyXR2LG3DYRwAqrWWjym6El2ExYrIEffEgB
         Duzcc6EOp4lvhRdqoEQvibz2QpNsVXDsokhdRl7EJpWJqUmJFVthm/rZOf9ObbScEpIv
         UsqiHrFskl2xIcYZONNdXgC/FKJLq2uqoFy+SDvzl6qzy3zKVHCRPJ1D8Mbde+EVViO8
         ZhuTgw3klSaDJr5/x11oWkKIQ2S3Aa77E2nmuRMX69xbLp5wYIZFOM9198gojc74pr55
         R87f9VL7Ot7oD0Q1vGAxFMcY+JWYX2Pp2ZvAOujQUTvXDgXTqicdaaU+sHCEyJHzIauV
         YhyQ==
X-Gm-Message-State: AOAM531UZTfTG/gXnSggMeOli3hDEIH2SYvg21fqXbU/CvWLB0MPFg9B
        RwlqsZtiWFn63hK7KGsDNXAghnEcX+MuXbat01g=
X-Google-Smtp-Source: ABdhPJxND3CQs32gJN7cmHImhkA9/nnV0T9eLjEx/cT26U16EIQbcBQinG8SUFSH+2YuXCxwER+byC/tZG+6cri+agA=
X-Received: by 2002:a9d:7997:: with SMTP id h23mr5186659otm.28.1597488412052;
 Sat, 15 Aug 2020 03:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
 <CA+icZUUjtu3fCNTngY52h3uRL+eUaimNJb0UNwj5v-QwKggs5A@mail.gmail.com>
 <CA+icZUWH5f4B_6eYy2_OOi45VjUkE_kN9akqvcOxxmmmM3TSrg@mail.gmail.com>
 <CAKwvOdnj6ObdpsdVYkDxWp-dVTTg=xMkBm84y419SNtLuAqfMg@mail.gmail.com>
 <CAKwvOdnahyqQQMdWhzpaYkJNi21Ux=8qyBmRnPidiT_RAn0YFw@mail.gmail.com>
 <CA+icZUVKBsp4cJV5V=ZtywEi=Ary5w-fNSijkNknU+U9xiKRRg@mail.gmail.com> <CA+icZUV5m+kPWpk0ovoWD+DK0Tn8=c0MdWnr2XTxStwXf_VF0g@mail.gmail.com>
In-Reply-To: <CA+icZUV5m+kPWpk0ovoWD+DK0Tn8=c0MdWnr2XTxStwXf_VF0g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 15 Aug 2020 12:46:40 +0200
Message-ID: <CA+icZUW6vb2JgKCnWMx-yRU24benZNLizwk30HLPGwYrNDR-3A@mail.gmail.com>
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

On Sat, Aug 15, 2020 at 10:23 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Aug 15, 2020 at 5:28 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Aug 15, 2020 at 2:27 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 3:57 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Aug 14, 2020 at 2:19 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Fri, Aug 14, 2020 at 7:29 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > Thanks for the proposal.
> > > > > >
> > > > > > I have adapted it to fit my patchset against Linux v5.8.
> > > > > >
> > > > > > Both Debian's GCC-10 and a snapshot version of LLVM toolchain
> > > > > > v11.0.0-rc1+ seems to be OK.
> > > > > >
> > > > >
> > > > > Yupp, OK.
> > > > >
> > > > > I was able to boot FreeDOS 1.2 VM in VirtualBox GUI.
> > > >
> > > > Hi Sedat,
> > > > Apologies, but it's not clear to me precisely which patch you tested.
> > > > Can you please confirm whether you tested:
> > > > 1. Arnd's patch that started this thread.
> > > > 2. My proposed diff adding -fno-addrsig to CFLAGS_powernow-k6.o.
> > > > 3. My proposed diff removing __force_order from the kernel.
> > > >
> > > > I'm hoping you were referring to testing 3., but it's not clear to me.
> > >
> > > Ah, sorry, I missed your comment on github:
> > > https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674282107
> > >
> > > Ok, I will look at more disassembly next week and hopefully have a
> > > patch ready, with your tested by tag.
> > >
> >
> > Sorry for not being precise - I tested with solution (3.).
> > Later I added the diff I used as mentioned in your above comment.
> >
> > See [1]:
> >
> > > In a 2nd run building with a selfmade clang-11 and LLVM "bin"utils is fine, too.
> >
> > I cannot say much to older versions of GCC and/or LLVM/Clang if
> > removing "__force_order" works fine.
> >
> > Another (4.) solution:
> > Sami tried successfully by adding "__weak" declaration with
> > CONFIG_LKDTM=m (see [2]).
> > I am OK if this works, too.
> >
> > Please, see my attachments.
> >
> > - Sedat -
> >
> > [1] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674340760
> > [2] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674182703
>
> Unfortunately, the diff from Sami does not work together with Arvind's
> patchset...
>
> x86/boot: Remove run-time relocations from compressed kernel
>
> ...which got included in <tip.git#x86/boot> recently.
>
> I see the following:
>
>   ld.lld-11 -m elf_x86_64  -pie  --no-dynamic-linker -T
> arch/x86/boot/compressed/vmlinux.lds
> arch/x86/boot/compressed/kernel_info.o
> arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o
> arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o
> arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o
> arch/x86/boot/compressed/cpuflags.o
> arch/x86/boot/compressed/early_serial_console.o
> arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o
> arch/x86/boot/compressed/mem_encrypt.o
> arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o
> arch/x86/boot/compressed/efi_thunk_64.o
> drivers/firmware/efi/libstub/lib.a -o arch/x86/boot/compressed/vmlinux
> ld.lld-11: error: Unexpected GOT entries detected!
> ld.lld-11: error: Unexpected run-time relocations detected!
> ld.lld-11: error: Unexpected GOT entries detected!
> ld.lld-11: error: Unexpected run-time relocations detected!
> make[5]: *** [arch/x86/boot/compressed/Makefile:91:
> arch/x86/boot/compressed/vmlinux] Error 1
>
> When you need further informations, please let me know.
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674182703

When I revert...

commit df6d4f9db79c1a5d6f48b59db35ccd1e9ff9adfc
"x86/boot/compressed: Don't declare __force_order in kaslr_64.c"

...I can build, boot on bare metal and start FreeDOS VM in VirtualBox.

For more details see [2].

- Sedat -

[1] https://git.kernel.org/linus/df6d4f9db79c1a5d6f48b59db35ccd1e9ff9adfc
[2] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674378085
