Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDBCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBCD2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BV1MYnzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBGR2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:28:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38914 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:28:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so2723171oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RrybGK8nIp+3lMsUM9rfqG/KoDqGPjWoiE9IU7FJclE=;
        b=BV1MYnzG67f1BADE7f70mCxo6352zyZbRtK1aQtH1EPB1PQo6ZuStPbPhMd8a6EGq6
         anpCYTICrZiHjhRxzPw5C2nvOXGuvJhLdtdFX6/yKvodwNctSzzBGbA3uOR2wpS2Qn/I
         DtDSAs3NpFSlxAZOq0LBp7n9v2yq2O1VbPJS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RrybGK8nIp+3lMsUM9rfqG/KoDqGPjWoiE9IU7FJclE=;
        b=m2btE7vCBj1zzktxW9eO8cPodsbb1DOLGf0T/AwEydtMaqxDdixIA8cO8OFUzbpn1Z
         pGiCU8SLgm4h39LiWsQdh6kQBihgjFLhgqO2ZF2rcTnXTipcMWbCcZ5a/uY5HiDnZVTv
         Tw6mlt6hxv/W03VaiBkI7Eh/0nIrcHudkOPREY/EWTbL2BUWFMpZkpT55qEFUCK1Xj0G
         VdeG4Ee2H7rQa/JR5bfc4au6XPu6ryGwDHA5rZ3H1Kw7Medi3vi/aASwfzLOEFjFma4t
         HTj/ukwAjnq9A8CoYkHADRD01JjhEz7NjQHE8zTlMQHAWYDfmu83W/+QMMp6n4xBocQW
         yhcw==
X-Gm-Message-State: APjAAAXDWWIwz30sym1tA/OALnRp/y6dvT3ivrQH+i5TNlbL4BMIkfYs
        zgEQ+4COaLcwKtqCKeVqvLGyNA==
X-Google-Smtp-Source: APXvYqyS0Z3WGyUeiuVJhSYy8jsQe+U4U8pa9n+c2daLpzWRPaJLIhaFVa6m6vQ3SkI+Qm3GdrWl3g==
X-Received: by 2002:a05:6808:b1c:: with SMTP id s28mr2853844oij.2.1581096510491;
        Fri, 07 Feb 2020 09:28:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v25sm1273626otk.51.2020.02.07.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 09:28:29 -0800 (PST)
Date:   Fri, 7 Feb 2020 09:28:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-ID: <202002070850.BD92BDCA@keescook>
References: <20200207150809.19329-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207150809.19329-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 07:07:59AM -0800, Mark Salyzyn wrote:
> +#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
> +/* caller called add_device_randomness, but it is from a trusted source */
> +void __init credit_trusted_entropy(unsigned int size)
> +{
> +	credit_entropy_bits(&input_pool, size * 8);
> +}
> +#endif

As Ted already mentioned, I was expecting the string contents to actually
get added somewhere. Is the idea that it's already been added via the
add_device_randomness(command_line) call, and you just want to explicitly
credit those bytes? If so, that deserves a comment, and I think it should
likely not use 8 bits per character, as that's not how many bits are
possible for an alphanumeric string character; I would expect 6 bits (~32
standard letter/number) -- this likely needs fixing in the fdt patch too.

> diff --git a/include/linux/random.h b/include/linux/random.h
> index d319f9a1e4290..1e09eeadc613c 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -20,6 +20,11 @@ struct random_ready_callback {
>  
>  extern void add_device_randomness(const void *, unsigned int);
>  extern void add_bootloader_randomness(const void *, unsigned int);
> +#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
> +extern void __init credit_trusted_entropy(unsigned int b);
> +#else
> +static inline void credit_trusted_entropy(unsigned int b) {}
> +#endif
>  
>  #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>  static inline void add_latent_entropy(void)
> diff --git a/init/main.c b/init/main.c
> index cc0ee4873419c..ae976b2dea5dc 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -524,24 +524,53 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
>   * parsing is performed in place, and we should allow a component to
>   * store reference of name/value for future reference.
>   */
> +static const char rng_seed_str[] __initconst = "rng-seed=";
> +/* try to clear rng-seed so it won't be found by user applications. */
> +static void __init copy_command_line(char *dest, char *src, size_t r)
> +{
> +	char *rng_seed = strnstr(src, rng_seed_str, r);
> +
> +	if (rng_seed) {
> +		size_t l = rng_seed - src;
> +		char *end;
> +
> +		memcpy(dest, src, l);
> +		dest += l;
> +		src = rng_seed + strlen(rng_seed_str);
> +		r -= l + strlen(rng_seed_str);
> +		end = strnchr(src, r, ' ');
> +		if (end) {
> +			if (l && rng_seed[-1] == ' ')
> +				++end;
> +			r -= end - src;
> +			src = end;
> +		}
> +	}
> +	memcpy(dest, src, r);
> +	dest[r] = '\0';
> +}
> +
>  static void __init setup_command_line(char *command_line)
>  {
>  	size_t len, xlen = 0, ilen = 0;
> +	static const char argsep_str[] __initconst = " -- ";
> +	static const char alloc_fail_msg[] __initconst =
> +		"%s: Failed to allocate %zu bytes\n";

There's some refactoring in this patch unrelated to the seed logic. Can
you split that out? (I think these changes are good.)

>  
>  	if (extra_command_line)
>  		xlen = strlen(extra_command_line);

Unrelated note: whoa this is based on linux-next which has a massive
change to the boot command line handling and appears to be doing some
bad things. I need to go find that thread...

>  	if (extra_init_args)
> -		ilen = strlen(extra_init_args) + 4; /* for " -- " */
> +		ilen = strlen(extra_init_args) + strlen(argsep_str);
>  
> -	len = xlen + strlen(boot_command_line) + 1;
> +	len = xlen + strnlen(boot_command_line, sizeof(boot_command_line)) + 1;
>  
>  	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
>  	if (!saved_command_line)
> -		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> +		panic(alloc_fail_msg, __func__, len + ilen);
>  
>  	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
>  	if (!static_command_line)
> -		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> +		panic(alloc_fail_msg, __func__, len);
>  
>  	if (xlen) {
>  		/*
> @@ -549,11 +578,14 @@ static void __init setup_command_line(char *command_line)
>  		 * lines because there could be dashes (separator of init
>  		 * command line) in the command lines.
>  		 */
> -		strcpy(saved_command_line, extra_command_line);
> -		strcpy(static_command_line, extra_command_line);
> +		copy_command_line(saved_command_line, extra_command_line, xlen);
> +		copy_command_line(static_command_line, extra_command_line,
> +				  xlen);
>  	}
> -	strcpy(saved_command_line + xlen, boot_command_line);
> -	strcpy(static_command_line + xlen, command_line);
> +	copy_command_line(saved_command_line + xlen, boot_command_line,
> +			  len - xlen - 1);
> +	copy_command_line(static_command_line + xlen, command_line,
> +			  len - xlen - 1);
>  
>  	if (ilen) {
>  		/*
> @@ -562,13 +594,15 @@ static void __init setup_command_line(char *command_line)
>  		 * to init.
>  		 */
>  		len = strlen(saved_command_line);
> -		if (!strstr(boot_command_line, " -- ")) {
> -			strcpy(saved_command_line + len, " -- ");
> -			len += 4;
> +		if (!strnstr(boot_command_line, argsep_str,
> +			     sizeof(boot_command_line))) {
> +			strcpy(saved_command_line + len, argsep_str);
> +			len += strlen(argsep_str);
>  		} else
>  			saved_command_line[len++] = ' ';
>  
> -		strcpy(saved_command_line + len, extra_init_args);
> +		copy_command_line(saved_command_line + len, extra_init_args,
> +				  ilen - strlen(argsep_str));
>  	}
>  }
>  
> @@ -875,6 +909,21 @@ asmlinkage __visible void __init start_kernel(void)
>  	rand_initialize();
>  	add_latent_entropy();
>  	add_device_randomness(command_line, strlen(command_line));
> +	if (IS_BUILTIN(CONFIG_RANDOM_TRUST_BOOTLOADER)) {
> +		size_t l = strlen(command_line);
> +		char *rng_seed = strnstr(command_line, rng_seed_str, l);
> +
> +		if (rng_seed) {
> +			char *end;
> +
> +			rng_seed += strlen(rng_seed_str);
> +			l -= rng_seed - command_line;
> +			end = strnchr(rng_seed, l, ' ');
> +			if (end)
> +				l = end - rng_seed;
> +			credit_trusted_entropy(l);
> +		}
> +	}

Can you pull this out of line and write a new static help that does all
of the rng stuff here? Basically from rand_initialize() through
boot_init_stack_canary(), so it's all in one place and not "open coded"
in start_kernel(). (And then, actually, you don't need a separate
credit_trusted_entropy() function at all -- just call
credit_entropy_bits() directly there (and add a comment about the
command line already getting added).

>  	boot_init_stack_canary();
>  
>  	time_init();
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

-- 
Kees Cook
