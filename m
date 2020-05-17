Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3654C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D23652065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LHuXzNp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEQUYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgEQUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:24:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF33C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:24:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r22so3774115pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xJfh8wtg8VU/LekHNRZntBM6NKqzlnqBAF+Ti06Hbl8=;
        b=LHuXzNp/fpMFbgA1ik1F5h/HtiAQS+OCjQwzHb+xa23pCFiRLx0TtdFIvyQA+AxIpx
         /jsMCSMx7iqg3gNWtdSOGVkLjqlR11osqcF3N5Yc22um85SnUJEF6zKPm4KwX/BRBx38
         iCcZttssvcV95O7sUiVclgdNH0La0eYeMDALNTKiV9oucO13Xnu/mEN6iqoaBzqMQ42a
         ew1rI4eitHe6rkxY2oEkBuVPYMY+Z2oVWQxqdFvu6PXz1a7JPXkv34eNyzSY0jMDtYh+
         hWOXhIHJnlJLDbxFpqm7ZRc2u959myE8pTZ4EeUVGgiYaD+nSkgqxh9sj+e2G2iBydWm
         5L0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xJfh8wtg8VU/LekHNRZntBM6NKqzlnqBAF+Ti06Hbl8=;
        b=r275Rt8diUrItoonqNWM6Q/mbbfk6hmu8ZJL5s+QW2UXjl0zh84JCo7MjsnyV+pSUF
         vKioqlUAWZfbTonVC+GrardPaTY3T8uMCuWSSc52g1aDxAd+Gd8ZC+53LPIHN+pDaCxW
         nfNQMOLr5vWDbuTqmd0SSnzOzl6z4SubsVcvQt6dBvBbkJTqLYPh64tqwczu8BUPD6YS
         kdb02kmwqnDL/M/J2g63608jHNGNm7g0pOmaKgqVsW18sDSMG7WL8m7x3xUrU3YG9GA7
         krO512VGwXMwEgKKPUYIkGpQKUdFYbVsyKZlOIs0378aVDPbyQi4WuYn0hA4cCSDfLwn
         Bk5g==
X-Gm-Message-State: AOAM531vegDNtSMPeoyf7sw1zZUuux7Mjxt04+xgeNKlT/8EFTb7Dd3N
        IEfgb0EZ/VfhqodJ1/b2FK1W5L0HvvA=
X-Google-Smtp-Source: ABdhPJyc4FAch87vJQNftuA12J+lH1MbWT2+1bsDsoqBKLpyyh2WxakZfnbH2eT/zMgw1sDzw0xCww==
X-Received: by 2002:a62:3241:: with SMTP id y62mr13442754pfy.194.1589747046981;
        Sun, 17 May 2020 13:24:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:91d6:39a4:5ac7:f84a? ([2605:e000:100e:8c61:91d6:39a4:5ac7:f84a])
        by smtp.gmail.com with ESMTPSA id b140sm6566871pfb.119.2020.05.17.13.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 13:24:06 -0700 (PDT)
Subject: Re: [PATCH for-next 0/3] unrelated cleanups for next
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1589713554.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cbfe320-bb8a-3e82-09bf-e08c0cd853a7@kernel.dk>
Date:   Sun, 17 May 2020 14:24:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1589713554.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 5:13 AM, Pavel Begunkov wrote:
> Independent cleanups, that's it.
> 
> Pavel Begunkov (3):
>   io_uring: remove req->needs_fixed_files
>   io_uring: rename io_file_put()
>   io_uring: don't repeat valid flag list
> 
>  fs/io_uring.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
Jens Axboe

