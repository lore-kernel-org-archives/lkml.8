Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC76C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626172078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586436932;
	bh=ouqY93umzCgNrgbre1T56T3qF+4V8KNH3EWaJaSL00Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wM+GEKBuxjPfWfMZhgIKXODFBJOP/dNpGrIXnh5pytDBOcQyDpUJKF69HD2r32R3P
	 do1PP87Pga5/ynwxDDt6i67ErYY6R4PbjfOy3uGd2tbYx813c9dk4EEneIm+0W5AVk
	 znZyFasLULAV/Oo2dbteQmpjlwPiOzZe8I1KBq3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDIMza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDIMza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:55:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EECF20B1F;
        Thu,  9 Apr 2020 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586436930;
        bh=ouqY93umzCgNrgbre1T56T3qF+4V8KNH3EWaJaSL00Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAsFkmOCqOEblMO+YurrQIDGlK+ibLPqbQH6IgSjK7cSFtOpljw13l1iBvg4FtfEE
         tHkZMSReJ+q3n5pAX3qgKzxG+1AvCFOOehg+3hYSfFrU7RQMNj2LQQDTjN9iovbeXD
         sKSd0caPqkuyr8Ke4ssonZdwoT1LRCYyUfWD7ufU=
Date:   Thu, 9 Apr 2020 13:55:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64/cpufeature: Add DIT and CSV2 feature bits in
 ID_PFR0 register
Message-ID: <20200409125526.GC13078@willie-the-truck>
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580215149-21492-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:09:05PM +0530, Anshuman Khandual wrote:
> Enable DIT and CSV2 feature bits in ID_PFR0 register as per ARM DDI 0487E.a
> specification. Except RAS and AMU, all other feature bits are now enabled.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 3 +++
>  arch/arm64/kernel/cpufeature.c  | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 054aab7ebf1b..469d61c8fabf 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -718,6 +718,9 @@
>  #define ID_ISAR6_DP_SHIFT		4
>  #define ID_ISAR6_JSCVT_SHIFT		0
>  
> +#define ID_PFR0_DIT_SHIFT		24
> +#define ID_PFR0_CSV2_SHIFT		16
> +
>  #define ID_PFR2_SSBS_SHIFT		4
>  #define ID_PFR2_CSV3_SHIFT		0
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c1e837fc8f97..9e4dab15c608 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -341,6 +341,8 @@ static const struct arm64_ftr_bits ftr_id_isar6[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_pfr0[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_DIT_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_CSV2_SHIFT, 4, 0),

Same comment as CSV3 here. Why is CSV2 being treated as strict here, but not
in the aa64* register?

Will
