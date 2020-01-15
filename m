Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639EBC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395802187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579081764;
	bh=kQEYyTRF9+ukK/xlFWoKZxJOpIIXWl+uj7Qfml47YIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZA8u5wzE1Zk+CO7JlQgqQKQ9J3LA+bUJ51aKPiNu375DVQQyrbUT4SHI1M/4zBUid
	 5Rzn7ANVxK8/77VKcNZVcMfHif+h/FNGp/UIBMkG6ko91p7L13VeimlPbuKhvzumlZ
	 s6Xi72qT5m/rFDZf9q2ulAgCk4htU8wCV73ul7LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgAOJtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgAOJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:49:22 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585F82187F;
        Wed, 15 Jan 2020 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579081761;
        bh=kQEYyTRF9+ukK/xlFWoKZxJOpIIXWl+uj7Qfml47YIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6U3xjVMoZRI+DVMWuutNNkjNF96YThrvkbWoAjPGUN0RVnPlNNooQ8EcyINvdEFx
         3a/uApzPmBEtxEu8Oi5LJ15Ff3EZiU5JjY7rHiENVN3w7rb68BNa3rg2S0m2Bx8mgc
         P1ISA76foIpNPnYGpVljskJtTGBAcrKqdAF5BTTc=
Date:   Wed, 15 Jan 2020 09:49:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, julien@xen.org
Subject: Re: [PATCH v2] arm64: cpufeature: Export matrix and other features
 to userspace
Message-ID: <20200115094916.GC21692@willie-the-truck>
References: <20191216113337.13882-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216113337.13882-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:33:37AM +0000, Steven Price wrote:
> Export the features introduced as part of ARMv8.6 exposed in the
> ID_AA64ISAR1_EL1 and ID_AA64ZFR0_EL1 registers. This introduces the
> Matrix features (ARMv8.2-I8MM, ARMv8.2-F64MM and ARMv8.2-F32MM) along
> with BFloat16 (Armv8.2-BF16), speculation invalidation (SPECRES) and
> Data Gathering Hint (ARMv8.0-DGH).
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> [Added other features in those registers]
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This is a v2 of Julien's patch[1] extended to export all the new
> features contained within the ID_AA64ISAR1_EL1 and ID_AA64ZFR0_EL1
> registers.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20191025171056.30641-1-julien.grall@arm.com/
> 
>  Documentation/arm64/cpu-feature-registers.rst | 16 ++++++++++
>  Documentation/arm64/elf_hwcaps.rst            | 31 +++++++++++++++++++
>  arch/arm64/include/asm/hwcap.h                |  8 +++++
>  arch/arm64/include/asm/sysreg.h               | 12 +++++++
>  arch/arm64/include/uapi/asm/hwcap.h           |  8 +++++
>  arch/arm64/kernel/cpufeature.c                | 20 ++++++++++++
>  arch/arm64/kernel/cpuinfo.c                   |  8 +++++
>  7 files changed, 103 insertions(+)
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index b6e44884e3ad..5382981533f8 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -200,6 +200,14 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> +     | I8MM                         | [55-52] |    y    |
> +     +------------------------------+---------+---------+
> +     | DGH                          | [51-48] |    y    |
> +     +------------------------------+---------+---------+
> +     | BF16                         | [47-44] |    y    |
> +     +------------------------------+---------+---------+
> +     | SPECRES                      | [43-40] |    y    |
> +     +------------------------------+---------+---------+

I applied this for CI testing last night, but actually I think it's broken.
AFAICT, the instructions introduced by SPECRES are behind an SCTLR_EL1
enable (EnRCTX) which defaults to disabled, so we should either be enabling
them before setting the HWCAP or not exposing them at all.

Given that the instructions are not broadcast and are likely to be very
expensive, I don't think that exposing them to EL0 is a good idea.

In other words, I'll drop the SPECRES parts from this patch. Sound ok?

Will
