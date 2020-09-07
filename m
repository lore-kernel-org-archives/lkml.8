Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A03C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718B7206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599500992;
	bh=rVo9sIaJfmCRWE4FoqnLmL1YvT7fJE04BXGXALFvavQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L9GYgJY1DyZrY2ynH/DfQyczWRoklGCQWZKODz82L/5MIQT0nvfNH5qQAfU9+t91R
	 15HdYYLCLneZA1F5oDqVk88J1HADzgVSbIJEmXeLyMAbQfo/rFpLcC56yPQMFR0f4d
	 D0P2xVFMvtATo7kTU+Eus02FlvvPyY2TnA5EDmbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgIGRtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgIGMQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:16:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668222075A;
        Mon,  7 Sep 2020 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599480976;
        bh=rVo9sIaJfmCRWE4FoqnLmL1YvT7fJE04BXGXALFvavQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibqdHTlWtj8fVzuAtUTJF7iep0nyxxqaeZ5d6wNHyTSBujcUgQoVz08GsIsjBP/9Y
         T5tDzKWcs0FAHofEwjeqtMzrri3PUciAziZOBt1P6DkfEjgVBI5Lfn2oqfEHnTTPqP
         3esz4w8eF6Q3S+cCMrSedn6CBYjF6nL0N5uwZ9+A=
Date:   Mon, 7 Sep 2020 13:16:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/cpuinfo: Define HWCAP name arrays per their
 actual bit definitions
Message-ID: <20200907121611.GA12237@willie-the-truck>
References: <1597665863-564-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597665863-564-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:34:23PM +0530, Anshuman Khandual wrote:
> HWCAP name arrays (hwcap_str, compat_hwcap_str, compat_hwcap2_str) that are
> scanned for /proc/cpuinfo are detached from their bit definitions making it
> vulnerable and difficult to correlate. It is also bit problematic because
> during /proc/cpuinfo dump these arrays get traversed sequentially assuming
> they reflect and match actual HWCAP bit sequence, to test various features
> for a given CPU. This redefines name arrays per their HWCAP bit definitions
> . It also warns after detecting any feature which is not expected on arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on 5.9-rc1
> 
> Mark, since the patch has changed I have dropped your Acked-by: tag. Are you
> happy to give a new one ?
> 
> Changes in V3:
> 
> - Moved name arrays to (arch/arm64/kernel/cpuinfo.c) to prevent a build warning
> - Replaced string values with NULL for all compat features not possible on arm64
> - Changed compat_hwcap_str[] iteration on size as some NULL values are expected
> - Warn once after detecting any feature on arm64 that is not expected
> 
> Changes in V2: (https://patchwork.kernel.org/patch/11533755/)
> 
> - Defined COMPAT_KERNEL_HWCAP[2] and updated the name arrays per Mark
> - Updated the commit message as required
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11532945/)
> 
>  arch/arm64/include/asm/hwcap.h |   9 +++
>  arch/arm64/kernel/cpuinfo.c    | 172 ++++++++++++++++++++++-------------------
>  2 files changed, 100 insertions(+), 81 deletions(-)

[...]

> +	[KERNEL_HWCAP_FP]		= "fp",
> +	[KERNEL_HWCAP_ASIMD]		= "asimd",
> +	[KERNEL_HWCAP_EVTSTRM]		= "evtstrm",
> +	[KERNEL_HWCAP_AES]		= "aes",

It would be nice if the cap and the string were generated by the same
macro, along the lines of:

#define KERNEL_HWCAP(c)	[KERNEL_HWCAP_##c] = #c,

Does making the constants mixed case break anything, or is it just really
churny to do?

> @@ -166,9 +167,18 @@ static int c_show(struct seq_file *m, void *v)
>  		seq_puts(m, "Features\t:");
>  		if (compat) {
>  #ifdef CONFIG_COMPAT
> -			for (j = 0; compat_hwcap_str[j]; j++)
> -				if (compat_elf_hwcap & (1 << j))
> +			for (j = 0; j < ARRAY_SIZE(compat_hwcap_str); j++) {
> +				if (compat_elf_hwcap & (1 << j)) {
> +					/*
> +					 * Warn once if any feature should not
> +					 * have been present on arm64 platform.
> +					 */
> +					if (WARN_ON_ONCE(!compat_hwcap_str[j]))
> +						continue;
> +
>  					seq_printf(m, " %s", compat_hwcap_str[j]);
> +				}
> +			}
>  
>  			for (j = 0; compat_hwcap2_str[j]; j++)

Hmm, I find this pretty confusing now as compat_hwcap_str is not NULL
terminated and must be traversed with a loop bounded by ARRAY_SIZE(...),
whereas compat_hwcap2_str *is* NULL terminated and is traversed until you
hit the sentinel.

I think hwcap_str, compat_hwcap_str and compat_hwcap2_str should be
identical in this regard.

Will
