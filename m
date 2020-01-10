Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25909C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC15E2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgAJOvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:51:00 -0500
Received: from foss.arm.com ([217.140.110.172]:45688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgAJOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:50:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0FB30E;
        Fri, 10 Jan 2020 06:50:59 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3BF3F6C4;
        Fri, 10 Jan 2020 06:50:58 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:50:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        dave.martin@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com
Subject: Re: [PATCH v2 3/7] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
Message-ID: <20200110145055.GE8786@arrakis.emea.arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217183402.2259904-4-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:33:58PM +0000, Suzuki K Poulose wrote:
> The NO_FPSIMD capability is defined with scope SYSTEM, which implies
> that the "absence" of FP/SIMD on at least one CPU is detected only
> after all the SMP CPUs are brought up. However, we use the status
> of this capability for every context switch. So, let us change
> the scope to LOCAL_CPU to allow the detection of this capability
> as and when the first CPU without FP is brought up.
> 
> Also, the current type allows hotplugged CPU to be brought up without
> FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
> up. Fix both of these issues by changing the capability to
> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
> 
> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
