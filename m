Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED02C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544222075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="hO81LZGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgD1HGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1HGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:06:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11280C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:06:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so1450322wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5xMxzq1+6fPKftxXFu1ru4KGONd/NB7Kh51Ynpspd1U=;
        b=hO81LZGWWo8vQjLiiioyCkIRbDV6DOkETpCDAwqQdX+A5qxIQgwr1HYewNk54bxA7U
         VUidLvM9h71FNcWZnNJYZ3yOumKakvofrrqMoUqQuNJ7S80BnFrt1MtCsxiIHLBGb4cO
         /TddRb91i9lTxuviX7DN+kD+9PvS58iLrlpFqIYwBT7Q93N0FCiNKQFEmUhyq2+dHicN
         ZNjbd84dQDNMQQUw9JGt9oqx+VP7v1BvscRU593V9qpLgb9ryM4WUBikbEQEXkJ4GqT4
         qC6/5rkcMwZBBZ0ve117vQ1OEL6fiBT3fkqtDQQFh32D6t2ccFohocb83Vh/DdeY6Wzv
         eqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5xMxzq1+6fPKftxXFu1ru4KGONd/NB7Kh51Ynpspd1U=;
        b=b+xqvFjVpH8PEfI5K7AMaugVZLbbtealMAzvzX4XwdOGk2M6FW6w7YnoJgzNoj+hm3
         8sMU8RspavjwFfqrsXKqg6MI9sa06Es8Ajvh/9zkHs/MbWFTll/t2ziUJH+QSEC9CzUP
         VWwFlSJo3dNa1CbR2lfK2tUq8TO0Q9iYv47br/QeNHaa1Q+LBzmcecPR2gQcZWk8hzAr
         jPy+yL3KIMaR3t+Rdqr8jTESffWIN7WW+o8FX8VNLrLRUdiW/zAvF6lFKayh1oBGJekI
         +KMMlVdny2rYLqyUFT26iI02Nm5WJLSk49AXFnLLGap5xjFE82XmN36ABAA+MvMAiSKA
         Dj6g==
X-Gm-Message-State: AGi0PubrrUj95vjqipXcnV4M4mxXwWpl+B+prlqtLHS2fPTm9u1u6EAI
        iws9M8hVu928doAJO3uqig+/Rw==
X-Google-Smtp-Source: APiQypLJlkHPjon8EswejZeDOa29Qh08hz2eo34BgU9hmyxGa6xTEGyLyDc2U6KDsMGt3wkaBlFeFw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr2697226wmg.147.1588057612762;
        Tue, 28 Apr 2020 00:06:52 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
        by smtp.gmail.com with ESMTPSA id l9sm23897081wrq.83.2020.04.28.00.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:06:52 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:06:51 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200428070651.qbsyivvaakflipr4@mpHalley.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
 <20200427182245.GA547726@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427182245.GA547726@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2020 18:22, Niklas Cassel wrote:
>On Mon, Apr 27, 2020 at 08:03:11PM +0200, Javier González wrote:
>> On 27.04.2020 14:34, Niklas Cassel wrote:
>> > When jumping to the out_put_disk label, we will call put_disk(), which will
>> > trigger a call to disk_release(), which calls blk_put_queue().
>> >
>> > Later in the cleanup code, we do blk_cleanup_queue(), which will also call
>> > blk_put_queue().
>> >
>> > Putting the queue twice is incorrect, and will generate a KASAN splat.
>> >
>> > Set the disk->queue pointer to NULL, before calling put_disk(), so that the
>> > first call to blk_put_queue() will not free the queue.
>> >
>> > The second call to blk_put_queue() uses another pointer to the same queue,
>> > so this call will still free the queue.
>> >
>> > Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
>> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> > ---
>> > drivers/nvme/host/core.c | 2 ++
>> > 1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> > index 91c1bd659947..f2adea96b04c 100644
>> > --- a/drivers/nvme/host/core.c
>> > +++ b/drivers/nvme/host/core.c
>> > @@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> >
>> >       return;
>> >  out_put_disk:
>> > +      /* prevent double queue cleanup */
>> > +      ns->disk->queue = NULL;
>> >       put_disk(ns->disk);
>> >  out_unlink_ns:
>> >       mutex_lock(&ctrl->subsys->lock);
>> > --
>> > 2.25.3
>> >
>> What about delaying the assignment of ns->disk?
>>
>> diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
>> index a4d8c90ee7cc..6da4a9ced945 100644
>> --- i/drivers/nvme/host/core.c
>> +++ w/drivers/nvme/host/core.c
>> @@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>         disk->queue = ns->queue;
>>         disk->flags = flags;
>>         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
>> -       ns->disk = disk;
>>
>>         __nvme_revalidate_disk(disk, id);
>>
>> @@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>                 }
>>         }
>>
>> +       ns->disk = disk;
>> +
>
>Hello Javier!
>
>
>The only case where we jump to the out_put_disk label, is if the
>nvme_nvm_register() call failed.
>
>In that case, we want to undo the alloc_disk_node() operation, i.e.,
>decrease the refcount.
>
>If we don't set "ns->disk = disk;" before the call to nvme_nvm_register(),
>then, if register fails, and we jump to the put_disk(ns->disk) label,
>ns->disk will be NULL, so the recount will not be decreased, so I assume
>that this memory would then be a memory leak.
>
>
>I think that the problem is that the block functions are a bit messy.
>Most drivers seem to do blk_cleanup_queue() first and then do put_disk(),
>but some drivers do it in the opposite way, so I think that we might have
>some more use-after-free bugs in some of these drivers that do it in the
>opposite way.
>

Hi Niklas,

Yes, the out_put_disk label was introduced at the same time as the
LightNVM entry point. We can do a better job at separating the cleanup
functions, but as far as I can see ns->disk is not used in the LightNVM
initialization, so delaying the initialization should be ok. Part of
this should be also changing the out_put_disk to put_disk(disk).

Note that initializing other namespace types here do not require
ns->disk either, so delaying initialization should be ok. We have been
running with this patch locally for some time.

This said, this is an alternative as your fix works.

Javier

