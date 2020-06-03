Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6027C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7B220679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnMB87tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFCNFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:05:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FA9C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:05:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so1254262lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvpZigEQhzvGX1wtVixE7CC7e2aN9bo5yvyFaTFkM/Y=;
        b=KnMB87tpBGmffea+n49g6WxXpNYaovSPXxUbSJqdIT04+p0j5dX8lWbCm02J1PQHTK
         lrcxiU9R5/Of7OvRPJhojI6wud/eHYtFFCaIsIvngA4+d8d5uVul6BmVIBHwClWrzX1T
         rsCb8PYQ5Slk9YZy3Qmyzeim7jPoieXOJTTmIv3TZZ6x7Kobvgs1nXESpLQ0aACyGXJT
         pJQVexNJQmHOoE4mq14L3YLkseNBHNtK3LuHqev3ZnIbwMM1aCXIStSTPgEUPosBKZ/X
         1MtMXV5hOJ35y8y8JxLKvuRUvbPEkWDP9B5BDvdwkG0IIGA16MnsCw/Oto5lerYQu03H
         eg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvpZigEQhzvGX1wtVixE7CC7e2aN9bo5yvyFaTFkM/Y=;
        b=daoZIfEVTPjFdw/N0TCPl+4jd/4lWxOByoOqNLPu20gmcdrN6m3UiU3LB7yMTn6cy6
         RSROqrwYjsLKQthfe6tNpqGCFdM5JeSruviMBO9aiIu3FsxiBG3+YpqHGQHvBbTtq1e6
         yYrrLnwTW3I8w1Qmm0ZLMHNq7sWj5+JC6IicKkndQD/oUfO6osr+891Eb2z2KvCPZ0LV
         mdNfgY0ja0ZXO7O27wXkHBx8xCQVH4o9XTFiEMwH2TdHgTgYkQDVEv19aFx4WiGNFpg/
         d4YWK/lL/fI1998yeaiNPUBlkn8FSwcdqTLm99LDUXVLTSiv3Ws3sQEC0m45q7OQrTwK
         1T8g==
X-Gm-Message-State: AOAM532849pnmX2LDumlNgFEh399/Na6/2zY/xSSH309jsojWUtxMztq
        fpqTLTOcnaU2RnvbXixEZT7+BCaOPhBO+KaHZ6yEDQ==
X-Google-Smtp-Source: ABdhPJzSEKBux1k4uv+CzmbEtAHouEvQhIC4i8M6gS9ACULZNzAL1vkf0qJFl0Z522VDzmqj9GH9UjAATvoQezkNB8g=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr2458517lfi.204.1591189540320;
 Wed, 03 Jun 2020 06:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-5-git-send-email-sumit.garg@linaro.org> <20200603082503.GD14855@linux-b0ei>
 <CAFA6WYMHtXzW-VLJYhC_-7w5+1NgM8PYrNXv=-2g_GKdOO+sNQ@mail.gmail.com> <20200603114242.khv5yi5yweq3e2jz@holly.lan>
In-Reply-To: <20200603114242.khv5yi5yweq3e2jz@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 18:35:29 +0530
Message-ID: <CAFA6WYOqJ-7Ctr46ATqvH2zRz+9biehmL85cuE+tbHRgxxpZkg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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

On Wed, 3 Jun 2020 at 17:12, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Wed, Jun 03, 2020 at 03:02:02PM +0530, Sumit Garg wrote:
> > On Wed, 3 Jun 2020 at 13:55, Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Wed 2020-06-03 12:52:15, Sumit Garg wrote:
> > > > In kgdb context, calling console handlers aren't safe due to locks used
> > > > in those handlers which could in turn lead to a deadlock. Although, using
> > > > oops_in_progress increases the chance to bypass locks in most console
> > > > handlers but it might not be sufficient enough in case a console uses
> > > > more locks (VT/TTY is good example).
> > > >
> > > > Currently when a driver provides both polling I/O and a console then kdb
> > > > will output using the console. We can increase robustness by using the
> > > > currently active polling I/O driver (which should be lockless) instead
> > > > of the corresponding console. For several common cases (e.g. an
> > > > embedded system with a single serial port that is used both for console
> > > > output and debugger I/O) this will result in no console handler being
> > > > used.
> > > >
> > > > In order to achieve this we need to reverse the order of preference to
> > > > use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> > > > store "struct console" that represents debugger I/O in dbg_io_ops and
> > > > while emitting kdb messages, skip console that matches dbg_io_ops
> > > > console in order to avoid duplicate messages. After this change,
> > > > "is_console" param becomes redundant and hence removed.
> > > >
> > > > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > > > index 4139698..6e182aa 100644
> > > > --- a/drivers/tty/serial/kgdboc.c
> > > > +++ b/drivers/tty/serial/kgdboc.c
> > > > @@ -558,6 +557,7 @@ static int __init kgdboc_earlycon_init(char *opt)
> > > >       }
> > > >
> > > >       earlycon = con;
> > > > +     kgdboc_earlycon_io_ops.cons = con;
> > > >       pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> > > >       if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
> > > >               earlycon = NULL;
> > >
> > > Should we clear kgdboc_earlycon_io_ops.cons here when
> > > kgdb_register_io_module() failed?
> > >
> >
> > AFAIK, kgdboc_earlycon_io_ops won't be used at any later stage in case
> > registration fails. So IMO, it would be a redundant assignment unless
> > I missed something.
>
> Or, putting it another way, earlycon is a redundant (albeit better
> maintained) copy of kgdboc_earlycon_io_ops.cons. So I think the best
> thing to do is entirely replace earlycon with
> kgdboc_earlycon_io_ops.cons and then properly set it to NULL!
>

Sounds reasonable, will replace earlycon instead.

-Sumit

>
> Daniel.
