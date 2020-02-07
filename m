Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14048C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D3020720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1puzGfr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:25:20 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35144 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:25:19 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so39994ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D0i0v0Cz1w3Ih0IH4JNeGVFe/a2Q5iggZsx6TJ9mToY=;
        b=1puzGfr9auD7dz8vqFdog9zyFWiG/w03wmti5jFrzbn5deIO9B+5RtKhvJ1BtVSkA4
         Omm2qTErgNB3NrxizQzDNCjrt+qbxOGAAdoSZXbDjSZ0QgIUtfKM+oWmuCQsyWoE/+2T
         MiX+Ye2enSXvnDLbXnGcl3OzH+sKm1umdiPOaoEyz5rxMkn3DxR/NILq13X+ALJ/88G3
         oEPs7bqq4J11DUU+DUsixPNUbT/ZYliCth/N5lFjz96JKQc4kM0Booo5UJQmsqiZUOKS
         Bh0Hn88jw4i/no1aT1OHq4WOvUkepjioJO04mqn11jRRsZIBZDxpQ5CdWcGrxwBBhG12
         oErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D0i0v0Cz1w3Ih0IH4JNeGVFe/a2Q5iggZsx6TJ9mToY=;
        b=LpVM/AeXhZHX0XW+JicoWdQT9u8DS2vhJ7b/ylT4uGxwxkYleTwt57X0GzqV0kJyUl
         Iiup7Ep9/HlyDAQ1Lrvuq16u2+EJ6QqQMoNQ1J1TSDLzgjEogafPKfugN9Fgg301ACwF
         mH6kswKbUkXppsdqgUjA5KJZh/pJ56hXpe4kYFmKAOOtjuKlabn+IXsEX3a/Rt3QCsjp
         M0GYlhddOZSNR4lmgAA5PwaM9GFjBPhArnxjsdwRiph+ik2eJJapvBFmMpsZ4F+NOsaz
         hr2fiySa1CUN6vHpWJCdfV3J+6tXBz4i9XNNh3QFpQJfpFVkEdR8bhp9ATcEZCc/DwFf
         gpjA==
X-Gm-Message-State: APjAAAVM64T9DdXsz0RgK3W6DMFJ3Io1fSqwqESr/wNHyfC9hBj6ltEx
        NHlO2IOOc/uxMCHUI6lMZbZXnQvc7+c=
X-Google-Smtp-Source: APXvYqzS0iPhHfnmffotPOpJOKrniWWF85K0/m3gxuzflJHnAwqdqS8isV5VH0mIWJEG12YTs6O+Kg==
X-Received: by 2002:a92:8311:: with SMTP id f17mr202900ild.82.1581092718939;
        Fri, 07 Feb 2020 08:25:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z15sm1433711ill.20.2020.02.07.08.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:25:18 -0800 (PST)
Subject: Re: [PATCH] io_uring: remove unused struct io_async_open
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a14a8fc0c22be0dbbd9767f424e876704d9e9c8d.1581092449.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f4bbc97-0cb9-1f45-db7e-0bf28b64f01a@kernel.dk>
Date:   Fri, 7 Feb 2020 09:25:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a14a8fc0c22be0dbbd9767f424e876704d9e9c8d.1581092449.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 9:21 AM, Pavel Begunkov wrote:
> struct io_async_open is unused, remove it.

Oops - thanks, applied.

-- 
Jens Axboe

