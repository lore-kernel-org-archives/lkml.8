Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6D8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E35208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjh1PibL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgE2FqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2FqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:46:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD128C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:46:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so1070145ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uVbFFVStB5c4phiwJ2viwNKkm/fPEp8ZAWXEnpfQC8=;
        b=cjh1PibL62d5fJAUTjBlkQsSL7zCsGTOMqk736jIfcWC1sG9LZqJEabmt3REI7veqF
         tN9Wz7UF34ddA06WkbiuwPboV0K7lqGseYo+JQc34MgOOzcboAnsvYmTKYmtO0vZSR2s
         FvRbAmGKYG54if9bPUjzF6/4VYV4vRYsvInbEtUpqTMdhjJdvJFfEqtm9YkYs/fXUNpR
         1Dwst0XNB81qxZGK0p8WFWs52i2Jk22tiFu083B4vsLufEO6c6b+/6RpafXCOPhROt9E
         /h2a4pUhYwx3tMw72JV5RwIrdZpBQ1w8DBxyl6QgQcMJV/q7cowRocFd9lLiiLUV3fOm
         iTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uVbFFVStB5c4phiwJ2viwNKkm/fPEp8ZAWXEnpfQC8=;
        b=AUT9POIClkZtbW80xT+vyCWzy1mowzt20MUT9KgyZ9c1biODMVkD1spnstmfJz0/nf
         8bt0qj21GUPqm26/SAjDE0kbNNpYLI6ZX/CFvffjcLhc9THe0PQ1am4pbpB3Se1uLF9R
         ZQQn8ulOCz6J2xmE2vMJkQshzymanPz1Y9LraPzrUwKQSULPzBKd+oK8zSxv4STZuKvm
         LXMG/24lOhmsY5J/yeSvFgnxEc1rEeqO7oiFh1YZGXLcfptFl9VtthDsBv89C4fXPtiA
         yfPPZpnk8m0A4WEqtca8u6oer/Ka2CnaGLJyLR8WXnkKsrZn6S/v8U/YJ7fk6IGVBZ7o
         DmEA==
X-Gm-Message-State: AOAM532aykSXmgJrWBJNg/vUBiLxY3DbemehAsEnXTiRHza9WuQ5QDrb
        Bu2SrD83TLTNyddWPtO5md8oGWM8EAuYUCKB1L41Qw==
X-Google-Smtp-Source: ABdhPJyb6oa8fJFntT6QCoy+P+T9Ig6SvCBBijr5OuBOZRTN3r8/IYx5KtW8CSYvWvJgnaVPKZ2n4vYMTylWvrmpJok=
X-Received: by 2002:a2e:2204:: with SMTP id i4mr3411851lji.110.1590731176287;
 Thu, 28 May 2020 22:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-5-git-send-email-sumit.garg@linaro.org> <20200527133115.x5hqzttsg73saiky@holly.lan>
 <CAFA6WYNeBDRdRqb8dB5HA923ujD3zq7JEQQnV4WJr_fthCc=GQ@mail.gmail.com>
 <20200528112620.a6zhgnkl2izuggsa@holly.lan> <20200528145721.GE11286@linux-b0ei>
In-Reply-To: <20200528145721.GE11286@linux-b0ei>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 29 May 2020 11:16:04 +0530
Message-ID: <CAFA6WYO6D-9dT46Zpmm9diW7QQPTWbT64K7XKXQasdwJ4xuZxw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kdb: Switch kdb_msg_write() to use safer polling I/O
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 20:27, Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2020-05-28 12:26:20, Daniel Thompson wrote:
> > On Thu, May 28, 2020 at 11:48:48AM +0530, Sumit Garg wrote:
> > > On Wed, 27 May 2020 at 19:01, Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > On Wed, May 27, 2020 at 11:55:59AM +0530, Sumit Garg wrote:
> > > > > In kgdb NMI context, calling console handlers isn't safe due to locks
> > > > > used in those handlers which could lead to a deadlock. Although, using
> > > > > oops_in_progress increases the chance to bypass locks in most console
> > > > > handlers but it might not be sufficient enough in case a console uses
> > > > > more locks (VT/TTY is good example).
> > > > >
> > > > > Currently when a driver provides both polling I/O and a console then kdb
> > > > > will output using the console. We can increase robustness by using the
> > > > > currently active polling I/O driver (which should be lockless) instead
> > > > > of the corresponding console. For several common cases (e.g. an
> > > > > embedded system with a single serial port that is used both for console
> > > > > output and debugger I/O) this will result in no console handler being
> > > > > used.
> > > >
> > > > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > > > index b072aeb..05d165d 100644
> > > > > --- a/include/linux/kgdb.h
> > > > > +++ b/include/linux/kgdb.h
> > > > > @@ -275,6 +275,7 @@ struct kgdb_arch {
> > > > >   * for the I/O driver.
> > > > >   * @is_console: 1 if the end device is a console 0 if the I/O device is
> > > > >   * not a console
> > > > > + * @tty_drv: Pointer to polling tty driver.
> > > > >   */
> > > > >  struct kgdb_io {
> > > > >       const char              *name;
> > > > > @@ -285,6 +286,7 @@ struct kgdb_io {
> > > > >       void                    (*pre_exception) (void);
> > > > >       void                    (*post_exception) (void);
> > > > >       int                     is_console;
> > > > > +     struct tty_driver       *tty_drv;
> > > >
> > > > Should this be a struct tty_driver or a struct console?
> > > >
> > > > In other words if the lifetime the console structure is the same as the
> > > > tty_driver then isn't it better to capture the console instead
> > > > (easier to compare and works with non-tty devices such as the
> > > > USB debug mode).
> > > >
> > >
> > > IIUC, you mean to say we can easily replace "is_console" with "struct
> > > console". This sounds feasible and should be a straightforward
> > > comparison in order to prefer "dbg_io_ops" over console handlers. So I
> > > will switch to use "struct console" instead.
> >
> > My comment contains an if ("if the lifetime of the console structure is
> > the same") so you need to check that it is true before sharing a patch to
> > make the change.
>
> Honestly, I am not completely familiar with the console an tty drivers
> code.
>
> Anyway, struct console is typically statically defined by the console
> driver code. It is not must to have but I am not aware of any
> driver where it would be dynamically defined.
>

Yes this is mine understanding as well.

> On the other hand, struct tty_driver is dynamically allocated
> when the driver gets initialized.
>
> So I would say that it is pretty safe to store struct console.

Okay.

> Well, you need to call con->device() to see if the tty_driver
> is actually initialized.

Agree and con->device() is already invoked here [1]. So we only need
to store struct console if con->device() invocation returns success.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/kgdboc.c#n174

-Sumit

>
> Best Regards,
> Petr
