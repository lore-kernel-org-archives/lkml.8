Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E41C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709FF20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgERKpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:45:38 -0400
Received: from foss.arm.com ([217.140.110.172]:37766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgERKpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:45:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52543101E;
        Mon, 18 May 2020 03:45:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBF4B3F52E;
        Mon, 18 May 2020 03:45:33 -0700 (PDT)
Date:   Mon, 18 May 2020 11:45:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lecopzer Chen <lecopzer@gmail.com>, alexandru.elisei@arm.com
Cc:     Sumit Garg <sumit.garg@linaro.org>, julien.thierry.kdev@gmail.com,
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
Message-ID: <20200518104524.GA1224@C02TD0UTHF1T.local>
References: <20200516124857.75004-1-lecopzer@gmail.com>
 <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
 <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, May 18, 2020 at 02:26:00PM +0800, Lecopzer Chen wrote:
> HI Sumit,
> 
> Thanks for your information.
> 
> I've already implemented IPI (same as you did [1], little difference
> in detail), hardlockup detector and perf in last year(2019) for
> debuggability.
> And now we tend to upstream to reduce kernel maintaining effort.
> I'm glad if someone in ARM can do this work :)
> 
> Hi Julien,
> 
> Does any Arm maintainers can proceed this action?

Alexandru (Cc'd) has been rebasing and reworking Julien's patches, which
is my preferred approach.

I understand that's not quite ready for posting since he's investigating
some of the nastier subtleties (e.g. mutual exclusion with the NMI), but
maybe we can put the work-in-progress patches somewhere in the mean
time.

Alexandru, do you have an idea of what needs to be done, and/or when you
expect you could post that?

Thanks,
Mark.

> This is really useful in debugging.
> Thank you!!
> 
> 
> 
> [1] https://lkml.org/lkml/2020/4/24/328
> 
> 
> Lecopzer
> 
> Sumit Garg <sumit.garg@linaro.org> 於 2020年5月18日 週一 下午1:46寫道：
> >
> > + Julien
> >
> > Hi Lecopzer,
> >
> > On Sat, 16 May 2020 at 18:20, Lecopzer Chen <lecopzer@gmail.com> wrote:
> > >
> > > These series implement Perf NMI funxtionality and depends on
> > > Pseudo NMI [1] which has been upstreamed.
> > >
> > > In arm64 with GICv3, Pseudo NMI was implemented for NMI-like interruts.
> > > That can be extended to Perf NMI which is the prerequisite for hard-lockup
> > > detector which had already a standard interface inside Linux.
> > >
> > > Thus the first step we need to implement perf NMI interface and make sure
> > > it works fine.
> > >
> >
> > This is something that is already implemented via Julien's patch-set
> > [1]. Its v4 has been floating since July, 2019 and I couldn't find any
> > major blocking comments but not sure why things haven't progressed
> > further.
> >
> > Maybe Julien or Arm maintainers can provide updates on existing
> > patch-set [1] and how we should proceed further with this interesting
> > feature.
> >
> > And regarding hard-lockup detection, I have been able to enable it
> > based on perf NMI events using Julien's perf patch-set [1]. Have a
> > look at the patch here [2].
> >
> > [1] https://patchwork.kernel.org/cover/11047407/
> > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.html
> >
> > -Sumit
> >
> > > Perf NMI has been test by dd if=/dev/urandom of=/dev/null like the link [2]
> > > did.
> > >
> > > [1] https://lkml.org/lkml/2019/1/31/535
> > > [2] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq
> > >
> > >
> > > Lecopzer Chen (3):
> > >   arm_pmu: Add support for perf NMI interrupts registration
> > >   arm64: perf: Support NMI context for perf event ISR
> > >   arm64: Kconfig: Add support for the Perf NMI
> > >
> > >  arch/arm64/Kconfig             | 10 +++++++
> > >  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++------
> > >  drivers/perf/arm_pmu.c         | 51 ++++++++++++++++++++++++++++++----
> > >  include/linux/perf/arm_pmu.h   |  6 ++++
> > >  4 files changed, 88 insertions(+), 15 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
