Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A67C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333432080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgAJOtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:49:53 -0500
Received: from foss.arm.com ([217.140.110.172]:45626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgAJOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:49:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CA03328;
        Fri, 10 Jan 2020 06:49:52 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 484923F6C4;
        Fri, 10 Jan 2020 06:49:51 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:49:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        dave.martin@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com
Subject: Re: [PATCH v2 7/7] arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag
 cleanly
Message-ID: <20200110144948.GC8786@arrakis.emea.arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217183402.2259904-8-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:34:02PM +0000, Suzuki K Poulose wrote:
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 3eb338f14386..240c52b71cda 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -269,7 +269,7 @@ static void sve_free(struct task_struct *task)
>   */
>  static void task_fpsimd_load(void)
>  {
> -	WARN_ON(!have_cpu_fpsimd_context());
> +	WARN_ON(!system_supports_fpsimd() || !have_cpu_fpsimd_context());

Nitpick: in the other functions you kept to WARN_ONs, apart from this
one where you added a ||.

Other than the KVM bits:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
