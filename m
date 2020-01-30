Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CCC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E868206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgA3JXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:23:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgA3JXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 672E0AFF0;
        Thu, 30 Jan 2020 09:04:29 +0000 (UTC)
Date:   Thu, 30 Jan 2020 10:04:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200130090428.f5lrkxclnmuegqxw@pathway.suse.cz>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-01-27 13:47:18, Andy Shevchenko wrote:
> There are two callers which use the returned code from unregister_console().
> In some cases, i.e. successfully unregistered Braille console or when console
> has not been enabled the return code is 1. This code is ambiguous and also
> prevents callers to distinguish successful operation.
>
> Replace this logic to return only negative error codes or 0 when console,
> either enabled, disabled or Braille has been successfully unregistered.

I am quite confused by the above message. It is probably because
the patched code is so confusing ;-)

I would start with something like:

<begin>
There are only two callers that use the returned code from
unregister_console():

  + unregister_early_console() in arch/m68k/kernel/early_printk.c
  + kgdb_unregister_nmi_console() in drivers/tty/serial/kgdb_nmi.c

They both expect to get "0" on success and a non-zero value on error.
</end>

The above is more or less clear. Now, the question is what behavior
is considered as success and what is failure.

I started thinking about this in a paranoid mode. The console
registration code is so tricky and it is easy to create
regression.

But I think that it is actually not much important. There are only
two callers that handle the return code:

   + The 1st one m68k is a late init call and the error code of
     init calls is ignored.

   + The 2nd one in kdb code is not much important. I wonder if anyone
     is actually using kdb. If I remember correctly then Linus
     prosed to remove it completely during the discussion about
     lockless printk at Plumbers 2019 and nobody was against.

     In fact, the kdb code is probably wrong. tty_register_driver()
     is called before register_console() in
     kgdb_register_nmi_console() =>

     kgdb_unregister_nmi_console() should probably call
     tty_unregister_driver() even when unregister_console() fails.

unregister_console() is exported symbol but I doubt that the are
more users of the error code.

So, I think that we do not need to care about regressions.
But it is worth to define some resonable behavior, see
below.


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d40a316908da..da6a9bdf76b6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2817,10 +2817,12 @@ int unregister_console(struct console *console)
>  		console->name, console->index);
>  
>  	res = _braille_unregister_console(console);
> -	if (res)
> +	if (res < 0)
>  		return res;
> +	if (res > 0)
> +		return 0;

Sigh, I wish that _braille_unregister_console() did not returned 1
on success but ...

I would describe this as a bugfix. unregister_console() should return
success (0) when _braille_unregister_console() succeeds.

>
> -	res = 1;
> +	res = -ENODEV;

I would describe this as using a regular "meaningful" error code.

>  	console_lock();
>  	if (console_drivers == console) {
>  		console_drivers=console->next;
> @@ -2838,6 +2840,9 @@ int unregister_console(struct console *console)
>  	if (!res && (console->flags & CON_EXTENDED))
>  		nr_ext_console_drivers--;
>  
> +	if (res && !(console->flags & CON_ENABLED))
> +		res = 0;

I personally think that success or failure of unregister_console()
should not depend on the state of CON_ENABLED flag:

  + As it was discussed in the other thread. There are few consoles
    that have set CON_ENABLED by default. unregister_console()
    should not succeed when register_console() was not called
    before.

  + This check would open a question if we should return error
    when the console was in the list but CON_ENABLED was not set.
    But consoles might be temporary disabled, see console_stop().
    unregister_console() should succeed even when the console
    was temporary stopped.

But I think that this is only theoretical discussion. IMHO, nobody
really depends on the return code in reality. Alternative solution
would be to make it symetric with register_console() and do not
return the error code at all.

Best Regards,
Petr
