Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC92C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B3A207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcfzLicS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgESUY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESUYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:24:25 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC6C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:24:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id g20so266006qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BEhjl2sdMOZA0+u7BxgbzxLPOF8R+jwnsLIgVIjuNrQ=;
        b=vcfzLicSVcEJCTGWSvbckZ/Vd1G7w0WYemjhBFSHrKBLv+gc66U8GSb5LU8krom4d6
         9E+cZn179Kvh/4YaUKu+eKgTC0y8txJTN5DUmazVIz+NtU25CnUnuNBTOjBFOmPKkJtg
         nlfOJ8C/lJFAYm07FuogQ5ujzs51Cc9Vh0wdcCF66w/svFGUJ265Erzur4gV+S6LUuvV
         42GIrluv3U2BDhBRHBDAGjkBLDK00VAGjkOJrNS67YjS7JecJkO5nCEOn2rTkCTpgSnc
         DpVgmAunIi/V9oSPXhM2VIU2e+DKJfT3FpC26it4wCw9M/JwggZgqcDLy20ktPhVWkfE
         yNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BEhjl2sdMOZA0+u7BxgbzxLPOF8R+jwnsLIgVIjuNrQ=;
        b=MM5vTrWXN2qK/yBsPj5r5yR8I2OsPs0LfFENi2wLzxlG3e+48qRUwHgaLKQyEKEhcj
         V38i8Zm9liutDwgdv4zYSDc2LuLCdtv/K9NHYAEWti6AvGIKJue92F73OSjXJoK8eii+
         RhZpOewAViXL/HCN4OszG7s0Bw4Ga1ZLY/VKSCt01Sg8Sc/NBaY7HwBlLfjfYIdn+ukK
         dtjAiwPB3JVFiG86tFqTLyNAP1tX9pEy2q23Oj1N/35OUK1CbFd/8O40e1pD9bqDD1zz
         Y3QhbSiI1A8AfdYGv95scg+9gyAX6J4QgXLuH6J3f6JiZdSa6VSJH7IieKUMaf7/tIRg
         n5NA==
X-Gm-Message-State: AOAM533pJt+hJcuXBt9tPh2Ro6+t6uWh4BoVol7uGYdSQxxTCLQfV28m
        7iSoskmKpMXbJNIjCEVUW/nkgg==
X-Google-Smtp-Source: ABdhPJzWg5eT4XU8PyB/lKOKtTmUZDuIIdiKz+D0SNP4XnEEUu3zuan7MH/0OqLxDQbgToY17Qe2TA==
X-Received: by 2002:a0c:f445:: with SMTP id h5mr1361198qvm.151.1589919863076;
        Tue, 19 May 2020 13:24:23 -0700 (PDT)
Received: from [192.168.1.4] ([177.194.48.209])
        by smtp.googlemail.com with ESMTPSA id i41sm702836qte.15.2020.05.19.13.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 13:24:22 -0700 (PDT)
To:     Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, Rich Felker <dalias@libc.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Subject: Re: clock_gettime64 vdso bug on 32-bit arm, rpi-4
Message-ID: <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
Date:   Tue, 19 May 2020 17:24:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/05/2020 16:54, Arnd Bergmann wrote:
> Jack Schmidt reported a bug for the arm32 clock_gettimeofday64 vdso call last
> month: https://github.com/richfelker/musl-cross-make/issues/96 and
> https://github.com/raspberrypi/linux/issues/3579
> 
> As Will Deacon pointed out, this was never reported on the mailing list,
> so I'll try to summarize what we know, so this can hopefully be resolved soon.
> 
> - This happened reproducibly on Linux-5.6 on a 32-bit Raspberry Pi patched
>    kernel running on a 64-bit Raspberry Pi 4b (bcm2711) when calling
>    clock_gettime64(CLOCK_REALTIME)

Does it happen with other clocks as well?

> 
> - The kernel tree is at https://github.com/raspberrypi/linux/, but I could
>   see no relevant changes compared to a mainline kernel.

Is this bug reproducible with mainline kernel or mainline kernel can't be
booted on bcm2711?

> 
> - From the report, I see that the returned time value is larger than the
>   expected time, by 3.4 to 14.5 million seconds in four samples, my
>   guess is that a random number gets added in at some point.

What kind code are you using to reproduce it? It is threaded or issue
clock_gettime from signal handlers?

> 
> - From other sources, I found that the Raspberry Pi clocksource runs
>   at 54 MHz, with a mask value of 0xffffffffffffff. From these numbers
>   I would expect that reading a completely random hardware register
>   value would result in an offset up to 1.33 billion seconds, which is
>   around factor 100 more than the error we see, though similar.
> 
> - The test case calls the musl clock_gettime() function, which falls back to
>   the clock_gettime64() syscall on kernels prior to 5.5, or to the 32-bit
>   clock_gettime() prior to Linux-5.1. As reported in the bug, Linux-4.19 does
>   not show the bug.
> 
> - The behavior was not reproduced on the same user space in qemu,
>   though I cannot tell whether the exact same kernel binary was used.
> 
> - glibc-2.31 calls the same clock_gettime64() vdso function on arm to
>   implement clock_gettime(), but earlier versions did not. I have not
>   seen any reports of this bug, which could be explained by users
>   generally being on older versions.
> 
> - As far as I can tell, there are no reports of this bug from other users,
>   and so far nobody could reproduce it.
> 
> - The current musl git tree has been patched to not call clock_gettime64
>    on ARM because of this problem, so it cannot be used for reproducing it.

So should glibc follow musl and remove arm clock_gettime6y4 vDSO support
or this bug is localized to an specific kernel version running on an
specific hardware?

> 
> If anyone has other information that may help figure out what is going
> on, please share.
> 
>         Arnd
> 
