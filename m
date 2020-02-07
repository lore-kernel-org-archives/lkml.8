Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565FBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2737B214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="gHL5u41U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBGR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:58:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41607 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:58:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id l3so140602pgi.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FfPJmW6BJOKgHihNnbUsgwH294+bwZ9sGROPQFB4wCg=;
        b=gHL5u41U+Cl12x7j3MMJdYFV96fH42p4oyzBzUQr9BqlUVs87WHexXMxoGPcc+O4kw
         0f3EQuvib1WhabPFiCSVC5lx8MmjikJc6ngJ2BZvPM4rU9kZ12d2amILNwSoxH32d/29
         t9cSM9gikGoUDiGdFUKJU5TvfqCDPepdSYsP0awbrd5Bf7Ty9JfWDomLJazz3/LVA6I9
         oWL4Lr0Mk1fHKq2E052JJ/kuHCmOCjc+ep9Jt8tILPtOxAKZzlJGT/NkxluBueTwW7JK
         l5VV33qnRKm4lZO9e2ue9yawhAKFPzJWTEdxEtWSvwominr+LypjP3m0N0fRwI6EclVh
         aZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FfPJmW6BJOKgHihNnbUsgwH294+bwZ9sGROPQFB4wCg=;
        b=bTej8x3B/ldszq2Su10U2jfB/wsDjfYsZZkYvIs1n7NwCxaZUvG0nW2ozru8P9utzl
         wWZrOd7uTTVwgyF7/uqF0NubcdCT8ayL4GOfzmWftXHNwahJ20waicNRQUUgu0kBTxKK
         keSaRL8uh/Ci1VaDBOy5iVAStKPMWrgPkBA9VlE9L3vudbfDkic6F4KTcb2dC6Z9a8qF
         quwZc3zxs/mEkK4nqDdOvQe9uIxk/yngOdQclNDD3tx9Yt8qViiy0kXPMn8s635ajDrS
         7H/CWNc1AxA+rrYhtU6i4ItXqZrKD82ZTq03x4gr/NaBiU++XJk7IQV4pBrVfR7j386s
         LnNA==
X-Gm-Message-State: APjAAAVlsiv6xIn3PEPJkhx5W8fDuFfC9wZuOBIfcQgocaUz+lYrAnyH
        IvBPUwYgbHf0/Gqi7GBEqukt3Q==
X-Google-Smtp-Source: APXvYqxvQ4GAZ8CHdjISy+xX6M+Y5ptYOAVPZxon8CQhrg7l4cwsDOPiFCSuTk8Fy1U2VdGyjNczWA==
X-Received: by 2002:a62:1c88:: with SMTP id c130mr74939pfc.195.1581098309959;
        Fri, 07 Feb 2020 09:58:29 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id t19sm3643834pgg.23.2020.02.07.09.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 09:58:29 -0800 (PST)
Subject: Re: [PATCH] random: add rng-seed= command line option
To:     Kees Cook <keescook@chromium.org>
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
References: <20200207150809.19329-1-salyzyn@android.com>
 <202002070850.BD92BDCA@keescook>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <de2f12b4-aec4-89ea-a2cb-7aaed73916c7@android.com>
Date:   Fri, 7 Feb 2020 09:58:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <202002070850.BD92BDCA@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 9:28 AM, Kees Cook wrote:
> On Fri, Feb 07, 2020 at 07:07:59AM -0800, Mark Salyzyn wrote:
>> +#if defined(CONFIG_RANDOM_TRUST_BOOTLOADER)
>> +/* caller called add_device_randomness, but it is from a trusted source */
>> +void __init credit_trusted_entropy(unsigned int size)
>> +{
>> +	credit_entropy_bits(&input_pool, size * 8);
>> +}
>> +#endif
> As Ted already mentioned, I was expecting the string contents to actually
> get added somewhere. Is the idea that it's already been added via the
> add_device_randomness(command_line) call, and you just want to explicitly
> credit those bytes? If so, that deserves a comment, and I think it should
> likely not use 8 bits per character, as that's not how many bits are
> possible for an alphanumeric string character; I would expect 6 bits (~32
> standard letter/number) -- this likely needs fixing in the fdt patch too.

Yup, responded to Ted as such.

Both can have near-raw 8-bit data as long as they stay away from certain 
characters.

For the command line space and nul characters. Since rng-seed is 
stripped out of any views no one needs to get hurt.

For OF some other parse characters need to be skipped. The rng-seed is 
also memset'd out of existence after being read so no one gets hurt.

I see no harm with multiplying by six in both cases as entropy credit 
should be realistic, but generators can be more ambitious ...

> . .  .
>> +}
>> +
>>   static void __init setup_command_line(char *command_line)
>>   {
>>   	size_t len, xlen = 0, ilen = 0;
>> +	static const char argsep_str[] __initconst = " -- ";
>> +	static const char alloc_fail_msg[] __initconst =
>> +		"%s: Failed to allocate %zu bytes\n";
> There's some refactoring in this patch unrelated to the seed logic. Can
> you split that out? (I think these changes are good.)

Ok, two patches that come to mind:

- move string constants solely referenced in __init function to __initconst

- boot_command_line is not guaranteed nul terminated, strlen must be 
replaced with strnlen.

>>   
>>   	if (extra_command_line)
>>   		xlen = strlen(extra_command_line);
> Unrelated note: whoa this is based on linux-next which has a massive
> change to the boot command line handling and appears to be doing some
> bad things. I need to go find that thread...

I took top of linus tree, I did not use linux-next (!) Hopefully all is 
good.

> . . .
>> @@ -875,6 +909,21 @@ asmlinkage __visible void __init start_kernel(void)
>>   	rand_initialize();
>>   	add_latent_entropy();
>>   	add_device_randomness(command_line, strlen(command_line));
>> +	if (IS_BUILTIN(CONFIG_RANDOM_TRUST_BOOTLOADER)) {
>> +		size_t l = strlen(command_line);
>> +		char *rng_seed = strnstr(command_line, rng_seed_str, l);
>> +
>> +		if (rng_seed) {
>> +			char *end;
>> +
>> +			rng_seed += strlen(rng_seed_str);
>> +			l -= rng_seed - command_line;
>> +			end = strnchr(rng_seed, l, ' ');
>> +			if (end)
>> +				l = end - rng_seed;
>> +			credit_trusted_entropy(l);
>> +		}
>> +	}
> Can you pull this out of line and write a new static help that does all
> of the rng stuff here? Basically from rand_initialize() through
> boot_init_stack_canary(), so it's all in one place and not "open coded"
> in start_kernel(). (And then, actually, you don't need a separate
> credit_trusted_entropy() function at all -- just call
> credit_entropy_bits() directly there (and add a comment about the
> command line already getting added).

sgtm, will do.

Thanks both -- Mark

