Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B858EC2D0A7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6C206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzUc11E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgIGL3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgIGLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:24:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:24:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so15374742wrl.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNFvxhnA0NnzUC7lrNJrUKsLLmz7/HC2qOyPmU9vUl0=;
        b=uzUc11E0gok7gl6O5NNy2E0O4w9nQRfSU0c4U5Pb0vlWerd2W52/oGEaCOOf21VZvz
         qbUWgc2jjvIpozWCfp5pFMHduvVHPw9c48sqGnfyIUUgJG8BtPryhVoO1vbQrZt1/2t5
         BGv5rA9Q15nMiYW8wLCBNm91gw329WdwEEbDzBSo09EzeCoL4z5eMUY/Mab/sG1oaIfF
         7eTtOIxJhimNEA8xKA/QRtsNsbmswuWJftIDEE+4nua2bEgR1PPGWBqjJRJd5dr51Jy+
         m2vaxKwhT9k2SZY3Dh7QIltaGj2udCVRKw+lhS67Vb9tGQFVsD564QdWXYAzA5u+OU1S
         EBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNFvxhnA0NnzUC7lrNJrUKsLLmz7/HC2qOyPmU9vUl0=;
        b=FzknNLtQXdPBWbMi9oiABKGTy5kgSlh0zzEQDwFIVMpW6lyVrCA5UzbA2eERA10ltc
         sYp7o46PodIDXwXFKg+r5dLZ4WNvZd067HNL6/yRYbAnb3+VfqJ1ivZYOZ2bgopIOtYz
         4gC0Yiiu4s3a2W+rHqKcfAM/JwGM1aLaFwVVm8vMoBFvTqpnt3bnzanpvg1i0RToY1ye
         hbdF0wdkSXqxMxCn+fp/b9IupCKDc5n+jpIeUupbaFMibAOAax+7rP4aewkqMAflFbOf
         vrfFuniJqnoT80P52gZj6eU6rYsQE/VRf6xToVwOlctGi1/QeikXTXxNtbebMivjVOje
         So0w==
X-Gm-Message-State: AOAM530bRpRF1AEEnOKSy7E29rF1EkwD9pq7G1TClZFly28r87+ACJUi
        P6Q1Mm06Gt3FBb7P/+Sj8alsDO8QSG4Vr38Tp1k=
X-Google-Smtp-Source: ABdhPJy8sgbC/sJ9Rm/BrKqEAwV59GWXOOZ8VFQbp18vsLtPw1wPlO3O6XyZjZZQOJ5PDx5K8cjviVYWAdsvQNWMSFI=
X-Received: by 2002:a5d:630a:: with SMTP id i10mr20495093wru.137.1599477853937;
 Mon, 07 Sep 2020 04:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com> <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 7 Sep 2020 16:53:47 +0530
Message-ID: <CA+1E3r+sN8n6-ibJ1v_S5HEdfhbJ8yAYTm5ja=0M8ng2ujLZ4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/09/07 16:01, Kanchan Joshi wrote:
> >> Even for SMR, the user is free to set the elevator to none, which disables zone
> >> write locking. Issuing writes correctly then becomes the responsibility of the
> >> application. This can be useful for settings that for instance use NCQ I/O
> >> priorities, which give better results when "none" is used.
> >
> > Was it not a problem that even if the application is sending writes
> > correctly, scheduler may not preserve the order.
> > And even when none is being used, re-queue can happen which may lead
> > to different ordering.
>
> "Issuing writes correctly" means doing small writes, one per zone at most. In
> that case, it does not matter if the block layer reorders writes. Per zone, they
> will still be sequential.
>
> >> As far as I know, zoned drives are always used in tightly controlled
> >> environments. Problems like "does not know what other applications would be
> >> doing" are non-existent. Setting up the drive correctly for the use case at hand
> >> is a sysadmin/server setup problem, based on *the* application (singular)
> >> requirements.
> >
> > Fine.
> > But what about the null-block-zone which sets MQ-deadline but does not
> > actually use write-lock to avoid race among multiple appends on a
> > zone.
> > Does that deserve a fix?
>
> In nullblk, commands are executed under a spinlock. So there is no concurrency
> problem. The spinlock serializes the execution of all commands. null_blk zone
> append emulation thus does not need to take the scheduler level zone write lock
> like scsi does.

I do not see spinlock for that. There is one "nullb->lock", but its
scope is limited to memory-backed handling.
For concurrent zone-appends on a zone, multiple threads may set the
"same" write-pointer into incoming request(s).
Are you referring to any other spinlock that can avoid "same wp being
returned to multiple threads".

-- 
Kanchan
