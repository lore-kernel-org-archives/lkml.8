Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADE72080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Ae1sQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgIGL50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgIGLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:55:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0BC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:54:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so14116540wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OR+grx7rkHafCDDiGBz5vMeFbMGhU5jA0sq+dJevcqs=;
        b=H3Ae1sQMU3QDMtnyX3+xZtz6s1GPf3SQJ48vMHTrvOqN0P90Bi8at73uXh4Hg13jk3
         /o9/3Z1EuejT24OKfqp7aLZnu9lsD9zjP029koxPH7CiWyO11KFnw5CrRCav9GL3VJ8y
         35ReUrwanHemCx5mhqF0M22pBQYwq1IYvogw2EZfEp9YyvM95JkR+z9QQ7fJlRJ8+QfN
         yFDqcFdOCeQfigpb9NgvSaySzkZhGa7WVY4oItULB45o+jmw140QknPxxx8N+9EnUH08
         lEAsQ3kP8j6YqWDaf4ETVXWNh8czD0XwxQluGOytQe9Sdp2s0bD8G32b38Eh9ojVa8Bf
         OPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OR+grx7rkHafCDDiGBz5vMeFbMGhU5jA0sq+dJevcqs=;
        b=WLWdQ4Z9Ps+JbI8BZKXy4r6bmR6w9uNVWmy4K4Bqs94dRai2PB2I/0I8MVEorg22V6
         lCJk447uD0RHVJt8bUjPJNYILJQZZFCXA+Rmc/c0Pi8WZUuHqDfrpgU2aIRt1m9tepwx
         JwxLqIOCJI6RKnYVu+0lJVmDmob+UX4mK/UmbosCZbNnMdGmaOv+6+am4SnSV0X+xThH
         dk2ZKSrG8ABVryHpt/9Uui2s8C1xRbA8oxutDtqaPD9uh6XKpJRoqBTak37WVIUamqNn
         aStq3ZunrVlR3bJ/1sbVZAzN1yrCPY9ttsrb8X/Xi6KbzmcYUyuRWvrAmzPuLjpY56+f
         PLmA==
X-Gm-Message-State: AOAM531tY6Rc142ErqrkQcmp8wEAkdxKZ6Do8uEzF08frqHE2pX1r9th
        Sw7jktz1vhCykO6+ZnsmwhgO4JTOfCpIa58YI3M=
X-Google-Smtp-Source: ABdhPJwQrcj7pOMtW+ubR5dY9vTjAdfHlJlCVTWfZxIAQNeUmmUxO7ArntdPLUqJ7jvqE9jaZxgl9E7Hl5fxw2RmDkA=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr19558190wmj.138.1599479684792;
 Mon, 07 Sep 2020 04:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
 <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+sN8n6-ibJ1v_S5HEdfhbJ8yAYTm5ja=0M8ng2ujLZ4g@mail.gmail.com> <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 7 Sep 2020 17:24:18 +0530
Message-ID: <CA+1E3rJtGTt6gss-5uAjzQ+BAXWTOTcjUzyFToz-QWbEfkLkaA@mail.gmail.com>
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

On Mon, Sep 7, 2020 at 5:07 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/09/07 20:24, Kanchan Joshi wrote:
> > On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >>
> >> On 2020/09/07 16:01, Kanchan Joshi wrote:
> >>>> Even for SMR, the user is free to set the elevator to none, which disables zone
> >>>> write locking. Issuing writes correctly then becomes the responsibility of the
> >>>> application. This can be useful for settings that for instance use NCQ I/O
> >>>> priorities, which give better results when "none" is used.
> >>>
> >>> Was it not a problem that even if the application is sending writes
> >>> correctly, scheduler may not preserve the order.
> >>> And even when none is being used, re-queue can happen which may lead
> >>> to different ordering.
> >>
> >> "Issuing writes correctly" means doing small writes, one per zone at most. In
> >> that case, it does not matter if the block layer reorders writes. Per zone, they
> >> will still be sequential.
> >>
> >>>> As far as I know, zoned drives are always used in tightly controlled
> >>>> environments. Problems like "does not know what other applications would be
> >>>> doing" are non-existent. Setting up the drive correctly for the use case at hand
> >>>> is a sysadmin/server setup problem, based on *the* application (singular)
> >>>> requirements.
> >>>
> >>> Fine.
> >>> But what about the null-block-zone which sets MQ-deadline but does not
> >>> actually use write-lock to avoid race among multiple appends on a
> >>> zone.
> >>> Does that deserve a fix?
> >>
> >> In nullblk, commands are executed under a spinlock. So there is no concurrency
> >> problem. The spinlock serializes the execution of all commands. null_blk zone
> >> append emulation thus does not need to take the scheduler level zone write lock
> >> like scsi does.
> >
> > I do not see spinlock for that. There is one "nullb->lock", but its
> > scope is limited to memory-backed handling.
> > For concurrent zone-appends on a zone, multiple threads may set the
> > "same" write-pointer into incoming request(s).
> > Are you referring to any other spinlock that can avoid "same wp being
> > returned to multiple threads".
>
> Checking again, it looks like you are correct. nullb->lock is indeed only used
> for processing read/write with memory backing turned on.
> We either need to extend that spinlock use, or add one to protect the zone array
> when doing zoned commands and checks of read/write against a zone wp.
> Care to send a patch ? I can send one too.

Sure, I can send.
Do you think it is not OK to use zone write-lock (same like SCSI
emulation) instead of introducing a new spinlock?


-- 
Kanchan
