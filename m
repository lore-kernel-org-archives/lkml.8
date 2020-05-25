Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB523C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B578520787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="b580WbuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbgEYKCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389398AbgEYKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:02:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD476C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:02:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so19897448ejd.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6JDfobSYqsyyu/D04lt0P9nNu2ecR7qiHqjNJohMlNY=;
        b=b580WbuQio33Ps4e9L5AU+KV1wNrHDvSj3P7VUMr67ZaY1yZjpzIbAVBTvJ/Tk5IFP
         1tnDzoH8kmqk8Kh/oRxWch+baMdtU7/Z/MUuMIA82bhJtoRyBpuQLB7NtYahUK0ALJFh
         fEmWHjzKhN0EHWI+coRlbD1JAiWnGem/TR0cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JDfobSYqsyyu/D04lt0P9nNu2ecR7qiHqjNJohMlNY=;
        b=uWcs/qNJlUjD9QES3wvyNVtHV2Cc0bvW2RfHuEgQOZkWlVdNL9OVtsPm0GyqxwxA2K
         dxIFpXyed5q9EraZee0cRKP3tHF2Lb5kYgy0F++4a6jr8VV0dy4yfJnm9ZctFx1Y4e/v
         lU8g/3V8m4yIj9Nwz+V8w92jK5NGkKKu1VogwqCBZfVswu6SPG6qpjldeWcboehlk1Zr
         lRD23jga3m2+ZOGDfyAOl+HmLg8ncwlOZlNG44fTWLFPSgByvQpCOHxOJTe6LAL4ikkO
         wEfPlIKDMSio6dwoFuSkwwLvX/w6vHs2KGk6kgAYUG0zGLSaRD/7UDIABEsY2O3cCnaF
         oE3A==
X-Gm-Message-State: AOAM533XSftntIx8sPqywiVFD/YG4pH0xRXUWYkCBpErZvVPiNhe1RJx
        wKuza/L1FCGPTPd/YCnGs7ZE7lfIN08=
X-Google-Smtp-Source: ABdhPJytttyVFOBHWCNPFXrLtf0vBMuWsXkAaUqpN6Eu9Z0mfXUzr8e2Mo0B65wbCGSqkLgV0Gef6A==
X-Received: by 2002:a17:906:6841:: with SMTP id a1mr18675793ejs.271.1590400970458;
        Mon, 25 May 2020 03:02:50 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id y66sm7684552ede.24.2020.05.25.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 03:02:49 -0700 (PDT)
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
References: <20200522204738.645043059@infradead.org>
 <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
 <20200523125940.GA2483@worktop.programming.kicks-ass.net>
 <20200523213235.GB4496@worktop.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <cd2f91e4-aa90-eb98-7f8c-218e8521ac85@rasmusvillemoes.dk>
Date:   Mon, 25 May 2020 12:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200523213235.GB4496@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2020 23.32, Peter Zijlstra wrote:
> On Sat, May 23, 2020 at 02:59:40PM +0200, Peter Zijlstra wrote:
>> On Fri, May 22, 2020 at 03:13:57PM -0700, Andy Lutomirski wrote:
> 
>> Good point, so the trivial optimization is below. I couldn't find
>> instruction latency numbers for DRn load/stores anywhere. I'm hoping
>> loads are cheap.
> 
> +	u64 empty = 0, read = 0, write = 0;
> +	unsigned long dr7;
> +
> +	for (i=0; i<100; i++) {
> +		u64 s;
> +
> +		s = rdtsc();
> +		barrier_nospec();
> +		barrier_nospec();
> +		empty += rdtsc() - s;
> +
> +		s = rdtsc();
> +		barrier_nospec();
> +		dr7 = native_get_debugreg(7);
> +		barrier_nospec();
> +		read += rdtsc() - s;
> +
> +		s = rdtsc();
> +		barrier_nospec();
> +		native_set_debugreg(7, 0);
> +		barrier_nospec();
> +		write += rdtsc() - s;
> +	}
> +
> +	printk("XXX: %ld %ld %ld\n", empty, read, write);
> 
> 
> [    1.628125] XXX: 2800 2404 19600
> 
> IOW, reading DR7 is basically free, and certainly cheaper than looking
> at cpu_dr7 which would probably be an insta cache miss.
> 

Naive question: did you check disassembly to see whether gcc threw your
native_get_debugreg() away, given that the asm isn't volatile and the
result is not used for anything? Testing here only shows a "mov
%r9,%db7", but the read did seem to get thrown away.

Rasmus
