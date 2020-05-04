Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC002C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E0720705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFI4O7/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEDT3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:29:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4BDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:29:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so371238pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yu8mvWYIKNthxzoTFx8cveVtLJJpkwIpSM4x6ymM6A0=;
        b=KFI4O7/llNt/2/Xg9TGQwPu8L+YV3F/5e0Nq8G8ku+Qy0+V+dB856Mdv6VHKIHiQwu
         15hpWh/v8B9xmnmFtzXDQDNICckhP9gLSw6qd5xar8UcOxsX2Y0ALWLAQkxGldWW24MC
         3eIQnUtEfg3YNzrlLn0hxjU3amUMmiY14I3gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yu8mvWYIKNthxzoTFx8cveVtLJJpkwIpSM4x6ymM6A0=;
        b=UDHthDeseJ24WZnUPLvoyRj8Y2gqvZ3eNgoe95C0CiLGrRrXkl6OE77NPrVJwlWn+Z
         qqdxfRXl7oHQeM8NXKpHAUiIxeA5VQ2dyJ1OUou8PfZcTAse2Wm4Yo3Vx1lpLVCPpe0S
         GqdAQWkCpX1Xy7aQgNjEnOHQyNQfrLBJTQSEuAsIR/m+JgNdK60S/lSwvnik2DtqZ+MX
         wv73r9Fcn1IU/A33lsA9zDP+TX0hzhQtPmnN1MSXVWfvEe3Yg+LE8ZNqmj+efKyIWFT4
         ZnVkM9SqBbRDvoP+3wOjnI86Cz7D/yLMyDo+MsRWDtlG8zXn5qUj0VOzaPampFUkLyX0
         jhjA==
X-Gm-Message-State: AGi0PuYW0bkSCZBye7ZcHD6A90gJLnYbhJCP1XN4Gv+DLI6h371YmzJn
        YzbHOcVP8zBfWMWOgFf1nptde4HCYso=
X-Google-Smtp-Source: APiQypJEdaJEp70hkjwt+Grt8d9OToNcVFk0hEfRCKkuAyNnQw7XejbZ5vqYEyZTHPELhn74PH8F7w==
X-Received: by 2002:a17:90a:1b44:: with SMTP id q62mr590798pjq.79.1588620560320;
        Mon, 04 May 2020 12:29:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p64sm253162pjp.7.2020.05.04.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:29:19 -0700 (PDT)
Date:   Mon, 4 May 2020 12:29:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pstore/ram: allow to dump kmesg during regular
 reboot
Message-ID: <202005041222.4A870DFEC@keescook>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502143555.543636-3-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 10:35:54AM -0400, Pavel Tatashin wrote:
> Currently, ramoops is capable to collect dmesg buffer only during
> panic and oops events. However, it is desirable to optionally allow
> collecting dmesg buffers during other events as well: reboot, kexec,
> emergency reboot etc.
> 
> While, a similar functionality is provided by pstore console it is not the
> same. Often, console message level is reduced in production due to baud
> rate limitation of serial consoles.  Having a noisy console reduces the
> boot performance.
> 
> Thus, if the shutdown dmesg buffer is needed to study the shutdown
> performance, it is currently not possible to do so with console as by
> increasing the console output the shutdown time substantially increases
> as well.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  fs/pstore/platform.c       |  6 ++++--
>  fs/pstore/ram.c            | 38 +++++++++++++++++++++++++++-----------
>  include/linux/pstore.h     |  1 +
>  include/linux/pstore_ram.h |  1 +
>  4 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 408277ee3cdb..d0393799fe6c 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -476,8 +476,10 @@ static struct kmsg_dumper pstore_dumper = {
>  /*
>   * Register with kmsg_dump to save last part of console log on panic.
>   */
> -static void pstore_register_kmsg(void)
> +static void pstore_register_kmsg(int dmesg_all)
>  {
> +	if (dmesg_all)
> +		pstore_dumper.max_reason = KMSG_DUMP_MAX;

So, I'd like to avoid any new arguments in the API and instead add a new
field to struct pstore_info, which will be valid when PSTORE_FLAGS_DMESG
is set, and the max kdump reason can be set there by the pstore backends.

>  	kmsg_dump_register(&pstore_dumper);
>  }
>  
> @@ -603,7 +605,7 @@ int pstore_register(struct pstore_info *psi)
>  		pstore_get_records(0);
>  
>  	if (psi->flags & PSTORE_FLAGS_DMESG)
> -		pstore_register_kmsg();
> +		pstore_register_kmsg(psi->flags & PSTORE_FLAGS_DMESG_ALL);
>  	if (psi->flags & PSTORE_FLAGS_CONSOLE)
>  		pstore_register_console();
>  	if (psi->flags & PSTORE_FLAGS_FTRACE)
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 795622190c01..9d2d1b299225 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -62,6 +62,12 @@ module_param(dump_oops, int, 0600);
>  MODULE_PARM_DESC(dump_oops,
>  		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
>  
> +static int dump_all;
> +module_param(dump_all, int, 0600);
> +MODULE_PARM_DESC(dump_all,
> +		 "set to 1 to record all kernel kmesg dump events (default 0) "
> +		 "otherwise only panics and oops are recorded");

And instead of using a "dump_all" here, let's add a new field that is
the max reason. When both "max_reason" and "dump_oops" are defined,
"max_reason" should win.

> +
>  static int ramoops_ecc;
>  module_param_named(ecc, ramoops_ecc, int, 0600);
>  MODULE_PARM_DESC(ramoops_ecc,
> @@ -82,6 +88,7 @@ struct ramoops_context {
>  	size_t ftrace_size;
>  	size_t pmsg_size;
>  	int dump_oops;
> +	int dump_all;
>  	u32 flags;
>  	struct persistent_ram_ecc_info ecc_info;
>  	unsigned int max_dump_cnt;
> @@ -381,17 +388,19 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
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
> +	if (!cxt->dump_all) {
> +		/*
> +		 * By default only store crash logs, rather than storing general
> +		 * kernel logs.
> +		 */
> +		if (record->reason != KMSG_DUMP_OOPS &&
> +		    record->reason != KMSG_DUMP_PANIC)
> +			return -EINVAL;

Then all these tests can be collapsed much more cleanly, etc.

>  
> -	/* Skip Oopes when configured to do so. */
> -	if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
> -		return -EINVAL;
> +		/* Skip Oopes when configured to do so. */
> +		if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
> +			return -EINVAL;
> +	}
>  
>  	/*
>  	 * Explicitly only take the first part of any new crash.
> @@ -688,6 +697,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  	pdata->mem_address = res->start;
>  	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
>  	pdata->dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
> +	pdata->dump_all = of_property_read_bool(of_node, "dump-all");
>  
>  #define parse_size(name, field) {					\
>  		ret = ramoops_parse_dt_size(pdev, name, &value);	\
> @@ -786,6 +796,7 @@ static int ramoops_probe(struct platform_device *pdev)
>  	cxt->ftrace_size = pdata->ftrace_size;
>  	cxt->pmsg_size = pdata->pmsg_size;
>  	cxt->dump_oops = pdata->dump_oops;
> +	cxt->dump_all = pdata->dump_all;
>  	cxt->flags = pdata->flags;
>  	cxt->ecc_info = pdata->ecc_info;
>  
> @@ -828,8 +839,11 @@ static int ramoops_probe(struct platform_device *pdev)
>  	 * the single region size is how to check.
>  	 */
>  	cxt->pstore.flags = 0;
> -	if (cxt->max_dump_cnt)
> +	if (cxt->max_dump_cnt) {
>  		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
> +		if (cxt->dump_all)
> +			cxt->pstore.flags |= PSTORE_FLAGS_DMESG_ALL;
> +	}
>  	if (cxt->console_size)
>  		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
>  	if (cxt->max_ftrace_cnt)
> @@ -866,6 +880,7 @@ static int ramoops_probe(struct platform_device *pdev)
>  	mem_address = pdata->mem_address;
>  	record_size = pdata->record_size;
>  	dump_oops = pdata->dump_oops;
> +	dump_all = pdata->dump_all;
>  	ramoops_console_size = pdata->console_size;
>  	ramoops_pmsg_size = pdata->pmsg_size;
>  	ramoops_ftrace_size = pdata->ftrace_size;
> @@ -949,6 +964,7 @@ static void __init ramoops_register_dummy(void)
>  	pdata.ftrace_size = ramoops_ftrace_size;
>  	pdata.pmsg_size = ramoops_pmsg_size;
>  	pdata.dump_oops = dump_oops;
> +	pdata.dump_all = dump_all;
>  	pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
>  
>  	/*
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index e779441e6d26..32092c2d7224 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -195,6 +195,7 @@ struct pstore_info {
>  #define PSTORE_FLAGS_CONSOLE	BIT(1)
>  #define PSTORE_FLAGS_FTRACE	BIT(2)
>  #define PSTORE_FLAGS_PMSG	BIT(3)
> +#define PSTORE_FLAGS_DMESG_ALL	BIT(4)
>  
>  extern int pstore_register(struct pstore_info *);
>  extern void pstore_unregister(struct pstore_info *);
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index 9cb9b9067298..f23c29cbd205 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -134,6 +134,7 @@ struct ramoops_platform_data {
>  	unsigned long	ftrace_size;
>  	unsigned long	pmsg_size;
>  	int		dump_oops;
> +	int		dump_all;
>  	u32		flags;
>  	struct persistent_ram_ecc_info ecc_info;
>  };
> -- 
> 2.25.1
> 

Thanks!

-- 
Kees Cook
