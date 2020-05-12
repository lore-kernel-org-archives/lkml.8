Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9323BC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F9120753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UEfD8pEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgELX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELX5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:57:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB0CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:57:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so1078039pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/un83eq62ib7sMEBamqsTej2IdlfzhbBhP+Wn1rFlVw=;
        b=UEfD8pEyXNO1N8kgnrJK8T/3rhVXgWPjLWlN+Y1j9OXH8AlHW2iBRg+mElxjb2A0pj
         YfTrukk3ZWjZlQHoWFa90FUzcjYnuLz1T771TfwQvrP1PSda8JMpIDUzKCl9hbgNb/Fp
         rlLSxVnU9nRzG8dbeuyBJL3wapz3qWZgC0TI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/un83eq62ib7sMEBamqsTej2IdlfzhbBhP+Wn1rFlVw=;
        b=qxG+MuL3CpD3QLk30NjjcOW8H7FCJ2RXLQgC/CTYv8Lbu0WYACSoIvu/awCPR/QjPH
         TcDQsZiKASpTBsxdhiFpFeMCDHJqu21KLt3uGVp8/YJF5IdJ6PlunF3eWy10Ws5d2VS/
         vAKT0tCkqAXyvyOcVOBPv5aG1Cty1iTxyMcmvernH4mBOO16QveufKs9tYiT7g9wPRU0
         x1ObglZFmM4GhV7OeHm6k12N2BfSS7CSjGUcGj7MgdhEWzbPCWKg1bIFIP7Ikk/cMnTO
         hZYKhZojH8F3BaIkKCiEFI4IadceVL1TE32+2kbJ0YylKZ0PcGMAr4u47PzUCTE5w5zD
         17sg==
X-Gm-Message-State: AGi0PuafB6E+TYKRkjqvn7d8w6CTolJ4TKJXGSEqZkjQ41EKWOCs3OzX
        1svJzz/r4U0qoWGuRib35IZRNg==
X-Google-Smtp-Source: APiQypKLCiYnLwVN1YMsLc9KIENkyooXV7ldGuJb8isv4LBxYRuK4jAVvJZGE5SScqNhGl3zo3n87w==
X-Received: by 2002:aa7:8b15:: with SMTP id f21mr23148055pfd.72.1589327866540;
        Tue, 12 May 2020 16:57:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z60sm14218113pjj.14.2020.05.12.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:57:45 -0700 (PDT)
Date:   Tue, 12 May 2020 16:57:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] pstore/ram: Introduce max_reason and convert
 dump_oops
Message-ID: <202005121652.7EC6FE3@keescook>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200506211523.15077-5-keescook@chromium.org>
 <20200512233504.GA118720@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512233504.GA118720@sequoia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:35:04PM -0500, Tyler Hicks wrote:
> On 2020-05-06 14:15:21, Kees Cook wrote:
> > From: Pavel Tatashin <pasha.tatashin@soleen.com>
> > 
> > Now that pstore_register() can correctly pass max_reason to the kmesg
> > dump facility, introduce a new "max_reason" module parameter and
> > "max-reason" Device Tree field.
> > 
> > The "dump_oops" module parameter and "dump-oops" Device
> > Tree field are now considered deprecated, but are now automatically
> > converted to their corresponding max_reason values when present, though
> > the new max_reason setting has precedence.
> > 
> > For struct ramoops_platform_data, the "dump_oops" member is entirely
> > replaced by a new "max_reason" member, with the only existing user
> > updated in place.
> > 
> > Additionally remove the "reason" filter logic from ramoops_pstore_write(),
> > as that is not specifically needed anymore, though technically
> > this is a change in behavior for any ramoops users also setting the
> > printk.always_kmsg_dump boot param, which will cause ramoops to behave as
> > if max_reason was set to KMSG_DUMP_MAX.
> > 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Link: https://lore.kernel.org/r/20200505154510.93506-4-pasha.tatashin@soleen.com
> > Link: https://lore.kernel.org/r/20200505154510.93506-5-pasha.tatashin@soleen.com
> > Co-developed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Documentation/admin-guide/ramoops.rst     | 14 +++++--
> >  drivers/platform/chrome/chromeos_pstore.c |  2 +-
> >  fs/pstore/ram.c                           | 51 +++++++++++++++--------
> >  include/linux/pstore_ram.h                |  2 +-
> >  4 files changed, 45 insertions(+), 24 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> > index 6dbcc5481000..a60a96218ba9 100644
> > --- a/Documentation/admin-guide/ramoops.rst
> > +++ b/Documentation/admin-guide/ramoops.rst
> > @@ -32,11 +32,17 @@ memory to be mapped strongly ordered, and atomic operations on strongly ordered
> >  memory are implementation defined, and won't work on many ARMs such as omaps.
> >  
> >  The memory area is divided into ``record_size`` chunks (also rounded down to
> > -power of two) and each oops/panic writes a ``record_size`` chunk of
> > +power of two) and each kmesg dump writes a ``record_size`` chunk of
> >  information.
> >  
> > -Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
> > -variable while setting 0 in that variable dumps only the panics.
> > +Limiting which kinds of kmsg dumps are stored can be controlled via
> > +the ``max_reason`` value, as defined in include/linux/kmsg_dump.h's
> > +``enum kmsg_dump_reason``. For example, to store both Oopses and Panics,
> > +``max_reason`` should be set to 2 (KMSG_DUMP_OOPS), to store only Panics
> > +``max_reason`` should be set to 1 (KMSG_DUMP_PANIC). Setting this to 0
> > +(KMSG_DUMP_UNDEF), means the reason filtering will be controlled by the
> > +``printk.always_kmsg_dump`` boot param: if unset, it'll be KMSG_DUMP_OOPS,
> > +otherwise KMSG_DUMP_MAX.
> >  
> >  The module uses a counter to record multiple dumps but the counter gets reset
> >  on restart (i.e. new dumps after the restart will overwrite old ones).
> > @@ -90,7 +96,7 @@ Setting the ramoops parameters can be done in several different manners:
> >          .mem_address            = <...>,
> >          .mem_type               = <...>,
> >          .record_size            = <...>,
> > -        .dump_oops              = <...>,
> > +        .max_reason             = <...>,
> >          .ecc                    = <...>,
> >    };
> >  
> > diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
> > index d13770785fb5..fa51153688b4 100644
> > --- a/drivers/platform/chrome/chromeos_pstore.c
> > +++ b/drivers/platform/chrome/chromeos_pstore.c
> > @@ -57,7 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
> >  	.record_size	= 0x40000,
> >  	.console_size	= 0x20000,
> >  	.ftrace_size	= 0x20000,
> > -	.dump_oops	= 1,
> > +	.max_reason	= KMSG_DUMP_OOPS,
> >  };
> >  
> >  static struct platform_device chromeos_ramoops = {
> > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > index c2f76b650f91..b8dac1d04e96 100644
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
> > @@ -57,10 +57,15 @@ module_param(mem_type, uint, 0600);
> >  MODULE_PARM_DESC(mem_type,
> >  		"set to 1 to try to use unbuffered memory (default 0)");
> >  
> > -static int dump_oops = 1;
> > -module_param(dump_oops, int, 0600);
> > +static int ramoops_dump_oops = -1;
> > +module_param_named(dump_oops, ramoops_dump_oops, int, 0400);
> >  MODULE_PARM_DESC(dump_oops,
> > -		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
> > +		 "set to 1 to dump oopses & panics, 0 to only dump panics (deprecated: use max_reason instead)");
> > +
> > +static int ramoops_max_reason = KMESG_DUMP_OOPS;
> > +module_param_named(max_reason, ramoops_max_reason, int, 0400);
> > +MODULE_PARM_DESC(max_reason,
> > +		 "maximum reason for kmsg dump (default 2: Oops and Panic) ");
> >  
> >  static int ramoops_ecc;
> >  module_param_named(ecc, ramoops_ecc, int, 0600);
> > @@ -81,7 +86,6 @@ struct ramoops_context {
> >  	size_t console_size;
> >  	size_t ftrace_size;
> >  	size_t pmsg_size;
> > -	int dump_oops;
> >  	u32 flags;
> >  	struct persistent_ram_ecc_info ecc_info;
> >  	unsigned int max_dump_cnt;
> > @@ -382,16 +386,14 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
> >  		return -EINVAL;
> >  
> >  	/*
> > -	 * Out of the various dmesg dump types, ramoops is currently designed
> > -	 * to only store crash logs, rather than storing general kernel logs.
> > +	 * We could filter on record->reason here if we wanted to (which
> > +	 * would duplicate what happened before the "max_reason" setting
> > +	 * was added), but that would defeat the purpose of a system
> > +	 * changing printk.always_kmsg_dump, so instead log everything that
> > +	 * the kmsg dumper sends us, since it should be doing the filtering
> > +	 * based on the combination of printk.always_kmsg_dump and our
> > +	 * requested "max_reason".
> >  	 */
> > -	if (record->reason != KMSG_DUMP_OOPS &&
> > -	    record->reason != KMSG_DUMP_PANIC)
> > -		return -EINVAL;
> > -
> > -	/* Skip Oopes when configured to do so. */
> > -	if (record->reason == KMSG_DUMP_OOPS && !cxt->dump_oops)
> > -		return -EINVAL;
> >  
> >  	/*
> >  	 * Explicitly only take the first part of any new crash.
> > @@ -692,7 +694,14 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >  	pdata->mem_size = resource_size(res);
> >  	pdata->mem_address = res->start;
> >  	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
> > -	pdata->dump_oops = !of_property_read_bool(of_node, "no-dump-oops");
> > +	/*
> > +	 * Setting "no-dump-oops" is deprecated and will be ignored if
> > +	 * "max_reason" is also specified.
> > +	 */
> > +	if (of_property_read_bool(of_node, "no-dump-oops"))
> > +		pdata->max_reason = KMSG_DUMP_PANIC;
> > +	else
> > +		pdata->max_reason = KMSG_DUMP_OOPS;
> >  
> >  #define parse_size(name, field, default_value) {			\
> >  		ret = ramoops_parse_dt_size(pdev, name, default_value,	\
> > @@ -708,6 +717,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >  	parse_size("pmsg-size", pdata->pmsg_size, 0);
> >  	parse_size("ecc-size", pdata->ecc_info.ecc_size, 0);
> >  	parse_size("flags", pdata->flags, 0);
> > +	parse_size("max-reason", pdata->max_reason, pdata->max_reason);
> >  
> >  #undef parse_size
> >  
> > @@ -791,7 +801,6 @@ static int ramoops_probe(struct platform_device *pdev)
> >  	cxt->console_size = pdata->console_size;
> >  	cxt->ftrace_size = pdata->ftrace_size;
> >  	cxt->pmsg_size = pdata->pmsg_size;
> > -	cxt->dump_oops = pdata->dump_oops;
> >  	cxt->flags = pdata->flags;
> >  	cxt->ecc_info = pdata->ecc_info;
> >  
> > @@ -834,8 +843,10 @@ static int ramoops_probe(struct platform_device *pdev)
> >  	 * the single region size is how to check.
> >  	 */
> >  	cxt->pstore.flags = 0;
> > -	if (cxt->max_dump_cnt)
> > +	if (cxt->max_dump_cnt) {
> >  		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
> > +		cxt->pstore.max_reason = pdata->max_reason;
> > +	}
> >  	if (cxt->console_size)
> >  		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
> >  	if (cxt->max_ftrace_cnt)
> > @@ -871,7 +882,7 @@ static int ramoops_probe(struct platform_device *pdev)
> >  	mem_size = pdata->mem_size;
> >  	mem_address = pdata->mem_address;
> >  	record_size = pdata->record_size;
> > -	dump_oops = pdata->dump_oops;
> > +	ramoops_max_reason = pdata->max_reason;
> >  	ramoops_console_size = pdata->console_size;
> >  	ramoops_pmsg_size = pdata->pmsg_size;
> >  	ramoops_ftrace_size = pdata->ftrace_size;
> > @@ -954,7 +965,11 @@ static void __init ramoops_register_dummy(void)
> >  	pdata.console_size = ramoops_console_size;
> >  	pdata.ftrace_size = ramoops_ftrace_size;
> >  	pdata.pmsg_size = ramoops_pmsg_size;
> > -	pdata.dump_oops = dump_oops;
> > +	/* Parse deprecated module param "dump_oops" into "max_reason". */
> > +	if (ramoops_dump_oops != -1)
> > +		pdata.max_reason = ramoops_dump_oops ? KMSG_DUMP_OOPS
> > +						     : KMSG_DUMP_PANIC;
> > +	pdata.max_reason = ramoops_max_reason;
> 
> This isn't quite right. We're conditionally assigning pdata.max_reason
> and then immediately re-assigning it.
> 
> IIUC, we're just missing an else block and it should look like this:
> 
> 	/* Parse deprecated module param "dump_oops" into "max_reason". */
> 	if (ramoops_dump_oops != -1)
> 		pdata.max_reason = ramoops_dump_oops ? KMSG_DUMP_OOPS
> 						     : KMSG_DUMP_PANIC;
> 	else
> 		pdata.max_reason = ramoops_max_reason;

Oops, yes. ramoops_max_reason needs to also have an "unset" value so
this can determine which was set... I'll get this fixed. Thanks for
double-checking this!

-- 
Kees Cook
