Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A2C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A96208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgCKMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:46:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54256 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgCKMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:46:56 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jC0lB-0002tx-9z
        for linux-kernel@vger.kernel.org; Wed, 11 Mar 2020 12:46:53 +0000
Received: by mail-wm1-f70.google.com with SMTP id y7so864694wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tvJQ44fhgXDdQWn9cAVor3F6zkLzPnJd2Xj0RCMCHmY=;
        b=nduHtIep0fyr6ZpZ0p7e6BmfoCm7ct6slTMO/qlCgUfg3is3mN+4/uUWbDOr3kQdN8
         hg9CqCf93lNF0I732E8bhBasmxldLkdHNn7OMivjSc45NQdCEsGIRsg/5wPbOS4aFte6
         RvbrIeRcuMrwfu/DJahoahreLdhA3Xv7mdBZjzwN34gI9Nm8hqlr4WLrO8CUYu7OkYbI
         /dVBT1sHJIW+XHysmOZbGdp14PqiD+PkacNTfvR6fU7NIo7mpcfZDbGw+q5gMW4FYWWs
         Fug1DM5Qdaw4xoOqwPzrt7E8QTlyYnrP0ehHk/sZtUyx3CPGSsgyVl6GCSlzfFnWkVDQ
         Le9A==
X-Gm-Message-State: ANhLgQ3svYaVW9YIgEYDkorxP8HAT85pXXJ2kP8iD+Cywsjv/0dhn3mn
        ePBoablrzVCrD+DiYccNzygzQlSTakgjmYSkGBSjRQi/V5tWdqqEHFpdOmbjZcmeaZNEe9IQpy8
        QTLYw2VFmZpD3fdESmL1cyDQRIbg4Uq2DhaZhgxKCDw==
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr4479065wrb.90.1583930812954;
        Wed, 11 Mar 2020 05:46:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtAy92hJw4Au2IdrMrzzgrgGedx1iAVmYY2M7Bh+NAeJKr0TODVlWeXtDrPpdu/KAZGYTygCg==
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr4479040wrb.90.1583930812703;
        Wed, 11 Mar 2020 05:46:52 -0700 (PDT)
Received: from [192.168.1.75] (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id b5sm28652028wrj.1.2020.03.11.05.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:46:51 -0700 (PDT)
Subject: Re: [PATCH] panic: Add sysctl/cmdline to dump all CPUs backtraces on
 oops event
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, kernel@gpiccoli.net
References: <20200310163700.19186-1-gpiccoli@canonical.com>
 <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
 <20200310182647.59f6ea73aad3aca619065f1e@linux-foundation.org>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <64a6c1c0-9514-e823-3507-a131c7daa578@canonical.com>
Date:   Wed, 11 Mar 2020 09:46:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200310182647.59f6ea73aad3aca619065f1e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2020 22:26, Andrew Morton wrote:
> On Tue, 10 Mar 2020 13:59:15 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>> +oops_all_cpu_backtrace:
>>> +================
>>> +
>>> +Determines if kernel should NMI all CPUs to dump their backtraces when
>>
>> I would much prefer that to be written without using NMI as a verb.
> 
> "Non maskably interrupt" ;)
> 
> I think it's OK.  Concise and the meaning is clear.

Hi Andrew, good idea heheh
Thank you and all that reviewed the grammar/wording, certainly I can
change that and resubmit.


> 
> 
> Why do we need the kernel boot parameter?  Isn't
> /proc/sys/kernel/oops_all_cpu_backtrace sufficient?
> 

I kept the kernel parameter as a consistency thing - every sysctl
"*_all_cpubacktrace" has a respective kernel parameter, so I did the
same (and if we get an oops booting a new kernel, this is maybe useful
depending on the point we get the oops). But if it's a problem for you,
I can remove the kernel parameter, your choice.

Cheers,


Guilherme
