Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C67FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0758720734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teY98qQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgFIRHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgFIRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:07:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6F3C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 10:07:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b201so10361927pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZTx5ZBPEtd3KxV5xBnh5x2GRsPKbPJ5c2KJSSkn+vw=;
        b=teY98qQweiRG9Z35MsT4j4Knwffo6RT5Dj1YRoO07EYclZZTZvaQ1Ndplt88ajtLOL
         uyYt7flI7YpxxJuCn5NFKQxLsfRUwBRNgPwp1SJbkwPlIfQd7XwU1RT9bU4QTAU1NFc1
         rbaeqJ9lGpczQ9BHjJvS17pRxDPIjiUOEZCS78U1ngDWhCZnHibp6ZAffMPS5I3VvOle
         DrQjldL7fREqQN6fOQf4scC7IwbkkwAmqLwVHRR8pF75mA0ebaCljrU349ii2jCXC5VA
         bDiqbE/olxFQ8ZoRqE1j048V8V1M1amoiZJpxTN7vSOW1eyB2htS/3ksIWxEyWGPXA6+
         FNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CZTx5ZBPEtd3KxV5xBnh5x2GRsPKbPJ5c2KJSSkn+vw=;
        b=LBmNZrvi/GOlU/PhBATxOu+pNHsPvHb6hcuGZJQgXBwsIbLWYLeylixLnDOb974jHm
         OkdxooFLCm4GjUv9e7PNAiCH4O7rS2gNMyByf9p0O2rwdtjYVk1YUyHltb7tUxYow2qR
         8I6MGDXhVRtB4WPnCWtj3ZqajIRCKYG728BPRUbHL5zXXtFLrWoTcbyWEP9Cah3t1xB2
         wl4/z62Q8m3IE34TfaczDXDbCyNVMY2WjNP+9Ze4j3eXP1l+Bz1mcEp8JkPLHkWGjARt
         uper26i3TIcrkqwcyIL8OzR3Dg8WoMiaPwrToC+G7a7o8HEUNFlfSyGMmehqMfo17aj2
         3U4g==
X-Gm-Message-State: AOAM530Nguqw5NfqUA0BMoDNsAPbGV6Bw4tdilmL9Bvby0AzWiZYhxHQ
        wd8wi5Cmh3ozQGjRgGEc7KvtTCDL
X-Google-Smtp-Source: ABdhPJx2oyVh3mFBarYg1D8Z38J6lsSInExMBaC/8a/jMF9o7sxPKX9R0YptlwYFXAdUKCYu9f2KWg==
X-Received: by 2002:a62:a510:: with SMTP id v16mr9091185pfm.154.1591722466255;
        Tue, 09 Jun 2020 10:07:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u17sm9183634pgo.90.2020.06.09.10.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 10:07:45 -0700 (PDT)
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de> <20200605100059.GB7524@linux.ibm.com>
 <20200609121056.GB3871@suse.de>
 <c11fd19b-e5b6-1bc9-6392-04dbab358b67@roeck-us.net>
 <20200609162354.GB12636@suse.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d7dbd2e2-5547-01e5-296d-23d4e982b2cc@roeck-us.net>
Date:   Tue, 9 Jun 2020 10:07:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200609162354.GB12636@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 9:23 AM, Joerg Roedel wrote:
> Hi Guenter,
> 
> On Tue, Jun 09, 2020 at 07:15:42AM -0700, Guenter Roeck wrote:
>> To build csky images, you have to disable CONFIG_FRAME_POINTER or use a
>> non-upstream compiler. To build any images reliably, you have to disable
>> CONFIG_GCC_PLUGIN_RANDSTRUCT or use a version of gcc old enough to not
>> support it (gcc 6.x is fine). For mips, you have to specify ARCH and
>> CROSS_COMPILE as environment variables.
> 
> My test setup builds defconfigs for all architectures using the gcc-9.3
> based cross-compilers from kernel.org (except the ones I have no
> compiler for). That used to work for CSky and MIPS(64) when working on
> my vmalloc changes.
> 
> On MIPS the build failure looks like some Makefile breakage, but I
> didn't dive deeper into that.
> 

Yes, that was discussed elsewhere. A fix has been submitted and should
hopefully find its way into the kernel sometime soon.

> For CSky the compiler complains about not supporting '-mbacktrace'.
> 

Yes, that is why you have to disable CONFIG_FRAME_POINTER.
'-mbacktrace' is not supported in upstream versions of gcc for csky;
it is only supported in the out-of-tree csky toolchain.

>> alpha is a lost case. The offending commit is 0f1c9688a19 ("tty/sysrq:
>> alpha: export and use __sysrq_get_key_op()"); it looks like that wasn't
>> build tested. It can not be reverted easily because of subsequent changes.
> 
> The below diff fixed the alpha build for me, but I am sure another fix
> is already queued somewhere.
> 

Let's hope it is.

Thanks,
Guenter

> diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> index 6fa802c495b4..8f4ad63a3a9a 100644
> --- a/arch/alpha/kernel/setup.c
> +++ b/arch/alpha/kernel/setup.c
> @@ -431,8 +431,13 @@ register_cpus(void)
>  arch_initcall(register_cpus);
>  
>  #ifdef CONFIG_MAGIC_SYSRQ
> +static void sysrq_reboot_handler(int unused)
> +{
> +	machine_halt();
> +}
> +
>  static const struct sysrq_key_op srm_sysrq_reboot_op = {
> -	.handler	= machine_halt,
> +	.handler	= sysrq_reboot_handler,
>  	.help_msg       = "reboot(b)",
>  	.action_msg     = "Resetting",
>  	.enable_mask    = SYSRQ_ENABLE_BOOT,
> 

