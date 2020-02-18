Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EB9208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ICU3JWbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBRQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:01:55 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36131 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:01:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so1186758pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dVP6ZBY2M+JrXuQUqUGK+vQhunheflUolWE45cf3nnw=;
        b=ICU3JWbYKsPU2LQp9Pckivg7ORJ9M0upNPytjf4vm+H9SRKAwOgapZ9KcctfHeA+cs
         bywLjK6tFX3QDzLFtM1sM35d6Avu+T7vs11eS+du7H9AHKztudeKBZUXvXWPD7Kay8+j
         pRyVPOHpuZZGL6M8jVEGkixipV4gSqIIPjICKCo4WZbPC3jmdIs0GKV7DmDtmHxk4ysY
         sxx4qeEO95aiclgGRrYs01bqfPNlFpsqjLg2Kg6wlkGR+V8asWPf5H/jpTLjx+HsEYtK
         aNlE8hwR7vOicYF6qRcqXU0BurifiTLUV3w3E3olt8B0VOlDP8EQBx31+blfuU+raNch
         T9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dVP6ZBY2M+JrXuQUqUGK+vQhunheflUolWE45cf3nnw=;
        b=IvTkNiKBqAhRBHLnLCwIQjboeY+Zswi5bV/ZJBBfYWW9D4pVHr7j8547zAzZpYwZ3R
         6sfXgQfrW7/V0SlR+IYQoIUen69y9tJMd/ipShk/jwUObFbAT3GGy9lzHLhXyfp3dyFV
         5aswAk/dGvwdVINwfl62hKLIHHTt8cbK8VWnRmF+039wqAu6zqlW2XAuhFABm5oWdlQY
         TzT+ZERrrzUKaWgqWXGrUbDX6zvNjaU/eTXu9sbssHKuo5hEjOhoqrqBuWJV3rN8zwj5
         KElK6kita4xBA9ogh/aXLpvCP2GvtOt67XTDur5xR6MTla6tX831vYns848T/zcOYbyM
         9UpA==
X-Gm-Message-State: APjAAAXEHZO50at/SVepf/8unWCxScm24Mv7fNjuSE9kQ3ZyYNfoHznP
        HfsmkR++jWDtS/Oldlqkekp4Jw==
X-Google-Smtp-Source: APXvYqzvg0IX1qJX1aYNAwvN1mdrx8cX2z3C4UiXMydXlRlI5aTm13AWzHtr/FnhIrHybbtSueEusw==
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr20343697plo.51.1582041713571;
        Tue, 18 Feb 2020 08:01:53 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id l10sm3804643pjy.5.2020.02.18.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 08:01:52 -0800 (PST)
Subject: Re: [PATCH 2/3] random: rng-seed source is utf-8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Rob Herring <robh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <158166062748.9887.15284887096084339722.stgit@devnote2>
 <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
 <20200214224744.GC439135@mit.edu>
 <f15511bf-b840-0633-3354-506b7b0607fe@android.com>
 <20200215005336.GD439135@mit.edu>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <243ab5a8-2ce1-1465-0175-3f5d483cbde1@android.com>
Date:   Tue, 18 Feb 2020 08:01:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200215005336.GD439135@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 4:53 PM, Theodore Y. Ts'o wrote:
> On Fri, Feb 14, 2020 at 02:55:36PM -0800, Mark Salyzyn wrote:
>>> This is why I really think what gets specified via the boot command
>>> line, or bootconfig, should specify the bits of entropy and the
>>> entropy seed *separately*, so it can be specified explicitly, instead
>>> of assuming that *everyone knows* that rng-seed is either (a) a binary
>>> string, or (b) utf-8, or (c) a hex string.  The fact is, everyone does
>>> *not* know, or everyone will have a different implementation, which
>>> everyone will say is *obviously* the only way to go....
>>>
>> Given that the valid option are between 4 (hex), 6 (utf-8) or 8 (binary), we
>> can either split the difference and accept 6; or take a pass at the values
>> and determine which of the set they belong to [0-9a-fA-F], [!-~] or
>> [\000-\377]  nor need to separately specify.
> So let's split this up into separate issues.  First of all, from an
> architectural issue, I really think we need to change
> add_bootloader_randomness() in drivers/char/random.c so it looks like this:
>
> void add_bootloader_randomness(const void *buf, unsigned int size, unsigned int entropy_bits)
>
> That's because this is a general function that could be used by any
> number of bootloaders.  For example, for the UEFI bootloader, it can
> use the UEFI call that will return binary bits.  Some other bootloader
> might use utf-8, etc.  So it would be an abstraction violation to have
> code in drivers/char/random.c make assumption about how a particular
> bootloader might be behaving.
>
> The second question is we are going to be parsing an rng_seed
> parameter it shows up in bootconfig or in the boot command line, how
> do we decide how many bits of entropy it actually has.  The advantage
> of using the boot command line is we don't need to change the rest of
> the bootloader ecosystem.  But that's also a massive weakness, since
> apparently some people are already using it, and perhaps not in the
> same way.
>
> So what I'd really prefer is if we use something new, and we define it
> in a way that makes as close as possible to "impossible to misuse".
> (See Rusty Russell's API design manifesto[1]).  So I'm going to
> propose something different.  Let's use something new, say
> entropy_seed_hex, and let's say that it *must* be a hex string:
>
>      entropy_seed_hex=7337db91a4824e3480ba6d2dfaa60bec
>
> If it is not a valid hex string, it gets zero entropy credit.
>
> I don't think we really need to worry about efficient encoding of the
> seed, since 256 bits is only 64 characters using a hex string.  An
> whether it's 32 characters or 64 characters, the max command line
> string is 32k, so it's probably not worth it to try to do something
> more complex.  (And only 128 bits is needed to declare the CRNG to be
> fully initialized, in which case we're talking about 16 characters
> versus 32 charaters.)
>
> [1] http://sweng.the-davies.net/Home/rustys-api-design-manifesto
>
> 						- Ted
>
I am additionally concerned about add_bootloader_randomness() because it 
is possible for it to sleep because of add_hwgenerator_randomness() as 
once it hits the entropy threshold. As-is it can not be used inside 
start_kernel() because the sleep would result in a kernel panic, and I 
suspect its use inside early_init_dt_scan_chosen() for the commit "fdt: 
add support for rng-seed" might also be problematic since it is 
effectively called underneath start_kernel() is it not?

If add_bootloader_randomness was rewritten to call 
add_device_randomness() always, and when trusted also called the 
functionality of the new credit_trusted_entropy_bits (no longer needing 
to be exported if so), then the function could be used in both 
start_kernel() and early_init_dt_scan_chosen().


-- Mark

