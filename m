Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C92CC3403A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514F21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582033193;
	bh=8MIgSUVG1vBHF+xjowMLhULulLb4CVftpGAFG9luE9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U6jK3Y2QsN3nqvvt951eahtGihUfO0PdLifTONO1qm8sEZ5goLPY97MBx0crVzrOv
	 5AXeHSEjxcRhFnJz3kX5R2stiX+6LoxA0nQhulm++4Xw1JJm/4C9Ps4pyPCqEtacWY
	 FF3zULRCnVS8N6CtYVCs2QdecdXeKpLsw9UlHuKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgBRNjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBRNju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:39:50 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8578A2173E;
        Tue, 18 Feb 2020 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582033190;
        bh=8MIgSUVG1vBHF+xjowMLhULulLb4CVftpGAFG9luE9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1cpeQqTDA28ONjB3IwZuJRuSQO+JuDzB6ePSCf9UaBMYkSo8LemaZzTO6EYjRAYy
         aCOR+yemsiYGuUoOukhNG5eMAvDQhIV1KKEkrRkzk6G+j3XXPUOECc+d6DzxgFVIll
         t2LOdnA4KLsCFXarF8XMG87Hsw74ViNntaIUYWGo=
Date:   Tue, 18 Feb 2020 13:39:43 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
Message-ID: <20200218133943.GF20212@willie-the-truck>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:24:38PM +0000, John Garry wrote:
> On 18/02/2020 12:57, Will Deacon wrote:
> > On Fri, Jan 24, 2020 at 10:34:58PM +0800, John Garry wrote:
> > > Currently event aliasing for only CPU and uncore PMUs is supported. In
> > > fact, only uncore PMUs aliasing for when the uncore PMUs are fixed for a
> > > CPU is supported, which may not always be the case for certain
> > > architectures.
> > > 
> > > This series adds support for PMU event aliasing for system and other
> > > uncore PMUs which are not fixed to a specific CPU.
> > > 
> > > For this, we introduce support for another per-arch mapfile, which maps a
> > > particular system identifier to a set of system PMU events for that
> > > system. This is much the same as what we do for CPU event aliasing.
> > > 
> > > To support this, we need to change how we match a PMU to a mapfile,
> > > whether it should use a CPU or system mapfile. For this we do the
> > > following:
> > > 
> > > - For CPU PMU, we always match for the event mapfile based on the CPUID.
> > >    This has not changed.
> > > 
> > > - For an uncore or system PMU, we match first based on the SYSID (if set).
> > >    If this fails, then we match on the CPUID.
> > > 
> > >    This works for x86, as x86 would not have any system mapfiles for uncore
> > >    PMUs (and match on the CPUID).
> > > 
> > > Initial reference support is also added for ARM SMMUv3 PMCG (Performance
> > > Monitor Event Group) PMU for HiSilicon hip08 platform with only a single
> > > event so far - see driver in drivers/perf/arm_smmuv3_pmu.c for that driver.
> > 
> > Why don't we just expose SMMU_IIDR in the SMMUv3 PMU directory, so that
> > you can key off that?
> 
> That does not sound like a standard sysfs interface.

It's standard in the sense that PMUs already have their own directory under
sysfs where you can put things. For example, the "caps" directory is a
dumping ground for all sorts of PMU-specific information.

On the other hand, saying "please go figure out which SoC you're on"
certainly isn't standard and is likely to lead to unreliable, spaghetti
code.

> Anyway, I don't think that works for every case, quoting from
> https://lkml.org/lkml/2019/10/16/465:
> 
> "> Note: I do acknowledge that an overall issue is that we assume all PMCG
> IMP DEF events are same for a given SMMU model.
> 
> That assumption does technically fail already - I know MMU-600 has
> different IMP-DEF events for its TCU and TBUs, however as long as we can
> get as far as "this is some part of an MMU-600" the driver should be
> able to figure out the rest ..."

Perhaps I'm misreading this, but it sounds like if you knew it was an
MMU-600 then you'd be ok. I also don't understand how a SoC ID makes things
any easier in this regard.

> So even if it is solvable here, the kernel driver(s) will need to be
> reworked. And that is just solving one case in many.

PMU drivers will need to expose more information to userspace so that they
can be identified more precisely, yes. I wouldn't say they would need to be
"reworked".

> I'm nervous about coming up with a global "SYSID"
> > when we don't have the ability to standardise anything in that space.
> 
> I understand totally, especially if any sysid is based on DT bindings.

Well if this is going to be ACPI-only then it's a non-starter.

> But this is some sort of standardization:
> https://developer.arm.com/docs/den0028/c, see SMCCC_ARCH_SOC_ID

Yay, firmware :/

Even if this was widely implemented (it's not), I still think that it's
the wrong level of abstraction. Why not do away with ACPI/DT entirely
and predicate everything off the SoC ID?

Will
