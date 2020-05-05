Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91498C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5777920735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588678045;
	bh=2qyj23dngg47wERUJsWyKoEE8tvAolSujJUARVwGSHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MpUgmhY2L874CRTUA9hK64vTZSqPybD9V1BnqfdH0u58BPL4gtKy/C1/7L95DKnt4
	 0hQinU7APVoiP8uRRsBYJiiK3soJEIsNDShZv3/IObj6hrclb2jm+dY+IJiTb8LGMy
	 QvmtUJ4ZR2BEjjKRVwDngMijSeWvdHuN4KG1bgsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgEEL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEEL1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:27:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A50C206B9;
        Tue,  5 May 2020 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588678043;
        bh=2qyj23dngg47wERUJsWyKoEE8tvAolSujJUARVwGSHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ry4CXumTr926r/3eV5UJeAhNwO1TOsjR0/iUKFfDQs0pnRlplC1QQgY4b8yHoVDeE
         ZWc7fsttR0CsX+C6KAHnnDKepfun1WdhSXv+DbkYPXKMbwagSOvMICauAM/k6EaVpl
         TOTH3JYKfwu7YgDF/Xai67unQr9go1BONb32bfik=
Date:   Tue, 5 May 2020 12:27:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/16] arm64/cpufeature: Introduce ID_PFR2 CPU register
Message-ID: <20200505112718.GH19710@willie-the-truck>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-5-git-send-email-anshuman.khandual@arm.com>
 <20200505111241.GF19710@willie-the-truck>
 <20200505111607.GA82823@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505111607.GA82823@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 12:16:07PM +0100, Mark Rutland wrote:
> On Tue, May 05, 2020 at 12:12:41PM +0100, Will Deacon wrote:
> > On Sat, May 02, 2020 at 07:03:53PM +0530, Anshuman Khandual wrote:
> > > This adds basic building blocks required for ID_PFR2 CPU register which
> > > provides information about the AArch32 programmers model which must be
> > > interpreted along with ID_PFR0 and ID_PFR1 CPU registers. This is added
> > > per ARM DDI 0487F.a specification.
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Cc: kvmarm@lists.cs.columbia.edu
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > 
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > >  arch/arm64/include/asm/cpu.h    |  1 +
> > >  arch/arm64/include/asm/sysreg.h |  4 ++++
> > >  arch/arm64/kernel/cpufeature.c  | 11 +++++++++++
> > >  arch/arm64/kernel/cpuinfo.c     |  1 +
> > >  arch/arm64/kvm/sys_regs.c       |  2 +-
> > >  5 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> > > index b4a40535a3d8..464e828a994d 100644
> > > --- a/arch/arm64/include/asm/cpu.h
> > > +++ b/arch/arm64/include/asm/cpu.h
> > > @@ -46,6 +46,7 @@ struct cpuinfo_arm64 {
> > >  	u32		reg_id_mmfr3;
> > >  	u32		reg_id_pfr0;
> > >  	u32		reg_id_pfr1;
> > > +	u32		reg_id_pfr2;
> > >  
> > >  	u32		reg_mvfr0;
> > >  	u32		reg_mvfr1;
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index e5317a6367b6..c977449e02db 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -153,6 +153,7 @@
> > >  #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
> > >  #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
> > >  #define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
> > > +#define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)
> > 
> > nit: but please group these defines by name rather than encoding.
> 
> So far we've *always* grouped these by encoding in this file, so can we
> keep things that way for now? Otherwise we're inconsistent with both
> schemes.

Hmm, but it's really hard to read sorted that way and we'll end up with
duplicate definitions like we had for some of the field offsets already.
The only ID register that seems to be out of place atm is MMFR4, which I
can move (see below)

Will

--->8

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 2dd3f4ca9780..137201ea383b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -140,6 +140,7 @@
 #define SYS_ID_MMFR1_EL1		sys_reg(3, 0, 0, 1, 5)
 #define SYS_ID_MMFR2_EL1		sys_reg(3, 0, 0, 1, 6)
 #define SYS_ID_MMFR3_EL1		sys_reg(3, 0, 0, 1, 7)
+#define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
 
 #define SYS_ID_ISAR0_EL1		sys_reg(3, 0, 0, 2, 0)
 #define SYS_ID_ISAR1_EL1		sys_reg(3, 0, 0, 2, 1)
@@ -147,7 +148,6 @@
 #define SYS_ID_ISAR3_EL1		sys_reg(3, 0, 0, 2, 3)
 #define SYS_ID_ISAR4_EL1		sys_reg(3, 0, 0, 2, 4)
 #define SYS_ID_ISAR5_EL1		sys_reg(3, 0, 0, 2, 5)
-#define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
 #define SYS_ID_ISAR6_EL1		sys_reg(3, 0, 0, 2, 7)
 
 #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
