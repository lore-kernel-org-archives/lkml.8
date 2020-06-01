Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF647C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44FF2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgFAVMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:12:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgFAVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:12:36 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N30VJ-1iyiLf0kLV-013KLK; Mon, 01 Jun 2020 23:12:34 +0200
Received: by mail-qt1-f172.google.com with SMTP id z1so8982278qtn.2;
        Mon, 01 Jun 2020 14:12:33 -0700 (PDT)
X-Gm-Message-State: AOAM533nA2M7X0nDNCszYQzXUCVp89iHBeSWdIULd1mVC8utIrefaarU
        6gTBMaYCH1RBmUxZe/ZXl++W+8JEp99ko9v4VFU=
X-Google-Smtp-Source: ABdhPJwlkHJZj6oVKbNFiO9r5IBxcZavRqQB46OFlMlJ5U6cADZ7c3bv7G5ohWFCGoIb7lBj/Snd0szOhKQRVmnLlSw=
X-Received: by 2002:ac8:4742:: with SMTP id k2mr16568747qtp.304.1591045953016;
 Mon, 01 Jun 2020 14:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200424221948.1120587-1-arnd@arndb.de> <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org> <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org> <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de> <20200601181259.GV1079@brightrain.aerifal.cx>
In-Reply-To: <20200601181259.GV1079@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jun 2020 23:12:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3=XjLvQYz2xB_1=XHFb34Q6zhAJbpJEDRUPX_r=kEBRg@mail.gmail.com>
Message-ID: <CAK8P3a3=XjLvQYz2xB_1=XHFb34Q6zhAJbpJEDRUPX_r=kEBRg@mail.gmail.com>
Subject: Re: [GIT PULL] sh: remove sh5 support
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vnD1w4JIerwlVbUrWo+NrkH4+L+5V+6rEkGIinq8OlF6s3wAXtV
 nrPCLJyZRKHNfEIFbdt/vwySKjCVMiKiBnA5a4cII6OtAw0mNUh+RyGz+p5rwPrfAwZZrKN
 JUFdLBBAb5McBgsDozrzx01hOUXN2tHWUskOFf4zjiGyxug8TOtmd5uQUrFX6xxI2+dn7M6
 04P0+RDBDA9XSS7kL4vcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ufMYFtxDZQc=:hx3cVG0gQM4l9JYE4Hyr24
 dHMWcbDMSjr5HDKazRI1aSMJxCDiP8vrJ+tHsrm5dvBrJUipPl7bjREhsKppBZcI8mW84j18q
 vo676g7BH4x5fUwsGLTm62JPKQsejZ6rvXxREcScRZlT0a0E2o3d3rrxQgCaqK65vuRGo/cvW
 ObVm3OmXN5aHqYdqPjTYo1a40gcur2b+Bu+XRgN5Jdb7omlECCf6gwjfqaLQBmH1bRN/rE25j
 a0AW1gNN1gTwuykP8QJp10mZJFdwn1iOdm6AfDtJ9pL5mepbiQVM4PYQQioNftXxINMgqL9Oa
 AbGNZMNlxna9mUNRfS/xMseF09CN2jlch4Ynqz3Pqxwi4J5xuKs2AMdY16C2Vr0pPLkdLMe0y
 PDm2EI/th43Dp/t8p9xbAZydfkfIiEVAMwdfItoGF2QWtch+r4hf6mcJ+JQTDN2HUvogFpPRk
 h8C/3wKg5zHtR6YiltX7t9G2nLoJWSaGDZKOML+GcG4IVowTDCvQgAy5cm2UWaxDoy0hjDeaD
 V7FcJNgzg9UQjWYzDzWyAO9ox+2AChNbP+Ll+5lA0ue8YfaGju4BBqMNQFcW1D69s5A/fOcU4
 oCuEfVfAaLvxjaN+UgyDODHFyAtRhjg1T7gBbA/miq9yPLeucy6rRyr5yIJ0mdY2zCda7uiZm
 yAUnzkR/jCa+ElkB4I1Jj9LqNS1n81gW8bJha1yraQCo95SSUlG/Xn2421plIBoHt6ZLELOIc
 /dAzW42p6vhiReWyG7fa6aODDE+xVPLbFABnWyW5R/8JH3dWBr01tF2j0sTt2Wvz25cZcTA3g
 19FBmRq1qkC1jVhImaqbJDi4D45nuMo0uBKhjaZ8FC8WxXhW1U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 8:13 PM Rich Felker <dalias@libc.org> wrote:
> On Sat, May 30, 2020 at 10:08:09AM +0200, John Paul Adrian Glaubitz wrote:
> > On 5/29/20 7:53 PM, Rich Felker wrote:
> > > [PATCH next] sh: remove call to memset after dma_alloc_coherent
> > > https://marc.info/?l=linux-sh&m=157793031102356&w=2
>
> Can anyone confirm that this is correct/safe?

Yes, this is safe, I checked both the API definition and the sh
implementation in arch_dma_alloc(), which passes __GFP_ZERO.

       Arnd
