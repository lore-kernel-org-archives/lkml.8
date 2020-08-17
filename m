Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EC9206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbgHQRWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:22:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37059 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388954AbgHQQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:43:24 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1k7iEC-0002wJ-Sx
        for linux-kernel@vger.kernel.org; Mon, 17 Aug 2020 16:43:21 +0000
Received: by mail-qt1-f197.google.com with SMTP id p22so12465915qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0xqp6xB0x/F0bhAYGhsldeK+3c9wtI19yZmF/fn1Ktk=;
        b=pQ32GfSpQFmWMisOsd4yc4OEyB1NGFDSGKbQ8XHf891Bt4+FAZ/8Pnmg4y4h+z4Fwp
         Pe0ggyGcQgz4teh8r6xGUgu3i7wTuPG0Z0vFNgjjCcSS52dY65Pgs6nUOtQU51tFe6RS
         hpLs/bcbd2BRJq/hQgWOYIDCe997VUhTQDXxeSv5NlRLJXlqsBpO3e8QObOhFpxnQSwc
         4I3kpDYAtBUVT2x5hJ0AA1uDOO7h+DEEpC2Vk83XCFuYym7PFwZcKknJOwU1pj8kQM4G
         RjWAcPSsQEomLT+dZNlFqLclJMXFj+5+ZfGM3ZgB4JKUzuUjUHBw9pwYl6GYRzAyghy7
         vejQ==
X-Gm-Message-State: AOAM532y7JubkplwWnUgSAdgGkh+ObRXorpctHve4xTSK0xRzpX9mq2G
        Q7R449bLhXA1AgHV2W51kNyV/6nsT8ntg5MeX/ZYvEi5iPchdSjo8/Alb6WfgyI1r1x2LW9t0GC
        kqdoGiChRcb8si8+GzU/fQCyKyZ2YrpQnRVcx+EiYNw==
X-Received: by 2002:aed:3689:: with SMTP id f9mr14186360qtb.238.1597682600000;
        Mon, 17 Aug 2020 09:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV+pqTxdDjsPAf45jTQsDme4iPUwb15CUTVTopNSxei2R4A1jDkAKkX2pvDfXB8lwqkS5Fmg==
X-Received: by 2002:aed:3689:: with SMTP id f9mr14186338qtb.238.1597682599694;
        Mon, 17 Aug 2020 09:43:19 -0700 (PDT)
Received: from [192.168.1.75] ([191.8.4.228])
        by smtp.gmail.com with ESMTPSA id k5sm19858067qtu.2.2020.08.17.09.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 09:43:18 -0700 (PDT)
Subject: Re: [PATCH 4.19 35/47] x86/irq: Seperate unused system vectors from
 spurious entry again
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jan.kiszka@siemens.com, jbeulich@suse.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        pedro.principeza@canonical.com
References: <c2b7a96a-122e-bdec-7368-d54700a55915@canonical.com>
 <20200817162156.GA715236@kroah.com>
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
Message-ID: <a2788632-5690-932b-90de-14bd9cabedec@canonical.com>
Date:   Mon, 17 Aug 2020 13:43:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200817162156.GA715236@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 13:21, Greg KH wrote:
> On Mon, Aug 17, 2020 at 12:36:25PM -0300, Guilherme G. Piccoli wrote:
>> Hi Greg / Thomas and all involved here. First, apologies for
>> necro-bumping this thread, but I'm working a backport of this patch to
>> kernel 4.15 (Ubuntu) and then I noticed we have it on stable, but only
>> in 4.19+.
>>
>> Since the fixes tag presents an old commit (since ~3.19), I'm curious if
>> we have a special reason to not have it on long-term stables, like 4.9
>> or 4.14. It's a subtle portion of arch code, so I'm afraid I didn't see
>> something that prevents its backport for previous versions.
> 
> What is the git commit id of this patch you are referring to, you didn't
> provide any context here :(
> 
> thanks,
> 
> greg k-h
> 

I'm sorry, I hoped the subject + thread would suffice heh

So, the mainline commit is: f8a8fe61fec8 ("x86/irq: Seperate unused
system vectors from spurious entry again") [0]. The backport to 4.19
stable tree has the following id: fc6975ee932b .

Thanks,


Guilherme


[0] http://git.kernel.org/linus/f8a8fe61fec8
