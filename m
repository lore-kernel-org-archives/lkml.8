Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90412C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2322080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgAJOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:50:24 -0500
Received: from foss.arm.com ([217.140.110.172]:45656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgAJOuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:50:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383B6328;
        Fri, 10 Jan 2020 06:50:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2443F6C4;
        Fri, 10 Jan 2020 06:50:21 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:50:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        dave.martin@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: Introduce system_capabilities_finalized()
 marker
Message-ID: <20200110145019.GD8786@arrakis.emea.arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-2-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217183402.2259904-2-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:33:56PM +0000, Suzuki K Poulose wrote:
> We finalize the system wide capabilities after the SMP CPUs
> are booted by the kernel. This is used as a marker for deciding
> various checks in the kernel. e.g, sanity check the hotplugged
> CPUs for missing mandatory features.
> 
> However there is no explicit helper available for this in the
> kernel. There is sys_caps_initialised, which is not exposed.
> The other closest one we have is the jump_label arm64_const_caps_ready
> which denotes that the capabilities are set and the capability checks
> could use the individual jump_labels for fast path. This is
> performed before setting the ELF Hwcaps, which must be checked
> against the new CPUs. We also perform some of the other initialization
> e.g, SVE setup, which is important for the use of FP/SIMD
> where SVE is supported. Normally userspace doesn't get to run
> before we finish this. However the in-kernel users may
> potentially start using the neon mode. So, we need to
> reject uses of neon mode before we are set. Instead of defining
> a new marker for the completion of SVE setup, we could simply
> reuse the arm64_const_caps_ready and enable it once we have
> finished all the setup. Also we could expose this to the
> various users as "system_capabilities_finalized()" to make
> it more meaningful than "const_caps_ready".
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
