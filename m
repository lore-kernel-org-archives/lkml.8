Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85810C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B86220866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dzOwMbyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgCDDB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:01:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34713 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgCDDB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:01:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so353139plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8zFTVbTQU7V0OF6FX6oDnQG5+NUAJ3hxQM3Ad109F48=;
        b=dzOwMbyLpBiRKf7FAh5JcPXOWnscGPta89pkjmV5CLAxCAfe75icMIjGlPt3oe3uBo
         dCQEC00ZrOsSm650/HvuIeNjmoMWOgt5/18i/Uzj/VD7Ws0/kpty9/56BH5Ktimq5x3d
         3874cVy/52tN0A4U+zzKRExYn7P3PK736UrRrceBigW69RFUoYoSSb7z49glapnD9W5C
         22SJ97vPK38jZUwi+igKrZqT7CEgOrlW5sQK3DGfXvZu1hkRukm1m+SmdQFi5yp2gkwy
         MCapqZAqRAa7Qc9fjw/NAFgOHmm7J1Fu/DxOZA6dxwGvd1HQpOodxDGRoqzZj4FI4wUU
         yt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zFTVbTQU7V0OF6FX6oDnQG5+NUAJ3hxQM3Ad109F48=;
        b=BTBgv3zEvYW2zCjQnNXuPi662B3aH2keqdhc4UM5aN8FjgM734tqV2q3BgZujjbeA9
         qi8K03t0W+BRK7T+A8+zb05ieA9OXEvzFMz/BnR2eUkq8wyhH077wQVYbm38OCmm24DE
         cMUiwsdsYwujqX4Ti7Q8/b3cz5t+BD/qc3ji3ZmO/ypuJ2qOnghpBx6vsL6STkGsseWZ
         jWoUQhAVwpS+l7xasfwETiNcW073WrdhHuuLtX5B0FwfxH5xGkncoFz7u4pLXhVlU6/E
         1vu53yU7OXfRsihix3SmAUp1WEpF/pm8WNXMvyIDn+MHFSgo9yVG2LC39AudOtGRCR6x
         LrSw==
X-Gm-Message-State: ANhLgQ0+F3+EbQ6TmU0g/q2sw1kZakHN0LucqJSK81ecN/wSBrib7gma
        bF3NjJwvbNQgF3ztCW4u3mPdEw==
X-Google-Smtp-Source: ADFU+vvUs+OrIckddXX8LhPmztePsb0qpVAGmJjwtx41tZ+o+TVc09hMoD4phxhSzlDeWKRxfdhnDQ==
X-Received: by 2002:a17:90a:f8e:: with SMTP id 14mr711003pjz.159.1583290886902;
        Tue, 03 Mar 2020 19:01:26 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id mr7sm507482pjb.12.2020.03.03.19.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 19:01:26 -0800 (PST)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200304131750.55d84beb@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd8154ef-bb6f-aa7c-2553-582f0b497516@kernel.dk>
Date:   Tue, 3 Mar 2020 20:01:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304131750.55d84beb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 7:17 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> fs/io_uring.c: In function 'io_close':
> fs/io_uring.c:3415:3: warning: ignoring return value of 'refcount_inc_not_zero', declared with attribute warn_unused_result [-Wunused-result]
>  3415 |   refcount_inc_not_zero(&req->refs);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   62e0c6b73a2c ("io_uring: make submission ref putting consistent")

That should just be a refcount_inc() and also looks like it should happen
before the async queue. I'll fix it up.

-- 
Jens Axboe

