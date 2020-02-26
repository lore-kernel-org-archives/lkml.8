Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EEFC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8464320801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBZKY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:24:29 -0500
Received: from foss.arm.com ([217.140.110.172]:33408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgBZKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:24:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A94731FB;
        Wed, 26 Feb 2020 02:24:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96F7B3F9E6;
        Wed, 26 Feb 2020 02:24:27 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:24:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu
Cc:     broonie@kernel.org, catalin.marinas@arm.com,
        richard.henderson@linaro.org, will@kernel.org
Subject: Re: [PATCH 0/4] random/arm64: enable RANDOM_TRUST_CPU for arm64
Message-ID: <20200226102422.GA21484@lakrids.cambridge.arm.com>
References: <20200210130015.17664-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210130015.17664-1-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ted, sorry to ping, but do you have any thoughts on this series?

I'm happy to rework this, or drop it if you think it's completely wrong,
but if you're not too concerned it would be nice to be able to queue
this soon.

Thanks,
Mark.

On Mon, Feb 10, 2020 at 01:00:11PM +0000, Mark Rutland wrote:
> On arm64 systems some CPUs may have RNG instructions while others do
> not, and consequently we cannot generally enable the use of RNG
> instructions until all CPUs have been booted (as otherwise we'd have
> problems with preemption, etc). This prevents us from seeding the
> primary CRNG using the RNG, as this occurs before secondary CPUs are
> onlined.
> 
> These patches rework the core CRNG intialization code so that the arch
> code can (optionally) distinguish boot-time usage from runtime usage of
> the arch_get_random_*() functions. This allows arm64 to use the boot
> CPU's RNG to seed the primary CRNG, regardless of whether secondary CPUs
> support the RNG instructions. Other architectures should see no
> functional change as a result of this patches.
> 
> Thanks,
> Mark.
> 
> Mark Rutland (3):
>   random: split primary/secondary crng init paths
>   random: add arch_get_random_*long_early()
>   arm64: add credited/trusted RNG support
> 
> Richard Henderson (1):
>   random: Make RANDOM_TRUST_CPU depend on ARCH_RANDOM
> 
>  arch/arm64/include/asm/archrandom.h | 14 ++++++++++
>  drivers/char/Kconfig                |  2 +-
>  drivers/char/random.c               | 52 ++++++++++++++++++++++++++++---------
>  include/linux/random.h              | 22 ++++++++++++++++
>  4 files changed, 77 insertions(+), 13 deletions(-)
> 
> -- 
> 2.11.0
> 
