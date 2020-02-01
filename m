Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A5FC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF50206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wAo0xbc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBAQ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:26:18 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:46337 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgBAQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:26:18 -0500
Received: by mail-pf1-f175.google.com with SMTP id k29so5079913pfp.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w0PjGS/klgnrRtPNKFCF6fGGDejuNhQNgoqlU58Tch0=;
        b=wAo0xbc12Nh4hBoZVjwv+emR9n/jSarM4NO7bzpPeAFDhzcuD4s73If4amekxIh8IB
         DO/EFDkqEuHsWJN9yzrZpuPKz2HeXhADf6All8yxhV4FzVl9Tgy/nTMLFVxdvyRLN9mg
         JiTXclzNVzUv+krA2I4fpeESlvxWHuCLciHRT1cfQWVLkTAgwRnhf/4wMq4uHyl2FTMx
         xrhU+sVzKtvYvSFEbOuVhyOkFYDD6RCYqy4n0QTFkZEsI2CqDEi8GU1PtXbVzikUyFr7
         /IKfrTo+wVuZ4waRqyxchYbj0VoRgaFInimhuH6XyYGNgFDdvOPxlqx30Q7gZsGGvpSt
         W77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w0PjGS/klgnrRtPNKFCF6fGGDejuNhQNgoqlU58Tch0=;
        b=EFEXam1VEqnTvB96A34tmoKA2I4im8VnuTUCpd6FkKZOG7reneFYVY1dwWoHNAQ4Yk
         oT/Ad0Z/0uxMnwtQLrq8qrqJDotVjddu3k3vK/5oYydSfcoUX8zoGbDmeFfGyUxOtG+0
         xujjmoHuNkUAU/ofh7IIUZabbG8D6o07mBDQzysAes5NlauEgxwcsGQub6UUCkNRVKTC
         0hjAhxItnzYnS4qQ2vRJrO0bMacgaVFKfMwvTii98gNWFPYOFLrMQqjTHF6ogoxPW9ze
         nAt/J0M9rRZDNKqMTls8tbCZTEmjwdC5EUXxvCWJqdVbb/vqB/ECX7MzXOprcuucxLRD
         itfQ==
X-Gm-Message-State: APjAAAX+tmVOMrVp1gX1a6vVyiJXAyehsiCZFZ3A5f3lDKP0LwX7RBlV
        YBVcqKVEeAwoDPyc3MM7eKmWr0ZtDa4=
X-Google-Smtp-Source: APXvYqwhuUQ1S8cgtvCF/gHqRGnjcizBH7lNM6PwbO1VijPq03ib1uGGVdk3Y3njtLPXenUjzjBlng==
X-Received: by 2002:a62:1889:: with SMTP id 131mr16240997pfy.250.1580574376482;
        Sat, 01 Feb 2020 08:26:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c14sm14642299pfn.8.2020.02.01.08.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 08:26:16 -0800 (PST)
Subject: Re: [PATCH] io_uring: iterate req cache backwards
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <df6e93383161cd3bdbe19fe816b761af0096c303.1580518665.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d46cbbd6-65c4-93f9-b3f4-566ec8f10272@kernel.dk>
Date:   Sat, 1 Feb 2020 09:26:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <df6e93383161cd3bdbe19fe816b761af0096c303.1580518665.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 5:58 PM, Pavel Begunkov wrote:
> Grab requests from cache-array from the end, so can get by only
> free_reqs.

Applied, thanks.

-- 
Jens Axboe

