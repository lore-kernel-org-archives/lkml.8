Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826D32073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgE0SwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:52:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgE0SwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:52:14 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MybX9-1ioW4D3EiL-00z0ao for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 20:28:24 +0200
Received: by mail-qt1-f172.google.com with SMTP id a23so20059216qto.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:28:24 -0700 (PDT)
X-Gm-Message-State: AOAM532ElrXGMnOvToqFtg9QDFRhp2IH/Aw90UwD4neOfiZUnVOUunr/
        kqKPP4ucMvjN+dP/ZcvUxfcw5WS8c1Zj2PPw5yY=
X-Google-Smtp-Source: ABdhPJzQFIUHW/JF3c0VCZnhiM4CA4LQ8k4vA7NOeogILSh6rHeZtA5TuSpUsKWWob7tJdlDv6coQztfVWvYPA3oB/s=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr5557996qtk.142.1590604103622;
 Wed, 27 May 2020 11:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134016.753354-1-arnd@arndb.de> <20200527152406.GD59947@C02TD0UTHF1T.local>
 <CAKwvOdn637hSboMnMV=S5f1wbiEnc6qtnrn=fpeCGtvr2W_Daw@mail.gmail.com>
In-Reply-To: <CAKwvOdn637hSboMnMV=S5f1wbiEnc6qtnrn=fpeCGtvr2W_Daw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 20:28:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-L-AQomvTcBv-KH1cVVu6uYNT_-2Ofir3UgwzGjcSug@mail.gmail.com>
Message-ID: <CAK8P3a3-L-AQomvTcBv-KH1cVVu6uYNT_-2Ofir3UgwzGjcSug@mail.gmail.com>
Subject: Re: [PATCH] arm64: disable -fsanitize=shadow-call-stack for big-endian
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AAs3BLls+YSdR1xFKiw97CMcig+gAVZJsoMLAefqQ52Ob22UL43
 eaCJPpfSOF5SgItYD9FnjFxFAFSl1z8E9cd1dEycQpOp9sg3q5RzJkkAxc4Ba+OqM35074d
 ri6aRCYL6QuOAn/k/OiD+oiXYiKX/X2rblFDd3kVLokcoT+OKb8B7nw7fpCo4gGHYHI5pB4
 1mDlOW9JpWe2RhY6mrDPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UIrWExRtcrs=:YjImiCCLj5aKp9nTRIA67t
 gHFr2K0bfKkUKvieZpHMM55dGkl4spbMf4FqzIgp5kyh/CPwbUUXla0ppGBPoPZ0VUiQsZrOG
 /FDM4fHS81ySOsMXDZYo8UEdHKMKAcrR0yQFOizCf59ycplXnCbcp5xgV7xUMjMm0hsPhRlLI
 B7ReEn30Q7+1J13bKCHXikqZFUPUyvBODVecRBl3bmSwAZMz7BewjuORC8/jQcN4BaqAQLi7U
 xVMlHDVzG2hIFVGoi1/VgBUhU7lpIKFv23RerAakJUYFVUbvlCYzquSdnJt1+l900gwgRqg/E
 4YxbvBxwacEMODIvMc94fl9KsoBo9Aiw93wuPotIckaTVPX1XeTgrQXh7QGqzlNLMMvveBLBi
 Dew3JJsYKPjt9cQ1tr/2L7evFCcpuJvZPjuP6zNaGwt+qSuguDqIoBPifG4XIk/Uv29fDbHYj
 4I1Q1ZyZqa+q1o1HiupJSjmIKy+3SQ2etd9zSsQU9BZaO+0NMZx+MiKNxtkPumObRapeg2yKL
 XS1u30n6kLgizzCdE5bCCNNiHa0bErKYcvLW7OiqL9dshw/AmpmLjsUKnIv8OJuO3Y9wP44bp
 kAhKp0aK2VdJRKWTsqQe94gfnaFes6mxgj/0UE6MeU2NVUop/O0M5dG3aAYKX0GWClN16MwVn
 beSKfj35pYqI8UQW6XCujhJ/yAaAIdAzaDn1VD6w5PLxZ6+cqX0I1POf20wDaNbWpRPeyy0Om
 RfbbXFE27cUxoL3s/1YDR30PgoJrAAxXYtx/Ua/0VKjI1WqZLgC6Yu6zIkNEwHVHayMHcFzkn
 wU8q1hMvMtjZNsEOkNpzar+uYLsLirexG2MQtV4W9bKbRSLuYM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 7:28 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Wed, May 27, 2020 at 8:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, May 27, 2020 at 03:39:46PM +0200, Arnd Bergmann wrote:
> > > clang-11 and earlier do not support -fsanitize=shadow-call-stack
> > > in combination with -mbig-endian, but the Kconfig check does not
> > > pass the endianess flag, so building a big-endian kernel with
> > > this fails at build time:
> > >
> > > clang: error: unsupported option '-fsanitize=shadow-call-stack' for target 'aarch64_be-unknown-linux'
> > >
> > > Change the Kconfig check to let Kconfig figure this out earlier
> > > and prevent the broken configuration. I assume this is a bug
> > > in clang that needs to be fixed, but we also have to work
> > > around existing releases.
> > >
> > > Fixes: 5287569a790d ("arm64: Implement Shadow Call Stack")
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=46076
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I suspect this is similar to the patchable-function-entry issue, and
> > this is an oversight that we'd rather fix toolchain side.
> >
> > Nick, Fangrui, thoughts?
>
> Exactly, Fangrui already has a fix: https://reviews.llvm.org/D80647.
> Thanks Fangrui!

Ok, great! I had opened the bug first so I could reference it in the
commit changelog, it seems the fix came fast than I managed to
send out the kernel workaround.

Do we still want the kernel workaround anyway to make it work
with older clang versions, or do we expect to fall back to not
use the integrated assembler for the moment?

      Arnd
