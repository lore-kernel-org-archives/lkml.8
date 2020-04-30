Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7523AC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4514C20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLKpiqor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD3AcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:32:18 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9CC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:32:18 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so2680668vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvBPc0DiyGZraWsHXTZijFQXms7S1k4nGWlL29l0V6o=;
        b=LLKpiqorH1T+DHvdVpNwSJ6wA5dpT5aybNXWckiQzkEuh6BbgjbDZ1vujEnC7zaAlZ
         EqEJTChEoOVixhZggQqOBqxnHbOSByZBPP/2dDtSyKe7XOuhVUZLIQT4Pi9+FUld0X90
         yqHEJk1FRQp/pz/nHyfm+APLUWpPoYOxck25Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvBPc0DiyGZraWsHXTZijFQXms7S1k4nGWlL29l0V6o=;
        b=i2iYRPm/nr26GXFINdGmgs3/im0Z3Cz2LLrG8QWjc6JPnSs1qqhbjyqQQGNs9SYqpb
         rHdkIoVfAgmSr5caOePtG5ziKds1vd0bOdHn4lB7eh7xlPVx1N+hPNz+Pqn6BiZySor2
         HD92yTuSV3t+N6lajclyfE5F8P/uQbzXTqYECQ+HxJ9wra8R3FZ6OGA1GNwWNIAfccBg
         dHea5rZuWry7f15zDnsO8EX6QwYAJiP/b3pUuXp/AtBXHH5bi4K2VSujg3d8wtVGhi97
         ywOkG9s/Gu1kx9HyrdVXgMjgcKBz5VKyqoPHakQslBs8VKyzR517xRdYxpiPGfS5k+DJ
         5Oww==
X-Gm-Message-State: AGi0Pua0HAwj+maceF/0Bex/XTSZHXvTKrcCw8CbUs1Ll2VE7BqVQp6p
        L2XzhcmgY6ZHosWCYRiPXxHf/gOkrxs=
X-Google-Smtp-Source: APiQypIWQr9HEzH3ZnNhXFJCuEj5YnQrt5tNOM2u83qZI0GHGWD3+iaUhC0Wdjw2/Vv/njaQVoqr/Q==
X-Received: by 2002:a67:eb84:: with SMTP id e4mr1051623vso.8.1588206736897;
        Wed, 29 Apr 2020 17:32:16 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id m203sm360352vka.41.2020.04.29.17.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 17:32:15 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id g184so2687150vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:32:15 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr980053vsk.106.1588206735333;
 Wed, 29 Apr 2020 17:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200429170804.880720-1-daniel.thompson@linaro.org>
In-Reply-To: <20200429170804.880720-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Apr 2020 17:32:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaABk9uejyDR73fW7DDsYvPHaWBD+DpJBGFftJ78UJLg@mail.gmail.com>
Message-ID: <CAD=FV=UaABk9uejyDR73fW7DDsYvPHaWBD+DpJBGFftJ78UJLg@mail.gmail.com>
Subject: Re: [PATCH] serial: kgdboc: Allow earlycon initialization to be deferred
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 29, 2020 at 10:08 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> As described in the big comment in the patch, earlycon initialization
> can be deferred if, a) earlycon was supplied without arguments and, b)
> the ACPI SPCR table hasn't yet been parsed.
>
> Unfortunately, if deferred, then the earlycon is not ready during early
> parameter parsing so kgdboc cannot use it. This patch mitigates the
> problem by giving kgdboc_earlycon a second chance during
> dbg_late_init(). Adding a special purpose interface slightly increase
> the intimacy between kgdboc and debug-core but this seems better than
> adding kgdb specific hooks into the arch code (and much, much better
> than faking non-intimacy with function pointers).
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     Hi Doug,
>
>     This patch extends your patch set to make it easier to deploy on ACPI
>     systems[1]:
>       earlycon kgdboc_earlycon kgdboc=ttyAMA0
>
>     I have mixed feeling about it because it adds calls from debug-core
>     into kgdboc and I don't think there are other examples of this.
>     However earlycon auto-configuration is so awesome I'd like to
>     be able to keep using it and this is the best I have come up with
>     so far ;-).

It's a little gross, but it's OK with me.  I guess the other option
would be to have "kgdboc_earlycon" try again at various different
initcall levels...

Speaking of which, I wonder if you could just make kgdboc register to
run at "console_initcall" level.  If I'm reading it properly:

start_kernel()
- setup_arch(): ACPI stuff is done by the end of this, right?
- console_init(): It would be easy to get called here, I think.
- dbg_late_init(): Where you're hooking in now.

I didn't put printouts in any code and test it out, but if the above
is right then you'll actually get called _earlier_ and with less
hackiness if you just have kgdboc try again at console initlevel.


>     Daniel.
>
>
>     [1] And also on DT based arm64 systems that have ACPI support
>         enabled at compile time because such systems don't decide
>         whether to adopt DT or ACPI until after early parameter
>         parsing.
>
>  drivers/tty/serial/kgdboc.c | 26 +++++++++++++++++++++++++-
>  include/linux/kgdb.h        |  2 ++
>  kernel/debug/debug_core.c   |  4 ++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7aca0a67fc0b..a7a079ce2c5d 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -509,6 +509,8 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
>         .is_console             = true,
>  };
>
> +static bool kgdboc_earlycon_late_enable __initdata;
> +
>  static int __init kgdboc_earlycon_init(char *opt)
>  {
>         struct console *con;
> @@ -529,7 +531,23 @@ static int __init kgdboc_earlycon_init(char *opt)
>         console_unlock();
>
>         if (!con) {
> -               pr_info("Couldn't find kgdb earlycon\n");
> +               /*
> +                * If earlycon deferred its initialization then we also need to
> +                * do that since there is no console at this point. We will
> +                * only defer ourselves when kgdboc_earlycon has no arguments.
> +                * This is because earlycon init is only deferred if there are
> +                * no arguments to earlycon (we assume that a user who doesn't
> +                * specify an earlycon driver won't know the right console name
> +                * to put into kgdboc_earlycon and will let that auto-configure
> +                * too).
> +                */
> +               if (!kgdboc_earlycon_late_enable &&
> +                   earlycon_acpi_spcr_enable && (!opt || !opt[0])) {
> +                       earlycon_kgdboc_late_enable = true;
> +                       pr_info("No suitable earlycon yet, will try later\n");
> +               } else {
> +                       pr_info("Couldn't find kgdb earlycon\n");
> +               }

Personally I'd rather take all the caveats out and just make it
generic.  Stash the name of the console in a string (you can make it
initdata so it doesn't waste any space) and just always retry later if
we didn't find the console.  Then you don't need to be quite so
fragile and if someone else finds another reason to delay earlycon
we'll still work.

Speaking of which, if we build kgdboc as a module won't you get an
error accessing "earlycon_acpi_spcr_enable"?


>                 return 0;
>         }
>
> @@ -545,6 +563,12 @@ static int __init kgdboc_earlycon_init(char *opt)
>  }
>
>  early_param("kgdboc_earlycon", kgdboc_earlycon_init);
> +
> +void __init kgdb_earlycon_late_init(void)
> +{
> +       if (kgdboc_earlycon_late_enable)
> +               earlycon_kgdboc_init(NULL);
> +}
>  #endif /* CONFIG_KGDB_SERIAL_CONSOLE */
>
>  module_init(init_kgdboc);
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 77a3c519478a..02867a2f0eb4 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -227,6 +227,8 @@ extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
>  extern void kgdb_arch_late(void);
>
>
> +extern void __init kgdb_earlycon_late_init(void);
> +

It's not required to add "__init" for declarations, is it?


>  /**
>   * struct kgdb_arch - Describe architecture specific values.
>   * @gdb_bpt_instr: The instruction to trigger a breakpoint.
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 2d74dcbca477..f066ef2bc615 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -963,11 +963,15 @@ void __weak kgdb_arch_late(void)
>  {
>  }
>
> +void __init __weak kgdb_earlycon_late_init(void)
> +

I assume the above is because "kgdboc" can be compiled as a module and
you need to essentially no-op your call in that case?  If so, could
you add a comment about it?  I also would have thought you'd actually
need to define the weak function implementation, not just declare it.
Maybe I'm confused, though.


>  void __init dbg_late_init(void)
>  {
>         dbg_is_early = false;
>         if (kgdb_io_module_registered)
>                 kgdb_arch_late();
> +       else
> +               kgdb_earlycon_late_init();
>         kdb_init(KDB_INIT_FULL);

It feels like it'd be better not to make yourself an "else" but rather
to add a 2nd "if" test either at the beginning or the end of this
function.  I'm 99% sure it makes no difference, but it makes my brain
hurt a little trying to prove it because you've added another flow of
control to analyze / keep working.  Specifically you've now got a case
where you're running a bunch of the "debug_core" code where
"dbg_is_early = false" but you haven't yet run "KDB_INIT_FULL".

Anyway, I don't feel that strongly about it, so if you really like it
the way it is that's fine...


-Doug
