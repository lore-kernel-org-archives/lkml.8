Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C88AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4089E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392356AbgHQTUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:20:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbgHQPgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:36:39 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1k7hBZ-0003m7-49
        for linux-kernel@vger.kernel.org; Mon, 17 Aug 2020 15:36:33 +0000
Received: by mail-qt1-f199.google.com with SMTP id d2so12288415qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:in-reply-to:from:subject:autocrypt
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=lX4oOpPokyQTRhoLahqmU7hqvUsW/41acop/Y5jmbvU=;
        b=lQZg6DK5QXuk6HASQTe4gXU4atE0SswMRIqjU17EBygJtc9i5h9Ra9AUSs8ZT0B7wI
         ihmoojEYgwDC/X8QnTe5/IvJsakmvib8AX3p3i5nczut6+iZpEnNiazg1+AViz+tEj3+
         /XC28oGxbRrA9hGharOB38vEJx0538IO0muUvWd7vm/G9l4119s6YyUzuZH6hL6icfSJ
         Q7tLyT71QROrniN4zYaDzC5xuTWkWHKJpXvocARNbwpUeiHrGJrd/tGl/YZ+9jAUngsY
         gAp76C8ExgnI6aq9VETH/5Sy1MOqejUet7NFaPKj1cdz10uWUHmMsAx6YpEIKhvkAtTv
         MApw==
X-Gm-Message-State: AOAM533DQT2ceo/yFZQgSqd+TGC+VwnR0hfzxfLgw3l2uxKNtxOgj7dV
        uyJCx8bB2wmpAId9Chea46uFtqF8n+T4ZFQAIDNkgPHkPaUDY+lMjLid1akkK7rLmfvzuU4y6Q3
        0tZifW9MD2Qi15nZbr2FjSAq6FbVVqyE6d07+6hy+TQ==
X-Received: by 2002:a05:620a:122c:: with SMTP id v12mr13770143qkj.113.1597678592181;
        Mon, 17 Aug 2020 08:36:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzchQO2wunkBbUHR/IjckxcCFqozbIFfFvtzJjLWjYXzLfIMTg7Akjsd9tvlBZhBTWCddLYzA==
X-Received: by 2002:a05:620a:122c:: with SMTP id v12mr13770114qkj.113.1597678591791;
        Mon, 17 Aug 2020 08:36:31 -0700 (PDT)
Received: from [192.168.1.75] ([191.8.4.228])
        by smtp.gmail.com with ESMTPSA id n6sm16058624qkh.74.2020.08.17.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 08:36:30 -0700 (PDT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jan.kiszka@siemens.com, jbeulich@suse.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        gpiccoli@canonical.com, pedro.principeza@canonical.com
In-Reply-To: 
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH 4.19 35/47] x86/irq: Seperate unused system vectors from
 spurious entry again
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
Message-ID: <c2b7a96a-122e-bdec-7368-d54700a55915@canonical.com>
Date:   Mon, 17 Aug 2020 12:36:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg / Thomas and all involved here. First, apologies for
necro-bumping this thread, but I'm working a backport of this patch to
kernel 4.15 (Ubuntu) and then I noticed we have it on stable, but only
in 4.19+.

Since the fixes tag presents an old commit (since ~3.19), I'm curious if
we have a special reason to not have it on long-term stables, like 4.9
or 4.14. It's a subtle portion of arch code, so I'm afraid I didn't see
something that prevents its backport for previous versions.

Thanks in advance,


Guilherme
