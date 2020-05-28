Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CD4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E045207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390945AbgE1OUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:20:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56096 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbgE1OUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:20:52 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jeJOs-0002Ip-07
        for linux-kernel@vger.kernel.org; Thu, 28 May 2020 14:20:50 +0000
Received: by mail-qt1-f198.google.com with SMTP id o11so118817qti.23
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:in-reply-to:from:subject:autocrypt
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=GL47WqaNh0Bxpyg70k1tnSp6HYgAjXbkmzgdit/0Vrk=;
        b=NNYL/gxXZSxWxjyn/QIZFPSn5BPGu0vKrmBVuwfujx4R0QfmsqJkv3spzJ7QlWQw0x
         qZErvNqw9wmyRB1z2cP2UxMfDUJfu8sPbuEBI0cE13GouT4W5Kn3xNKNWws2Vp+PLEpq
         kKSEndNGXkXYvffhfCUnNUOPHIso/ysWzxzmD2y/Newwu+jsl0mb5Sd1NOGY0dHDekZH
         kfWhVrpdtCF0bshCSPzL4Yyhv50V34W9aZnXAI/YuKFbpYmvBX5A/jVi1hLlm6CcKzVp
         UEq0XGBdlrgaYPaAnbT7ARbxvHdwYomg/TaSXoZiJxNYRxKf7CkMZ1GnYjYcoxdqL/4n
         2k+g==
X-Gm-Message-State: AOAM5307TlHkZY6oaqdVGCbxBHzYtfpaOIQ5TeXHD4HusgCp1Gaq/pPu
        cqHS42S5w64n2djyQb0iekOViSQ0rFai8HOo9011pVXRoq39/Ms0XNO41QXwl5sRKnlGeO0Qr3j
        W6LuzePsEBVNmIq9HdcUJlKeyhPP9LB/2ghQZunXv1Q==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr2838244qkf.131.1590675645854;
        Thu, 28 May 2020 07:20:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfLsLHRDVTzCMMlEhcaEuL7V6F7lbQ8otswg8xlmGEJtSPm6X/ZKu9EoeL9JWyyFLQl2fIyg==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr2838216qkf.131.1590675645576;
        Thu, 28 May 2020 07:20:45 -0700 (PDT)
Received: from [192.168.1.75] ([179.110.231.191])
        by smtp.gmail.com with ESMTPSA id n75sm846338qke.52.2020.05.28.07.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 07:20:44 -0700 (PDT)
To:     jan@schnhrr.de
Cc:     linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        pmenzel@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, gpiccoli@canonical.com
In-Reply-To: 
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH v2] x86/tsc: Allow quick PIT calibration despite
 interruptions
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
Message-ID: <9bfbe39b-fcf1-0e05-ae36-e13e7e63194d@canonical.com>
Date:   Thu, 28 May 2020 11:20:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan and all involved here, I'd like to know if there was any news on
this patch - seems users are still facing this issue on AMD systems.

Thanks in advance,


Guilherme
