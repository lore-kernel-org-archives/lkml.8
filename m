Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC688C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C222520842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faJGcOsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgBKK5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:57:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60630 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727558AbgBKK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581418638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHDZin+UZkvf57OXTiAEW8DlkByJ4zhgnoIg7b8L+NE=;
        b=faJGcOsbQf9aU4IBHUxmzJEiwYkD+olJJ/UH+ZW2HYb4qPGWub9FRIDhhU5xrWyB6N7s8J
        uqLZMjo73Jgitoa+EyhmsNAo4dFc4l6petiYQcMmYno4aBRLBj5S5OCbizA40GWH+nzAEG
        VxHn6MznHSUPx5HUC1b4SYk/LiD3IY0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-K3g9EBoYNGu5hbs7vf_xWg-1; Tue, 11 Feb 2020 05:57:15 -0500
X-MC-Unique: K3g9EBoYNGu5hbs7vf_xWg-1
Received: by mail-qt1-f197.google.com with SMTP id c8so6299378qte.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 02:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zHDZin+UZkvf57OXTiAEW8DlkByJ4zhgnoIg7b8L+NE=;
        b=OXLgaVf3tzuM9Uoq4hlAurf+RPGU8UGmNlu7SizHGgF+nn0eZ8T+KEY6bHMPUe32zT
         O4L/+3iJM6pOLNthCIOKFuFzrlWou29ZiUyHxbDtOZJzwJluu+Sd0ljFSPrJqrkMl3xx
         rZ3RkfhK/LWNfBSFgFcEAV48NNO3E1Kd3UZ/rHKPW23OhnGDhKqDcjvqJoGd8iwiVDoz
         +9NSpRqLyErNNNnDFHx/gMiyK6o49mxe/+fXXgUpm8TkO3QH4V98hvcnHx5QbjeUjSc/
         jnsRxVI+u9hqaYIeknuVRJ9+/TtkrUU+HAuv3eNKfJG6F02GK8I5fEGtPTV1s3McGCd0
         oeIA==
X-Gm-Message-State: APjAAAWyOfGsIvO7iqk87lO0F8vdSVd8MJyCquuPjrZdfBEs2PnWbNzm
        pzM7C+fUjTC26SbAR3/6s64C6ny9tS9v+X0Fhn3nelzN2/ZaMMqVWyRTKQH2LIOCmwHTDmx9nJP
        M+V5SXLE/oqR0/OMf87+QGNTo
X-Received: by 2002:ac8:6618:: with SMTP id c24mr1791420qtp.327.1581418634810;
        Tue, 11 Feb 2020 02:57:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcqApMTJKfRU4KaIK2j3dYSSGgI3NBh3ICYMKJb9stGPpMG+yyEwb6XYA+WHcmJ3qLyBYqvA==
X-Received: by 2002:ac8:6618:: with SMTP id c24mr1791404qtp.327.1581418634534;
        Tue, 11 Feb 2020 02:57:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id z1sm1872926qtq.69.2020.02.11.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 02:57:13 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:57:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200211053953-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <20200210062938-mutt-send-email-mst@kernel.org>
 <20200211160541.GA37446@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211160541.GA37446@chaop.bj.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:05:41PM +0000, Chao Peng wrote:
> On Mon, Feb 10, 2020 at 06:44:50AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> > > We have compared the number of files and the lines of code between
> > > virtio-mmio and virio-pci.
> > > 
> > > 				Virtio-PCI	    Virtio-MMIO	
> > > 	number of files(Linux)	    161			1
> > > 	lines of code(Linux)	    78237		538
> > 
> > 
> > 
> > Something's very wrong here. virtio PCI is 161 files?
> > Are you counting the whole PCI subsystem?
> 
> Right, that is just a rough statistics.

Please try not to make them look so wrong then.
E.g. you don't include drivers/base/platform-msi.c for
mmio do you? Your patch brings a bunch of code in there.

> Surely enough, some drivers will
> never get enabled in a typcial config.
> 
> > Sure enough:
> > 
> > $ find drivers/pci -name '*c' |wc -l
> > 150
> 
> and plus:
> $ find arch/x86/pci/ -name '*c' |wc -l
> 22

But what's the point? This is code that is maintained by PCI core
people anyway.

> > 
> > That's not reasonable, this includes a bunch of drivers that
> > never run on a typical hypervisor.
> > 
> > MMIO is also not as small as you are trying to show:
> > 
> > $ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
> >        2 text files.
> >        2 unique files.                              
> >        0 files ignored.
> > 
> > github.com/AlDanial/cloc v 1.82  T=0.01 s (230.7 files/s, 106126.5 lines/s)
> > -------------------------------------------------------------------------------
> > Language                     files          blank        comment           code
> > -------------------------------------------------------------------------------
> > C                                1            144            100            535
> > C/C++ Header                     1             39             66             36
> > -------------------------------------------------------------------------------
> > SUM:                             2            183            166            571
> > -------------------------------------------------------------------------------
> > 
> > 
> > I don't doubt MMIO is smaller than PCI. Of course that's because it has
> > no features to speak of - just this patch already doubles it's size. If
> > we keep doing that because we want the features then they will reach
> > the same size in about 4 iterations.
> 
> Since current virtio-mmio size is small enough, so adding any notable
> feature would easily double it.

But really unlike PCI this is just PV stuff that is not reused by
anyone. We end up maintaining all this by ourselves.

> I have no objection that it may one day
> reach the same level of PCI, but in this patch some are actually
> generic changes and for MSI specific code we provide the option to
> confige away.
> 
> Thanks,
> Chao

The option will make it fall down at runtime but
it does not actually seem to remove all of the overhead.



> > 
> > 
> > -- 
> > MST

