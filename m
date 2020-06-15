Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD1B20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592255939;
	bh=aDeXj4GuF31ecjlwOt1cyEe3JewPTNCIbkYoQHZzrLo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=z/IbElKYzrGjIVdrgfdXBPufFrENC244hz7lMGzXqpkaEyseQLPDUdrFD5LqQmLOB
	 +sLyB0nD+hm3l59VFzR17CDZuJIg+XD33zjxV0TP9w5izlpl71qke8r//ua38OmZx/
	 T1KIl3o9FibUmariVktQu4xNw7DZ0XyWyxQWZKuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbgFOVS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:18:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F70EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:18:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id n70so14291522ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7wA6ADxC0Dv+t7J8Wpe11c9KpuI2oB9fUD9vRBm08wI=;
        b=azI1s18oxIrt8ZIRPYEqjiirYROksN7bF4+9hkSf89s3dEGkXFZA/VXLhoxdYm/fVL
         5zlmRy3J0G4t8wBdya2zDV1R54dGq+JtpoS1OD22Z5JMyGivsCbpd9SqRnwJVODR4RrF
         jEo0/NqHBmzUG7PUx2wh9rfZmcGH074bTzLpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7wA6ADxC0Dv+t7J8Wpe11c9KpuI2oB9fUD9vRBm08wI=;
        b=d+WoU8aMXi++kG3x4POBD3+dY4sYlA5OzIOwulDV9d6jNayP37QkBKBBgJzFeJJrvA
         7Gf0yYiNTBWBD3aaBsJUjN09/Vxy5ICBO20n8PnzPP2Bi8mQDBRVlZYtbG0D3yfv5fxQ
         h5u4/HJL0MX0TL5oysixnjBGQIUDKDgKG9xTuBWnxgvECH/BvwfKOv4950h1J+Ruln7f
         RiOzQQMlAdqHeM0dmbmUzKXontT1uTEh9pWcR1iT/JNlpIBXYgE/kVGQUNBzUt7/5dKb
         3KQ8zCm2BXR3V+lIC4+RpUJF2ovZXkoL4TzTmzcVKtcJ+1qvVYlz9HMyNS/qFO1OpXmM
         8uYg==
X-Gm-Message-State: AOAM530rmqsXHASHHiYE4QeDroSG0oYwFCoddIBPDLqgslQsyaTusScx
        xJ50fxD/697czImViMZV+vyfP2UhHgg=
X-Google-Smtp-Source: ABdhPJyt9qFWCrVbXHYTreglZXd2H+Zn3JT3Dj4UxYFmtU8quc45cRuomajICXf01bUEcNOBCY+TRg==
X-Received: by 2002:a9d:4507:: with SMTP id w7mr22512273ote.366.1592255936242;
        Mon, 15 Jun 2020 14:18:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g5sm3556719otb.20.2020.06.15.14.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 14:18:55 -0700 (PDT)
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        skhan@linuxfoundation.org
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
 <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com>
 <f5102546-786d-eb63-10c5-97a92c0be311@linuxfoundation.org>
 <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c35745bb-5700-f6c8-ae5b-e931502cb270@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 15:18:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 2:55 PM, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 1:41 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> I have CONFIG_DEBUG_INFO enabled. Ran the stack trace through
>> scripts/decode_stacktrace.sh
> 
> Thanks. It looks like it isn't needed and people already know what the cause is.
> 
> Also, sadly the stack trace decoding didn't end up as useful as it
> could have been because it looks like it doesn't know how to do the
> nice address lookups for modules.
> 
> So this:
> 
>> [   15.341237] RIP: 0010:__memset (arch/x86/lib/memset_64.S:41)
> 
> gets nicely pinpointed to the source, but the most critical part of
> the call trace is in modules, and there we end up having just
> 
>> [   15.341259] Call Trace:
>> [   15.341267] ? snd_pcm_hw_params+0x3ca/0x440 snd_pcm
>> [   15.341272] snd_pcm_common_ioctl+0x173/0xf20 snd_pcm
>> [   15.341277] ? snd_ctl_ioctl+0x1c5/0x710 snd
>> [   15.341282] snd_pcm_ioctl+0x27/0x40 snd_pcm
> 
> without then looking at the debug info in the snd_pcm module to figure that out.
> 
> Then when the call trace gets back to non-module code, it looks good again:
> 
>> [   15.341285] ksys_ioctl (fs/ioctl.c:49 /home/shuah/lkml/linux_5.8/fs/ioctl.c:753)
>> [   15.341288] __x64_sys_ioctl (fs/ioctl.c:760)
>> [   15.341291] do_syscall_64 (arch/x86/entry/common.c:359)
>> [   15.341294] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:124)
> 
> with pinpointing to exactly where the calls are.
> 
> I note that Konstantin Khlebnikov did add support to do the module
> parts too back in 2016, but it requires people to know to give the
> module path too.
> 
> Adding him and Sasha to the participants in case there are ideas on
> how to improve on this (and party just because I want to once again
> give scripts/decode_stacktrace.sh soem more mention, because a lot of
> people seem to be unaware of how useful it can be to make oopses and
> traces more readable..
> 

Thanks. I usually decode all of this by hand. This script saves a lot
of time. Very cool.

Yeah. I should have thought about adding module path. With module path
added, I get better results:

[   15.341267] ? snd_pcm_hw_params (./include/linux/string.h:391 
/home/shuah/lkml/linux_5.8/sound/core/pcm_native.c:759) snd_pcm
[   15.341272] snd_pcm_common_ioctl (sound/core/pcm_native.c:792 
/home/shuah/lkml/linux_5.8/sound/core/pcm_native.c:3210) snd_pcm
[   15.341277] ? snd_ctl_ioctl+0x1c5/0x710 snd
[   15.341282] snd_pcm_ioctl (sound/core/pcm_native.c:3297) snd_pcm
[   15.341285] ksys_ioctl (fs/ioctl.c:49 
/home/shuah/lkml/linux_5.8/fs/ioctl.c:753)
[   15.341288] __x64_sys_ioctl (fs/ioctl.c:760)
[   15.341291] do_syscall_64 (arch/x86/entry/common.c:359)
[   15.341294] entry_SYSCALL_64_after_hwframe 
(arch/x86/entry/entry_64.S:124)
[   15.341296] RIP: 0033:0x7fcbaf56137b
[ 15.341297] Code: Bad RIP value.

> Maybe even just a warning about lacking a module path when there are
> module symbols present?
> 

It does tell you the usage.

Usage:
	scripts/decode_stacktrace.sh [vmlinux] [base path] [modulespath]


I would be useful to add a warning.

thanks,
-- Shuah
