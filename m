Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7ECC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1092063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgHQRak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:30:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37453 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbgHQQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:59:09 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1k7iTS-00040Z-DC
        for linux-kernel@vger.kernel.org; Mon, 17 Aug 2020 16:59:06 +0000
Received: by mail-qk1-f199.google.com with SMTP id 1so11267467qkm.19
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t1x9C5h8RE8Px4q89lymM+TedzlONkscXaarS6nSz68=;
        b=C8VpP1zMfvneDf2REwD15iZSjsZZ5ICeO3mLU5blBfnBVrEvZuOe21gycU13SpNhP3
         C+Xmsptu7mJqisbZZiZUMKsDadCJLN+P63Su6tQ2VHsGkjLhClcuFhCdisIOq1madjR7
         Z+5YnGzXFZSWy2Z/dOO8esAbiKhVqEufLF53vgas9hZmWvgXMIXJMszGTyIGbsXJ73rB
         o0cVCRxyrLmIKouOSJkPCtwy8YC3lntVgcRaGcVMSlZkJOqKuUL2TsL0jCMv/JqUttm+
         ulDicTODpjLo79/s26tiLpmxOx9QBAqUpqboLFZ9jhFuGjvSSvP92NF05Vjf2zo+2Ozt
         Bs6A==
X-Gm-Message-State: AOAM5326ofxul6YrbkjgSgbn4CefiYTg2eojcKWXvc/5vK2H7d2+6fKP
        CnFfZ++YMz29EqAyh8tIL14Lort8Z0BaMBqpEImvrzzHT9Bsie8P+Q0sLUE+zLM5N9WfH2ZyiBB
        242gkbIPjNsmxJ1g0ah+ZvWzrrkWDeHsNaRCL+Os78w==
X-Received: by 2002:ac8:1729:: with SMTP id w38mr14451109qtj.103.1597683545481;
        Mon, 17 Aug 2020 09:59:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxJJiv/Ri8rwm/wGpQwF0OCCWyOwaGCMllzvaEgPPwx8RdxAfTH9PUscUkBAtI5yJmc8VJeQ==
X-Received: by 2002:ac8:1729:: with SMTP id w38mr14451090qtj.103.1597683545208;
        Mon, 17 Aug 2020 09:59:05 -0700 (PDT)
Received: from [192.168.1.75] ([191.8.4.228])
        by smtp.gmail.com with ESMTPSA id y14sm20591273qtc.84.2020.08.17.09.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 09:59:04 -0700 (PDT)
Subject: Re: [PATCH 4.19 35/47] x86/irq: Seperate unused system vectors from
 spurious entry again
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     jan.kiszka@siemens.com, jbeulich@suse.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        stable@vger.kernel.org,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        pedro.principeza@canonical.com
References: <c2b7a96a-122e-bdec-7368-d54700a55915@canonical.com>
 <20200817162156.GA715236@kroah.com>
 <a2788632-5690-932b-90de-14bd9cabedec@canonical.com>
 <20200817164924.GA721399@kroah.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <14968c46-ad8f-fbdf-88d6-0ded954534c9@canonical.com>
Date:   Mon, 17 Aug 2020 13:59:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200817164924.GA721399@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 13:49, Greg KH wrote:
> [...]
>> I'm sorry, I hoped the subject + thread would suffice heh
> 
> There is no thread here :(
> 

Wow, that's odd. I've sent with In-Reply-To, I'd expect it'd get
threaded with the original message. Looking in lore archive [1], it
seems my first message wasn't threaded but the others were...apologies
for that, not sure what happened...


>> So, the mainline commit is: f8a8fe61fec8 ("x86/irq: Seperate unused
>> system vectors from spurious entry again") [0]. The backport to 4.19
>> stable tree has the following id: fc6975ee932b .
> 
> Wow, over 1 1/2 years old, can you remember individual patches that long
> ago?
> 
> Anyway, did you try to backport the patch to older kernels to see if it
> was possible and could work?
> 
> If so, great, please feel free to submit it to the
> stable@vger.kernel.org list and I will be glad to pick it up.
> 

I'm working on it, it is feasible. But I'm seeking here, in this
message, what is the reason it wasn't backported for pre-4.19 - is there
anything on these patches that is known to break old kernels? I'll
certainly submit my backported patch to stable 4.14 once I'm sure it's
working and there's no specific reason to not have it done before.

Thanks again!


[1]
https://lore.kernel.org/stable/a2788632-5690-932b-90de-14bd9cabedec@canonical.com/T/#mf0b26d5a7ff880cfd63bcda80136296275d3682e
