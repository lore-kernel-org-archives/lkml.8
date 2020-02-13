Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07AFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB83F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="rdisC/Rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgBMSpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:45:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44167 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:45:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id y5so3493868pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HW/BXhZ167OEEajAOw2rAoUCDtpe+TnVa4bYsRxTPYc=;
        b=rdisC/Rf+eihKVY2ofZQRKz1/ekjzEms1VyVIvgQw828ZDUOoUk4WssQq9o4es+AwI
         q54fFsbMVJekC0s/uz/JGLEZHy/UIE9CUDJlMq4du0H4pSpMkNh6pZ13Y8srYFho26EU
         iyc89cHX88v96wm3Pf5IGpxIGMob3BFzo5uQvIci2uLfm7VFy5eIU/bOJsWeCXKU00ne
         BTkOMFRIxvqmSJ38p1W+evSjUSDqUf2XfXOMRZNIBO3H6iipsc1MDlDcMXTAWP+BlxNW
         YCUpkxGEEM3vwa+VOOTAUwek2EWkYQ1F98648arU6wbTvtnBmepymPPK17IJsLXxyGTn
         MYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HW/BXhZ167OEEajAOw2rAoUCDtpe+TnVa4bYsRxTPYc=;
        b=JbUiedCxS/WimSy9/3dn0FtqEp9XdGfUcox+GRISplIBIRkeJSm7u4q59UWN2ozPC2
         BxKOck6uJlCE3F9XjrfK392d/3gO/ze0T4CGFEELi6aZsntExH457Nlv4p+5asnLAfdW
         lHbdG979NT9LnWbCDBlB2xMLhd1J9j/3PN+Hq5WZdUG16avfI2cH9BzYIRlMRYfTzFlI
         iIRFBKorh0MbEL1I6sEu1S8TvA6zJRApP7qRxVQgEow37GRVhiKYhX14Wi/7R0CnUZcD
         AASSKYGgGo4eL0fG3nlOhjmgH2wr2ONOiBa6WkVx/P2Doh2HC3Kxfyif2hUsP8mnfIcf
         tAyg==
X-Gm-Message-State: APjAAAVgqZIN60A4+WtU4bB1bTEBfzozFt9zc9jbJG+w+JH/wC8htsJ1
        bzVGf9axHPGlC+NvzdoHLYRvLQ==
X-Google-Smtp-Source: APXvYqyrfRc75DhUOUqp0yRCOfhN/ILA1RABTCP6/i7LIIQfn1FLv2iKkOuVWTlyFICyHA+NaY/mgw==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr15943820pgn.413.1581619500709;
        Thu, 13 Feb 2020 10:45:00 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id 28sm4018642pgl.42.2020.02.13.10.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 10:45:00 -0800 (PST)
Subject: Re: [PATCH] random: add rng-seed= command line option
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
References: <20200207150809.19329-1-salyzyn@android.com>
 <20200207155828.GB122530@mit.edu>
 <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
 <20200208004922.GE122530@mit.edu> <20200207195326.0344ef82@oasis.local.home>
 <20200213202454.f1bb0e65ccc429bde039111b@kernel.org>
 <20200214000343.a3b49deb2f0455568b371d0e@kernel.org>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2dc50225-10e2-01dc-c376-6f9e73087242@android.com>
Date:   Thu, 13 Feb 2020 10:44:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200214000343.a3b49deb2f0455568b371d0e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 7:03 AM, Masami Hiramatsu wrote:
> On Thu, 13 Feb 2020 20:24:54 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>>>> My preference would be to pass in the random seed *not* on the
>>>> command-line at all, but as a separate parameter which is passed to
>>>> the bootloader, just as we pass in the device-tree, the initrd and the
>>>> command-line as separate things.  The problem is that how we pass in
>>>> extra boot parameters is architecture specific, and how we might do it
>>>> for x86 is different than for arm64.  So yeah, it's a bit more
>>>> inconvenient to do things that way; but I think it's also much
>>>> cleaner.
>>> Hmm, if the boot loader could add on to the bootconfig that Masami just
>>> added, then it could add some "random" seed for each boot! The
>>> bootconfig is just an appended file at the end of the initrd.
>> Yeah, it is easy to add bootconfig support to a bootloader. It can add
>> a entropy number as "rng.seed=XXX" text after initrd image with size
>> and checksum. That is architecutre independent way to pass such hidden
>> parameter.
>> (hidden key must be filtered out when printing out the /proc/bootconfig,
>> but that is very easy too, just need a strncmp)
>>
> And here is the patch to support "random.rng_seed = XXX" option by
> bootconfig. Now you can focus on what you want to do. No need to
> modify command line strings.

LGTM, our virtualized emulator (cuttlefish) folks believe they can do it 
this way. Albeit keep in mind that there are _thousands_ of embedded 
bootloaders out there that are comfortable updating DT and kernel 
command line, but few that add boot configs, so this may add complexity. 
For our use case that caused us to need this, the cuttlefish Android 
emulated device, not a problem though.

However, the entropy _data_ has not been added (see below)

Could you please formally re-submit your patch mhiramet@ with a change 
to push the _data_ as well to the entropy?

-- Mark

>
> BTW, if you think you need to pass UTF-8 code as a data, I'm happy to
> update the bootconfig to support it. Just for the safeness, I have
> limited it by isprint() || isspace().
>
> Thank you,
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 26956c006987..43fbbd307204 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -554,6 +554,7 @@ config RANDOM_TRUST_CPU
>   
>   config RANDOM_TRUST_BOOTLOADER
>   	bool "Trust the bootloader to initialize Linux's CRNG"
> +	select BOOT_CONFIG
>   	help
>   	Some bootloaders can provide entropy to increase the kernel's initial
>   	device randomness. Say Y here to assume the entropy provided by the
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index c7f9584de2c8..0ae33bbbd338 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2311,3 +2311,11 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
>   		add_device_randomness(buf, size);
>   }
>   EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> +
> +#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
> +/* caller called add_device_randomness, but it is from a trusted source */
> +void __init credit_trusted_entropy_bits(unsigned int nbits)
> +{
> +	credit_entropy_bits(&input_pool, nbits);
> +}
> +#endif
> diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> index 9955d75c0585..aace466c56ed 100644
> --- a/fs/proc/bootconfig.c
> +++ b/fs/proc/bootconfig.c
> @@ -36,6 +36,9 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
>   		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
>   		if (ret < 0)
>   			break;
> +		/* For keeping security reason, remove randomness key */
> +		if (!strcmp(key, RANDOM_SEED_XBC_KEY))
> +			continue;
>   		ret = snprintf(dst, rest(dst, end), "%s = ", key);
>   		if (ret < 0)
>   			break;
> diff --git a/include/linux/random.h b/include/linux/random.h
> index d319f9a1e429..c8f41ab4f342 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -20,6 +20,13 @@ struct random_ready_callback {
>   
>   extern void add_device_randomness(const void *, unsigned int);
>   extern void add_bootloader_randomness(const void *, unsigned int);
> +#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
> +extern void __init credit_trusted_entropy_bits(unsigned int nbits);
> +#else
> +static inline void credit_trusted_entropy_bits(unsigned int nbits) {}
> +#endif
> +
> +#define RANDOM_SEED_XBC_KEY "random.rng_seed"
>   
>   #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>   static inline void add_latent_entropy(void)
> diff --git a/init/main.c b/init/main.c
> index f95b014a5479..6c3f51bc76d5 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -776,6 +776,32 @@ void __init __weak arch_call_rest_init(void)
>   	rest_init();
>   }
>   
> +static __always_inline void __init collect_entropy(const char *command_line)
> +{
> +	/*
> +	 * For best initial stack canary entropy, prepare it after:
> +	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
> +	 * - timekeeping_init() for ktime entropy used in rand_initialize()
> +	 * - rand_initialize() to get any arch-specific entropy like RDRAND
> +	 * - add_latent_entropy() to get any latent entropy
> +	 * - adding command line entropy
> +	 */
> +	rand_initialize();
> +	add_latent_entropy();
> +	add_device_randomness(command_line, strlen(command_line));
> +	if (IS_BUILTIN(CONFIG_RANDOM_TRUST_BOOTLOADER)) {
> +		/*
> +		 * Added bootconfig device randomness above,

This part is incorrect, the rng_seed collected below was _not_ added to 
the device_randomness.

add_device_randomness(rng_seed, strlen(rng_seed)) needs to be pushed 
below along with the credit.

> +		 * now add entropy credit for just random.rng_seed=<data>
> +		 */
> +		const char *rng_seed = xbc_find_value(RANDOM_SEED_XBC_KEY, NULL);
> +
> +		if (rng_seed)
> +			credit_trusted_entropy_bits(strlen(rng_seed) * 6);
> +	}
> +	boot_init_stack_canary();
> +}
> +
>   asmlinkage __visible void __init start_kernel(void)
>   {
>   	char *command_line;
> @@ -887,18 +913,7 @@ asmlinkage __visible void __init start_kernel(void)
>   	softirq_init();
>   	timekeeping_init();
>   
> -	/*
> -	 * For best initial stack canary entropy, prepare it after:
> -	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
> -	 * - timekeeping_init() for ktime entropy used in rand_initialize()
> -	 * - rand_initialize() to get any arch-specific entropy like RDRAND
> -	 * - add_latent_entropy() to get any latent entropy
> -	 * - adding command line entropy
> -	 */
> -	rand_initialize();
> -	add_latent_entropy();
> -	add_device_randomness(command_line, strlen(command_line));
> -	boot_init_stack_canary();
> +	collect_entropy(command_line);
>   
>   	time_init();
>   	printk_safe_init();
>

