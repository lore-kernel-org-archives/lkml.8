Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B173C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB872207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TondnGZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgFZMNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:13:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC40DC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:13:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so9259595wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lgJeax4YtrsAbRvaQNJ0gahjRNXXWAt78uuKg3Bv4Hw=;
        b=TondnGZm7ga94vOgOuPcI9V7a4tJqO2aGcDDV/78djiybvmgjHKzKS4+7K10rQHQBu
         81NvrYLXaNTiQ/EBI6rta4Aylj/hmxieM3c0588mnet/Qab20khhFbDn3wfRIm6/jRP6
         0pGeuR1Z5GjYiH8t/G3XstwwmYay5PHiAw33Aq7sab93YJi6ThKqwKon9bBU5f+I0KjD
         LwO6abZr35buFre8ECL4GG7pv3aaEsXveuw3VWushZ/yfSmJBfj25VpqALrZUM3Q6Dn9
         oOnXpYK7aZdmnUvRKLX9FC/aldtP2EZUlodje8VGkcZD76jU6Qxl/f/3PzU5f3NXfF2w
         mKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgJeax4YtrsAbRvaQNJ0gahjRNXXWAt78uuKg3Bv4Hw=;
        b=hB5qABT+5FvqfNhv8ytjkfMuCtUzKjCqc4DBtAinajcsyEHtjd1U4b9UvYIiH8BEk9
         HsJuSMMFy0S4UaUMZcZd8tq73xOVfXy8+bwi7rebxsMAoRUUf1yoEjWLT2guG4NLCMmK
         zqJJqXlU9Kv8DcjGSBIyPCzHzFiyxJQXdJ1IKXpQOuP9X9EIiT6iPMrCggCp1HBBtTaY
         Te83mN7k4QZ66TnRhcfSraBHdujTujKjzWHsFS4xBUkS5RHsOZLVc0hWfdhNBUpHkuXj
         Qn3mtPoTO8NKFOJdDg+ipLNUihS5nQB9U/sPpvz11SdnQSu/RqtCSxFk9XV4ezkvPE+/
         0SzQ==
X-Gm-Message-State: AOAM530JQ4cIAI2kQaH1CNzSdDKOER7ESEJDdCpmM+b+I1S5QMv+2J2d
        1Lwzv97ispzzAMZaud9+bQpKsw==
X-Google-Smtp-Source: ABdhPJxx20BY12FOVEn5PxX/xhe0RRoRONuEjTeYr7QcGsD2Wh4umYD4K9aB+iQ54fbVdvHUWrnQcA==
X-Received: by 2002:adf:9524:: with SMTP id 33mr1307384wrs.156.1593173631367;
        Fri, 26 Jun 2020 05:13:51 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q188sm14377194wma.46.2020.06.26.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:13:50 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:13:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] kdb: Switch to use safer dbg_io_ops over console
 APIs
Message-ID: <20200626121348.eeutt4py34f2yg3y@holly.lan>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
 <1591264879-25920-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591264879-25920-5-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

This patch touches some kgdb related code in both serial and usb trees.

Any objections to my queuing this via the kgdb tree?

After testing I've concluded that this, and its friends (which only
touch kgdb), fix enough problems that I plan to queue it for v5.8.


Daniel.


On Thu, Jun 04, 2020 at 03:31:19PM +0530, Sumit Garg wrote:
> In kgdb context, calling console handlers aren't safe due to locks used
> in those handlers which could in turn lead to a deadlock. Although, using
> oops_in_progress increases the chance to bypass locks in most console
> handlers but it might not be sufficient enough in case a console uses
> more locks (VT/TTY is good example).
> 
> Currently when a driver provides both polling I/O and a console then kdb
> will output using the console. We can increase robustness by using the
> currently active polling I/O driver (which should be lockless) instead
> of the corresponding console. For several common cases (e.g. an
> embedded system with a single serial port that is used both for console
> output and debugger I/O) this will result in no console handler being
> used.
> 
> In order to achieve this we need to reverse the order of preference to
> use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> store "struct console" that represents debugger I/O in dbg_io_ops and
> while emitting kdb messages, skip console that matches dbg_io_ops
> console in order to avoid duplicate messages. After this change,
> "is_console" param becomes redundant and hence removed.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tty/serial/kgdb_nmi.c |  2 +-
>  drivers/tty/serial/kgdboc.c   | 32 ++++++++++++++++----------------
>  drivers/usb/early/ehci-dbgp.c |  3 ++-
>  include/linux/kgdb.h          |  5 ++---
>  kernel/debug/kdb/kdb_io.c     |  4 +++-
>  5 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
> index 5022447..6004c0c 100644
> --- a/drivers/tty/serial/kgdb_nmi.c
> +++ b/drivers/tty/serial/kgdb_nmi.c
> @@ -50,7 +50,7 @@ static int kgdb_nmi_console_setup(struct console *co, char *options)
>  	 * I/O utilities that messages sent to the console will automatically
>  	 * be displayed on the dbg_io.
>  	 */
> -	dbg_io_ops->is_console = true;
> +	dbg_io_ops->cons = co;
>  
>  	return 0;
>  }
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 4139698..84ffede 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -45,7 +45,6 @@ static struct platform_device *kgdboc_pdev;
>  
>  #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
>  static struct kgdb_io		kgdboc_earlycon_io_ops;
> -static struct console		*earlycon;
>  static int                      (*earlycon_orig_exit)(struct console *con);
>  #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>  
> @@ -145,7 +144,7 @@ static void kgdboc_unregister_kbd(void)
>  #if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
>  static void cleanup_earlycon(void)
>  {
> -	if (earlycon)
> +	if (kgdboc_earlycon_io_ops.cons)
>  		kgdb_unregister_io_module(&kgdboc_earlycon_io_ops);
>  }
>  #else /* !IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
> @@ -178,7 +177,7 @@ static int configure_kgdboc(void)
>  		goto noconfig;
>  	}
>  
> -	kgdboc_io_ops.is_console = 0;
> +	kgdboc_io_ops.cons = NULL;
>  	kgdb_tty_driver = NULL;
>  
>  	kgdboc_use_kms = 0;
> @@ -198,7 +197,7 @@ static int configure_kgdboc(void)
>  		int idx;
>  		if (cons->device && cons->device(cons, &idx) == p &&
>  		    idx == tty_line) {
> -			kgdboc_io_ops.is_console = 1;
> +			kgdboc_io_ops.cons = cons;
>  			break;
>  		}
>  	}
> @@ -433,7 +432,8 @@ static int kgdboc_earlycon_get_char(void)
>  {
>  	char c;
>  
> -	if (!earlycon->read(earlycon, &c, 1))
> +	if (!kgdboc_earlycon_io_ops.cons->read(kgdboc_earlycon_io_ops.cons,
> +					       &c, 1))
>  		return NO_POLL_CHAR;
>  
>  	return c;
> @@ -441,7 +441,8 @@ static int kgdboc_earlycon_get_char(void)
>  
>  static void kgdboc_earlycon_put_char(u8 chr)
>  {
> -	earlycon->write(earlycon, &chr, 1);
> +	kgdboc_earlycon_io_ops.cons->write(kgdboc_earlycon_io_ops.cons, &chr,
> +					   1);
>  }
>  
>  static void kgdboc_earlycon_pre_exp_handler(void)
> @@ -461,7 +462,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  	 * boot if we detect this case.
>  	 */
>  	for_each_console(con)
> -		if (con == earlycon)
> +		if (con == kgdboc_earlycon_io_ops.cons)
>  			return;
>  
>  	already_warned = true;
> @@ -484,25 +485,25 @@ static int kgdboc_earlycon_deferred_exit(struct console *con)
>  
>  static void kgdboc_earlycon_deinit(void)
>  {
> -	if (!earlycon)
> +	if (!kgdboc_earlycon_io_ops.cons)
>  		return;
>  
> -	if (earlycon->exit == kgdboc_earlycon_deferred_exit)
> +	if (kgdboc_earlycon_io_ops.cons->exit == kgdboc_earlycon_deferred_exit)
>  		/*
>  		 * kgdboc_earlycon is exiting but original boot console exit
>  		 * was never called (AKA kgdboc_earlycon_deferred_exit()
>  		 * didn't ever run).  Undo our trap.
>  		 */
> -		earlycon->exit = earlycon_orig_exit;
> -	else if (earlycon->exit)
> +		kgdboc_earlycon_io_ops.cons->exit = earlycon_orig_exit;
> +	else if (kgdboc_earlycon_io_ops.cons->exit)
>  		/*
>  		 * We skipped calling the exit() routine so we could try to
>  		 * keep using the boot console even after it went away.  We're
>  		 * finally done so call the function now.
>  		 */
> -		earlycon->exit(earlycon);
> +		kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.cons);
>  
> -	earlycon = NULL;
> +	kgdboc_earlycon_io_ops.cons = NULL;
>  }
>  
>  static struct kgdb_io kgdboc_earlycon_io_ops = {
> @@ -511,7 +512,6 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
>  	.write_char		= kgdboc_earlycon_put_char,
>  	.pre_exception		= kgdboc_earlycon_pre_exp_handler,
>  	.deinit			= kgdboc_earlycon_deinit,
> -	.is_console		= true,
>  };
>  
>  #define MAX_CONSOLE_NAME_LEN (sizeof((struct console *) 0)->name)
> @@ -557,10 +557,10 @@ static int __init kgdboc_earlycon_init(char *opt)
>  		goto unlock;
>  	}
>  
> -	earlycon = con;
> +	kgdboc_earlycon_io_ops.cons = con;
>  	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
>  	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {
> -		earlycon = NULL;
> +		kgdboc_earlycon_io_ops.cons = NULL;
>  		pr_info("Failed to register kgdb with earlycon\n");
>  	} else {
>  		/* Trap exit so we can keep earlycon longer if needed. */
> diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
> index ea0d531..775cf70 100644
> --- a/drivers/usb/early/ehci-dbgp.c
> +++ b/drivers/usb/early/ehci-dbgp.c
> @@ -1058,7 +1058,8 @@ static int __init kgdbdbgp_parse_config(char *str)
>  		kgdbdbgp_wait_time = simple_strtoul(ptr, &ptr, 10);
>  	}
>  	kgdb_register_io_module(&kgdbdbgp_io_ops);
> -	kgdbdbgp_io_ops.is_console = early_dbgp_console.index != -1;
> +	if (early_dbgp_console.index != -1)
> +		kgdbdbgp_io_ops.cons = &early_dbgp_console;
>  
>  	return 0;
>  }
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index c62d764..529116b 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -276,8 +276,7 @@ struct kgdb_arch {
>   * the I/O driver.
>   * @post_exception: Pointer to a function that will do any cleanup work
>   * for the I/O driver.
> - * @is_console: 1 if the end device is a console 0 if the I/O device is
> - * not a console
> + * @cons: valid if the I/O device is a console; else NULL.
>   */
>  struct kgdb_io {
>  	const char		*name;
> @@ -288,7 +287,7 @@ struct kgdb_io {
>  	void			(*deinit) (void);
>  	void			(*pre_exception) (void);
>  	void			(*post_exception) (void);
> -	int			is_console;
> +	struct console		*cons;
>  };
>  
>  extern const struct kgdb_arch		arch_kgdb_ops;
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 0e4f2ed..683a799 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -549,7 +549,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	if (msg_len == 0)
>  		return;
>  
> -	if (dbg_io_ops && !dbg_io_ops->is_console) {
> +	if (dbg_io_ops) {
>  		const char *cp = msg;
>  		int len = msg_len;
>  
> @@ -562,6 +562,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	for_each_console(c) {
>  		if (!(c->flags & CON_ENABLED))
>  			continue;
> +		if (c == dbg_io_ops->cons)
> +			continue;
>  		/*
>  		 * Set oops_in_progress to encourage the console drivers to
>  		 * disregard their internal spin locks: in the current calling
> -- 
> 2.7.4
