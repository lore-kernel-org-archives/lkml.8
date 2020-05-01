Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818FDC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1342166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KBM/6NPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgEARg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729659AbgEARg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:36:28 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:36:28 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id g129so2852088vkh.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TA6stwlQtMs0s5sdi3+tZ1ygYla8dV/bmC8ohmequGA=;
        b=KBM/6NPcoPyp2XNp6JUEX0Xt3PKjJ4OeWDSYAI2ClnarZon9yxFPFl0VQ1Z9H+zyGX
         7H7FRh2pe/8P19+PEzHcCgj2mDQkmWTZTnHkastnytPBWT6e2Zv/spgFa23CPQY0iA4z
         tkPgdfzL0pxE3paW1H2UbOMPQjNB308rhBS6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA6stwlQtMs0s5sdi3+tZ1ygYla8dV/bmC8ohmequGA=;
        b=DluubVNxhkxExWIKwOTGLcpN/U6NehrYuDD6DEOfJUNlzXpM9VzuEbYWAuYmvCE2oo
         DOokd5vX888MHKFqPpRvEXJRZZGtARMg0TVw/p8fec61B3YMRVKIAHnAHBk0cWzDEqbu
         nCd7hpzAFHxtlT3N7yM1928UQTrCgzY6vklppCvVnhglb6cmndiQzBkHwIPvEu0Ian3D
         Ar4L/HDtLOufUh2kkkyvLp8qG4gktoOucnsSyttuL8K96oHHYxYMFmZlF8NFFOmv1fDH
         wGh3/Fd28Ph9YfUXXYcykw1e5BIzt/MZ5ePGhq11lP+xzXD+U27Wy5RmvjTDR+SUKI9y
         1uYg==
X-Gm-Message-State: AGi0PuZPfhYhWjc5kTYHr2xzjGFyVuoDfhPm+6gjCDVH2MRY7d0STtIW
        jmu5RPgp/deGLCTPMxYJGXy+dQ3GYws=
X-Google-Smtp-Source: APiQypKD2M/ETNeOaiQV1O5ERUHYupBwZglrItBtzYP1tRCIqFMpFKO8AmO5QvpEDr4LzH80r1Rxcw==
X-Received: by 2002:a1f:8dcd:: with SMTP id p196mr3680151vkd.64.1588354587398;
        Fri, 01 May 2020 10:36:27 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id b204sm950183vkb.17.2020.05.01.10.36.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:36:26 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id s5so3997598uad.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:36:26 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr3831812uab.8.1588354586095;
 Fri, 01 May 2020 10:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
 <20200501114943.ioetuxe24gi27bll@holly.lan> <20200501133202.GA2402281@wychelm.lan>
In-Reply-To: <20200501133202.GA2402281@wychelm.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 May 2020 10:36:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com>
Message-ID: <CAD=FV=WKKCkr1va9S+ygL7XuOvSm12-qw4dCSo=FBtyXx4JvhQ@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: Be a bit more robust about handling earlycon leaving
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 1, 2020 at 6:32 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 01, 2020 at 12:49:43PM +0100, Daniel Thompson wrote:
> > On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> > > The original implementation of kgdboc_earlycon included a comment
> > > about how it was impossible to get notified about the boot console
> > > going away without making changes to the Linux core.  Since folks
> > > often don't want to change the Linux core for kgdb's purposes, the
> > > kgdboc_earlycon implementation did a bit of polling to figure out when
> > > the boot console went away.
> > >
> > > It turns out, though, that it is possible to get notified about the
> > > boot console going away.  The solution is either clever or a hack
> > > depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> > > need to do is head-patch the "exit" routine of the boot console.  We
> > > know that "struct console" must be writable because it has a "next"
> > > pointer in it, so we can just put our own exit routine in, do our
> > > stuff, and then call back to the original.
> >
> > I think I'm in the hack camp on this one!
> >
> >
> > > This works great to get notified about the boot console going away.
> > > The (slight) problem is that in the context of the boot console's exit
> > > routine we can't call tty_find_polling_driver().
> >
> > I presume this is something to do with the tty_mutex?
> > > We solve this by
> > > kicking off some work on the system_wq when we get notified and this
> > > works pretty well.
> >
> > There are some problems with the workqueue approach.
>
> ... so did a couple of experiments to avoid the workqueue.
>
> It occured to me that, since we have interfered with deinit() then the
> console hasn't actually been uninitialized meaning we could still use it.
> This does exposes us to risks similar to keep_bootcon but in exchange
> there is no window where kgdb is broken (and no need to panic).
>
> My prototype is minimal but I did wonder about ripping out all the
> code to defend against removal of the earlycon and simply keep the
> earlycon around until a new kgdbio handler is installed.

It took me a little while, but I finally see what you're saying.
You're saying that we keep calling into the boot console even though
it's no longer in the list of consoles.  Then we temporarily disable
the boot console's exit routine until kgdb_earlycon() is done.  (side
note: the exit routine was recently added and probably most consoles
don't use it).

OK, that doesn't seem totally insane.  It actually works OK for you?

It's probably at least worth a warning in the log if we detect that
we're using the boot console and it's not in the console list anymore.
Then if kgdb starts misbehaving someone might have a clue.

If your solution is OK we might also want to remove the call to
cleanup_earlycon_if_invalid() in configure_kgdboc() too.

I think you might win the "hackiest solution" prize, but your solution
definitely does seem better because I can't think of any other good
way to handle people whose consoles register a long time before their
tty.  ;-)


-Doug
