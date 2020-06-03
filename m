Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F34FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D04820674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHwY0sL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFCLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgFCLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2493C08C5C4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so1996155wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3uwm8GKhOaqpoZ0YGgbFzd1wKVWSSHIAlOR+KHduXk=;
        b=qHwY0sL6MjgOfAS8/Jg15PLIDIl+0xDJXebfzbSeGl77uFAAkGwTrhJGvtoEV8yCFQ
         uQqYKe/hGqiHMVUhvdCS3WbLDa0ruXpuTd5G1VDg2QXRE4RbDOPBSAP/znisL0NU4zVa
         BpCMGAzPFeBcOdesoja9rolr5FvYCsuXbks6gt7Vif890nJvHG8zyqo78y4/Ohp6c5ye
         d8uM42cunpL2/No9RMeiKejypbM/ZnJh1svSxrMypFsb+9OrscztyeEl5mDS1o0BOnL7
         9XZz3UDbVkN1FJBYJuTs0JweChbdtwClFLsWZbOrQlE92+n3nnT5ZCsYTALnBez9RcUl
         oJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3uwm8GKhOaqpoZ0YGgbFzd1wKVWSSHIAlOR+KHduXk=;
        b=muOzciUBlCTBRrweUDATTBHjxbJ7FRSrL/M8+YVCNUVDmxInjWy4ZxylS+hQJPoCqi
         H1ESpiMVUJxATsi+uHHJw5J1JFKnMrCs3IciHZd5WvUnsO7wnueo2uoos+mpkSu1MY7v
         Dg9im4ov/ATHQSsI6WkK7DL1hbj0XVIRuK54WGwVZZ4HfhVSB9WHTEu8eZv5nThQI1Rw
         Z1vP7SJ5xMknIIQpK3OPYTEqTHZC9TFKuhncvqShAL8OotzDwQ7jCyYnaew9u/RZuYLd
         aou0sk8Ir5H0rEZ6Nkso12zA763ZsQ+CWqg/0JH9mFUH0ng17sM5vKaLb22KvmnfssNQ
         r8mg==
X-Gm-Message-State: AOAM533Y16sK9fuPy5+5mPrLEn6LVDku2mty64t225VHfz+c/gaUqP4R
        JII49r6Pfx7f0FboRpw8mvnXGg==
X-Google-Smtp-Source: ABdhPJx2JYmj3kQlas2NeFsHxLhERdjRzWJtW534D05ClC6owgvaZ0fayMzFXCD3mkbt6TOctSu4bw==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr32264160wrx.326.1591184565225;
        Wed, 03 Jun 2020 04:42:45 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c206sm2137559wmf.36.2020.06.03.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 04:42:44 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:42:42 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200603114242.khv5yi5yweq3e2jz@holly.lan>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-5-git-send-email-sumit.garg@linaro.org>
 <20200603082503.GD14855@linux-b0ei>
 <CAFA6WYMHtXzW-VLJYhC_-7w5+1NgM8PYrNXv=-2g_GKdOO+sNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMHtXzW-VLJYhC_-7w5+1NgM8PYrNXv=-2g_GKdOO+sNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:02:02PM +0530, Sumit Garg wrote:
> On Wed, 3 Jun 2020 at 13:55, Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2020-06-03 12:52:15, Sumit Garg wrote:
> > > In kgdb context, calling console handlers aren't safe due to locks used
> > > in those handlers which could in turn lead to a deadlock. Although, using
> > > oops_in_progress increases the chance to bypass locks in most console
> > > handlers but it might not be sufficient enough in case a console uses
> > > more locks (VT/TTY is good example).
> > >
> > > Currently when a driver provides both polling I/O and a console then kdb
> > > will output using the console. We can increase robustness by using the
> > > currently active polling I/O driver (which should be lockless) instead
> > > of the corresponding console. For several common cases (e.g. an
> > > embedded system with a single serial port that is used both for console
> > > output and debugger I/O) this will result in no console handler being
> > > used.
> > >
> > > In order to achieve this we need to reverse the order of preference to
> > > use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> > > store "struct console" that represents debugger I/O in dbg_io_ops and
> > > while emitting kdb messages, skip console that matches dbg_io_ops
> > > console in order to avoid duplicate messages. After this change,
> > > "is_console" param becomes redundant and hence removed.
> > >
> > > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > > index 4139698..6e182aa 100644
> > > --- a/drivers/tty/serial/kgdboc.c
> > > +++ b/drivers/tty/serial/kgdboc.c
> > > @@ -558,6 +557,7 @@ static int __init kgdboc_earlycon_init(char *opt)
> > >       }
> > >
> > >       earlycon = con;
> > > +     kgdboc_earlycon_io_ops.cons = con;
> > >       pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> > >       if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
> > >               earlycon = NULL;
> >
> > Should we clear kgdboc_earlycon_io_ops.cons here when
> > kgdb_register_io_module() failed?
> >
> 
> AFAIK, kgdboc_earlycon_io_ops won't be used at any later stage in case
> registration fails. So IMO, it would be a redundant assignment unless
> I missed something.

Or, putting it another way, earlycon is a redundant (albeit better
maintained) copy of kgdboc_earlycon_io_ops.cons. So I think the best
thing to do is entirely replace earlycon with
kgdboc_earlycon_io_ops.cons and then properly set it to NULL!


Daniel.
