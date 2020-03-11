Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA31EC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9532208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgCKMCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:02:16 -0400
Received: from foss.arm.com ([217.140.110.172]:48688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgCKMCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:02:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C891FB;
        Wed, 11 Mar 2020 05:02:15 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF18B3F6CF;
        Wed, 11 Mar 2020 05:02:14 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:02:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: Mark call_smc_arch_workaround_1 as __maybe_unused
Message-ID: <20200311120212.GE3216816@arrakis.emea.arm.com>
References: <20200310232544.8792-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310232544.8792-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:25:44PM -0700, Nathan Chancellor wrote:
> When building allnoconfig:
> 
> arch/arm64/kernel/cpu_errata.c:174:13: warning: unused function
> 'call_smc_arch_workaround_1' [-Wunused-function]
> static void call_smc_arch_workaround_1(void)
>             ^
> 1 warning generated.
> 
> Follow arch/arm and mark this function as __maybe_unused.
> 
> Fixes: 4db61fef16a1 ("arm64: kvm: Modernize __smccc_workaround_1_smc_start annotations")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied. Thanks.

-- 
Catalin
