Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CDFC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B02080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgAMJSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:18:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:18:16 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iqvrT-0001U2-Eu; Mon, 13 Jan 2020 09:18:15 +0000
Date:   Mon, 13 Jan 2020 10:18:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Amanieu d'Antras <amanieu@gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
Message-ID: <20200113091813.zkye72cubpfhemww@wittgenstein>
References: <20191124195225.31230-1-jongk@linux-m68k.org>
 <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
 <CAMuHMdU9hu+EAAnBD5dH3+LS5pNi9fOjFNesv3eFSCoqbW3CCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdU9hu+EAAnBD5dH3+LS5pNi9fOjFNesv3eFSCoqbW3CCA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:10:26AM +0100, Geert Uytterhoeven wrote:
> On Sun, Jan 12, 2020 at 5:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > assembler as was done for clone() as well. This is needed because all
> > > registers need to be saved. The C wrapper then calls the generic
> > > sys_clone3() with the correct arguments.
> > >
> > > Tested on A1200 using the simple test program from:
> > >
> > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> > >
> > > Cc: linux-m68k@vger.kernel.org
> > > Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
> >
> > Thanks, applied and queued for v5.6.
> 
> Which is now broken because of commit dd499f7a7e342702 ("clone3: ensure
> copy_thread_tls is implemented") in v5.5-rc6 :-(

Sorry, just for clarification what and how is it broken by 
dd499f7a7e342702 ("clone3: ensure > copy_thread_tls is implemented")
?

> 
> BTW, was this the reason for the failures at the end of
> https://lore.kernel.org/lkml/CACz-3rhmUfxbfhznvA6NOF69SR49NDZwnkZ=Bmhw_cf4SkiadQ@mail.gmail.com/?

Unlikely since CLONE_SETTLS is currently not covered by the
clone3()/process creation test suite because it is highly arch
dependent on how to retrieve the tls pointer. But we're going to add
tests soon I hope.

Thanks!
Christian
