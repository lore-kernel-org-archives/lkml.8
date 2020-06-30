Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676AF20674
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSmqHNR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgF3F4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgF3F4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:56:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD9BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:56:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so10615869lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8oezB9J+U2+aZrUcRMbQ+boDcYTf1u5GevKkRgvGQw=;
        b=zSmqHNR70DhHngHAc93WqKm7thBFYc0NMoZjyG8cNG+2dSEHnyy64EwZa7TL7HbTZA
         c6MEmS/8BraTkUJw5+J7TddJrCqndBVNXlSvpYRjQoUlfKz9PBfSfcnIgPUcvMDf8GJM
         yhkygfhOD5qrOUgdkyPst+0hJ0YvtoIhuKl6Dm0RpHACAt5HZvyI3Pgaa5vodgD7KaOU
         wY3cZJdTj9KJveD3cuqSPqZDiLI3/l+ORputDKpC6c8ebcFaCRU2TwxmMl6TLHtdkmAD
         PQkY6p5wU/uw+vAo2oovVe1ZXp3bukO/q4m0BEmh/gb4VeifPP+3jBYv6aT+mnjxWa4G
         rxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8oezB9J+U2+aZrUcRMbQ+boDcYTf1u5GevKkRgvGQw=;
        b=YUNPw/1Lh0jkpDTmQrDboYBMZloURfjT7BTSdRyp6XtqCm1D+enCRYttJ3BKuqIfUa
         a5dEEsEpmR+wp75UJ368mK7iMrcqsnv6JzVvpy+LnOh/hM2OeUJQgWrmTTQh/8jkhSOV
         DTiU8HLMBj0a36rEghcEKSdo2J7j87UZp6w4z+DbplEhD4VekKdPnSVF08qHy3ulOX4K
         qlV6fjif/MNMWSAUNCZPazZpZ2v3FXYxIiZt4S/1yndQ2eg8RJqckM107Kg/a6LXDX3m
         GfvdMNLEpzofct+GQ9PKEZWNP+fWPrpO8cedEPyCzm9LxtHok9+J0771MuyiErJKDh0a
         wfag==
X-Gm-Message-State: AOAM5300ZDbIETfTRbyaZvYgdgxZT5pzytltlKMD+r5f/OhLR1yCpX9R
        p99UXouv9j+LY3DyuDvaXpcGeu34IfqLUYw6qKRRSOe6wTo=
X-Google-Smtp-Source: ABdhPJwEQrcbY9Xpo6fvWx9CWHmTT5YtDnz0CtwCEmEVFhnk47jEhTH2dtMXCRsKU7sJrtbuCkCuLWiVOfyaOWzMBlw=
X-Received: by 2002:a19:8c09:: with SMTP id o9mr11283562lfd.160.1593496569051;
 Mon, 29 Jun 2020 22:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135923.14912-1-cengiz@kernel.wtf> <20200629145020.GL6156@alley>
 <20200629153756.cxg74nec3repa4lu@holly.lan>
In-Reply-To: <20200629153756.cxg74nec3repa4lu@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 30 Jun 2020 11:25:57 +0530
Message-ID: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
Subject: Re: [PATCH] kdb: prevent possible null deref in kdb_msg_write
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Cengiz Can <cengiz@kernel.wtf>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 at 21:07, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 29, 2020 at 04:50:20PM +0200, Petr Mladek wrote:
> > On Mon 2020-06-29 16:59:24, Cengiz Can wrote:
> > > `kdb_msg_write` operates on a global `struct kgdb_io *` called
> > > `dbg_io_ops`.
> > >
> > > Although it is initialized in `debug_core.c`, there's a null check in
> > > `kdb_msg_write` which implies that it can be null whenever we dereference
> > > it in this function call.
> > >
> > > Coverity scanner caught this as CID 1465042.
> > >
> > > I have modified the function to bail out if `dbg_io_ops` is not properly
> > > initialized.
> > >
> > > Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> > > ---
> > >  kernel/debug/kdb/kdb_io.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > > index 683a799618ad..85e579812458 100644
> > > --- a/kernel/debug/kdb/kdb_io.c
> > > +++ b/kernel/debug/kdb/kdb_io.c
> > > @@ -549,14 +549,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
> > >     if (msg_len == 0)
> > >             return;
> > >
> > > -   if (dbg_io_ops) {
> > > -           const char *cp = msg;
> > > -           int len = msg_len;
> > > +   if (!dbg_io_ops)
> > > +           return;
> >
> > This looks wrong. The message should be printed to the consoles
> > even when dbg_io_ops is NULL. I mean that the for_each_console(c)
> > cycle should always get called.
> >
> > Well, the code really looks racy. dbg_io_ops is set under
> > kgdb_registration_lock. IMHO, it should also get accessed under this lock.
> >
> > It seems that the race is possible. kdb_msg_write() is called from
> > vkdb_printf(). This function is serialized on more CPUs using
> > kdb_printf_cpu lock. But it is not serialized with
> > kgdb_register_io_module() and kgdb_unregister_io_module() calls.
>
> We can't take the lock from the trap handler itself since we cannot
> have spinlocks contended between regular threads and the debug trap
> (which could be an NMI).
>
> Instead, the call to kgdb_unregister_callbacks() at the beginning
> of kgdb_unregister_io_module() should render kdb_msg_write()
> unreachable prior to dbg_io_ops becoming NULL.
>
> As it happens I am starting to believe there is a race in this area but
> the race is between register/unregister calls rather than against the
> trap handler (if there were register/unregister races then the trap
> handler is be a potential victim of the race though).
>
>
> > But I might miss something. dbg_io_ops is dereferenced on many other
> > locations without any check.
>
> There is already a paranoid "just in case there are bugs" check in
> kgdb_io_ready() so in any case I think the check in kdb_msg_write() can
> simply be removed.
>
> As I said in my other post, if dbg_io_ops were ever NULL then the
> system is completely hosed anyway: we can never receive the keystroke
> needed to leave the debugger... and may not be able to tell anybody
> why.
>
>
> > >
> > > -           while (len--) {
> > > -                   dbg_io_ops->write_char(*cp);
> > > -                   cp++;
> > > -           }
> > > +   const char *cp = msg;
> > > +   int len = msg_len;
> > > +
> > > +   while (len--) {
> > > +           dbg_io_ops->write_char(*cp);
> > > +           cp++;
> > >     }
> > >
> > >     for_each_console(c) {
> >
> > You probably got confused by this new code:
> >
> >               if (c == dbg_io_ops->cons)
> >                       continue;
> >
> > It dereferences dbg_io_ops without NULL check. It should probably
> > get replaced by:
> >
> >               if (dbg_io_ops && c == dbg_io_ops->cons)
> >                       continue;
> >
> > Daniel, Sumit, could you please put some light on this?
>
> As above, I think the NULL check that confuses coverity can simply be
> removed.
>

+1

-Sumit

>
> Daniel.
