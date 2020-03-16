Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D5C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839220575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgCPOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:01:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37365 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgCPOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:01:43 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jDqJJ-0003Kd-02
        for linux-kernel@vger.kernel.org; Mon, 16 Mar 2020 14:01:41 +0000
Received: by mail-qv1-f71.google.com with SMTP id o102so5733746qvo.14
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ls0qQ2FGNgDvZWRTpY07HTV7A5C1zgaL8CBC4ySrAQw=;
        b=TDcK4wF6g5J66DN2+zpFiQ9nwlwVtuDGH3eMj6CDnHz7bP08dP1syJccmIAYqFMMiP
         K71TFKRtVxQtoXgS8r207laiSfSUwdrO6Xm08OdeyUV7vmjI1TeaxRdf3TE0NThPsmPi
         kC21MINtekCIfQkHZjTXfHzgWqAB3/nHJf2CreqzBqwhFEcp4Q16hFKgBxsCHRofahDn
         G8eGQZYK66PdEhDoYNfptXOfYkQCgmbKY4NF15WweEgeQIn3TIYAV3BBjzO9i0NLJ264
         XeEI2C0YBmIA/F6rWoJPPUqWbn0+QTqsK8jOt2/xNwFl87go9+vkccxchubnukZWeYiC
         1gag==
X-Gm-Message-State: ANhLgQ0BUYe/AREOz+HMusECaEVrPfb+C5NgEP+wGC8LMEVe8QVH/7jD
        C7aZvFOX6Pj8Uzaa5k3tWWGUWGBEvyKigmDqQ23eBbePHk6OHjgbSzAgNW12YMup6KgiAU1IypP
        hqqfOAFvJvvLoKXd4fLro4gMbxGiNMg5EEpS/+wHeqw==
X-Received: by 2002:ac8:1111:: with SMTP id c17mr117035qtj.253.1584367300056;
        Mon, 16 Mar 2020 07:01:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu0d8Jvr+dHBpCDoXy3rrdInV4r0mPhJVop5HUsqAwYQJYxYtMmITQv+vnidzPqqhpY1s6+gw==
X-Received: by 2002:ac8:1111:: with SMTP id c17mr116970qtj.253.1584367299496;
        Mon, 16 Mar 2020 07:01:39 -0700 (PDT)
Received: from [192.168.1.75] (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id f203sm4830714qke.100.2020.03.16.07.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 07:01:37 -0700 (PDT)
Subject: Re: [PATCH] kernel/hung_task.c: Introduce sysctl to print all traces
 when a hung task is detected
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, kernel@gpiccoli.net
References: <20200310155650.17968-1-gpiccoli@canonical.com>
 <ef3b3e9a-9d58-60ec-d638-88ad57d29aec@canonical.com>
 <202003132011.8143A71FE@keescook>
 <c4b05b32-216a-e130-259f-0d9506ff9244@i-love.sakura.ne.jp>
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
Message-ID: <627a34c6-6ccd-d6c9-ae91-fd7cb4087e96@canonical.com>
Date:   Mon, 16 Mar 2020 11:01:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c4b05b32-216a-e130-259f-0d9506ff9244@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/2020 01:27, Tetsuo Handa wrote:
> On 2020/03/14 12:12, Kees Cook wrote:
>> On Fri, Mar 13, 2020 at 02:23:37PM -0300, Guilherme G. Piccoli wrote:
>>> Kees / Testsuo, are you OK with this patch once I resend with the
>>> suggestions you gave me?
>>
>> I think so, yes. Send a v2 (to akpm with us in CC).
>>
>>> Is there anybody else I should loop in the patch that should take a
>>> look? Never sent sysctl stuff before, sorry if I forgot somebody heheh
>>
>> akpm usually takes these kinds of things.
>>
> 
> Well, maybe sysctl_hung_task_all_cpu_backtrace = 1 by default is better for
> compatibility? Please CC or BCC kernel-testing people so that they can add
> hung_task_all_cpu_backtrace=1 kernel command line parameter to their testing
> environments if sysctl_hung_task_all_cpu_backtrace = 0 by default.
> 

Thanks a lot Kees and Tetsuo, I'll implement the suggestions and loop
the kernel-testing  and akpm in V2.

About being default, I personally think it's better / more reasonable to
have this parameter defaults to 0, to keep consistency with all other
*_all_cpu_backtrace parameters. Right now kernel shows the backtraces
only when hung_task_panic is set, so the idea of this patch is to
decouple the toggles and allow the user to decide about this policy.

Nevertheless, if people consider that would be good to have it as
enabled by default, I can change it in a potential V3.
Cheers,


Guilherme
