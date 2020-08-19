Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784D0207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5lGJ4Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHSKc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgHSKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:32:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86683C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:32:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 9so1549105wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NV+AsSWtKgo9V3/Cia9q0raOuFNDesH+Q29wP1zWBh4=;
        b=B5lGJ4VjjJ0e8bFa5P9jabfVMJ2SDPRUYFM7GR79AU7H5PS7dHY0qLWGNgYNE40kxe
         KdNa5QE2zFmlsilJf1GOdlQECUEqFBq/M/SuwI4dKc0/AwbNc6/TGn1E62JqjyCvgHAq
         1PV8a8aEEwQ3ZwcumuPpv6ZMGZaJO6iWY/dJoQe6+0EdXyQw+DbdSkjssIMQQRIBMc6b
         s2VS0Jrye6Qzif4pBIJmA33Ab0sbcl7kPqSKP9mTjvhz6j8c5uRHGQ07fBMz/U2aRWeU
         fC26cTKMUYAuZYk9iwCvOelEWfptsBVaQ7Uw4GnyOMY76lP8PMBOOgsNWEBE9DVw4R6Y
         GHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV+AsSWtKgo9V3/Cia9q0raOuFNDesH+Q29wP1zWBh4=;
        b=rvYC8ZJMW4yc6DQhb7ComUif98siOF2EWS7AbfN7NSpqxmy0ftFsRU1SKniiRdJO0w
         kj1gB78eY2nh72pcCUQiAs8rQFDUDWcuvir4WC2rpFa+jLKEnvdgE9Qvf7pQ+ngNIx/Q
         zH/uXB84JU/Wm49f+ba3AKp2praf0wCzGim3W2qZ6K8+rCDZPSzUtddb+29+YQhv0WOl
         XmI4Qsphoe8uKVCIU+nspb++JRRM4D47pLrpoBZP+Lf0EaU/icpn43kYVD14o/zG77CC
         F6CApLjTYQ4CSuZMzUclMRfMQMhqIhq3XuR9x9gr1LfKT63u1/KcFK1eUcpeCP6x9BXG
         ywsQ==
X-Gm-Message-State: AOAM532ToNwa21zUrIN8a5eBanjXJnaSmqH+3Y0DSbELXM9v0zvrOybr
        +S26qjX5xtULqfUJZrToPHN9FmcgelhzPMP8xWY=
X-Google-Smtp-Source: ABdhPJz+viaPlrYERgK5MAmEg65lIg4xfE1p/n9zOxz9KVwyCf2C+pTAPZVcWcXsVfCSDePwL6IxtloMUbN+Mo/cQ1I=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr4446682wmh.4.1597833140938;
 Wed, 19 Aug 2020 03:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com> <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Wed, 19 Aug 2020 16:01:54 +0530
Message-ID: <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 3:08 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/08/19 18:27, Kanchan Joshi wrote:
> > On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> >>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
> >>
> >> No, it is not.
> >
> > Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
> > I see that null-block zoned and SCSI-ZBC both set this requirement. I
> > wonder how it became different for NVMe.
>
> It is not required for an NVMe ZNS drive that has zone append native support.
> zonefs and upcoming btrfs do not use regular writes, removing the requirement
> for zone write locking.

I understand that if a particular user (zonefs, btrfs etc) is not
sending regular-write and sending append instead, write-lock is not
required.
But if that particular user or some other user (say F2FS) sends
regular write(s), write-lock is needed.
Above block-layer, both the opcodes REQ_OP_WRITE and
REQ_OP_ZONE_APPEND are available to be used by users. And I thought
write-lock is taken or not is a per-opcode thing and not per-user (FS,
MD/DM, user-space etc.), is not that correct? And MQ-deadline can
cater to both the opcodes, while other schedulers cannot serve
REQ_OP_WRITE well for zoned-device.

> In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be set only
> and only if the drive does not have native zone append support.

Sure I can keep it that way, once I get it right. If it is really not
required for native-append drive, it should not be here at the place
where I added.

> And even in that
> case, since for an emulated zone append the zone write lock is taken and
> released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is required
> only if the user will also be issuing regular writes at high QD. And that is
> trivially controllable by the user by simply setting the drive elevator to
> mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.

Are we saying applications should switch schedulers based on the write
QD  (use any-scheduler for QD1 and mq-deadline for QD-N).
Even if it does that, it does not know what other applications would
be doing. That seems hard-to-get-right and possible only in a
tightly-controlled environment.



-- 
Joshi
