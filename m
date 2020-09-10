Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE6DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7649320C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="ZW+XrCOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgIJKz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgIJKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:52:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B21C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:52:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h6so4436264qtd.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bq6Xd8oBWW/kHc7+k0vFqhBls4w6B4cN1d1NTriuls=;
        b=ZW+XrCOJ9Hh8BdUcXHsXfPQsWDxpPcRlA+Zod0PrwTfm4pqgiZReUjNgCeFIZXPmpD
         WSg1VkhZnd49D1+mvRomDad172OZhvVlZLSBBc4AXkayC2lVG+pm8OLUf/CZ5Et8uL3W
         ybvngSICWecytQ4N9qHaCd3ksvrLTd/H81rbEn9lOZ+H5mcJ7uRvQvSPKR/AezVigLbC
         NlJl/Xzgyq5WF2JFWsWKbHmxkTLe4t5eewOpcQqME8SApDZZ9YRCosJvauJ7P4yP02lI
         kam36xVAyMsflj7fT1713H6j/vNnlm3K1DFv3DOBQraKHmkn/RC7yev0Kt5TjA5AbUwD
         Bacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bq6Xd8oBWW/kHc7+k0vFqhBls4w6B4cN1d1NTriuls=;
        b=lZYjl8jlGILHxcVua3X1lEtQNMGRnv6HhiPeWf/+oJExAnTyJUSykK5O4cj3xUxxH6
         H3HrhDlJrkX4xIBSi8y11aOGkalskJnhXVhRH5h1nYJfPSNdYNtklNCdM2RGs+uwX20r
         uQsuslaAttCOnOtHk5UwmfIApVMiTJa2u3807xTonxTCGR1HXVxt4BP2kxfaVQ1MVypr
         bpbhWs2V0tGzWgjcCPFWGA3hHczJc05RbdSXgGbPFqsNHaGdOxKdAtHeya58ZXOfn2nS
         F14hKHDqIsd/GJlsuDRiUbYlos1Jj0zXWXJoNO61OhZAT+y29v4Wrn1EoamslCOVZgU0
         xOfg==
X-Gm-Message-State: AOAM532U8cBuAmruHSoq7jpefaDDSZbWcKacHTXvohUgqANkBi3aECiC
        MjNAkYyuE0/0pCn/IvvTv7m2eCk0+/YU9g==
X-Google-Smtp-Source: ABdhPJy6O+/o8/P4gNB4yn6wAiyYvPZg0hNmNysrRDLfOHkpzISuROIy5kgaJXZUaKMI6m3u9qatJw==
X-Received: by 2002:ac8:7145:: with SMTP id h5mr7571530qtp.110.1599735161446;
        Thu, 10 Sep 2020 03:52:41 -0700 (PDT)
Received: from ?IPv6:2607:fb90:5e99:306e:7450:cff:fe32:650b? ([2607:fb90:5e99:306e:7450:cff:fe32:650b])
        by smtp.gmail.com with ESMTPSA id j31sm6893908qta.6.2020.09.10.03.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 03:52:40 -0700 (PDT)
Subject: Re: [PATCH] sh: fix syscall tracing
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
 <20200907174436.GK3265@brightrain.aerifal.cx>
 <3b8d5e6a-38d6-6eca-a49a-69e06680ec1c@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <c0685f0b-e997-39e9-8ae9-ee22c8e74a01@landley.net>
Date:   Thu, 10 Sep 2020 06:02:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3b8d5e6a-38d6-6eca-a49a-69e06680ec1c@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 4:55 AM, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/7/20 7:44 PM, Rich Felker wrote:
>>> Can we still get this merged as a hotfix for 5.9?
>>
>> Yes, fixes for regressions in the same release cycle are in-scope (the
>> whole point of having -rc's). I have at least one other fix that needs
>> to go in too and was just giving it a little time to make sure
>> everything's ok now and that there are no more.
> 
> Let me know if there is anything else left for testing.

Could you also merge the fix the build break, ala:

> The vmlinux image is a current vanilla Linux kernel using an initramfs filesystem:
> 
>   make ARCH=sh CROSS_COMPILE=sh2eb-linux-muslfdpic- j2_defconfig vmlinux
> 
> And trying to do that in current git dies with:
> 
>   CC      init/version.o
> In file included from ./include/linux/spinlock.h:318,
>                  from ./arch/sh/include/asm/smp.h:11,
>                  from ./include/linux/smp.h:82,
>                  from ./include/linux/lockdep.h:14,
>                  from ./include/linux/rcupdate.h:29,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/utsname.h:6,
>                  from init/version.c:14:
> ./include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
> ./include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function
> 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
>    90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>       |   ^~~~~~~~~~~~
>       |   xchg_acquire
> ./include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct
> raw_spinlock'} has no member named 'dep_map'
>    90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>       |                     ^~
> 
> And so on and so forth for pages. I bisected it to:
> 
> commit 0cd39f4600ed4de859383018eb10f0f724900e1b
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Thu Aug 6 14:35:11 2020 +0200
> 
>     locking/seqlock, headers: Untangle the spaghetti monster

Which I reported to Rich on the 2nd and he had me test a one line patch fixing
it (adding an extra #include) on the 3rd, but I just did a fresh pull and the
j2_defconfig build still broke a week later.

Rob
