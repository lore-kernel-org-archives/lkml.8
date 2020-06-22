Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA0BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5606D20739
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="tWT8IFwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgFVHzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgFVHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:55:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:55:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so3207637wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBfcbRhyaKPHpnPDFtJmNQKmojsvDKT6TheQQXt9J8o=;
        b=tWT8IFwe5d468dQ/pWYKtEiiNOsCdqVNU9IixpxAkeSoI/qU/Ctw+YBtHJkXKkYOX2
         4FyucGA8VC0RTUZpQw0fHLvGERBN1fvZEjh/7pw6AFRlp2UNUEMOcyXJVBlpfVt7ysjI
         udZZ2xkcPEhUWptzGOQplyd2hqA6u32cdGIY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBfcbRhyaKPHpnPDFtJmNQKmojsvDKT6TheQQXt9J8o=;
        b=GR1/zM5JRvzp7/233wQJw06Lgc//9xFVB3ZBeLnSk8V4wq86MuUvzeoE+ChZo4SRCw
         M9eINiIKcfoa5w/v+AN3/HuOi2yOhMdV86gKzr7nusqXRTvNM7sAogBqqNFcn4nr7+3V
         zN1V8efPnFSOLYKnsYCQxuAT1Qb6BLfQJODPiW7QEjEGaK6kS+Ohg9sMRuatn7WRKV9L
         fL7IBt2HCcswoJX6o1FkDqqJaxXox/nFp/40AQaaicF2YGdo0tsoxxJLRAhc5PpmggN8
         OIkLqf2/oADMin5nGKcuJDRErLN3OTkHqxz5mVYluw2nAt8N0hiKO166LC+pvNMuT2Mv
         k7Ng==
X-Gm-Message-State: AOAM530wtb3MBaiomo9BSc4vtFu4gX3lKoDooMisqQk8cBj9cG8ZD4no
        tqtGmFz+q3GjBFpOWRxrhXXcFOcD+Hwik2g6+d7MtA==
X-Google-Smtp-Source: ABdhPJzb10pCV/bZXscPOSvmToADrZtcrEMn2BzcwVIwO8GOzDWrQaPeQlsTT+CHQmU2Tpmrbn4hPj0CEs5uDrhBnRM=
X-Received: by 2002:adf:958a:: with SMTP id p10mr16673028wrp.323.1592812515841;
 Mon, 22 Jun 2020 00:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 22 Jun 2020 08:55:05 +0100
Message-ID: <CALrw=nFe2q5wn2LTA99yrFhZqGR9ehiqhEQqKFh44KmvTVF5gg@mail.gmail.com>
Subject: Re: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
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

On Mon, Jun 22, 2020 at 1:45 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/06/20 1:56, Mike Snitzer wrote:
> > On Fri, Jun 19 2020 at 12:41pm -0400,
> > Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> >> This is a follow up from the long-forgotten [1], but with some more convincing
> >> evidence. Consider the following script:
> >>
> >> #!/bin/bash -e
> >>
> >> # create 4G ramdisk
> >> sudo modprobe brd rd_nr=1 rd_size=4194304
> >>
> >> # create a dm-crypt device with NULL cipher on top of /dev/ram0
> >> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | sudo dmsetup create eram0
> >>
> >> # create a dm-crypt device with NULL cipher and custom force_inline flag
> >> echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 force_inline' | sudo dmsetup create inline-eram0
> >>
> >> # read all data from /dev/ram0
> >> sudo dd if=/dev/ram0 bs=4k iflag=direct | sha256sum
> >>
> >> # read the same data from /dev/mapper/eram0
> >> sudo dd if=/dev/mapper/eram0 bs=4k iflag=direct | sha256sum
> >>
> >> # read the same data from /dev/mapper/inline-eram0
> >> sudo dd if=/dev/mapper/inline-eram0 bs=4k iflag=direct | sha256sum
> >>
> >> This script creates a ramdisk (to eliminate hardware bias in the benchmark) and
> >> two dm-crypt instances on top. Both dm-crypt instances use the NULL cipher
> >> to eliminate potentially expensive crypto bias (the NULL cipher just uses memcpy
> >> for "encyption"). The first instance is the current dm-crypt implementation from
> >> 5.8-rc1, the second is the dm-crypt instance with a custom new flag enabled from
> >> the patch attached to this thread. On my VM (Debian in VirtualBox with 4 cores
> >> on 2.8 GHz Quad-Core Intel Core i7) I get the following output (formatted for
> >> better readability):
> >>
> >> # plain ram0
> >> 1048576+0 records in
> >> 1048576+0 records out
> >> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.2305 s, 202 MB/s
> >> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -
> >>
> >> # eram0 (current dm-crypt)
> >> 1048576+0 records in
> >> 1048576+0 records out
> >> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 53.2212 s, 80.7 MB/s
> >> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -
> >>
> >> # inline-eram0 (patched dm-crypt)
> >> 1048576+0 records in
> >> 1048576+0 records out
> >> 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.3472 s, 201 MB/s
> >> 8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -
> >>
> >> As we can see, current dm-crypt implementation creates a significant IO
> >> performance overhead (at least on small IO block sizes) for both latency and
> >> throughput. We suspect offloading IO request processing into workqueues and
> >> async threads is more harmful these days with the modern fast storage. I also
> >> did some digging into the dm-crypt git history and much of this async processing
> >> is not needed anymore, because the reasons it was added are mostly gone from the
> >> kernel. More details can be found in [2] (see "Git archeology" section).
> >>
> >> We have been running the attached patch on different hardware generations in
> >> more than 200 datacentres on both SATA SSDs and NVME SSDs and so far were very
> >> happy with the performance benefits.
> >>
> >> [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
> >> [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/
> >>
> >> Ignat Korchagin (1):
> >>   Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target
> >>
> >>  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------
> >>  1 file changed, 43 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>
> >
> > Hi,
> >
> > I saw [2] and have been expecting something from cloudflare ever since.
> > Nice to see this submission.
> >
> > There is useful context in your 0th patch header.  I'll likely merge
> > parts of this patch header with the more terse 1/1 header (reality is
> > there only needed to be a single patch submission).
> >
> > Will review and stage accordingly if all looks fine to me.  Mikulas,
> > please have a look too.
>
> Very timely: I was about to send a couple of patches to add zoned block device
> support to dm-crypt :)
>
> I used [1] work as a base to have all _write_ requests be processed inline in
> the submitter context so that the submission order is preserved, avoiding the
> potential reordering of sequential writes that the normal workqueue based
> processing can generate. This inline processing is done only for writes. Reads
> are unaffected.
>
> To do this, I added a "inline_io" flag to struct convert_context which is
> initialized in crypt_io_init() based on the BIO op.
> kcryptd_crypt_write_io_submit() then uses this flag to call directly
> generic_make_request() if inline_io is true.
>
> This simplifies things compared to [1] since reads can still be processed as is,
> so there are no issued with irq context and no need for a tasklet.

In one of our major IO workflows (CDN cache) using dm-crypt created
high and spiky p99 response times, which actually prompted this
investigation. So, of all the things we do prefer the read path to be
inlined even more than the write path.

> Should I send these patches as RFC to see what can be merged ? Or I can wait for
> these patches and rebase on top.
>
> >
> > Thanks,
> > Mike
> >
> > --
> > dm-devel mailing list
> > dm-devel@redhat.com
> > https://www.redhat.com/mailman/listinfo/dm-devel
> >
> >
>
>
> --
> Damien Le Moal
> Western Digital Research
