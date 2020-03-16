Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE862051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbgCPNvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:51:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36986 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbgCPNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:51:30 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jDq9Q-0002eB-H7
        for linux-kernel@vger.kernel.org; Mon, 16 Mar 2020 13:51:28 +0000
Received: by mail-qt1-f197.google.com with SMTP id z5so17215684qtd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 06:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EhIQwlnNAveoTYBrgyMkuzdwJCAMfoWP2So3b4Xexpc=;
        b=sIYZVTJpkcf3n9F80cxwY+fdGtFGlu8vPuLm8zFV95BRw/ujjgU7mlXuiCNFW+xqKb
         PTNQL5tuykDDBkM6EApsBi5RlKUKl4Thm5yXwuxN2yJ5PWBT+F1AIKSznBnWI1uB3kK4
         Ez+XvTeC0bKvJCM82iUKbw2AJWHHMgV638GztEcbSAlWv3AD7md17e8YxjoJYSvCyUPx
         gyV928c8OUEaKJViFuB1UYzeg9ynr+uYl627+kGuWC6CENmYgW8GxA0PXjAZmN4JLhch
         JZvakMz7gm0ScukrheWj6938rouB/fqyuCYm92jwGawhypAb2F1OkAZTe+YtDIXkcXu3
         2/yw==
X-Gm-Message-State: ANhLgQ1ORhjFFsufbJh8N76GxZBEcXvjtKaUNhaKYNS8/dSOJ1R/MK7s
        YX5FnNMh+0TLKSvTTmQfyIBdpN2xYDjANMRly2OhxCFLNoK50xT6TpmOVEJaq3z/TAqKkLQoI4o
        NFldXXVVaLmcbqgNhub7hNA6wzk97QaSn05/V6sfZKg==
X-Received: by 2002:a37:888:: with SMTP id 130mr24577653qki.261.1584366687699;
        Mon, 16 Mar 2020 06:51:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vszzPiSqqYYwz+LzbS41Ek/MGxZWMC8cVuT9ZHY+0rJ56S9EG2HbTJ3yNqMrYODePkX06qYAA==
X-Received: by 2002:a37:888:: with SMTP id 130mr24577633qki.261.1584366687458;
        Mon, 16 Mar 2020 06:51:27 -0700 (PDT)
Received: from [192.168.1.75] (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id c18sm6469605qka.111.2020.03.16.06.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 06:51:26 -0700 (PDT)
Subject: Re: [PATCH] panic: Add sysctl/cmdline to dump all CPUs backtraces on
 oops event
To:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, akpm@linux-foundation.org, kernel@gpiccoli.net
References: <20200310163700.19186-1-gpiccoli@canonical.com>
 <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
 <20200314142820.GQ22433@bombadil.infradead.org>
 <43c0e375-6ed1-6a4e-1d61-c0255bf94f26@infradead.org>
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
Message-ID: <a4f5bff0-82c8-114e-0386-9d44baa3cfac@canonical.com>
Date:   Mon, 16 Mar 2020 10:51:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <43c0e375-6ed1-6a4e-1d61-c0255bf94f26@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2020 18:18, Randy Dunlap wrote:
> On 3/14/20 7:28 AM, Matthew Wilcox wrote:
>> On Tue, Mar 10, 2020 at 01:59:15PM -0700, Randy Dunlap wrote:
>>>> +oops_all_cpu_backtrace:
>>>> +================
>>>> +
>>>> +Determines if kernel should NMI all CPUs to dump their backtraces when
>>>
>>> I would much prefer that to be written without using NMI as a verb.
>>
>> Concrete suggestion: "If this option is set, the kernel will send an NMI to
>> all CPUs to dump ..."
>>
> 
> Ack.  Thanks for that.
> 

Thanks Randy and Matthew! I'll implement those changes and resend as V2.
If anybody has suggestions of people I should add to CC list, please let
me know.

Thanks again,


Guilherme
