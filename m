Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C20C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7DD206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XuU7dBkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgEEXP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729332AbgEEXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:15:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6090C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:15:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so26159pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dm0dgRkdL/C9MFaGoSlAZDwZiTAnrAgNi7X8qdq6PDw=;
        b=XuU7dBkYKWBMVd39kmPbpe8lfR9Z+D/yZK0CeYken39/718BQlxvwVb7dW3uKj0HI/
         ThGz7AKBa86cW5AswNfNJA4RpccID/ytmy3lJt5kH95222DI4cf8qVkS4Nz8UqbsXLzZ
         deXx2k0YXghUnpLtxY5q7KhqhbZB/9L8kDEI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dm0dgRkdL/C9MFaGoSlAZDwZiTAnrAgNi7X8qdq6PDw=;
        b=SYZY1O/LFTf+gtKo5mLYv3+O123pemKoKiNpFAr/5Uouh625NbWRvm+JbnLGSSGS26
         5PsZQVw0aGEBibV6Fe1qCfwJwmfs7aoOhNzS5PmBPJfcOXykK0x4nbevi93egxc/R7tl
         s7rhTemQix60z/dqQWDRegudhSALzf2wihiUugPosDpcv89ckxYil9u9hRCRhPs3HubW
         d6LIMGYbZ+JoDZgpCyLbn6DMAnID0GB7c4+Nx6qBxjwhKYhZp3u31inflaUQ6cbNtXG3
         U3QBhJtKOU+NYD5knIXMLpA+BlzxpKAv+ghpkrkCNCv9p9ZZ5hJjv6KUSHw91qUQlgza
         bPEA==
X-Gm-Message-State: AGi0PubBF6WQjUrSHnCeQjYCeefCKc+5cOzcwJRlCQvTUmdTMgLZo3/Y
        lrSO7196BThYKqP3KQIpQLe36w==
X-Google-Smtp-Source: APiQypJp5E93vs/vJZmNsAUhYqY8kUxmJykSuvx1ycRtb6r7XIggG4IKljm1uboDyQqbr1ti1ZVacw==
X-Received: by 2002:a17:90a:d78e:: with SMTP id z14mr6251945pju.125.1588720526172;
        Tue, 05 May 2020 16:15:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r28sm72249pfg.186.2020.05.05.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 16:15:25 -0700 (PDT)
Date:   Tue, 5 May 2020 16:15:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] pstore/ram: in ramoops_platform_data convert
 dump_oops to max_reason
Message-ID: <202005051559.946100505D@keescook>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154510.93506-4-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:45:08AM -0400, Pavel Tatashin wrote:
> Now, that pstore_register() can correctly pass max_reason to kmesg dump
> facility, use it instead of dump_oops boolean.
> 
> Replace in ramoops_platform_data dump_oops with max_reason. When dump_oops
> was enabled set max_reason to KMSG_DUMP_OOPS, otherwise set it to
> KMSG_DUMP_PANIC.
> 
> Remove filtering logic from ramoops_pstore_write(), as that is not needed
> anymore, only dmesges specified by max_reason are passed to
> ramoops_pstore_write(). Also, because of this, we can remove
> cxt->dump_oops.

This is all looking good. I think I'd like to see patch 3 and 4 merged,
though. I'd like to make the dump_oops/max_reason conversion in one
patch. Noted below...

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/admin-guide/ramoops.rst     | 11 ++++++----
>  drivers/platform/chrome/chromeos_pstore.c |  2 +-
>  fs/pstore/ram.c                           | 26 +++++++----------------
>  include/linux/pstore_ram.h                |  2 +-
>  4 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index 6dbcc5481000..a296e1aa1617 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -32,11 +32,14 @@ memory to be mapped strongly ordered, and atomic operations on strongly ordered
>  memory are implementation defined, and won't work on many ARMs such as omaps.
>  
>  The memory area is divided into ``record_size`` chunks (also rounded down to
> -power of two) and each oops/panic writes a ``record_size`` chunk of
> +power of two) and each kmesg dump writes a ``record_size`` chunk of
>  information.
>  
> -Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
> -variable while setting 0 in that variable dumps only the panics.
> +Dumping reasons can be set via max_reason value, as defined in
> +include/linux/kmsg_dump.h: kmsg_dump_reason. For example, to
> +dump for both oopses and panics reasons, max_reason should be set to 2
> +(KMSG_DUMP_OOPS), to dump panics only max_reason should be set to 1
> +(KMSG_DUMP_PANIC).
>  
>  The module uses a counter to record multiple dumps but the counter gets reset
>  on restart (i.e. new dumps after the restart will overwrite old ones).
> @@ -90,7 +93,7 @@ Setting the ramoops parameters can be done in several different manners:
>          .mem_address            = <...>,
>          .mem_type               = <...>,
>          .record_size            = <...>,
> -        .dump_oops              = <...>,
> +        .max_reason             = <...>,
>          .ecc                    = <...>,
>    };

Good, yes, dump_oops should be removed from the platform data structure
since that's an entirely internal API.

>  
> diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
> index d13770785fb5..fa51153688b4 100644
> --- a/drivers/platform/chrome/chromeos_pstore.c
> +++ b/drivers/platform/chrome/chromeos_pstore.c
> @@ -57,7 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
>  	.record_size	= 0x40000,
>  	.console_size	= 0x20000,
>  	.ftrace_size	= 0x20000,
> -	.dump_oops	= 1,
> +	.max_reason	= KMSG_DUMP_OOPS,
>  };
>  
>  static struct platform_device chromeos_ramoops = {
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 795622190c01..223581aeea96 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -81,7 +81,6 @@ struct ramoops_context {
>  	size_t console_size;
>  	size_t ftrace_size;
>  	size_t pmsg_size;
> -	int dump_oops;
>  	u32 flags;
>  	struct persistent_ram_ecc_info ecc_info;
>  	unsigned int max_dump_cnt;
> @@ -381,18 +380,6 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
>  	if (record->type != PSTORE_TYPE_DMESG)
>  		return -EINVAL;
>  
> -	/*
> -	 * Out of the various dmesg dump types, ramoops is currently designed
> -	 * to only store crash logs, rather than storing general kernel logs.
> -	 */
> -	if (record->reason != KMSG_DUMP_OOPS &&
> -	    record->reason != KMSG_DUMP_PANIC)
> -		return -EINVAL;
> -
> -	/* Skip Oopes when configured to do so. */
> -	if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
> -		return -EINVAL;
> -
>  	/*
>  	 * Explicitly only take the first part of any new crash.
>  	 * If our buffer is larger than kmsg_bytes, this can never happen,
> @@ -687,7 +674,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  	pdata->mem_size = resource_size(res);
>  	pdata->mem_address = res->start;
>  	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
> -	pdata->dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
> +	dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
:
Is this setting the module param variable? That shouldn't happen here --
we may fail the DT and overwrite the user-configured setting for a
different backend. This should be a local variable and the "final"
max_reason should be calculated in this function, I think.

>  
>  #define parse_size(name, field) {					\
>  		ret = ramoops_parse_dt_size(pdev, name, &value);	\
> @@ -785,7 +772,6 @@ static int ramoops_probe(struct platform_device *pdev)
>  	cxt->console_size = pdata->console_size;
>  	cxt->ftrace_size = pdata->ftrace_size;
>  	cxt->pmsg_size = pdata->pmsg_size;
> -	cxt->dump_oops = pdata->dump_oops;
>  	cxt->flags = pdata->flags;
>  	cxt->ecc_info = pdata->ecc_info;
>  
> @@ -828,8 +814,14 @@ static int ramoops_probe(struct platform_device *pdev)
>  	 * the single region size is how to check.
>  	 */
>  	cxt->pstore.flags = 0;
> -	if (cxt->max_dump_cnt)
> +	if (cxt->max_dump_cnt) {
>  		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
> +		if (pdata->max_reason <= 0) {
> +			pdata->max_reason = dump_oops ? KMSG_DUMP_OOPS :
> +							KMSG_DUMP_PANIC;
> +		}
> +		cxt->pstore.max_reason = pdata->max_reason;
> +	}

I'm going to take a stab at reorganizing the DT, platform data, and
module args to have default handling done in a way that I like. I'm
having a hard time making specific suggestions here. :)

>  	if (cxt->console_size)
>  		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
>  	if (cxt->max_ftrace_cnt)
> @@ -865,7 +857,6 @@ static int ramoops_probe(struct platform_device *pdev)
>  	mem_size = pdata->mem_size;
>  	mem_address = pdata->mem_address;
>  	record_size = pdata->record_size;
> -	dump_oops = pdata->dump_oops;
>  	ramoops_console_size = pdata->console_size;
>  	ramoops_pmsg_size = pdata->pmsg_size;
>  	ramoops_ftrace_size = pdata->ftrace_size;
> @@ -948,7 +939,6 @@ static void __init ramoops_register_dummy(void)
>  	pdata.console_size = ramoops_console_size;
>  	pdata.ftrace_size = ramoops_ftrace_size;
>  	pdata.pmsg_size = ramoops_pmsg_size;
> -	pdata.dump_oops = dump_oops;
>  	pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
>  
>  	/*
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index 9cb9b9067298..9f16afec7290 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -133,7 +133,7 @@ struct ramoops_platform_data {
>  	unsigned long	console_size;
>  	unsigned long	ftrace_size;
>  	unsigned long	pmsg_size;
> -	int		dump_oops;
> +	int		max_reason;
>  	u32		flags;
>  	struct persistent_ram_ecc_info ecc_info;
>  };
> -- 
> 2.25.1
> 

So, hold off on a v3, and I'll send a series tomorrow, based on what
you've got here for v2. I like the refactoring; it's much cleaner to
have max_reason than dump_oops! :)

-- 
Kees Cook
