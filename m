Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA91120735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588677263;
	bh=0K2DpxSvS3/qR26Gr3apwXgTBLAzGZEQ2x9wJfhnTxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QnQ4dErZlI+LkWiXBOPekxN579BRoxUdkDlGOss0HSB17vh1HLfetLho2rIQRniCD
	 5iPQbC1wtzLcHq8sNmi1yawSrbvQSJ0f/8fwLmZJG8amti0XLwaMMPYDhxFmNejNXR
	 MwWdpWVc+z2vUF4tzjZByUivRS6thSlq4Vq0ealw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgEELOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgEELOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:14:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F267C206B9;
        Tue,  5 May 2020 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677262;
        bh=0K2DpxSvS3/qR26Gr3apwXgTBLAzGZEQ2x9wJfhnTxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQ0hNzy9lxbvL4cILbgFbeZ/9NRJSCI9Rbt0kC9oprAvlHm2yBVvqjud3RbtPKAtC
         xZAccWb+uKtskmlWSPhSyWJZ7S/fPiZxJ8SI3C+POiOvAOBDZ82GH9nJeE1fhSJW6+
         mHAXafyh7JbkC3s7kT6femZL1bDttkNKfZmtYBmA=
Date:   Tue, 5 May 2020 12:14:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 08/16] arm64/cpufeature: Add remaining feature bits in
 ID_MMFR4 register
Message-ID: <20200505111417.GG19710@willie-the-truck>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-9-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588426445-24344-9-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:03:57PM +0530, Anshuman Khandual wrote:
> Enable all remaining feature bits like EVT, CCIDX, LSM, HPDS, CnP, XNX,
> SpecSEI in ID_MMFR4 register per ARM DDI 0487F.a.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h |  8 ++++++++
>  arch/arm64/kernel/cpufeature.c  | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index f9e3b9350540..0f34927f52b9 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -790,6 +790,14 @@
>  #define ID_ISAR6_DP_SHIFT		4
>  #define ID_ISAR6_JSCVT_SHIFT		0
>  
> +#define ID_MMFR4_EVT_SHIFT		28
> +#define ID_MMFR4_CCIDX_SHIFT		24
> +#define ID_MMFR4_LSM_SHIFT		20
> +#define ID_MMFR4_HPDS_SHIFT		16
> +#define ID_MMFR4_CNP_SHIFT		12
> +#define ID_MMFR4_XNX_SHIFT		8

Why didn't you add ID_MMFR4_AC2_SHIFT as well?

Will
