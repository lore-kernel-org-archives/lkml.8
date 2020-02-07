Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB30C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1357621741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VQx6/s1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGRtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:49:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53784 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGRtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:49:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so1197197pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mc3SGpgLol8cuQPe/JM6xGKLq6o1Y8gj3sWaRfbubTI=;
        b=VQx6/s1n1WyROgC9QdY3EttPNVnPriU+I97RDkG9Nq4N0pBYeDw9WB+4mlNlzQWOF+
         8IjMoh8yO4YtMZhG0sdw5qIBNY1tmLPLIe0jbhBfVUSWRspGMG+MW5wMDVfI1H2vBemv
         sWzVSd1HHCvUS0i6pBLZQGeuLgaXFByHIc0QW1VuiRL4aI+mMaNnZL/+1AGYI6DX45Nv
         LuuV0rZJSjle5a/Gz9paQyz+tDdsiqT+Z7Pvf+CRgEXQy7aV60Yo9d4oUPeJKwa0+Qh9
         dW8Hnb1LAq4sW60V6naMbfFaAAxW2yhsmV/Tbqx59rY1nigSlyvXve9yhxRzubZoXITB
         4RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mc3SGpgLol8cuQPe/JM6xGKLq6o1Y8gj3sWaRfbubTI=;
        b=qf4CgfNwB4bb9IWbBzJX3wWaHe9+JB+Yw5Clzj7TenPf1iQEXEh2nPUdMEA0s6GJkz
         NCtw24cF3hFnmL/YfFnDVy2eP8hv5kAPyt2Yd62f1kaOvsaekToKw9ny02p8ATp/6AAA
         A+vV5z9p5IWRUs9LzRBFx5pw35Z6ufil4fobpk7Kxhzlkhw2mdqUZisx9FrzpT3WPJOj
         9dkAfoFNBcsmOeblnqWbL1BqcWyxFjHAu8y+Fw1pGy95Gmgr84rBMRO+5nkRAQbmf3WL
         O1tkAqS4DNxa1/wFeVdwoZwS1Oj9SlELuV6x7H8V52de8DgD2xosEn+l1W3TCPFDxA1a
         pgpQ==
X-Gm-Message-State: APjAAAUEi7G2TFzljyLt2x0S+YQ6JY9PMeMmN31PIRRn1Bs/V9DjRC4U
        8KAgS6PRVUiGLNaBEj77RqZ9+Q==
X-Google-Smtp-Source: APXvYqweSLl1/AP+V1KCRR30uvYgUjfDG/blpaEklwnq7tMWZQRehzABXPR3kY4bVpoWjU0kjGpqcw==
X-Received: by 2002:a17:90a:cb8c:: with SMTP id a12mr5267887pju.71.1581097758955;
        Fri, 07 Feb 2020 09:49:18 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id k4sm3918168pfg.40.2020.02.07.09.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 09:49:18 -0800 (PST)
Subject: Re: [PATCH] random: add rng-seed= command line option
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
 <20200207155828.GB122530@mit.edu>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
Date:   Fri, 7 Feb 2020 09:49:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200207155828.GB122530@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 7:58 AM, Theodore Y. Ts'o wrote:
> What was the base of your patch?  It's not applying on my kernel tree.
>
> On Fri, Feb 07, 2020 at 07:07:59AM -0800, Mark Salyzyn wrote:
>> A followup to commit 428826f5358c922dc378830a1717b682c0823160
>> ("fdt: add support for rng-seed") to extend what was started
>> with Open Firmware (OF or Device Tree) parsing, but also add
>> it to the command line.
>>
>> If CONFIG_RANDOM_TRUST_BOOTLOADER is set, then feed the rng-seed
>> command line option length as added trusted entropy.
>>
>> Always rrase all views of the rng-seed option, except early command
>> line parsing, to prevent leakage to applications or modules, to
>> eliminate any attack vector.
> s/rrase/erase/
Noticed that immediately after posting, figured there would be another 
round ;-}
>
>> It is preferred to add rng-seed to the Device Tree, but some
>> platforms do not have this option, so this adds the ability to
>> provide some command-line-limited data to the entropy through this
>> alternate mechanism.  Expect all 8 bits to be used, but must exclude
>> space to be accounted in the command line.
> "all 8 bits"?

Command line (and Device Tree for that matter) can provide 8-bits of 
data, and specifically for the command line as long as they skip space 
and nul characters, we will be stripping the content out of the command 
line because we strip it from view, so that no one gets hot and bothered.

I expected this to be contentious, this is why I call it out. Does 
_anyone_ have a disagreement with allowing raw data (minus nul and space 
characters) to be part of the rng-seed?

>
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
> This doesn't look right at all.  It calls credit_trusted_entropy(),
> but it doesn't actually feed the contents of rng_seed where.  Why not
> just call add_hwgeneterator_randomness() and drop adding this
> credit_trusted_entropy(l)?

It is already added (will add comment so that this is clear) just above 
with add_device_randomness(command_line,). So all we need to do is 
_credit_ the entropy increase.

A call to add_hwgenerator_randomness() can block when the minimum 
threshold has been fulfilled resulting in a kernel panic, and would mix 
the bytes a second time when fed.

-- Mark

