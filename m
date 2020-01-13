Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358D0C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136B72082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgAMJer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:34:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37909 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:34:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so6214664oth.5;
        Mon, 13 Jan 2020 01:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaKlC3q9CExkHbPXpr2oF1/dYZAiBMn8Z2AGW1rcAsk=;
        b=U+UnG8+kveOJszb2mdYO/8HBc69kSeEYbfcAIDCCeJqlDZolNVcxDbDZ6jYPmqqpv0
         Zt5dwjsc9lnjLhUccp0UWyRgA2YHXYFwbkNznCIE3G2FbHyZJ7kehgf/tRd4lOMp/TWE
         KpU6+uUAKlKgniUzVPcDEvBK9FjFMfYdoJKDkDvYl0O6DQNU/YdqC3YoODPw54a5ucVE
         x25A5ptSBGQdyRRFslCNb1RV5GKKaPID0B1Imrt66vy2LTkBmS0nXD0Gtf72W3wyM/yb
         nb+B5QGA62Dk8Dkhe5zqgDPKPGR7J2sgl2nIunKYIIzmcUqAnXBsV1pLUHhDx7+uAYUD
         nu+w==
X-Gm-Message-State: APjAAAVH/6QrV3tU4ki8yeGQX29YdDNV2jjMNVZXCx8cY46Ha+eZwBfw
        ApuFV0KWjJEYxuFbV5ljj5fspRYO7kwCORFC5wo=
X-Google-Smtp-Source: APXvYqyMuO4xkb3y3TDOh/yl+LjOIvbKWyuAhhxj9i1Hnmo5upqZoILZH3EXejAkFBwjlJ2NisHfRQ5YiP1UyPacKbk=
X-Received: by 2002:a05:6830:18c6:: with SMTP id v6mr7537190ote.145.1578908086649;
 Mon, 13 Jan 2020 01:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
 <CAMuHMdU9hu+EAAnBD5dH3+LS5pNi9fOjFNesv3eFSCoqbW3CCA@mail.gmail.com> <20200113091813.zkye72cubpfhemww@wittgenstein>
In-Reply-To: <20200113091813.zkye72cubpfhemww@wittgenstein>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jan 2020 10:34:35 +0100
Message-ID: <CAMuHMdXTqjPQN4UbH5a1BGjFTNLRrwDu97B=JxDii2VCoRjorA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Mon, Jan 13, 2020 at 10:18 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Jan 13, 2020 at 10:10:26AM +0100, Geert Uytterhoeven wrote:
> > On Sun, Jan 12, 2020 at 5:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > > assembler as was done for clone() as well. This is needed because all
> > > > registers need to be saved. The C wrapper then calls the generic
> > > > sys_clone3() with the correct arguments.
> > > >
> > > > Tested on A1200 using the simple test program from:
> > > >
> > > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> > > >
> > > > Cc: linux-m68k@vger.kernel.org
> > > > Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
> > >
> > > Thanks, applied and queued for v5.6.
> >
> > Which is now broken because of commit dd499f7a7e342702 ("clone3: ensure
> > copy_thread_tls is implemented") in v5.5-rc6 :-(
>
> Sorry, just for clarification what and how is it broken by
> dd499f7a7e342702 ("clone3: ensure > copy_thread_tls is implemented")
> ?

Because m68k does not implement copy_thread_tls() yet, and doesn't
select HAVE_COPY_THREAD_TLS yet.

Looking into fixing that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
