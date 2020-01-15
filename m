Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1442C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87376206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgAOKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:17:33 -0500
Received: from foss.arm.com ([217.140.110.172]:34436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgAOKRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:17:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0F031B;
        Wed, 15 Jan 2020 02:17:32 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA53D3F6C4;
        Wed, 15 Jan 2020 02:17:31 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:17:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, julien@xen.org
Subject: Re: [PATCH v2] arm64: cpufeature: Export matrix and other features
 to userspace
Message-ID: <20200115101729.GB32549@lakrids.cambridge.arm.com>
References: <20191216113337.13882-1-steven.price@arm.com>
 <20200115094916.GC21692@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115094916.GC21692@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:49:17AM +0000, Will Deacon wrote:
> On Mon, Dec 16, 2019 at 11:33:37AM +0000, Steven Price wrote:
> > Export the features introduced as part of ARMv8.6 exposed in the
> > ID_AA64ISAR1_EL1 and ID_AA64ZFR0_EL1 registers. This introduces the
> > Matrix features (ARMv8.2-I8MM, ARMv8.2-F64MM and ARMv8.2-F32MM) along
> > with BFloat16 (Armv8.2-BF16), speculation invalidation (SPECRES) and
> > Data Gathering Hint (ARMv8.0-DGH).
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > [Added other features in those registers]
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> > This is a v2 of Julien's patch[1] extended to export all the new
> > features contained within the ID_AA64ISAR1_EL1 and ID_AA64ZFR0_EL1
> > registers.
> > 
> > [1] https://lore.kernel.org/linux-arm-kernel/20191025171056.30641-1-julien.grall@arm.com/
> > 
> >  Documentation/arm64/cpu-feature-registers.rst | 16 ++++++++++
> >  Documentation/arm64/elf_hwcaps.rst            | 31 +++++++++++++++++++
> >  arch/arm64/include/asm/hwcap.h                |  8 +++++
> >  arch/arm64/include/asm/sysreg.h               | 12 +++++++
> >  arch/arm64/include/uapi/asm/hwcap.h           |  8 +++++
> >  arch/arm64/kernel/cpufeature.c                | 20 ++++++++++++
> >  arch/arm64/kernel/cpuinfo.c                   |  8 +++++
> >  7 files changed, 103 insertions(+)
> > 
> > diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> > index b6e44884e3ad..5382981533f8 100644
> > --- a/Documentation/arm64/cpu-feature-registers.rst
> > +++ b/Documentation/arm64/cpu-feature-registers.rst
> > @@ -200,6 +200,14 @@ infrastructure:
> >       +------------------------------+---------+---------+
> >       | Name                         |  bits   | visible |
> >       +------------------------------+---------+---------+
> > +     | I8MM                         | [55-52] |    y    |
> > +     +------------------------------+---------+---------+
> > +     | DGH                          | [51-48] |    y    |
> > +     +------------------------------+---------+---------+
> > +     | BF16                         | [47-44] |    y    |
> > +     +------------------------------+---------+---------+
> > +     | SPECRES                      | [43-40] |    y    |
> > +     +------------------------------+---------+---------+
> 
> I applied this for CI testing last night, but actually I think it's broken.
> AFAICT, the instructions introduced by SPECRES are behind an SCTLR_EL1
> enable (EnRCTX) which defaults to disabled, so we should either be enabling
> them before setting the HWCAP or not exposing them at all.
> 
> Given that the instructions are not broadcast and are likely to be very
> expensive, I don't think that exposing them to EL0 is a good idea.
> 
> In other words, I'll drop the SPECRES parts from this patch. Sound ok?

I completely agree. We deliberately avoided adding SPECRES for those
reasons previously:

  https://lore.kernel.org/r/20191212144633.GE46910@lakrids.cambridge.arm.com

Thanks,
Mark.
