Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6531EC35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C36720838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z4t1eM0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBGUku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:40:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37633 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:40:50 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so973835ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3BM9iBf4tMcWhkoBVwztjm/p/O6pxExGy748ew7vpgY=;
        b=z4t1eM0SRWDjgRgoaNVTVOYujuVJX8MrHV0Im41TK4N7inBN+BwXjsVbHFkTQPPDU7
         Yg3bywHGF9WeySOK6m1ezpz0kKUAM9ngv/YnpOqJRELwOEWU7S7Lk1D+5HIfDx7/KhXu
         CbZHXejktq63SUMI+9aNldGmebWO7kGhGyVRuxd1ORc29d5cOsPtaDFCe1VYoXXyc9sx
         D4AKpFIzbaBXWfiZJa6Q42+wylaHtos5ukmIzFB28NvQV+2wqgvZEn98EWyRpzbha8ks
         vOukWAl++QOvFOuBXA0zh1PzO+r24yWQ8BM4RMufjHzdSq2aVhpE6wuHCGjSsJiL1uKV
         0+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BM9iBf4tMcWhkoBVwztjm/p/O6pxExGy748ew7vpgY=;
        b=UFtiLi8hn79LqBp+Jx1gBjP+BEsBBouh0nKzckNEIaev/z6rCO2Yyj2rhhMLL6Ru1S
         JsDKX8bwZEZsZ1GcWf5mT2rNqEEuV7TM1GpBWqnOBVhuOGUFSsTqdPLXMHNyaHdz9IYA
         3OmGqQaRY4vP50DsegURVzLm9ys7piq8L6bvCjVvBSm/kyjk5/OijJgNsBcGxc8Zq/nJ
         hnsD0G6hEMSV0/yxpelU9eVo6jB1R3pvu71L2ObQ2UVMximxvzN3QAy3Au5V2nQVu3aE
         9DbK3FOmasw8kRsNetigKRnbQtrdkr3klZCqVBxHU+S9+kQx3sTkxRrbwpQQBPxKPLF9
         rkFw==
X-Gm-Message-State: APjAAAWMS146kwKRAI5X98Cj3bbfiaxG1lXDGd/AGP7PtHFakSL7dMFN
        QbpFq/czTQuJvXq+DfaPsgj32yvmHD0=
X-Google-Smtp-Source: APXvYqzL03OKDTfogu7XZwKuY5hY1MbhonUl8I+mCoRD4r5tI7HjIZ8mQ73aXqfQxlyLg8XDIOll9Q==
X-Received: by 2002:a6b:fe0f:: with SMTP id x15mr261039ioh.219.1581108048552;
        Fri, 07 Feb 2020 12:40:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t2sm1671968ild.34.2020.02.07.12.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 12:40:48 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix iovec leaks
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <03aa734fcea29805635689cc2f1aa648f23b5cd3.1581102250.git.asml.silence@gmail.com>
 <bb0aeec6-9dc4-2b58-a93e-ee37c38a919c@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e28cfb-fad0-ea23-48e0-461c10acccc5@kernel.dk>
Date:   Fri, 7 Feb 2020 13:40:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bb0aeec6-9dc4-2b58-a93e-ee37c38a919c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 12:09 PM, Pavel Begunkov wrote:
> On 07/02/2020 22:04, Pavel Begunkov wrote:
>> Allocated iovec is freed only in io_{read,write,send,recv)(), and just
>> leaves it if an error occured. There are plenty of such cases:
>> - cancellation of non-head requests
>> - fail grabbing files in __io_queue_sqe()
>> - set REQ_F_NOWAIT and returning in __io_queue_sqe()
>> - etc.
>>
>> Add REQ_F_NEED_CLEANUP, which will force such requests with custom
>> allocated resourses go through cleanup handlers on put.
> 
> This is probably desirable in stable-5.5, so I tried to not change much.
> I'll hide common parts in following patches for-5.6/next.

I appreciate that, it's worth keeping in mind for stable bound patches
for sure. Thanks, applied.

-- 
Jens Axboe

