Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7239CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541DD20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e2eC0J1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFCSvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFCSvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:51:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015ABC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 11:51:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so2363336pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lug0F2GI7N+Lwma/DkLLVhc9YRd7COIaK5RGBnIGGss=;
        b=e2eC0J1qk/RuWqVSXrDyFswyhBA0JYYwHNWTDVD3alpc/xLN22a6wbZ+DHfjDARTZi
         q5R4ZCVX6des6WR+8yltzCUjQXR+MDlFhqUxp505fAObtZlyz68MmCDyWl69/voGUMX2
         hod4Hno2nDD+Urhr7kJ0oLkivfyP9opYJIVXPcJO2NkZxVEV9YwwLw+RYZp2eOaLCRz2
         C2DB091ypB5Z8Ha6qb+kAl0Ktha+WlM/jMEvQQSU3tCc/0UML+2rqtG0Zkxhd33rDaQr
         lGSbCYSBAY9PXOoh4As9KtEEJrcro4H/tDu/6xu22QFUm/wi//aNU81xAf46q/xQBWMn
         jMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lug0F2GI7N+Lwma/DkLLVhc9YRd7COIaK5RGBnIGGss=;
        b=IaHd30WgJBMLfMz1QG5MW+Y4DtOlGmbyujJQxWzbpDGqUmMi+8SGO+Hw5cRIYqZATE
         MAInrN+kn14u5uhjruxisvGN+90IyiNHNxPhurnFTudXSpkX0mvi9hKFyPG2DSCYoVJL
         I5gRrF7vUTu+mZmnGjFXB0iPxKBQjuFLhOBg3rkN4IclYYcSuiC41th66yp72g86y1eQ
         qGItXjOmoeiuQMI7TjYuCrSK8fE2Ca8ieV57Jz7BKUevozKrfu1p7t/T4zDja6rYMh73
         xxBieLLmBVqu+CYrvDwdNsAdoo+YMHnYTnCPYxZ9LIcpJZlw32oilGYywbU1mvymcwrx
         1d5A==
X-Gm-Message-State: AOAM533XtZE0IG4lsLmR3c3YOzWjzA7U60Iw+pwIN8VIhZDIzuVry66j
        R+1fl/T209FUV3AzTIwBpxTtO32LyEnGjQ==
X-Google-Smtp-Source: ABdhPJxi0rxCADH7UzuKT+qM7/8gcj5zFQFyPDJhgEjtUE0Y/7sHxP/pA7n1dlfQ9Qp0Q15JdpXlMg==
X-Received: by 2002:a17:90b:3105:: with SMTP id gc5mr1478512pjb.36.1591210296061;
        Wed, 03 Jun 2020 11:51:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k11sm2049854pgq.10.2020.06.03.11.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 11:51:35 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] forbid fix {SQ,IO}POLL
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1591196426.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <414b9a24-2e70-3637-0b98-10adf3636c37@kernel.dk>
Date:   Wed, 3 Jun 2020 12:51:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1591196426.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 9:03 AM, Pavel Begunkov wrote:
> The first one adds checks {SQPOLL,IOPOLL}. IOPOLL check can be
> moved in the common path later, or rethinked entirely, e.g.
> not io_iopoll_req_issued()'ed for unsupported opcodes.
> 
> 3 others are just cleanups on top.
> 
> 
> v2: add IOPOLL to the whole bunch of opcodes in [1/4].
>     dirty and effective.
> v3: sent wrong set in v2, re-sending right one 
> 
> Pavel Begunkov (4):
>   io_uring: fix {SQ,IO}POLL with unsupported opcodes
>   io_uring: do build_open_how() only once
>   io_uring: deduplicate io_openat{,2}_prep()
>   io_uring: move send/recv IOPOLL check into prep
> 
>  fs/io_uring.c | 94 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 46 deletions(-)

Thanks, applied.

-- 
Jens Axboe

