Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F92253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xg6QbYvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVB4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:56:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40828 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAVB4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:56:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so2574215pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ughD8EkfzZ2MT9taNPpfqufT1vIfrbzj2d5lhoDdcCs=;
        b=xg6QbYvQI8Lcp3eyVvMHPQjo5nOSDbFcfnYJPf7c4tc4M68KNnggamZ05z0iPvQ6Tz
         oZRfs8nHGynhSz/3eOxGfNmxZM1kwjPwZwvQV2BGqUP3i/OZo/PI2BQHgL+MMAalMie6
         LjiGfByiRHSh1xSWJ8xeXBZTYdXmFzIPpSFaFRnEHrbpE52buXvhuTzBMFxHfcmem7Cz
         n8GPqQGJ4O0dZ/1r7DALHyfTy+h/WEa1BsmK3bmIXkdE9kzNXBVnsy+eeEhjeh0PoAuh
         g8gm++dFXs9PEqIsVEDP+LLsRPzklv/oDqNoLtix0WwNnlEp+ulMD8/33Mib1fc/qlJ/
         NMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ughD8EkfzZ2MT9taNPpfqufT1vIfrbzj2d5lhoDdcCs=;
        b=WIVEir8ha/DNWzuTnd3bgrHruy8elBfJwHAjg/z+GKjg/ucEQKVahZQKWaGbJuC8p3
         JaOZ29nbzFWzEjqIj9fTDOg04JS4qE8gxogqncwi7xec5aiE437W7U96FIRDQI4HJCj9
         g/9YXiNpd+Hc0vwubc3W1d4weld4KmbCM0cp1GYGg/ocpkekSNfksSG5+caHdINmDUHM
         Bt/biP48j6F2fzXheRiuvv3wJJfNnVfdSkaMghfJ4l7TZnuAIoCenNHenTAsUrzCapdL
         YkU/kzTsnoq3FCpcw8iI3GbiYrNJkaZa2J12PGQStJ8HQ00pUZjqAaSgidAl9C5yqBnb
         jTfg==
X-Gm-Message-State: APjAAAUy4CIVglAzW8IHdT0K1rIflbH8LGopDzKf6hUno/DyYI2nCV34
        Hmj/0D6rCwDCY8Td7QqXZi4pBQ==
X-Google-Smtp-Source: APXvYqwa8UKyJwV77XoBvUAWxuZJ8PJJ53EHBLJTOfOLb2DJYwRJN7ZRS5CUg7lkEkhIx6E7ZnhWHg==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr8564576plq.325.1579658161685;
        Tue, 21 Jan 2020 17:56:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 3sm678609pjg.27.2020.01.21.17.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 17:56:01 -0800 (PST)
Subject: Re: [POC RFC 0/3] splice(2) support for io_uring
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1579649589.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63119dd6-7668-a7bc-ea24-1db4909762bb@kernel.dk>
Date:   Tue, 21 Jan 2020 18:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1579649589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 5:05 PM, Pavel Begunkov wrote:
> It works well for basic cases, but there is still work to be done. E.g.
> it misses @hash_reg_file checks for the second (output) file. Anyway,
> there are some questions I want to discuss:
> 
> - why sqe->len is __u32? Splice uses size_t, and I think it's better
> to have something wider (e.g. u64) for fututre use. That's the story
> behind added sqe->splice_len.

IO operations in Linux generally are INT_MAX, so the u32 is plenty big.
That's why I chose it. For this specifically, if you look at splice:

	if (unlikely(len > MAX_RW_COUNT))
		len = MAX_RW_COUNT;

so anything larger is truncated anyway.

> - it requires 2 fds, and it's painful. Currently file managing is done
> by common path (e.g. io_req_set_file(), __io_req_aux_free()). I'm
> thinking to make each opcode function handle file grabbing/putting
> themself with some helpers, as it's done in the patch for splice's
> out-file.
>     1. Opcode handler knows, whether it have/needs a file, and thus
>        doesn't need extra checks done in common path.
>     2. It will be more consistent with splice.
> Objections? Ideas?

Sounds reasonable to me, but always easier to judge in patch form :-)

> - do we need offset pointers with fallback to file->f_pos? Or is it
> enough to have offset value. Jens, I remember you added the first
> option somewhere, could you tell the reasoning?

I recently added support for -1/cur position, which splice also uses. So
you should be fine with that.

-- 
Jens Axboe

