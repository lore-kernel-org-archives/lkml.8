Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C65C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9642075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbgE1O5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:57:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403902AbgE1O50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:57:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB96DAEC3;
        Thu, 28 May 2020 14:57:22 +0000 (UTC)
Date:   Thu, 28 May 2020 16:57:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] kdb: Switch kdb_msg_write() to use safer polling
 I/O
Message-ID: <20200528145721.GE11286@linux-b0ei>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-5-git-send-email-sumit.garg@linaro.org>
 <20200527133115.x5hqzttsg73saiky@holly.lan>
 <CAFA6WYNeBDRdRqb8dB5HA923ujD3zq7JEQQnV4WJr_fthCc=GQ@mail.gmail.com>
 <20200528112620.a6zhgnkl2izuggsa@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528112620.a6zhgnkl2izuggsa@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-28 12:26:20, Daniel Thompson wrote:
> On Thu, May 28, 2020 at 11:48:48AM +0530, Sumit Garg wrote:
> > On Wed, 27 May 2020 at 19:01, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Wed, May 27, 2020 at 11:55:59AM +0530, Sumit Garg wrote:
> > > > In kgdb NMI context, calling console handlers isn't safe due to locks
> > > > used in those handlers which could lead to a deadlock. Although, using
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
> > >
> > > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > > index b072aeb..05d165d 100644
> > > > --- a/include/linux/kgdb.h
> > > > +++ b/include/linux/kgdb.h
> > > > @@ -275,6 +275,7 @@ struct kgdb_arch {
> > > >   * for the I/O driver.
> > > >   * @is_console: 1 if the end device is a console 0 if the I/O device is
> > > >   * not a console
> > > > + * @tty_drv: Pointer to polling tty driver.
> > > >   */
> > > >  struct kgdb_io {
> > > >       const char              *name;
> > > > @@ -285,6 +286,7 @@ struct kgdb_io {
> > > >       void                    (*pre_exception) (void);
> > > >       void                    (*post_exception) (void);
> > > >       int                     is_console;
> > > > +     struct tty_driver       *tty_drv;
> > >
> > > Should this be a struct tty_driver or a struct console?
> > >
> > > In other words if the lifetime the console structure is the same as the
> > > tty_driver then isn't it better to capture the console instead
> > > (easier to compare and works with non-tty devices such as the
> > > USB debug mode).
> > >
> > 
> > IIUC, you mean to say we can easily replace "is_console" with "struct
> > console". This sounds feasible and should be a straightforward
> > comparison in order to prefer "dbg_io_ops" over console handlers. So I
> > will switch to use "struct console" instead.
> 
> My comment contains an if ("if the lifetime of the console structure is
> the same") so you need to check that it is true before sharing a patch to
> make the change.

Honestly, I am not completely familiar with the console an tty drivers
code.

Anyway, struct console is typically statically defined by the console
driver code. It is not must to have but I am not aware of any
driver where it would be dynamically defined.

On the other hand, struct tty_driver is dynamically allocated
when the driver gets initialized.

So I would say that it is pretty safe to store struct console.
Well, you need to call con->device() to see if the tty_driver
is actually initialized.

Best Regards,
Petr
