Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C63C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C13E2071E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgEANIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:08:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbgEANIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:08:40 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mgf8s-1iwW1y2BdE-00h4BS for <linux-kernel@vger.kernel.org>; Fri, 01 May
 2020 15:08:38 +0200
Received: by mail-qk1-f182.google.com with SMTP id b188so9100094qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 06:08:38 -0700 (PDT)
X-Gm-Message-State: AGi0Puaxu5QUb1xd17p6ftXdBuUCBJ08+QQ3eAUNf89IL8oCY7j+ocoA
        4xLFNA3cZJocffh3kCb301oOnqKWJ1HNyuGD0KE=
X-Google-Smtp-Source: APiQypIQKMczvsmA8czVkzIy2mSuhbAoGpgZxV8bOzCl0b08UxVuJJBgcqVg/CZiTFjDbNPjjNvHXxSVDLG+PKKdo+s=
X-Received: by 2002:a37:9d08:: with SMTP id g8mr3503582qke.138.1588338517367;
 Fri, 01 May 2020 06:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <20200501010733.ptvgzl3nbxybo4rd@treble> <20200501123319.GC3762@hirez.programming.kicks-ass.net>
In-Reply-To: <20200501123319.GC3762@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 15:08:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04Bm1_L7Qs-=0fu_yBd-R1FZvjjmtQu+Wd5PMnRQDPPg@mail.gmail.com>
Message-ID: <CAK8P3a04Bm1_L7Qs-=0fu_yBd-R1FZvjjmtQu+Wd5PMnRQDPPg@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:S/E+CWG0isb6P8wsifgEut1bx0Qf7ScsjZVuTXwvKyv02VJIzA+
 Cj0RbFQ7TW+LLUTUff4CmG4o0jWRMHtGYPqrTZu/XjtD+hPuyQTNEHM2HZwdML8cqq9PIVk
 gVqSa2jYVtKGU5Z8vLJS2F3bL77auiPYhF6yc1I2s17Tu7pGkYX3ry/jpkVezvQyZq4eY6J
 3KjV0mY11aQJNbVlAqcDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WW98L23znig=:dUiheXKA2pEavyt5fhAfFB
 00IEYCCHvcwFayF3j8bogYVKwdgOpHQvpb3cRLOcPxrq7Vw6zSpeRA3XRyaPpA+GmVQ7yE5QP
 J8VC6cgA6goix52W5gocEhUp2IOFS1ohTUlXzlgNlYyW1B32pUdvzCeO15i41X+aI2KmpYflH
 31X8bt3IC4ZHSGxytV4E3JgJfPk+/SvlJI8A32e7vuMXYPoMCIlsC4voUvEtM5DvBZFDrjBGi
 9moFMo973X2ZLbKpylv7BrgID0JFrPTUnBo8tK/VLQnFO6VcQxkPnrqAlj2DGBHuVLsyhFNod
 v3daDrzMKitDYxCYTqXsz4kwQ1cXm1uYlfeFI58VQl7QPxDfYN50zWJ76oJ0kGZYc3PuY1wvS
 w7RXrB6Lij8JDHrm8dktIEtVuGIvDAbJ7N3vqkGulFELH8Pri/VWyZyB1eAeVOTpC/G6IWJIV
 0LEjAySk/S/o52yOqhQj5GZ0cLov/lvVSeeXxtYOzD2qh2VfFvzJAaaewKdVB7wjVunCmIGO5
 OyWZ+JFlQBnU1mUUxqkRBt6mNEpWCyc15+T+mD0ZUJmGPV2wVJNjsjTGOfdeZGdRSdiadaTEI
 BaaDro6PF6mZFzN5M/V3bCJ4a2XHH5vZWYg8fqpfDTnBgKap9azsVHchdP7+oxFPzM6FjHi+z
 VmhT7TAa00wAMIUHTQHAkgZ+ebxDqWYAnGXdoPOncclMik+O8/BgadtEgib2/KOwI5zIfIbu2
 4LPYdeVxIYKZm4pm7S+Lh7W23lPWsQzoajQwWNMacl3fcFv0oit880cQM5swK5lzZBQGjvf5s
 3zytIQNrAFeQAQvXyJLj4DW/GfSt8u08CwPD6Cn0hYhcckk+oA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 2:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 30, 2020 at 08:07:33PM -0500, Josh Poimboeuf wrote:
> > On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> > > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x133: call to do_strncpy_from_user() with UACCESS enabled
> > > lib/strnlen_user.o: warning: objtool: strnlen_user()+0x122: call to do_strnlen_user() with UACCESS enabled
> >
> > Does this fix it?
> >
>
> GCC is a moron, a static function with inline and a single callsite,
> let's out-of-line it, shees!, try this instead:

I suppose we were kind-of asking for it by passing
-fno-inline-functions-called-once
when CONFIG_DEBUG_SECTION_MISMATCH=y is set ;-)

      Arnd
