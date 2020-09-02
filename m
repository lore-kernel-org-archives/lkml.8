Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F79C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0172207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBHhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBHhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:37:09 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272C3208DB;
        Wed,  2 Sep 2020 07:37:07 +0000 (UTC)
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
Date:   Wed,  2 Sep 2020 08:37:03 +0100
Message-Id: <159903220030.29783.7186911071188549924.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901095229.56793-1-sudeep.holla@arm.com>
References: <20200901095229.56793-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 10:52:29 +0100, Sudeep Holla wrote:
> Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> exported cpu_logical_map in order to fix tegra194-cpufreq module build
> failure.
> 
> As this might potentially cause problem while supporting physical CPU
> hotplug, tegra194-cpufreq module was reworded to avoid use of
> cpu_logical_map() via the commit 93d0c1ab2328 ("cpufreq: replace
> cpu_logical_map() with read_cpuid_mpir()")
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Remove exporting cpu_logical_map symbol
      https://git.kernel.org/arm64/c/60295d50958e

-- 
Catalin

