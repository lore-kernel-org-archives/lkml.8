Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3D0C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18D20826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIBHlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBHlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:41:23 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71B620826;
        Wed,  2 Sep 2020 07:41:20 +0000 (UTC)
Date:   Wed, 2 Sep 2020 08:41:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] arm64: Remove exporting cpu_logical_map symbol
Message-ID: <20200902074117.GA28265@gaia>
References: <20200901095229.56793-1-sudeep.holla@arm.com>
 <159903220030.29783.7186911071188549924.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159903220030.29783.7186911071188549924.b4-ty@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:37:03AM +0100, Catalin Marinas wrote:
> On Tue, 1 Sep 2020 10:52:29 +0100, Sudeep Holla wrote:
> > Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> > exported cpu_logical_map in order to fix tegra194-cpufreq module build
> > failure.
> > 
> > As this might potentially cause problem while supporting physical CPU
> > hotplug, tegra194-cpufreq module was reworded to avoid use of
> > cpu_logical_map() via the commit 93d0c1ab2328 ("cpufreq: replace
> > cpu_logical_map() with read_cpuid_mpir()")
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), thanks!
> 
> [1/1] arm64: Remove exporting cpu_logical_map symbol
>       https://git.kernel.org/arm64/c/60295d50958e

Either my script on top of b4 is broken or b4 0.5.2 has a bug. It was
supposed to only reply to Sudeep here but somehow combined it with the
recipient list from Jessica's patch (arm64/module: set trampoline
section flags regardless of CONFIG_DYNAMIC_FTRACE).

-- 
Catalin
