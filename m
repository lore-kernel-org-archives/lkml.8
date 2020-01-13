Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD0DC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7962080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgAMKRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:17:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgAMKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:17:18 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iqwmZ-0006e1-T4; Mon, 13 Jan 2020 10:17:16 +0000
Date:   Mon, 13 Jan 2020 11:17:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Amanieu d'Antras <amanieu@gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
Message-ID: <20200113101714.75v5gmg3rb5tlhze@wittgenstein>
References: <20191124195225.31230-1-jongk@linux-m68k.org>
 <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
 <CAMuHMdU9hu+EAAnBD5dH3+LS5pNi9fOjFNesv3eFSCoqbW3CCA@mail.gmail.com>
 <20200113091813.zkye72cubpfhemww@wittgenstein>
 <CAMuHMdXTqjPQN4UbH5a1BGjFTNLRrwDu97B=JxDii2VCoRjorA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXTqjPQN4UbH5a1BGjFTNLRrwDu97B=JxDii2VCoRjorA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:34:35AM +0100, Geert Uytterhoeven wrote:
> Hi Christian,
> 
> On Mon, Jan 13, 2020 at 10:18 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Mon, Jan 13, 2020 at 10:10:26AM +0100, Geert Uytterhoeven wrote:
> > > On Sun, Jan 12, 2020 at 5:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > > > assembler as was done for clone() as well. This is needed because all
> > > > > registers need to be saved. The C wrapper then calls the generic
> > > > > sys_clone3() with the correct arguments.
> > > > >
> > > > > Tested on A1200 using the simple test program from:
> > > > >
> > > > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> > > > >
> > > > > Cc: linux-m68k@vger.kernel.org
> > > > > Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
> > > >
> > > > Thanks, applied and queued for v5.6.
> > >
> > > Which is now broken because of commit dd499f7a7e342702 ("clone3: ensure
> > > copy_thread_tls is implemented") in v5.5-rc6 :-(
> >
> > Sorry, just for clarification what and how is it broken by
> > dd499f7a7e342702 ("clone3: ensure > copy_thread_tls is implemented")
> > ?
> 
> Because m68k does not implement copy_thread_tls() yet, and doesn't
> select HAVE_COPY_THREAD_TLS yet.

Oh right, sorry. I forgot that m68k has a patchset to enable clone3() up
for merging. I should've remembered that and warned you that we will
have to require copy_thread_tls() going forward. I hope the merge is
explanatory enough why we're doing it this way.

> 
> Looking into fixing that...

Thank you! Much appreciated!
Christian
