Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E57C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 16:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546F72073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCGQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 11:28:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40954 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgCGQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 11:28:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id p2so5103124wrw.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 08:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7rCLV5E51ratp/3myBhvIaN+I+zKEN/qjBxAwFykF/c=;
        b=MgiQC81a/NE+SsxruiruWTrAtpcGQEGJU7lo52/C48CMO3EIthZ3bg2ePvMAops3rL
         FJ4agyopAb9W5YRr/JGuRXoeKyPcseQdtTUJXi+k+o2hitIkmKZnxe7372h4RpKjxsuu
         UPLmmvZSiqqyoHRcg5KdPHVvY7L0196H+q1j+qPGSDi0LmyrsavdtQdNbM7peL+XySZP
         m4pkvAfo8f0+fc75TBEsYlYnyp4YExH4DxNxLr1eLkNsQJsYfEWxiRinZFNrqtWIrxWB
         3Nf8hnh7XzYoC6vxls6m5i3m9hhvG8/zB9vKPmMW9jPqbeUOvEjoX01+oMSw98VsPci7
         +2MQ==
X-Gm-Message-State: ANhLgQ0HXsGnOhqn4DDwfgyc67+xP8gfdsnw1GxLt/8biyVD28JF+j6U
        xlBn9h3KJYfyyKzwgKZXOJw=
X-Google-Smtp-Source: ADFU+vudtsTL5jvFHk3+tp19tHGWvIQcDl5cOHjjr59MIp4KDQX/to/8JWHgboZW6ZdVOY1Yg0U83A==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr10328678wrs.370.1583598505238;
        Sat, 07 Mar 2020 08:28:25 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g206sm18359810wme.46.2020.03.07.08.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 08:28:24 -0800 (PST)
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
Date:   Sat, 7 Mar 2020 17:28:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 03. 20, 14:58, Tetsuo Handa wrote:
> While syzkaller is finding many bugs, sometimes syzkaller examines
> stupid operations. Currently we prevent syzkaller from examining
> stupid operations by blacklisting syscall arguments and/or disabling
> whole functionality using existing kernel config options, but it is
> a whack-a-mole approach. We need cooperation from kernel side [1].
> 
> This patch introduces a kernel config option which allows disabling
> only specific operations. This kernel config option should be enabled
> only when building kernels for fuzz testing.
> 
> We discussed possibility of disabling specific operations at run-time
> using some lockdown mechanism [2], but conclusion seems that build-time
> control (i.e. kernel config option) fits better for this purpose.
> Since patches for users of this kernel config option will want a lot of
> explanation [3], this patch provides only kernel config option for them.
> 
> [1] https://github.com/google/syzkaller/issues/1622
> [2] https://lkml.kernel.org/r/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com
> [3] https://lkml.kernel.org/r/20191216163155.GB2258618@kroah.com
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/Kconfig.debug | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Changes since v1:
>   Drop users of this kernel config option.
>   Update patch description.
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 53e786e0a604..e360090e24c5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2208,4 +2208,14 @@ config HYPERV_TESTING
>  
>  endmenu # "Kernel Testing and Coverage"
>  
> +config KERNEL_BUILT_FOR_FUZZ_TESTING
> +       bool "Build kernel for fuzz testing"

If we really want to go this way, I wouldn't limit it for fuzz testing
only. Static analyzers, symbolic executors, formal verifiers, etc. --
all of them should avoid the paths.

So what about KERNEL_BUILT_FOR_ANALYZERS?

> +       default n
> +       help
> +	 Say N unless you are building kernels for fuzz testing.
> +	 Saying Y here disables several things that legitimately cause
> +	 damage under a fuzzer workload (e.g. copying to arbitrary
> +	 user-specified kernel address, changing console loglevel,
> +	 freezing filesystems).
> +
>  endmenu # Kernel hacking
> 


-- 
js
suse labs
