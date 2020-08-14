Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA01C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8B22068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQpryg9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgHNW5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:57:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE7C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:57:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l60so5083450pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WvgDPVRwH/G8nEvnfho4t/Ss9/BmgYz8A1j9g02WnU=;
        b=OQpryg9I4cG/dSW/SrgZxBRXXyp/Qj/GulMsUn3Q+9vXeng/xz7Lc7t16CW/uAg3Iv
         rFYDgSt+ze848j3oqtMs70gzuxOPhtP/KpCogeVWD5PqKlval6qRv/LBE10EZal9gket
         SaHnJ037Boip19JM1nN8pR3WsfakUIxhOOGH/INxraGPJoHeMR1o7BHORHVQ1hwNlzyc
         wVDWVNveOtQW1vFdT0E/WOMR5bx9gsmOyImAXbhT7UFyRNmqXD2x1uz3hnMY8GsgzS95
         DxGpXG9PJ0BnVX4EQWgNUexBboinfatQII+LuPljY502D05CCwTUq1DVYRho3bKi0LvV
         v8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WvgDPVRwH/G8nEvnfho4t/Ss9/BmgYz8A1j9g02WnU=;
        b=HtX1VhcPbbRHBb0tGEf15XdCs9msrWKECyEGH3Qmjku/Vf3RYMLVqlMUYSY7pzQvC9
         U4Ip/uBc1XuvIThzXpreHTs6u53+I0/R6ByealZUouHULB5nI/aWgcaaEcVu/qGaT45u
         znBx2HXIapaOtic6iTEu6/ojlv01OsBbl18Qbk9YbthOvEGxX++mIFbT6nho7ruUomxK
         tnMEd2h88BeI97yuHT5xi2yNT/J2I9WVS6+7VZgi8lWqePGFlcNAQvUkwqqv85Gqlr7R
         ktNyHdF32cjxfIpBgTyl7QxMeLUG3VlgdBCn/4r/vzIOkPj2PdUuYaxqy/NS6yS86nqn
         ozkg==
X-Gm-Message-State: AOAM533PW4lbr4ycnFm/kn6XBtimswaoDxnK12hchuODY+c31D1x1PpG
        maQZqHtG5N5IloZ0VJldPsXxqxLc5kUVdKopVgYUMg==
X-Google-Smtp-Source: ABdhPJwpHPvG+gANKUg+rLNbuVX3hvFnsRzQtxFawQdetHeWVZBNMiMYXAR3cXakSNIWhKz10qRqGt2jz00efQO6WWc=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr4046673pjb.101.1597445863888;
 Fri, 14 Aug 2020 15:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
 <CA+icZUUjtu3fCNTngY52h3uRL+eUaimNJb0UNwj5v-QwKggs5A@mail.gmail.com> <CA+icZUWH5f4B_6eYy2_OOi45VjUkE_kN9akqvcOxxmmmM3TSrg@mail.gmail.com>
In-Reply-To: <CA+icZUWH5f4B_6eYy2_OOi45VjUkE_kN9akqvcOxxmmmM3TSrg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 15:57:31 -0700
Message-ID: <CAKwvOdnj6ObdpsdVYkDxWp-dVTTg=xMkBm84y419SNtLuAqfMg@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Fri, Aug 14, 2020 at 2:19 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Aug 14, 2020 at 7:29 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Thanks for the proposal.
> >
> > I have adapted it to fit my patchset against Linux v5.8.
> >
> > Both Debian's GCC-10 and a snapshot version of LLVM toolchain
> > v11.0.0-rc1+ seems to be OK.
> >
>
> Yupp, OK.
>
> I was able to boot FreeDOS 1.2 VM in VirtualBox GUI.

Hi Sedat,
Apologies, but it's not clear to me precisely which patch you tested.
Can you please confirm whether you tested:
1. Arnd's patch that started this thread.
2. My proposed diff adding -fno-addrsig to CFLAGS_powernow-k6.o.
3. My proposed diff removing __force_order from the kernel.

I'm hoping you were referring to testing 3., but it's not clear to me.
I've been comparing the full disassemblies of vmlinux images when
built with Clang with 3 applied (they're no different, which is a
pleasant surprise, I didn't think kernel builds woulds would be fully
deterministic given the sheer amount of source).  I still need to
check the compressed vmlinux image, and various .ko's (XEN) that use
these read/write_cr[0,1,2,4]() functions, and then check them again
when built with GCC.  I'm falling behind a little trying to get our MC
organized for plumbers, as well as the end of intern season and
beginning of bi-annual "performance review" ("not stack ranking" I'm
told) at work.  If I don't find any differences, or if I do but don't
find them to be meaningful, I hope to push a more formal patch (rather
than just a diff) maybe next week.  I'll include my findings either
way; if it was 3 that you tested, I'll include your tested by tag when
sending.  Otherwise maybe you can help us test the more formal patch
next week?
-- 
Thanks,
~Nick Desaulniers
