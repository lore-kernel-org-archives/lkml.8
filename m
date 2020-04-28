Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11529C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8286206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ST57LC3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgD1Kcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgD1Kcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:32:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B68DC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:32:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so24031790wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AXbiHKswDMgt8rbtX7mZPHUHWcmhaf3PNptTH7f7SYs=;
        b=ST57LC3kF7eIqJdj03lQTNsNn5Ok+/tjEP9i+P/j7W9mhC7e4ig2ci/TvRNkrdH/gv
         tPSFyDRYzMfiQLrQcppDnYsKYajS6Xrr741febcQjxcbLgtZ/78c2LblD9cQN8Sgry8e
         n6/wRPIuYArrvUgoEaaTceqcGXRujm9C/fTCLcU96VADhG0Tmk0MlqM4zDpZpqLGAwkE
         ZcJKtA3xTY9SC/K6IGJWpjPp918Pi4wzXhpjpKxEHp20KtqOwK/FRCvXmgDcAbyk82Ng
         sow52dVMlkzZiUIHGCdu6AB1gpEbhWPw8l8vUAsOoxtUpgbJNdYcrg07XBEQGcF+/wmi
         HEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AXbiHKswDMgt8rbtX7mZPHUHWcmhaf3PNptTH7f7SYs=;
        b=L7qGfdJrupgtoTxEfbUqZinzZVpiMVEe7l6MDr/Wp5ItXiYQqM0NEMYGRm9M2X7iUA
         Xp8a6dcxvnOj4DCdhyJZPf12GttvRfIeP4WJN5HlO6SKCINosRtcwLskvoc2xDZG7J1H
         gaVe5X9xnEUSKmxB2wybNGul23E4uXGnX9EaINZmIyWoDlzER628HcIDYLPpQIZjCdZd
         ffmuWOn+74IRWjHcf+SBhfR2O2ylqjt2IXdG7xQiXuHORFqGU0HuFqTtQ6ruCeY/mgIz
         xYdHqjVQBjKlkwSsRxweiuXEqUj2KvqeZX7xpupXEHSsQT7Wi8kTjn6bjruO3g/+0ZSZ
         jwHw==
X-Gm-Message-State: AGi0PuZU2ErY5JecvBOs+MTr63ECRgjLcfgWen/o7TkW8tBNoJzZ0sdt
        6k+FOFM7ND5+2VXbv+OuDbbgYQ==
X-Google-Smtp-Source: APiQypK6ZDksNp73FYMuOOqRaJtjM5HLTyKxvbHE/CUIs+juS4qvPRGTGQA9zTzOYsc/IiHC7i9y7A==
X-Received: by 2002:adf:f990:: with SMTP id f16mr30076642wrr.33.1588069970704;
        Tue, 28 Apr 2020 03:32:50 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
        by smtp.gmail.com with ESMTPSA id l5sm24606831wrm.66.2020.04.28.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:32:50 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:32:49 +0200
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
Message-ID: <20200428103249.nrs2lhi2f5oakyrh@mpHalley.local>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
 <20200427182245.GA547726@localhost.localdomain>
 <20200428070651.qbsyivvaakflipr4@mpHalley.localdomain>
 <20200428074935.GA584449@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428074935.GA584449@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.2020 07:49, Niklas Cassel wrote:
>On Tue, Apr 28, 2020 at 09:06:51AM +0200, Javier González wrote:
>> CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.
>>
>>
>> On 27.04.2020 18:22, Niklas Cassel wrote:
>> > On Mon, Apr 27, 2020 at 08:03:11PM +0200, Javier González wrote:
>> > > On 27.04.2020 14:34, Niklas Cassel wrote:
>> > > > When jumping to the out_put_disk label, we will call put_disk(), which will
>> > > > trigger a call to disk_release(), which calls blk_put_queue().
>> > > >
>> > > > Later in the cleanup code, we do blk_cleanup_queue(), which will also call
>> > > > blk_put_queue().
>> > > >
>> > > > Putting the queue twice is incorrect, and will generate a KASAN splat.
>> > > >
>> > > > Set the disk->queue pointer to NULL, before calling put_disk(), so that the
>> > > > first call to blk_put_queue() will not free the queue.
>> > > >
>> > > > The second call to blk_put_queue() uses another pointer to the same queue,
>> > > > so this call will still free the queue.
>> > > >
>> > > > Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
>> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> > > > ---
>> > > > drivers/nvme/host/core.c | 2 ++
>> > > > 1 file changed, 2 insertions(+)
>> > > >
>> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> > > > index 91c1bd659947..f2adea96b04c 100644
>> > > > --- a/drivers/nvme/host/core.c
>> > > > +++ b/drivers/nvme/host/core.c
>> > > > @@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> > > >
>> > > >       return;
>> > > >  out_put_disk:
>> > > > +      /* prevent double queue cleanup */
>> > > > +      ns->disk->queue = NULL;
>> > > >       put_disk(ns->disk);
>> > > >  out_unlink_ns:
>> > > >       mutex_lock(&ctrl->subsys->lock);
>> > > > --
>> > > > 2.25.3
>> > > >
>> > > What about delaying the assignment of ns->disk?
>> > >
>> > > diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
>> > > index a4d8c90ee7cc..6da4a9ced945 100644
>> > > --- i/drivers/nvme/host/core.c
>> > > +++ w/drivers/nvme/host/core.c
>> > > @@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> > >         disk->queue = ns->queue;
>> > >         disk->flags = flags;
>> > >         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
>> > > -       ns->disk = disk;
>> > >
>> > >         __nvme_revalidate_disk(disk, id);
>> > >
>> > > @@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> > >                 }
>> > >         }
>> > >
>> > > +       ns->disk = disk;
>> > > +
>> >
>> > Hello Javier!
>> >
>> >
>> > The only case where we jump to the out_put_disk label, is if the
>> > nvme_nvm_register() call failed.
>> >
>> > In that case, we want to undo the alloc_disk_node() operation, i.e.,
>> > decrease the refcount.
>> >
>> > If we don't set "ns->disk = disk;" before the call to nvme_nvm_register(),
>> > then, if register fails, and we jump to the put_disk(ns->disk) label,
>> > ns->disk will be NULL, so the recount will not be decreased, so I assume
>> > that this memory would then be a memory leak.
>> >
>> >
>> > I think that the problem is that the block functions are a bit messy.
>> > Most drivers seem to do blk_cleanup_queue() first and then do put_disk(),
>> > but some drivers do it in the opposite way, so I think that we might have
>> > some more use-after-free bugs in some of these drivers that do it in the
>> > opposite way.
>> >
>>
>> Hi Niklas,
>>
>> Yes, the out_put_disk label was introduced at the same time as the
>> LightNVM entry point. We can do a better job at separating the cleanup
>> functions, but as far as I can see ns->disk is not used in the LightNVM
>> initialization, so delaying the initialization should be ok. Part of
>> this should be also changing the out_put_disk to put_disk(disk).
>
>Hello Javier,
>
>
>If I understand correctly, you are suggesting this:
>
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -3616,7 +3616,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>        disk->queue = ns->queue;
>        disk->flags = flags;
>        memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
>-       ns->disk = disk;
>
>        __nvme_revalidate_disk(disk, id);
>
>@@ -3628,6 +3627,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>                }
>        }
>
>+       ns->disk = disk;
>+
>        down_write(&ctrl->namespaces_rwsem);
>        list_add_tail(&ns->list, &ctrl->namespaces);
>        up_write(&ctrl->namespaces_rwsem);
>@@ -3642,7 +3643,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>
>        return;
>  out_put_disk:
>-       put_disk(ns->disk);
>+       put_disk(disk);
>  out_unlink_ns:
>        mutex_lock(&ctrl->subsys->lock);
>        list_del_rcu(&ns->siblings);
>
>
>That would not solve the double free error when the registration fails,
>since disk->queue is still set, so this call will still free the queue.
>
>Later in the cleanup code blk_cleanup_queue(ns->queue);
>is called, which will still try to free what is already freed.
>
>To remove the double free by delaying assignments, we would need to
>delay the assignment of disk->queue until after the LightNVM entry point,
>but I don't think that is possible, since __nvme_revalidate_disk(), which
>is called before the LightNVM entry point uses disk->queue.
>
>Christoph said that he would clean up this mess with better block layer
>APIs. So perhaps the fix that is already queued is good enough until then.
>

Makes sense. I see some things have changed in this path since I last
looked at it.

Thanks!
Javier
