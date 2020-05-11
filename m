Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B3C20731
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589191509;
	bh=E+mKJuj4Us4haykExfdIq1d4iuKiBTncDiuwyBJJnZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X8xkhkn9B9Vflw+KOAleFPMW6y3NL7TLxtppTIEfxHYiflqKMMU1Mbxgft2OtGfGH
	 ibL1zMXxPcivgrAeZae3SZiTjysR49SDIFds7tL9W62GmCSk2gnuSO/JDwkwkIcZD3
	 M2QFqrPB0c9sce7kTD6bIx/Zo4mXHJVoAmKgE7gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgEKKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgEKKFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:05:07 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3830A20720;
        Mon, 11 May 2020 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589191507;
        bh=E+mKJuj4Us4haykExfdIq1d4iuKiBTncDiuwyBJJnZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1S0hrvTORHavnYfk4jkXveWVsUk0xbGEJVQZsRkrry5xEex0cvkimVVGxCe0Hmt5B
         0n/tbrjMbMdVgy7z8oRCBt+p+SbF7wUN+GjxzAl1KbzbHl3iI5242omiq7ruIyZERe
         G15b9BhKyOWEW2AWn57vy8AkaZGqD2jSPLN6iTPQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jY5J3-00BFK0-KQ; Mon, 11 May 2020 11:05:05 +0100
Date:   Mon, 11 May 2020 11:04:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm64: kvm: Move __smccc_workaround_1_smc to
 .rodata
Message-ID: <20200511110459.1fcf4db7@why>
In-Reply-To: <20200430144831.59194-7-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
        <20200430144831.59194-7-dbrazdil@google.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: dbrazdil@google.com, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 15:48:22 +0100
David Brazdil <dbrazdil@google.com> wrote:

> This snippet of assembly is used by cpu_errata.c to overwrite parts of KVM hyp
> vector. It is never directly executed, so move it from .text to .rodata.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/hyp-entry.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> index 5986e1d78d3f..7e5f386c5c2d 100644
> --- a/arch/arm64/kvm/hyp/hyp-entry.S
> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> @@ -364,6 +364,11 @@ SYM_CODE_END(__bp_harden_hyp_vecs)
>  	.popsection
>  
>  #ifndef __HYPERVISOR__
> +	/*
> +	 * This is not executed directly and is instead copied into the vectors
> +	 * by install_bp_hardening_cb().
> +	 */
> +	.pushsection	.rodata
>  SYM_CODE_START(__smccc_workaround_1_smc)

I wonder whether we should keep the SYM_CODE_START() annotation or not.
It feels weird to say "code" in a rodata section, and the alignment
doesn't matter as we copy it in place, as you noticed.

>  	esb
>  	sub	sp, sp, #(8 * 4)
> @@ -377,5 +382,6 @@ SYM_CODE_START(__smccc_workaround_1_smc)
>  1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
>  	.org 1b
>  SYM_CODE_END(__smccc_workaround_1_smc)
> +	.popsection
>  #endif /* __HYPERVISOR__ */
>  #endif /* CONFIG_KVM_INDIRECT_VECTORS */

Otherwise, looks good.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
