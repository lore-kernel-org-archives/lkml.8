Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36907C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF17D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eyGFPsb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgFWPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732868AbgFWPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:07:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC488C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:07:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so23838183ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOJ4r5eRLu7pYwZ7nb72+ethCqIdEc1b6ZQTMBOmtl0=;
        b=eyGFPsb3Ecv6WIff2bnyEcA8O2/8mOk3tPZLQUq2/H/f8Sd85M7TXgnPiylYEf8dyu
         gUB03dQE5U2CvM4Ksj/DXZU45UuQfwrgX4Ev7MiRI2FRei2SetffW0alu4zcr+XB9Uoi
         d3IZsPcLIR5PSKN5vvLNqDrjl234SQc5VASr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOJ4r5eRLu7pYwZ7nb72+ethCqIdEc1b6ZQTMBOmtl0=;
        b=VlLiioxbQB6vJkQnQn6+2pGTS+rMIC4ElFhcF5elP7n92RyYs/sb2D/XcFgh9aB0CE
         GOblNrJV/LZP+1IzoB5kbmm2x/NdIgz3Rgc4hYIqbLm7uI/avoG+73/u4FJ4eBkNZWvu
         0p+9p7/spOYDDj9VfURj8VHLw/l67X9Jz/D0Fwk+DAUqpi75BaUIYKML+LvT6UMHXO+K
         qax2ROwNh4dr6HPmSGLto3nnswhaNnb+raIzbqse0F4DPqzrsvdSGkcLKdakh5D12N3L
         OBWLqtYGfgxosQwVMQDnKOeD4/PFSelfLMW2TTuofLU4hlgv/Q3RfcwWyqtcABV6bLtA
         16IQ==
X-Gm-Message-State: AOAM532xmsmEjRa7d6Czr1fPPuUNGN9rRKKOQ/bF9skETzCVHdlx0+c/
        t/I7tXroAuT00n7hde5tSV31uQ/G9wUyCfecBIOBcQ==
X-Google-Smtp-Source: ABdhPJwP9Jyaji8sBzfy2og0disuJ5Wf14im88KFBUmSXjgOfg7NRJaAK3RiZHjiAOpGyDUbhCfzYCZ6/QlxbQoR3ng=
X-Received: by 2002:a05:651c:2d0:: with SMTP id f16mr10958567ljo.387.1592924866020;
 Tue, 23 Jun 2020 08:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200623150118.GA19657@redhat.com>
In-Reply-To: <20200623150118.GA19657@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 23 Jun 2020 16:07:33 +0100
Message-ID: <CALrw=nHNJTX3kzv2Q=dc6hYr=d8S2=gT0VHkWigS1pmwr9ps5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
To:     Mike Snitzer <snitzer@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you think it may be better to break it in two flags: one for read
path and one for write? So, depending on the needs and workflow these
could be enabled independently?

Regards,
Ignat

On Tue, Jun 23, 2020 at 4:01 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Sun, Jun 21 2020 at  8:45pm -0400,
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> > On 2020/06/20 1:56, Mike Snitzer wrote:
> > > On Fri, Jun 19 2020 at 12:41pm -0400,
> > > Ignat Korchagin <ignat@cloudflare.com> wrote:
> > >
> > >> This is a follow up from the long-forgotten [1], but with some more convincing
> > >> evidence. Consider the following script:
> > >>
> > >> #!/bin/bash -e
> > >>
> > >> # create 4G ramdisk
> > >> sudo modprobe brd rd_nr=1 rd_size=4194304
> > >>
> > >> # create a dm-crypt device with NULL cipher on top of /dev/ram0
> > >> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | sudo dmsetup create eram0
> > >>
> > >> # create a dm-crypt device with NULL cipher and custom force_inline flag
> > >> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 force_inline' | sudo dmsetup create inline-eram0
> > >>
> > >> # read all data from /dev/ram0
> > >> sudo dd if=/dev/ram0 bs=4k iflag=direct | sha256sum
> > >>
> > >> # read the same data from /dev/mapper/eram0
> > >> sudo dd if=/dev/mapper/eram0 bs=4k iflag=direct | sha256sum
> > >>
> > >> # read the same data from /dev/mapper/inline-eram0
> > >> sudo dd if=/dev/mapper/inline-eram0 bs=4k iflag=direct | sha256sum
> > >>
> > >> This script creates a ramdisk (to eliminate hardware bias in the benchmark) and
> > >> two dm-crypt instances on top. Both dm-crypt instances use the NULL cipher
> > >> to eliminate potentially expensive crypto bias (the NULL cipher just uses memcpy
> > >> for "encyption"). The first instance is the current dm-crypt implementation from
> > >> 5.8-rc1, the second is the dm-crypt instance with a custom new flag enabled from
> > >> the patch attached to this thread. On my VM (Debian in VirtualBox with 4 cores
> > >> on 2.8 GHz Quad-Core Intel Core i7) I get the following output (formatted for
> > >> better readability):
> > >>
> > >> # plain ram0
> > >> 1048576+0 records in
> > >> 1048576+0 records out
> > >> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.2305 s, 202 MB/s
> > >> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -
> > >>
> > >> # eram0 (current dm-crypt)
> > >> 1048576+0 records in
> > >> 1048576+0 records out
> > >> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 53.2212 s, 80.7 MB/s
> > >> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -
> > >>
> > >> # inline-eram0 (patched dm-crypt)
> > >> 1048576+0 records in
> > >> 1048576+0 records out
> > >> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.3472 s, 201 MB/s
> > >> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -
> > >>
> > >> As we can see, current dm-crypt implementation creates a significant IO
> > >> performance overhead (at least on small IO block sizes) for both latency and
> > >> throughput. We suspect offloading IO request processing into workqueues and
> > >> async threads is more harmful these days with the modern fast storage. I also
> > >> did some digging into the dm-crypt git history and much of this async processing
> > >> is not needed anymore, because the reasons it was added are mostly gone from the
> > >> kernel. More details can be found in [2] (see "Git archeology" section).
> > >>
> > >> We have been running the attached patch on different hardware generations in
> > >> more than 200 datacentres on both SATA SSDs and NVME SSDs and so far were very
> > >> happy with the performance benefits.
> > >>
> > >> [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
> > >> [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/
> > >>
> > >> Ignat Korchagin (1):
> > >>   Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target
> > >>
> > >>  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------
> > >>  1 file changed, 43 insertions(+), 12 deletions(-)
> > >>
> > >> --
> > >> 2.20.1
> > >>
> > >
> > > Hi,
> > >
> > > I saw [2] and have been expecting something from cloudflare ever since.
> > > Nice to see this submission.
> > >
> > > There is useful context in your 0th patch header.  I'll likely merge
> > > parts of this patch header with the more terse 1/1 header (reality is
> > > there only needed to be a single patch submission).
> > >
> > > Will review and stage accordingly if all looks fine to me.  Mikulas,
> > > please have a look too.
> >
> > Very timely: I was about to send a couple of patches to add zoned block device
> > support to dm-crypt :)
> >
> > I used [1] work as a base to have all _write_ requests be processed inline in
> > the submitter context so that the submission order is preserved, avoiding the
> > potential reordering of sequential writes that the normal workqueue based
> > processing can generate. This inline processing is done only for writes. Reads
> > are unaffected.
> >
> > To do this, I added a "inline_io" flag to struct convert_context which is
> > initialized in crypt_io_init() based on the BIO op.
> > kcryptd_crypt_write_io_submit() then uses this flag to call directly
> > generic_make_request() if inline_io is true.
> >
> > This simplifies things compared to [1] since reads can still be processed as is,
> > so there are no issued with irq context and no need for a tasklet.
> >
> > Should I send these patches as RFC to see what can be merged ? Or I can wait for
> > these patches and rebase on top.
>
> It'd be ideal for this inline capability to address both Ignat's and
> your needs.  Given Ignat's changes _should_ enable yours (and Ignat
> clarified that having reads inline is actually important) then I think it
> best if you review Ignat's patch closely, rebase on it and test that it
> meets your needs.
>
> I'll wait for you to do this work so that I can get your feedback on
> whether Ignat's changes look good for you too.  We have some time before
> the 5.9 merge window opens, lets just keep the communication going and
> make sure what we send upstream addresses everyone's needs and concerns.
>
> Thanks,
> Mike
>
