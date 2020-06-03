Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2177B2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFyguRK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFCJcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:32:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E9C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:32:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id e125so894747lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4f1Cyl0YeI3L9KPObQmKLYBSMli65+QxBgDMxC3xLDI=;
        b=WFyguRK5TZF/ig1HlfEo56DPZl6QsdgRHwyzME5BE9Cnyzh2Tin6y4QU1grNXFyGi7
         N+BBHNjCVoSyp0epO1PvM0r3VVWE7M7b3aV4cyAxiVaeYZy4V/JpEMw0p/Vk+ZX/cMsR
         6Pfhxh2sdhOnCKXfTurwp8zJiRYQTtHBFCIwwvWuFCPGTgHDFHJtdlwVC5Qf4zMdhBn+
         KCtZHx9z/kFQYyABvuuX+NuXAWMJ/Bbe32m618ClyK4WM9RDLFndtES3lvMWfl435RkJ
         cozY/g85V6O70ZfWKJYXXrw/Kmi6KNj4Golqm2vioeoIO20wEANgjNEx9INwfPOg6ujn
         91cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4f1Cyl0YeI3L9KPObQmKLYBSMli65+QxBgDMxC3xLDI=;
        b=N3PoFyWP4uOE5c5/opZkDIsYTK6ysqv53D+fEx0q+s1SRKMbLl5tr4T/ATgkbHE+SK
         wtJrtDzVtllrR5TTyqtb6nRlPFiwkFA8GSAKUUkjAGT5lYFuJ08CmIABOb8sM2o3BdET
         kkDgEXis1IQn5oeUjKk+W4glOYZIU2pKg4KwiI0Ex/nd104e5ONfwLjJNiL1Q+0Dzkxf
         kTBJGKymj06DzBlxq6tPxlaZEnkrxKl8qEkHVDBWY+Bya/9o0xaqZGB5qC3phQrLz/jw
         JtGdowU/dQjxDWKCawMh2cWLToY2AZU8ZulZilgnlOUfR+rWBC53mfaGaEmjwP/3LVca
         cMKQ==
X-Gm-Message-State: AOAM533nReB+fOgG0b65fjQQgIvJaXwiIX0ueJkIoJSHQaEXjOuqpm6p
        eIT9ivkUM1ZAhhVgOg0zrioDt3X53q2t2SSqlqJP1Q==
X-Google-Smtp-Source: ABdhPJyMF3bTtwkxfKQ/zGDUE2fed47JYmAtXSJ5vvW8/FnxuQhwtIXWbzmhEspLiTN7/hirZv2g5bsjDGS/iKQTNDY=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr2002613lfi.204.1591176734387;
 Wed, 03 Jun 2020 02:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-5-git-send-email-sumit.garg@linaro.org> <20200603082503.GD14855@linux-b0ei>
In-Reply-To: <20200603082503.GD14855@linux-b0ei>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 15:02:02 +0530
Message-ID: <CAFA6WYMHtXzW-VLJYhC_-7w5+1NgM8PYrNXv=-2g_GKdOO+sNQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 13:55, Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2020-06-03 12:52:15, Sumit Garg wrote:
> > In kgdb context, calling console handlers aren't safe due to locks used
> > in those handlers which could in turn lead to a deadlock. Although, using
> > oops_in_progress increases the chance to bypass locks in most console
> > handlers but it might not be sufficient enough in case a console uses
> > more locks (VT/TTY is good example).
> >
> > Currently when a driver provides both polling I/O and a console then kdb
> > will output using the console. We can increase robustness by using the
> > currently active polling I/O driver (which should be lockless) instead
> > of the corresponding console. For several common cases (e.g. an
> > embedded system with a single serial port that is used both for console
> > output and debugger I/O) this will result in no console handler being
> > used.
> >
> > In order to achieve this we need to reverse the order of preference to
> > use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> > store "struct console" that represents debugger I/O in dbg_io_ops and
> > while emitting kdb messages, skip console that matches dbg_io_ops
> > console in order to avoid duplicate messages. After this change,
> > "is_console" param becomes redundant and hence removed.
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index 4139698..6e182aa 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -558,6 +557,7 @@ static int __init kgdboc_earlycon_init(char *opt)
> >       }
> >
> >       earlycon = con;
> > +     kgdboc_earlycon_io_ops.cons = con;
> >       pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> >       if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
> >               earlycon = NULL;
>
> Should we clear kgdboc_earlycon_io_ops.cons here when
> kgdb_register_io_module() failed?
>

AFAIK, kgdboc_earlycon_io_ops won't be used at any later stage in case
registration fails. So IMO, it would be a redundant assignment unless
I missed something.

-Sumit

> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index c62d764..529116b 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -276,8 +276,7 @@ struct kgdb_arch {
> >   * the I/O driver.
> >   * @post_exception: Pointer to a function that will do any cleanup work
> >   * for the I/O driver.
> > - * @is_console: 1 if the end device is a console 0 if the I/O device is
> > - * not a console
> > + * @cons: valid if the I/O device is a console; else NULL.
> >   */
> >  struct kgdb_io {
> >       const char              *name;
> > @@ -288,7 +287,7 @@ struct kgdb_io {
> >       void                    (*deinit) (void);
> >       void                    (*pre_exception) (void);
> >       void                    (*post_exception) (void);
> > -     int                     is_console;
> > +     struct console          *cons;
>
> Nit: I would call it "con". The trailing 's' makes me feel that that the
>      variable points to an array or list of consoles.
>
> >  };
> >
>
> Otherwise, it looks pretty straightforward.
>
> Best Regards,
> Petr
