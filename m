Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9DB2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YciUBurx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbgFXFWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:22:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60260 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727957AbgFXFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592976138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXtCMYzuSyQmAhIf24ZY39KZ53JUuAnzaU1mt7pqaeM=;
        b=YciUBurxt5IjO71XDMme47TNohjCUamJdh4uxnbYQF4IgHMajTtEPL6jiLLK5n+weZD0D3
        Cl6Cksg2U1rlHharGYjV31kGlOKQ9bTMWF5BioJi1bxYQJRH5FrjoDi3hNEVyPhldIm3ES
        R+ARMgJPS365yDUrr9jS5yQx4QgDOXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-iGFLzro-NT-trKNSaDgH8Q-1; Wed, 24 Jun 2020 01:22:14 -0400
X-MC-Unique: iGFLzro-NT-trKNSaDgH8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A2FC8015F0;
        Wed, 24 Jun 2020 05:22:13 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 292FF7168B;
        Wed, 24 Jun 2020 05:22:10 +0000 (UTC)
Date:   Wed, 24 Jun 2020 01:22:09 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
Message-ID: <20200624052209.GB23205@redhat.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200623150118.GA19657@redhat.com>
 <CALrw=nHNJTX3kzv2Q=dc6hYr=d8S2=gT0VHkWigS1pmwr9ps5Q@mail.gmail.com>
 <20200623152235.GB19657@redhat.com>
 <CY4PR04MB3751EB316BFD5600AFAA6796E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751EB316BFD5600AFAA6796E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24 2020 at 12:54am -0400,
Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> On 2020/06/24 0:23, Mike Snitzer wrote:
> > On Tue, Jun 23 2020 at 11:07am -0400,
> > Ignat Korchagin <ignat@cloudflare.com> wrote:
> > 
> >> Do you think it may be better to break it in two flags: one for read
> >> path and one for write? So, depending on the needs and workflow these
> >> could be enabled independently?
> > 
> > If there is a need to split, then sure.  But I think Damien had a hard
> > requirement that writes had to be inlined but that reads didn't _need_
> > to be for his dm-zoned usecase.  Damien may not yet have assessed the
> > performance implications, of not have reads inlined, as much as you
> > have.
> 
> We did do performance testing :)
> The results are mixed and performance differences between inline vs workqueues
> depend on the workload (IO size, IO queue depth and number of drives being used
> mostly). In many cases, inlining everything does really improve performance as
> Ignat reported.
> 
> In our testing, we used hard drives and so focused mostly on throughput rather
> than command latency. The added workqueue context switch overhead and crypto
> work latency compared to typical HDD IO times is small, and significant only if
> the backend storage as short IO times.
> 
> In the case of HDDs, especially for large IO sizes, inlining crypto work does
> not shine as it prevents an efficient use of CPU resources. This is especially
> true with reads on a large system with many drives connected to a single HBA:
> the softirq context decryption work does not lend itself well to using other
> CPUs that did not receive the HBA IRQ signaling command completions. The test
> results clearly show much higher throughputs using dm-crypt as is.
> 
> On the other hand, inlining crypto work significantly improves workloads of
> small random IOs, even for a large number of disks: removing the overhead of
> context switches allows faster completions, allowing sending more requests to
> the drives more quickly, keeping them busy.
> 
> For SMR, the inlining of write requests is *mandatory* to preserve the issuer
> write sequence, but encryption work being done in the issuer context (writes to
> SMR drives can only be O_DIRECT writes), efficient CPU resource usage can be
> achieved by simply using multiple writer thread/processes, working on different
> zones of different disks. This is a very reasonable model for SMR as writes into
> a single zone have to be done under mutual exclusion to ensure sequentiality.
> 
> For reads, SMR drives are essentially exactly the same as regular disks, so
> as-is or inline are both OK. Based on our performance results, allowing the user
> to have the choice of inlining or not reads based on the target workload would
> be great.
> 
> Of note is that zone append writes (emulated in SCSI, native with NVMe) are not
> subject to the sequential write constraint, so they can also be executed either
> inline or asynchronously.
> 
> > So let's see how Damien's work goes and if he trully doesn't need/want
> > reads to be inlined then 2 flags can be created.
> 
> For SMR, I do not need inline reads, but I do want the user to have the
> possibility of using this setup as that can provide better performance for some
> workloads. I think that splitting the inline flag in 2 is exactly what we want:
> 
> 1) For SMR, the write-inline flag can be automatically turned on when the target
> device is created if the backend device used is a host-managed zoned drive (scsi
> or NVMe ZNS). For reads, it would be the user choice, based on the target workload.
> 2) For regular block devices, write-inline only, read-inline only or both would
> be the user choice, to optimize for their target workload.
> 
> With the split into 2 flags, my SMR support patch becomes very simple.

OK, thanks for all the context.  Was a fun read ;)

SO let's run with splitting into 2 flags.  Ignat would you be up to
tweaking your patch to provide that and post a v2?

An added bonus would be to consolidate your 0/1 and 1/1 patch headers,
and add in the additional answers you provided in this thread to help
others understand the patch (mainly some more detail about why tasklet
is used).

Thanks,
Mike

