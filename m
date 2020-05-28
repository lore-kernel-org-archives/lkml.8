Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34C0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7E72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDlnELRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgE1GTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgE1GTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:19:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582FC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:19:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so20274572ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6wzGSWAzO6Y9V94w6NjURnljaOZPM/kHqxn4LN53UU=;
        b=kDlnELRVL1kkiXCkL9OsgTrT6K7LhmaWGvzinLnJhCOfWjepFEAIZx+YESCtX3YZYi
         cBRBAQPpx3CbsqRNhZ3WNyOnWzYcjevglEjYJ1qdyWT7xtJ9ffm6majXh9UtFFBVBQlD
         IAubNEa3IPU9Ha8xzHrb8UX2xWObvVjMWpogKNU+/3aq2Rqvqfn1YRkljwlxvhN1Qbuh
         Dy/rlWe7w1uphNYGhp/HPmR85P8unuQqLai4N/IMbNlpjsOJ7kavFuKhR3QH1Rz88HrZ
         xts+STY8/GTa+Xwf9IzW11NsPrTOokH5dTkFv+J/AdoL7RNegZzNEvHzE9YXA+4biAHN
         3Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6wzGSWAzO6Y9V94w6NjURnljaOZPM/kHqxn4LN53UU=;
        b=PpiRo+aGwsBevMI6uff7JEb7zZRG0hohvL+NOtZATicSt0dWZIsiAHFB3d4fT6nQ0B
         sAlvAKJFwRxgSqfFn+dYsGnsPIeQ3ASfMXPqN9MJuY0vgfs7eEl99LRW2wl43s6/xTlF
         9aOE9omEO/k+rq2wwRuzj19dtOaJEZtpZHL4CvJLuB+/UoFu2BnuBvr2al12ZH6xEj40
         2E0XQAZwB+x3Ghn14b3IgWF8gehkn9eRfHQ1Z7nZJLlswt1b58XLY6XMvWa6UtgRRWtd
         CdxCWKxPlUH368iOSaNrgyoAuhXKzSc2Pma9LsIlGA+7U0u77WQAeeKaJ26KClUVAG6/
         0FBQ==
X-Gm-Message-State: AOAM532MEuTIeC8wPxwYeIyLo+56nyfB1iBVKHJVn/9jYCXLWB3xRXDt
        KZtU4aSDGjUjD0GqmU52b96HTW4awad8RbeFpiYZ3Q==
X-Google-Smtp-Source: ABdhPJylWSoKAJTE57FP7FadAVGNn54Dte/EGhBccUu5jav28TYTjig9BOGV8hdW3KpAPu2aqAm86PxkkikGD7E6MR0=
X-Received: by 2002:a2e:a16e:: with SMTP id u14mr613038ljl.427.1590646739924;
 Wed, 27 May 2020 23:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-5-git-send-email-sumit.garg@linaro.org> <20200527133115.x5hqzttsg73saiky@holly.lan>
In-Reply-To: <20200527133115.x5hqzttsg73saiky@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 May 2020 11:48:48 +0530
Message-ID: <CAFA6WYNeBDRdRqb8dB5HA923ujD3zq7JEQQnV4WJr_fthCc=GQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kdb: Switch kdb_msg_write() to use safer polling I/O
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 19:01, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, May 27, 2020 at 11:55:59AM +0530, Sumit Garg wrote:
> > In kgdb NMI context, calling console handlers isn't safe due to locks
> > used in those handlers which could lead to a deadlock. Although, using
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
>
> Not sure I would have predicted all those changes to kgdboc.c based on
> this patch description. I assume this is to help identify which console
> matches our dbg_io_ops but it would be good to spell this out.
>

Okay, will add the corresponding description.

>
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tty/serial/kgdboc.c | 17 ++++++++---------
> >  include/linux/kgdb.h        |  2 ++
> >  kernel/debug/kdb/kdb_io.c   | 46 +++++++++++++++++++++++++++++++--------------
> >  3 files changed, 42 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index c9f94fa..6199fe1 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -35,7 +35,6 @@ static struct kparam_string kps = {
> >  };
> >
> >  static int kgdboc_use_kms;  /* 1 if we use kernel mode switching */
> > -static struct tty_driver     *kgdb_tty_driver;
> >  static int                   kgdb_tty_line;
> >
> >  #ifdef CONFIG_KDB_KEYBOARD
> > @@ -154,7 +153,7 @@ static int configure_kgdboc(void)
> >       }
> >
> >       kgdboc_io_ops.is_console = 0;
> > -     kgdb_tty_driver = NULL;
> > +     kgdboc_io_ops.tty_drv = NULL;
> >
> >       kgdboc_use_kms = 0;
> >       if (strncmp(cptr, "kms,", 4) == 0) {
> > @@ -178,7 +177,7 @@ static int configure_kgdboc(void)
> >               }
> >       }
> >
> > -     kgdb_tty_driver = p;
> > +     kgdboc_io_ops.tty_drv = p;
> >       kgdb_tty_line = tty_line;
> >
> >  do_register:
> > @@ -216,18 +215,18 @@ static int __init init_kgdboc(void)
> >
> >  static int kgdboc_get_char(void)
> >  {
> > -     if (!kgdb_tty_driver)
> > +     if (!kgdboc_io_ops.tty_drv)
> >               return -1;
> > -     return kgdb_tty_driver->ops->poll_get_char(kgdb_tty_driver,
> > -                                             kgdb_tty_line);
> > +     return kgdboc_io_ops.tty_drv->ops->poll_get_char(kgdboc_io_ops.tty_drv,
> > +                                                      kgdb_tty_line);
> >  }
> >
> >  static void kgdboc_put_char(u8 chr)
> >  {
> > -     if (!kgdb_tty_driver)
> > +     if (!kgdboc_io_ops.tty_drv)
> >               return;
> > -     kgdb_tty_driver->ops->poll_put_char(kgdb_tty_driver,
> > -                                     kgdb_tty_line, chr);
> > +     kgdboc_io_ops.tty_drv->ops->poll_put_char(kgdboc_io_ops.tty_drv,
> > +                                               kgdb_tty_line, chr);
> >  }
> >
> >  static int param_set_kgdboc_var(const char *kmessage,
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index b072aeb..05d165d 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -275,6 +275,7 @@ struct kgdb_arch {
> >   * for the I/O driver.
> >   * @is_console: 1 if the end device is a console 0 if the I/O device is
> >   * not a console
> > + * @tty_drv: Pointer to polling tty driver.
> >   */
> >  struct kgdb_io {
> >       const char              *name;
> > @@ -285,6 +286,7 @@ struct kgdb_io {
> >       void                    (*pre_exception) (void);
> >       void                    (*post_exception) (void);
> >       int                     is_console;
> > +     struct tty_driver       *tty_drv;
>
> Should this be a struct tty_driver or a struct console?
>
> In other words if the lifetime the console structure is the same as the
> tty_driver then isn't it better to capture the console instead
> (easier to compare and works with non-tty devices such as the
> USB debug mode).
>

IIUC, you mean to say we can easily replace "is_console" with "struct
console". This sounds feasible and should be a straightforward
comparison in order to prefer "dbg_io_ops" over console handlers. So I
will switch to use "struct console" instead.

>
> >  };
> >
> >  extern const struct kgdb_arch                arch_kgdb_ops;
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index f848482..c2efa52 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/kgdb.h>
> >  #include <linux/kdb.h>
> >  #include <linux/kallsyms.h>
> > +#include <linux/tty_driver.h>
> >  #include "kdb_private.h"
> >
> >  #define CMD_BUFLEN 256
> > @@ -542,13 +543,18 @@ static int kdb_search_string(char *searched, char *searchfor)
> >       return 0;
> >  }
> >
> > -static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8 ch))
> > +static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8),
> > +                      struct tty_driver *p, int line,
> > +                      void (*poll_put_char)(struct tty_driver *, int, char))
>
> Judging from your reply to comment 1 I guess this is already on the list
> to eliminate ;-).
>

Yeah.

-Sumit

>
> Daniel.
>
>
> >  {
> >       if (len <= 0)
> >               return;
> >
> >       while (len--) {
> > -             io_put_char(*cp);
> > +             if (io_put_char)
> > +                     io_put_char(*cp);
> > +             if (poll_put_char)
> > +                     poll_put_char(p, line, *cp);
> >               cp++;
> >       }
> >  }
> > @@ -561,22 +567,34 @@ static void kdb_msg_write(char *msg, int msg_len)
> >               return;
> >
> >       if (dbg_io_ops && !dbg_io_ops->is_console)
> > -             kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
> > +             kdb_io_write(msg, msg_len, dbg_io_ops->write_char,
> > +                          NULL, 0, NULL);
> >
> >       for_each_console(c) {
> > +             int line;
> > +             struct tty_driver *p;
> > +
> >               if (!(c->flags & CON_ENABLED))
> >                       continue;
> > -             /*
> > -              * While rounding up CPUs via NMIs, its possible that
> > -              * a rounded up CPU maybe holding a console port lock
> > -              * leading to kgdb master CPU stuck in a deadlock during
> > -              * invocation of console write operations. So in order
> > -              * to avoid such a deadlock, enable oops_in_progress
> > -              * prior to invocation of console handlers.
> > -              */
> > -             ++oops_in_progress;
> > -             c->write(c, msg, msg_len);
> > -             --oops_in_progress;
> > +
> > +             p = c->device ? c->device(c, &line) : NULL;
> > +             if (p && dbg_io_ops && p == dbg_io_ops->tty_drv && p->ops &&
> > +                 p->ops->poll_put_char) {
> > +                     kdb_io_write(msg, msg_len, NULL, p, line,
> > +                                  p->ops->poll_put_char);
> > +             } else {
> > +                     /*
> > +                      * While rounding up CPUs via NMIs, its possible that
> > +                      * a rounded up CPU maybe holding a console port lock
> > +                      * leading to kgdb master CPU stuck in a deadlock during
> > +                      * invocation of console write operations. So in order
> > +                      * to avoid such a deadlock, enable oops_in_progress
> > +                      * prior to invocation of console handlers.
> > +                      */
> > +                     ++oops_in_progress;
> > +                     c->write(c, msg, msg_len);
> > +                     --oops_in_progress;
> > +             }
> >               touch_nmi_watchdog();
> >       }
> >  }
> > --
> > 2.7.4
> >
