Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF4021775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PYPA0ttp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGSDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:03:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45793 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:03:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so2793818oic.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JRRbsgErUAdygrmUawyvbwsX1FDEnA0T+uTqNgnT/jc=;
        b=PYPA0ttpp+vc1TnF/YbgoL8VN/4M6PsjI4WWmR8vyu+3R6KHEB43Hz3d4BiZQQyOmS
         6hSONt7bVSi9vN0UJHUgktyq1UvvS3URDabSoLUNuTpum1G5TbVCieRi+jfxRvujRzuH
         Vtn/0cEzDXf0egrjaO5NHlV8ohOxGEmTDDeIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRRbsgErUAdygrmUawyvbwsX1FDEnA0T+uTqNgnT/jc=;
        b=OLWJ6ePEFMOpy3tgWwKWza2fY8WKZGGITkmzJdmHmbX3tJVltVmwa1X+RMaZop2Fxr
         cqks4uR7EXdB1H4x25kXR/WVQdCiB7StluehCFLic7XyCiIuGVgl0wD7yPnidCaLDLMy
         6M6QR0PE8B8Z6edylhv+G20LIbLstWZ6axhiYr/15p7DpyLJJB1FO1+/VsfkawMS4Xe7
         h1Ef9qrMK+9sKCi0+1TVmeQ5vrjfpAdwPU32MfLHwSj4o+tJJhFKQDZ4dRgsqyTA+rjk
         UY4j5CcxuFToc7tx2tdydt3/KOkLDeezdsYr4x8N27/1VNiEPwY8S3Rq57H1Cc6lwo4y
         D4Cg==
X-Gm-Message-State: APjAAAU9lM9k4W0IldWwkb+OsJjS0h5S1AWE4dtecmojYDV98WIQ8eGp
        65oyoDJkq59LwX2InPMeOPzlhA==
X-Google-Smtp-Source: APXvYqySIXJkC4E5+UAOxg9gQFoc/73ETVAbxtMnexlDJFWNypKUZaFeYl3y+TIOUNGOeYBgiO24Ig==
X-Received: by 2002:aca:b183:: with SMTP id a125mr2895769oif.83.1581098599147;
        Fri, 07 Feb 2020 10:03:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f22sm1314244otf.50.2020.02.07.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 10:03:18 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:03:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/22] bootconfig: init: Allow admin to use bootconfig
 for init command line
Message-ID: <202002070954.C18E7F58B@keescook>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867229521.17873.654222294326542349.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157867229521.17873.654222294326542349.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 01:04:55AM +0900, Masami Hiramatsu wrote:
> Since the current kernel command line is too short to describe
> long and many options for init (e.g. systemd command line options),
> this allows admin to use boot config for init command line.
> 
> All init command line under "init." keywords will be passed to
> init.
> 
> For example,
> 
> init.systemd {
> 	unified_cgroup_hierarchy = 1
> 	debug_shell
> 	default_timeout_start_sec = 60
> }
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  init/main.c |   31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index c0017d9d16e7..dd7da62d99a5 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -139,6 +139,8 @@ char *saved_command_line;
>  static char *static_command_line;
>  /* Untouched extra command line */
>  static char *extra_command_line;
> +/* Extra init arguments */
> +static char *extra_init_args;
>  
>  static char *execute_command;
>  static char *ramdisk_execute_command;
> @@ -372,6 +374,8 @@ static void __init setup_boot_config(void)
>  		pr_info("Load boot config: %d bytes\n", size);
>  		/* keys starting with "kernel." are passed via cmdline */
>  		extra_command_line = xbc_make_cmdline("kernel");
> +		/* Also, "init." keys are init arguments */
> +		extra_init_args = xbc_make_cmdline("init");
>  	}
>  }
>  #else
> @@ -507,16 +511,18 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
>   */
>  static void __init setup_command_line(char *command_line)
>  {
> -	size_t len, xlen = 0;
> +	size_t len, xlen = 0, ilen = 0;
>  
>  	if (extra_command_line)
>  		xlen = strlen(extra_command_line);
> +	if (extra_init_args)
> +		ilen = strlen(extra_init_args) + 4; /* for " -- " */
>  
>  	len = xlen + strlen(boot_command_line) + 1;
>  
> -	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> +	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
>  	if (!saved_command_line)
> -		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> +		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
>  
>  	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
>  	if (!static_command_line)
> @@ -533,6 +539,22 @@ static void __init setup_command_line(char *command_line)
>  	}
>  	strcpy(saved_command_line + xlen, boot_command_line);
>  	strcpy(static_command_line + xlen, command_line);
> +
> +	if (ilen) {
> +		/*
> +		 * Append supplemental init boot args to saved_command_line
> +		 * so that user can check what command line options passed
> +		 * to init.
> +		 */
> +		len = strlen(saved_command_line);
> +		if (!strstr(boot_command_line, " -- ")) {
> +			strcpy(saved_command_line + len, " -- ");
> +			len += 4;
> +		} else
> +			saved_command_line[len++] = ' ';
> +
> +		strcpy(saved_command_line + len, extra_init_args);
> +	}

This isn't safe because it will destroy any argument with " -- " in
quotes and anything after it. For example, booting with:

thing=on acpi_osi="! -- " other=setting

will wreck acpi_osi's value and potentially overwrite "other=settings",
etc.

(Yes, this seems very unlikely, but you can't treat " -- " as special,
the command line string must be correct parsed for double quotes, as
parse_args() does.)

>  }
>  
>  /*
> @@ -759,6 +781,9 @@ asmlinkage __visible void __init start_kernel(void)
>  	if (!IS_ERR_OR_NULL(after_dashes))
>  		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
>  			   NULL, set_init_arg);
> +	if (extra_init_args)
> +		parse_args("Setting extra init args", extra_init_args,
> +			   NULL, 0, -1, -1, NULL, set_init_arg);

Here is where you can append the extra_init_args, since parse_args()
will have done the work to find after_dashes correctly.

-Kees

>  
>  	/*
>  	 * These use large bootmem allocations and must precede
> 

-- 
Kees Cook
