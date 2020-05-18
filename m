Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317D9207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgEROT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:19:57 -0400
Received: from foss.arm.com ([217.140.110.172]:41548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgEROT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:19:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E3C2101E;
        Mon, 18 May 2020 07:19:56 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7F9E3F52E;
        Mon, 18 May 2020 07:19:52 -0700 (PDT)
Date:   Mon, 18 May 2020 15:19:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Lecopzer Chen <lecopzer@gmail.com>,
        julien.thierry.kdev@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        alexander.shishkin@linux.intel.com,
        Catalin Marinas <catalin.marinas@arm.com>, jolsa@redhat.com,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, namhyung@kernel.org,
        Will Deacon <will@kernel.org>, yj.chiang@mediatek.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
Message-ID: <20200518141946.GA3164@C02TD0UTHF1T.local>
References: <20200516124857.75004-1-lecopzer@gmail.com>
 <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
 <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
 <20200518104524.GA1224@C02TD0UTHF1T.local>
 <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
 <CAFA6WYPKD0Kkn5yQiKZQkM+tT0iW4oPnndegD-iau9EwB5DYog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPKD0Kkn5yQiKZQkM+tT0iW4oPnndegD-iau9EwB5DYog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:39:23PM +0530, Sumit Garg wrote:
> On Mon, 18 May 2020 at 16:47, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > On 5/18/20 11:45 AM, Mark Rutland wrote:
> > > On Mon, May 18, 2020 at 02:26:00PM +0800, Lecopzer Chen wrote:
> > >> HI Sumit,
> > >>
> > >> Thanks for your information.
> > >>
> > >> I've already implemented IPI (same as you did [1], little difference
> > >> in detail), hardlockup detector and perf in last year(2019) for
> > >> debuggability.
> > >> And now we tend to upstream to reduce kernel maintaining effort.
> > >> I'm glad if someone in ARM can do this work :)
> > >>
> > >> Hi Julien,
> > >>
> > >> Does any Arm maintainers can proceed this action?
> > > Alexandru (Cc'd) has been rebasing and reworking Julien's patches, which
> > > is my preferred approach.
> > >
> > > I understand that's not quite ready for posting since he's investigating
> > > some of the nastier subtleties (e.g. mutual exclusion with the NMI), but
> > > maybe we can put the work-in-progress patches somewhere in the mean
> > > time.
> > >
> > > Alexandru, do you have an idea of what needs to be done, and/or when you
> > > expect you could post that?
> >
> > I'm currently working on rebasing the patches on top of 5.7-rc5, when I have
> > something usable I'll post a link (should be a couple of days). After that I will
> > address the review comments, and I plan to do a thorough testing because I'm not
> > 100% confident that some of the assumptions around the locks that were removed are
> > correct. My guess is this will take a few weeks.
> >
> 
> Thanks Mark, Alex for the status updates on perf NMI feature.
> 
> Alex,
> 
> As the hard-lockup detection patch [1] has a dependency on perf NMI
> patch-set, I will rebase and test hard-lockup detector when you have
> got a working tree. But due to the dependency, I think patch [1]
> should be accepted along with perf NMI patch-set. So would you be open
> to include this patch as part of your series?
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.html

While it depends on the perf NMI bits, I don't think it makes sense to
tie that into the series given it's trying to achieve something very
different.

I think that should be reposted separately once the perf NMI bits are in
shape.

Thanks,
Mark.
