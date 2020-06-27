Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0338BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C817B20720
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R5KmdIuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgF0BcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgF0BcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 21:32:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF248C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 18:32:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so5673354pjf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V3hQ1dIoXim7qqWVyvns0W1nvaRRCfg5SWPqmiy1pNg=;
        b=R5KmdIuWQAxN70P6AnqZ40G2cGZDLe3sIpq0E4dDXQuS2O0sBKzcLP2QTCFJCh5rVU
         +9jjCZ57t1sXYxt4Y5aTTsVHBJy7aT59FePHDLuvD/L2ha87TZM/SK6GIq5jvRMSg6zj
         4fRcGjtoK/fWuSX6MvjXQYgGSrDY9T7QzTPeEvVY50OCZ/clQ7lLgKalGywEFguzVTeG
         9Ir85TPJMQ12pk2zAojitg6Lt5YDMoM/EqSC6DVWEgkvi3jhFksacTf5sTYR+X0zOCHW
         AgaakQuej9mRjDjedutPkwzaV1OCZ+x+3M8u7+6L2LFx1XljMgZParSs72nxjdQQwubM
         RmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3hQ1dIoXim7qqWVyvns0W1nvaRRCfg5SWPqmiy1pNg=;
        b=Amh8XAxYGs6syfIcagEtFUKi1vOa82toPV1UyllxX8xoLGoc+C6XVEaNQq+riRrg5I
         TZQ/c2ji8YHiwQ1Ov1sI16WNtFpYnnXLoZv1Tj6r2H4oAxvhQtLgWoolHITcHGu0OEhm
         /P92l7ZaEyHeAjvQj6jqvSpGrdJmMpEy/EzS9I9h/a/LiDauVbyQPYq4zoinHh5ZuCUr
         na9PAyld6290l3PhTR1dHb0dp+8Kp8yYxIcJjBn0w51zgonc5UW0SYrqtrKpyM7Zj0QS
         rDLEVabGNka0rSpFMtRM0x3INNA38e2NL7aNaTNWWnkaKBsY8PTl7F0+zk3ehxi1JoCS
         Wkew==
X-Gm-Message-State: AOAM533e8waH9cL9FWR+TQzEJRa26/6eZpJY/k4eWVp5ftFb4vGUQkSP
        vdb3vwJ2hr6f9kJVCI3GcpnIOw==
X-Google-Smtp-Source: ABdhPJySWhVcMIceVzo5G+fdcYSH7HSi7zM9hkZ6+tZGhilA+68fPvwzthDYtbAHYTcHZk2LOjSDQQ==
X-Received: by 2002:a17:90b:23d5:: with SMTP id md21mr6504435pjb.0.1593221537999;
        Fri, 26 Jun 2020 18:32:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f6sm29203037pfe.174.2020.06.26.18.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 18:32:17 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20200627090740.683308fd@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6920f023-5909-6ebf-606c-dbf467a31c7c@kernel.dk>
Date:   Fri, 26 Jun 2020 19:32:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627090740.683308fd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 5:07 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   cd664b0e35cb ("io_uring: fix hanging iopoll in case of -EAGAIN")
> 
> Fixes tag
> 
>   Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.

Gah, that's b4 messing it up. I've actually seen this before, but
I caught it. If you look at the actual commit, this is what the b4
output ends up being for the fixes line:

[snip]
io_kiocb's result and iopoll_completed")

Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize

even though it's correct in the email. I'm guessing some issue having to
do with the longer line?

CC Konstantin.

-- 
Jens Axboe

