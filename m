Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292B12065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kBApw+NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEQUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgEQUYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:24:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEBCC05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:24:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so3321237plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z9zu84Fg5bCdyhLC2wYEH5B7knjB0T5bEY/b5LE6/Yw=;
        b=kBApw+NTnkRSkrRYNyaE6tX07KJrqGu7aeXGzT/9GaxCO9yTYvQMXHSEnOSQpivy8p
         m+UJ/jefgoxQ0LjZBLFhXwsGDwryWSDEcrDZ6hm0gIMHhfSDwttv8FYvzW0QzXJ4HkAG
         ahURqQEKMGeEDg215rIaRWznBfLB0BwP3+pH4k0Qz3F1QxuxKxinmIRP28n1d91lV7Co
         UcwYZRx5UHXKqqxujFs1t49pw4hU1+/waqbghVdsf2jkYpeWpt+PxLrv7aWgFcjiP/50
         jJ/bZHZ45v7NwS2nI/EH5M48xJJSJ5wxIeXi3TsXYlqSbD/JIk120iY7GPh43ru9UZ+x
         edaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z9zu84Fg5bCdyhLC2wYEH5B7knjB0T5bEY/b5LE6/Yw=;
        b=BglYPTyvtrnHut24WPIK9+VuwByAFTIBol9PnRnVs2iyLdd0dwAzg/gJ6w7/vQk60d
         hlweZyUies/+dVp641pFP0dTAWRgGwFQkMk0268I1rO/tKPO1MXBuc1e/A7BBeGuubyN
         kIA9g029WL1SQ+IeaB8ZO23PyXhtRld+yK++URIE7SgmPoFuvrmGLYdG7bLG4MAeKruv
         voh6oYmgBucmOmPiyvZTEY4//u8gIl2UVmJoXzu6oCEH4JaNushaX5dmhY1sgA9Dj6oS
         5G3Rl+WY7LOKo8M5LoEfNMCgkWsUYjo2KKYUQOdxB0YaYImqqazR61jzNReGWYyi2mgc
         GV7g==
X-Gm-Message-State: AOAM532rqCoVJGTcQbrhPSnCKt6onJMnH7u5OshrpeDncCmStRDKGCas
        eC+C7vNvtQBhuC64TNl9ucBnM/quBBA=
X-Google-Smtp-Source: ABdhPJzxaQq75XQbJG6K4Vr6kZdGTmhP448nVWVvaN7Xh3pFBtGw11uqgpJuGcQhhZ0VOw1W14F9GQ==
X-Received: by 2002:a17:90a:c393:: with SMTP id h19mr16348964pjt.125.1589747057443;
        Sun, 17 May 2020 13:24:17 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:91d6:39a4:5ac7:f84a? ([2605:e000:100e:8c61:91d6:39a4:5ac7:f84a])
        by smtp.gmail.com with ESMTPSA id x25sm2036627pge.23.2020.05.17.13.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 13:24:17 -0700 (PDT)
Subject: Re: [PATCH liburing 0/4] splice/tee testing
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1589714504.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb36a039-dcc1-0756-2b85-9f763599d9d2@kernel.dk>
Date:   Sun, 17 May 2020 14:24:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1589714504.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 5:23 AM, Pavel Begunkov wrote:
> Add tee and improve splice tests
> 
> Pavel Begunkov (4):
>   splice/test: improve splice tests
>   update io_uring.h with tee()
>   tee/test: add test for tee(2)
>   splice/tee/tests: test len=0 splice/tee
> 
>  src/include/liburing/io_uring.h |   1 +
>  test/splice.c                   | 538 ++++++++++++++++++++++++++------
>  2 files changed, 445 insertions(+), 94 deletions(-)

Applied, thanks.

-- 
Jens Axboe

