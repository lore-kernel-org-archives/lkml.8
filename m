Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54681C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05820769
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgDFM3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:29:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59948 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgDFM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:29:53 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jLQsx-00060m-Jd
        for linux-kernel@vger.kernel.org; Mon, 06 Apr 2020 12:29:51 +0000
Received: by mail-qk1-f197.google.com with SMTP id w124so14096807qkd.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OF5+/9Hx0SVxloqW+AsVqfRADYJTfKE7xEAXHE0ATtQ=;
        b=XfJdIWL/AodHp08a9JGr1rgZG4Z3LpUoZGRjTiA1pU2YPHt8+va2HIkaQwC6sIjcWc
         x4400mhm/6+Y1o0L8EpJV1mk3whGa0IUQJ7aaUCfCEKxa1fk/r3Rg7B+pmE0sAcZBU+u
         aOTcMWlb6sD2SWQhR9ce+nyx2qjY7zlxKGgcs7a2M3IEVZeh4jgMujb+f1LJVwsXZgoq
         kZ6NaTgbxPonLuFerQBh2kTLqxcDsmDZSgmdiD0fSjImvyVkU1M1AI94Vy87E0LQH+pr
         FOBMBC/2DfbTI1Aownus2bR5XXjl9DtTgM2hDmlfxlYjYNwMrK6YfTABd7ATyyllJstV
         w94A==
X-Gm-Message-State: AGi0PubHY1iZY758/QmhAy0Z9v3oZ6XgzxKL8XuCcvETfYAIWs3lV0Nt
        +qtL9N0lckqaoVCa0awSDUNWKEf7NQgxO71rkYraWhOC6dEqFQRE4qibl53+LdNAoKPYcbe1igh
        7WMTxivgEEDQ9surDQPNoRWgAD2TrgGGfPr/Eztno2Q==
X-Received: by 2002:a05:6214:b8e:: with SMTP id fe14mr20926377qvb.44.1586176190788;
        Mon, 06 Apr 2020 05:29:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIFzhFbMp0Mc44zEb42FJlJTJPveQx3ILgrcP5rWAHivUCkkwOrdkiZvWqvKm7FEtjLJMVxzA==
X-Received: by 2002:a05:6214:b8e:: with SMTP id fe14mr20926359qvb.44.1586176190595;
        Mon, 06 Apr 2020 05:29:50 -0700 (PDT)
Received: from [192.168.1.75] (201-27-34-233.dsl.telesp.net.br. [201.27.34.233])
        by smtp.gmail.com with ESMTPSA id q15sm15131081qtj.83.2020.04.06.05.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:29:49 -0700 (PDT)
Subject: Re: [PATCH V3] panic: Add sysctl to dump all CPUs backtraces on oops
 event
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, vbabka@suse.cz, rdunlap@infradead.org,
        willy@infradead.org, kernel@gpiccoli.net
References: <20200327224116.21030-1-gpiccoli@canonical.com>
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
Message-ID: <2eda78ca-6a0e-7a70-d800-13fbe0038ebb@canonical.com>
Date:   Mon, 6 Apr 2020 09:29:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200327224116.21030-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew / Kees, sorry for the ping.
Is there anything else missing in this patch? What are the necessary
steps to get it merged?

Thanks in advance,


Guilherme
