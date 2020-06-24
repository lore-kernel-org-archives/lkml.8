Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DC4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369E12137B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="jdn7CK3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbgFXICx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFXICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:02:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:02:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j94so1325769wrj.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NQUfNYeK/TI+d0cUiXO3hjD9ZuHGvPoQ56932SRZ4c=;
        b=jdn7CK3zOy66vbV7hrftWuxB9RMgaz4zLIY+DNejBbyJCwC/A3kF8HxRfZqoIHQnqC
         Xm8pzcWumqbNm9wYfY+p1o49nHRRPKE1I7UwG6u09CTgzeefhvJi7wl0n15zqOx7vVz+
         1ZBedw6K5Kzn1s45v/cGXbV/LJDW3mZbNTrHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NQUfNYeK/TI+d0cUiXO3hjD9ZuHGvPoQ56932SRZ4c=;
        b=hsmrXjvfgarUpT4ZXEgywYNkUcQHLStuqkziJLy/TrjUpFsxDvdvJjH/4RSc3N/0/2
         auUvvhYkJiaVYpq/MKvhGrgSY+YtPZzTmkXV6gYUFomjtOmKlNRV8mje5oTtOOy+Y+y0
         mKIgb3014X10sL3C6ePkh+JsCAiiJ8AMFFcK8wIDPiebetJj70Hp4uXOh7cEA8KLqiJK
         RpntOmDrMiXqGJfOHrXya/c3u2e0UIY5uog57IKfhxsnoSkZ6mzXffX9bx74NdZcWjZH
         oK7e/PWxN20Ocz8QYnjz9OYeILzAyOplqQcJeIlfOcRrleQMhuDc54Ua+Fi1zwVW/985
         lPkg==
X-Gm-Message-State: AOAM533exl+ueVORNQvUPSS16YZIE5tdi0O5mf6B1U15PcrvLCirxrM/
        bzUGsIS8jmoU9cTpUlIGV4Lj9OmFihTbtDXDTGfLnQ==
X-Google-Smtp-Source: ABdhPJyOj1ZrwSODv5DHAZf4d+kATxblkm9SFPKRHbdMtMGNJ/yg0W/1HtM3nlPOFm9njnEwtQpklHyS8De4vgCySIc=
X-Received: by 2002:a5d:4992:: with SMTP id r18mr3868698wrq.323.1592985771104;
 Wed, 24 Jun 2020 01:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200623150118.GA19657@redhat.com> <CALrw=nHNJTX3kzv2Q=dc6hYr=d8S2=gT0VHkWigS1pmwr9ps5Q@mail.gmail.com>
 <20200623152235.GB19657@redhat.com> <CY4PR04MB3751EB316BFD5600AFAA6796E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200624052209.GB23205@redhat.com>
In-Reply-To: <20200624052209.GB23205@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 24 Jun 2020 09:02:39 +0100
Message-ID: <CALrw=nE4Wf3mBqb9BvaEu32aSpAuuGsbKmPBReOHRze-0jyfkw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
To:     Mike Snitzer <snitzer@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 6:22 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Wed, Jun 24 2020 at 12:54am -0400,
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> > On 2020/06/24 0:23, Mike Snitzer wrote:
> > > On Tue, Jun 23 2020 at 11:07am -0400,
> > > Ignat Korchagin <ignat@cloudflare.com> wrote:
> > >
> > >> Do you think it may be better to break it in two flags: one for read
> > >> path and one for write? So, depending on the needs and workflow these
> > >> could be enabled independently?
> > >
> > > If there is a need to split, then sure.  But I think Damien had a hard
> > > requirement that writes had to be inlined but that reads didn't _need_
> > > to be for his dm-zoned usecase.  Damien may not yet have assessed the
> > > performance implications, of not have reads inlined, as much as you
> > > have.
> >
> > We did do performance testing :)
> > The results are mixed and performance differences between inline vs workqueues
> > depend on the workload (IO size, IO queue depth and number of drives being used
> > mostly). In many cases, inlining everything does really improve performance as
> > Ignat reported.
> >
> > In our testing, we used hard drives and so focused mostly on throughput rather
> > than command latency. The added workqueue context switch overhead and crypto
> > work latency compared to typical HDD IO times is small, and significant only if
> > the backend storage as short IO times.
> >
> > In the case of HDDs, especially for large IO sizes, inlining crypto work does
> > not shine as it prevents an efficient use of CPU resources. This is especially
> > true with reads on a large system with many drives connected to a single HBA:
> > the softirq context decryption work does not lend itself well to using other
> > CPUs that did not receive the HBA IRQ signaling command completions. The test
> > results clearly show much higher throughputs using dm-crypt as is.
> >
> > On the other hand, inlining crypto work significantly improves workloads of
> > small random IOs, even for a large number of disks: removing the overhead of
> > context switches allows faster completions, allowing sending more requests to
> > the drives more quickly, keeping them busy.
> >
> > For SMR, the inlining of write requests is *mandatory* to preserve the issuer
> > write sequence, but encryption work being done in the issuer context (writes to
> > SMR drives can only be O_DIRECT writes), efficient CPU resource usage can be
> > achieved by simply using multiple writer thread/processes, working on different
> > zones of different disks. This is a very reasonable model for SMR as writes into
> > a single zone have to be done under mutual exclusion to ensure sequentiality.
> >
> > For reads, SMR drives are essentially exactly the same as regular disks, so
> > as-is or inline are both OK. Based on our performance results, allowing the user
> > to have the choice of inlining or not reads based on the target workload would
> > be great.
> >
> > Of note is that zone append writes (emulated in SCSI, native with NVMe) are not
> > subject to the sequential write constraint, so they can also be executed either
> > inline or asynchronously.
> >
> > > So let's see how Damien's work goes and if he trully doesn't need/want
> > > reads to be inlined then 2 flags can be created.
> >
> > For SMR, I do not need inline reads, but I do want the user to have the
> > possibility of using this setup as that can provide better performance for some
> > workloads. I think that splitting the inline flag in 2 is exactly what we want:
> >
> > 1) For SMR, the write-inline flag can be automatically turned on when the target
> > device is created if the backend device used is a host-managed zoned drive (scsi
> > or NVMe ZNS). For reads, it would be the user choice, based on the target workload.
> > 2) For regular block devices, write-inline only, read-inline only or both would
> > be the user choice, to optimize for their target workload.
> >
> > With the split into 2 flags, my SMR support patch becomes very simple.
>
> OK, thanks for all the context.  Was a fun read ;)
>
> SO let's run with splitting into 2 flags.  Ignat would you be up to
> tweaking your patch to provide that and post a v2?
>
> An added bonus would be to consolidate your 0/1 and 1/1 patch headers,
> and add in the additional answers you provided in this thread to help
> others understand the patch (mainly some more detail about why tasklet
> is used).

Yes, will do

> Thanks,
> Mike
>
