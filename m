Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5EDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B52070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHJyWVMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgERGUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERGUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:20:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94064C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:20:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so4450651ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSTNIXQj3Q6OdZ9siyJsFnsk+u2QPmFZetayBVXeQvY=;
        b=EHJyWVMQ6k2vq+IZRHKjaplkAjmLfHG/tmXifZxwUamd7/Ur4aVLXl43G00Y/eRhGL
         X2+Aa+vBnge640M3Wc4HOzmi/TpKNo0FDHZrNkxfuCctg+ovNsQVM1ytETx6ptSnc42c
         C6ahPqYKgslXoDAYlawN3SYf0VKqNHg2hwoJIvv9oURU/r5FjESnAlcUFkubYM/KsK9I
         AZYTxM2kBPnMDuObrAHddD1n/dZSJpZvjcrcVKBKkGQJtXt7sI19om9ZV6qckWqIyiCR
         /3MAanWwQ9/pIvZjA6mBuXf8RlQ8+/c5nUDVYjDfqxfTNSe/F3Tu9BOWZpBuNA3FlQNE
         eraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSTNIXQj3Q6OdZ9siyJsFnsk+u2QPmFZetayBVXeQvY=;
        b=WoXBCJ60HtNbPtHwW8c7QEIUm+e4WN4r9fSlzcGuw0oyfUfOw+VqcoG89u1kV1Yg6M
         6jiBSLGuzkvLPVltHdhl8An9RDf5f9MKzfbNn/1QChJv33PYfQpRm8G01+sAXEWABupg
         c0NI8TFQOshYKKiwm4Mw6CIHuS7EJKUYXZstRgjIf2WtXkGqBUHaNatC1MA1FhM6wFRj
         ffkCmpYlbQKqrFHIvoK+vUiLCg7IrRwhjCZeIw/Rx9uKjCFwuLCaT+PbJqff93lDIsi0
         +wRFn4f/1EaOCfu7QkaQ1j3l09cRd5TZJrMSbN7S3wj7m73+GhoIuHQLXSqA/OdaRPK3
         HhTg==
X-Gm-Message-State: AOAM532ErVlgfOSNReYZqLjUfUYOL7DPdW7/j7Rzewtwc1ums6Svv8XK
        oi7Gy02srvQKVHdzwg9x5q1WNiQhPXxyWCVd0EiGhA==
X-Google-Smtp-Source: ABdhPJyHYyRIXYzdyy/hgEBTWq22/GDXTVVpRIIMAbm3csQAURrxNISE0U2yv9pqCGw+66QGPZMxnrrGqHAd/Z/PIjY=
X-Received: by 2002:a2e:9907:: with SMTP id v7mr366660lji.0.1589782807841;
 Sun, 17 May 2020 23:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan> <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei> <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei> <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
 <20200515163638.GI42471@jagdpanzerIV.localdomain> <CAD=FV=XohG8ErL=_fyuA+MXEmfp55aW+SxSunb6YPRYj77bOxQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XohG8ErL=_fyuA+MXEmfp55aW+SxSunb6YPRYj77bOxQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 18 May 2020 11:49:55 +0530
Message-ID: <CAFA6WYMK3HKtCVxYcN25L7T5duVmH+jAOSbMQUZrJq3Pr8JBZA@mail.gmail.com>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any context
To:     Doug Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 22:22, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, May 15, 2020 at 9:36 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > On (20/05/15 17:32), Sumit Garg wrote:
> > > > Can I please have some context what problem does this solve?
> > >
> > > You can find the problem description here [1] which leads to this fix.
> >
> > [..]
> >
> > > [1] https://lkml.org/lkml/2020/5/12/213
> >
> > Thanks for the link. I'm slightly surprised it took so many years
> > to notice the addition of printk_nmi/printk_safe :)

It's been noticed now since I started playing with NMIs support on
arm64 for kgdb. And that's been only possible with the advent of
pseudo NMIs on arm64 since Linux 5.3 release.

>
> I haven't looked at all the details, but IIUC we don't normally enter
> kgdb on the primary CPU through a NMI context, but the secondary ones
> (on x86) always do.

There's a case for the primary CPU to enter kgdb in NMI context too.
Consider hard-lockup detection based kernel panic. I guess that's
already been working on x86 and should be able to work on arm64 after
this patch [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.html

-Sumit

>  Most things are run on the primary CPU and I
> think it's relatively unlikely for people to change the primary CPU
> (though it is possible).
>
> Probably things got worse when I changed the way "btc" worked to make
> it common between all architectures.  See commit 9ef50a686b53
> ("UPSTREAM: kdb: Fix stack crawling on 'running' CPUs that aren't the
> master").  Though theoretically someone could have changed masters and
> reproduced the problem with a simple "bt" before my patch, now a
> relatively normal command "btc" would tickle the problem.  I didn't
> notice it because I work almost totally on arm/arm64 machines and they
> don't have NMI (yet).
>
> In general I've always wondered about why (historically) kgdb bugs
> have sometimes gone unnoticed for a period of time.  That does seem to
> be changing, though, and I've seen a few longstanding bugs getting
> fixed recently.  :-)
>
>
> -Doug
