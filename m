Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3717C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7344620720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598033896;
	bh=7ZMnxBinhbuxuu76uI4BQcNGRdzuzbPEh3ZWwy0a3vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zwLtLiwEdKkRrdqeZqyeg/LlXQoX3z734+ejKWi2IGcfTimZkil6pH9cG4e8S8hJO
	 2ZUwitUsHJ8Gfmp1t3cl1F30Yhedx4vZfV+CG/2bfhXDFcs3jSSO4/8J67oxldQKVT
	 EkOyDCII3joUVrPzUzEPLZ04SHR4R/CUog5Ivi5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHUSSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgHUSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:18:10 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8DD620735
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598033889;
        bh=7ZMnxBinhbuxuu76uI4BQcNGRdzuzbPEh3ZWwy0a3vQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=maIWyNWPrBmOGTbebI0zVei53p07oW05BnWwKebNLH6x9g5wSBT47me3h0dMkZRzZ
         EifSicaXbM+ifLGGs7PFENF09GI4WoHDvywJMZKp1V44q+C+nD9b6B/pq8MHD8AMGQ
         vM/EW4vOndvpQ0WUl77PeHw3XbFllYbPNTuKiNgI=
Received: by mail-ot1-f50.google.com with SMTP id k12so2305081otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:18:09 -0700 (PDT)
X-Gm-Message-State: AOAM533nZdTDt9MPziszf0ftobxAZvLOL4mx2lQz4vAkyOApgxwP9vUz
        K5In24630l1R0DepzC3sOO5q2KBLOCE0EhpGlQ==
X-Google-Smtp-Source: ABdhPJy/o46mSao/iyigXFdlBssYsaaeBIUKzIltnUK6LL8LLeaAnrN+ySSRUiPbmI1h6pQn62RtTu8MK6E5r1dJE4U=
X-Received: by 2002:a05:6830:1d8e:: with SMTP id y14mr2864009oti.129.1598033889071;
 Fri, 21 Aug 2020 11:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200821154848.GI7871@localhost.localdomain> <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
 <8213206d4764375f32cbea36ea214573248094dc.camel@perches.com>
In-Reply-To: <8213206d4764375f32cbea36ea214573248094dc.camel@perches.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Aug 2020 12:17:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL0v6PXgMLVZzqZwjpZ4KTUGmutg6Z0YuvTccdAUa-=mw@mail.gmail.com>
Message-ID: <CAL_JsqL0v6PXgMLVZzqZwjpZ4KTUGmutg6Z0YuvTccdAUa-=mw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV) maintainers
To:     Joe Perches <joe@perches.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:05 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-08-21 at 10:45 -0600, Rob Herring wrote:
> > +Joe Perches
> >
> > On Fri, Aug 21, 2020 at 9:48 AM Steve Wahl <steve.wahl@hpe.com> wrote:
> > >
> > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> >
> > get_maintainers.pl doesn't work on MAINTAINERS. You need to send this
> > to the maintainers of the files listed in the entry below. Looks like
> > that would be the x86 maintainers.
> >
> >
> > What did Mauro, David and I do to become MAINTAINERS maintainers?
> >
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > (commit_signer:127/806=16%,authored:80/806=10%)
> > Rob Herring <robh@kernel.org> (commit_signer:103/806=13%)
> > "David S. Miller" <davem@davemloft.net> (commit_signer:99/806=12%)
> > linux-kernel@vger.kernel.org (open list)
> >
> >
> > Can we make --no-git-fallback the default? It's useful for
> > informational purposes, but never for who to email patches to. Having
> > no output would be better, then submitters have to think about where
> > to send patches.
>
> Doubtful that improves things.  At least the --git-fallback option
> shows who modified or got patches accepted to files that are
> nominally unmaintained.  It also shows the upstream path for those
> files via Signed-off-by: lines so I think --git-fallback is generally
> a good mechanism and control flag for directly unmaintained files.
>
> > What ever happened to splitting up MAINTAINERS to subdirectories? That
> > would help routing MAINTAINERS changes to the right maintainers.
>
> Splitting MAINTAINERS into subdirectories would do nothing
> to route patches.  It would just be convenience to reduce
> the total number of changes to a single file.

In general no, but for MAINTAINERS changes it would. Let's say I add
an entry for Documentation/devicetree/foo-bar.txt. With a per
subsystem/path MAINTAINERS file in
Documentation/devicetree/MAINTAINERS, you'd add an entry there and run
get_maintainer.pl:

$ touch Documentation/devicetree/MAINTAINERS
$ scripts/get_maintainer.pl -f Documentation/devicetree/MAINTAINERS
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

> Those large number of changes to the single MAINTAINERS file
> very rarely have any conflicts either, so it wouldn't really
> change the overall number of changes to MAINTAINERS entries
> spread around the tree.
>
> You are be welcome to try to split the file and get Linus to
> accept it.  I gave it a go.  Try yourself.
>
> https://lore.kernel.org/patchwork/patch/817857/

Yes, I remember that. He didn't seem totally opposed to it which is why I asked.

I have another reason for wanting the split. I want to generate a
MAINTAINERS file from the DT schema files. We have the data there and
it's checked automatically. I don't care to either continually tell
folks to add a MAINTAINERS entry or tell them to run checkpatch.pl to
tell them that. But if the infrastructure got merged, would that
already work?

Rob
