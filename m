Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FBF24814
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AchsNeAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgFVDGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgFVDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:06:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE2C061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:06:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so574462pfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5j5Fzg7GxTVWT9PLRapASOs1dnsZfkItW3BVr/LUrfs=;
        b=AchsNeAm+Q+D6vEvKdsWiuO1NbkuxYh+5H6mwL6nhtgdmVqN0erWQAc5BwR+SkQmu3
         jP8/ydqZe4Q5bvftnePx+6uKlomrRHnWcG5E+9rJyYw9EmWT0YdoyIjajSIure8Gxanj
         7WY0Ox7u8aIc443Or5uYVSV0YuheTRU0/SoqdRl6Zjf7vd7sD/UQs63XthrWWZY8ltrs
         hC9W6wtyAbmBhpHszC2H0pNKpOPPBv+JfsV6RXeoAkzx/mTX0TaLr9F0rScYvDtXRRsG
         ul3dIUKsDVJCQRQksL4PdTIyjONi1aL5TM7Fn+H7NEY+nZJz32fibj1diIERi5/dPWzf
         5xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5j5Fzg7GxTVWT9PLRapASOs1dnsZfkItW3BVr/LUrfs=;
        b=aovXRL/NAeBDdjz35oPhRQHX3MmwBZbp4oVkdUdcF+4QB3z917IwFNjrrE4jUtWzwE
         hCmyU+/t2lcRpE1mXsIEh4/4BBH0LhH2xTb9VRpTwBvQBA1mbkHtAW7k0ricCGj8Ka5O
         bxtiK/6tBhB/PjBciSlH/jMiz1tqqQpWb9Fuh58cTok05elOuRGk15FF4g2mUGz+Xnbe
         MW8eSSUsOqYXa/xltbLwt7q7T3++LcKJ4w4yoUpIflyhddl36h8a0e8ypdB79ChMt6BX
         0Gw5VjTfOMGI0ICyvWt/l5IvoWqzearabGCRBeIekMFu2INPilFp+GRN0G8+m9Vi1E3B
         kF0g==
X-Gm-Message-State: AOAM532WYP64l1JXAabssr1AqZdN0UlPTs6Hgw6EU4mKK57dOh1hTgnX
        LSNfXSJURLimPAy0CqnMgMAbPGD8o1M=
X-Google-Smtp-Source: ABdhPJx3XN7V3Q+CfNeUG7tETqBmj9eCBfnn5Ypn0AnPvVSgX6Ugs9fW0eooPcqBmkHE6Mo1oaF/ZA==
X-Received: by 2002:a62:7f58:: with SMTP id a85mr18844942pfd.89.1592795199005;
        Sun, 21 Jun 2020 20:06:39 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i20sm12575565pfd.81.2020.06.21.20.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 20:06:38 -0700 (PDT)
Subject: Re: [PATCH 0/4] small random patches
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1592733956.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <722368b0-11b3-90fa-8c27-8555ff5b3696@kernel.dk>
Date:   Sun, 21 Jun 2020 21:06:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1592733956.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/20 4:09 AM, Pavel Begunkov wrote:
> Nothing interesting, just killing some stuff first.
> Based on top of io_uring-5.8 + 15 async-buf patches.
> 
> Pavel Begunkov (4):
>   io_uring: remove setting REQ_F_MUST_PUNT in rw
>   io_uring: remove REQ_F_MUST_PUNT
>   io_uring: set @poll->file after @poll init
>   io_uring: kill NULL checks for submit state
> 
>  fs/io_uring.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)

Thanks, applied.

-- 
Jens Axboe

