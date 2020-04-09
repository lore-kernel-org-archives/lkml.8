Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF562078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586436878;
	bh=Ih/KWwvRBRAhYRIoIaWK8aug+LMPArgxNsTaDiehG88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p1TK5gBvHCnN5l/iTFCkklEGilZMR+zKnNJSa2zZN5hL5gmh+cg5ISZVpC0yBo1yA
	 AibKaGrU3S9j4JLheWWs9CpICH8v+hTgJ2aWvmE6uCcEYdcFhuVTCe+slTsysokDBs
	 8iGctkj4ESNW3xCv7yQlNKxqtKwwAvFaiV1XiyLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDIMyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgDIMyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:54:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620982078E;
        Thu,  9 Apr 2020 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586436875;
        bh=Ih/KWwvRBRAhYRIoIaWK8aug+LMPArgxNsTaDiehG88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1ukhvnAj5A1UP+XfMByybnpcpAplP4ot3hRH3dWuK0SGDzR8Xr6jbE+BHR2qZcQo
         bxiEmVjaH/7pyJVVqr54gtEjegy1yVPW0B9qK0JcHP7FygdvzSrZV8UzXcTlVtbcLr
         QS45i2CfQ6PP1WDVqZpEspJ32CSxDD+vNc3Md4co=
Date:   Thu, 9 Apr 2020 13:54:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64/cpufeature: Introduce ID_PFR2 CPU register
Message-ID: <20200409125431.GB13078@willie-the-truck>
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580215149-21492-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:09:04PM +0530, Anshuman Khandual wrote:
> This adds basic building blocks required for ID_PFR2 CPU register which
> provides information about the AArch32 programmers model which must be
> interpreted along with ID_PFR0 and ID_PFR1 CPU registers.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/cpu.h    |  1 +
>  arch/arm64/include/asm/sysreg.h |  4 ++++
>  arch/arm64/kernel/cpufeature.c  | 11 +++++++++++
>  arch/arm64/kernel/cpuinfo.c     |  1 +
>  arch/arm64/kvm/sys_regs.c       |  2 +-
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index b4a40535a3d8..464e828a994d 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -46,6 +46,7 @@ struct cpuinfo_arm64 {
>  	u32		reg_id_mmfr3;
>  	u32		reg_id_pfr0;
>  	u32		reg_id_pfr1;
> +	u32		reg_id_pfr2;
>  
>  	u32		reg_mvfr0;
>  	u32		reg_mvfr1;
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index b91570ff9db1..054aab7ebf1b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -151,6 +151,7 @@
>  #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
>  #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
>  #define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
> +#define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)
>  
>  #define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
>  #define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
> @@ -717,6 +718,9 @@
>  #define ID_ISAR6_DP_SHIFT		4
>  #define ID_ISAR6_JSCVT_SHIFT		0
>  
> +#define ID_PFR2_SSBS_SHIFT		4
> +#define ID_PFR2_CSV3_SHIFT		0
> +
>  #define MVFR0_FPROUND_SHIFT		28
>  #define MVFR0_FPSHVEC_SHIFT		24
>  #define MVFR0_FPSQRT_SHIFT		20
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0b6715625cf6..c1e837fc8f97 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -348,6 +348,12 @@ static const struct arm64_ftr_bits ftr_id_pfr0[] = {
>  	ARM64_FTR_END,
>  };
>  
> +static const struct arm64_ftr_bits ftr_id_pfr2[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR2_SSBS_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR2_CSV3_SHIFT, 4, 0),

Why is CSV3 strict here, but not when we see if in aa64pfr0? I think it
should be non-strict in both cases.

Will
