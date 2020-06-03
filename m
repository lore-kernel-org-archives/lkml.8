Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10ED320738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFCL7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:59:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCL7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:59:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94970AC7F;
        Wed,  3 Jun 2020 11:59:53 +0000 (UTC)
Date:   Wed, 3 Jun 2020 13:59:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, sergey.senozhatsky@gmail.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200603115944.GF14855@linux-b0ei>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-5-git-send-email-sumit.garg@linaro.org>
 <20200603082503.GD14855@linux-b0ei>
 <20200603091830.azwneja736lvqo4n@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603091830.azwneja736lvqo4n@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-03 10:18:30, Daniel Thompson wrote:
> On Wed, Jun 03, 2020 at 10:25:04AM +0200, Petr Mladek wrote:
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
> > >  	}
> > >  
> > >  	earlycon = con;
> > > +	kgdboc_earlycon_io_ops.cons = con;
> > >  	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
> > >  	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
> > >  		earlycon = NULL;
> > 
> > Should we clear kgdboc_earlycon_io_ops.cons here when
> > kgdb_register_io_module() failed?
> > 
> > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > index c62d764..529116b 100644
> > > --- a/include/linux/kgdb.h
> > > +++ b/include/linux/kgdb.h
> > > @@ -276,8 +276,7 @@ struct kgdb_arch {
> > >   * the I/O driver.
> > >   * @post_exception: Pointer to a function that will do any cleanup work
> > >   * for the I/O driver.
> > > - * @is_console: 1 if the end device is a console 0 if the I/O device is
> > > - * not a console
> > > + * @cons: valid if the I/O device is a console; else NULL.
> > >   */
> > >  struct kgdb_io {
> > >  	const char		*name;
> > > @@ -288,7 +287,7 @@ struct kgdb_io {
> > >  	void			(*deinit) (void);
> > >  	void			(*pre_exception) (void);
> > >  	void			(*post_exception) (void);
> > > -	int			is_console;
> > > +	struct console		*cons;
> > 
> > Nit: I would call it "con". The trailing 's' makes me feel that that the
> >      variable points to an array or list of consoles.
> 
> How strongly do you feel about it?

I do not have strong opinion about it.

> I'd probably agree with you except that the uart subsystem, which is by
> far the most prolific supplier of consoles for kgdb to use, calls
> pointers to single consoles "cons" so I'd prefer to be aligned on
> terminology.

You made me curious ;-) I tried to find what names are used for
struct console variables.

$linux> git grep "struct console \*c" | sed -e "s/^.*\(struct console[[:blank:]]*\*c[a-z]*\).*$/\1/" | sort | uniq -c
     26 struct console *c
    181 struct console *co
     68 struct console *con
      7 struct console *cons
     28 struct console *console
      1 struct console *cs

and from tty subdirectory:

linux/drivers/tty> git grep "struct console \*c" | sed -e "s/^.*\(struct console[[:blank:]]*\*c[a-z]*\).*$/\1/" | sort | uniq -c
      8 struct console *c
    136 struct console *co
     35 struct console *con
      4 struct console *cons
     10 struct console *console
      1 struct console *cs


Anyway, feel free to use whatever you want. I prefer "con".
But "cons" still looks better than "co" ;-)

Best Regards,
Petr
