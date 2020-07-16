Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD152076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594900852;
	bh=uIHeI2dm8rdCk7DKqpCQgSfBWLfxmE4uSZCDw/S6d0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLU9pyq88+Llr1u2BN+4ucgs9HWfbFHduhQ/fa5g+Xi8ObOj4J6EiFoTeB6vai+gA
	 7DoZtkqfKMtgPASizbaZnbOJNt30MAjW+mIzbaDrKlGytnfDL13562qeKlLnW+ZAW7
	 bQV+SlhQrxjkgiRlZbI6FzerKytZe1BnWL3GsqZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGPMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:00:50 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A727420739;
        Thu, 16 Jul 2020 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594900849;
        bh=uIHeI2dm8rdCk7DKqpCQgSfBWLfxmE4uSZCDw/S6d0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCuNji9/aIGbX+LF+n3Qmr4xn8rCXK9vlKY3FTKleC1ksIXRuopyOCgr7pw98qXpJ
         hOxaf/g6+RDa3c4JKDwotVgIhPglXTbirYMAuNAczMeW5fE1OJKHs0dQHUi3kIXHFB
         FdYmSx4kGZqd78s8S2qRQ9VsfdPPl3RQMzdaf3oY=
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>, john.garry@huawei.com,
        mark.rutland@arm.com, zhangshaokun@hisilicon.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, wang.wanghaifeng@huawei.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules during perf sampling
Date:   Thu, 16 Jul 2020 13:00:42 +0100
Message-Id: <159489574240.3940963.13068843481731049357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 17:19:25 +0800, Qi Liu wrote:
> When users try to remove PMU modules during perf sampling, kernel panic
> will happen because the pmu->read() is a NULL pointer here.
> 
> INFO on HiSilicon hip08 platform as follow:
> pc : hisi_uncore_pmu_event_update+0x30/0xa4 [hisi_uncore_pmu]
> lr : hisi_uncore_pmu_read+0x20/0x2c [hisi_uncore_pmu]
> sp : ffff800010103e90
> x29: ffff800010103e90 x28: ffff0027db0c0e40
> x27: ffffa29a76f129d8 x26: ffffa29a77ceb000
> x25: ffffa29a773a5000 x24: ffffa29a77392000
> x23: ffffddffe5943f08 x22: ffff002784285960
> x21: ffff002784285800 x20: ffff0027d2e76c80
> x19: ffff0027842859e0 x18: ffff80003498bcc8
> x17: ffffa29a76afe910 x16: ffffa29a7583f530
> x15: 16151a1512061a1e x14: 0000000000000000
> x13: ffffa29a76f1e238 x12: 0000000000000001
> x11: 0000000000000400 x10: 00000000000009f0
> x9 : ffff8000107b3e70 x8 : ffff0027db0c1890
> x7 : ffffa29a773a7000 x6 : 00000007f5131013
> x5 : 00000007f5131013 x4 : 09f257d417c00000
> x3 : 00000002187bd7ce x2 : ffffa29a38f0f0d8
> x1 : ffffa29a38eae268 x0 : ffff0027d2e76c80
> Call trace:
> hisi_uncore_pmu_event_update+0x30/0xa4 [hisi_uncore_pmu]
> hisi_uncore_pmu_read+0x20/0x2c [hisi_uncore_pmu]
> __perf_event_read+0x1a0/0x1f8
> flush_smp_call_function_queue+0xa0/0x160
> generic_smp_call_function_single_interrupt+0x18/0x20
> handle_IPI+0x31c/0x4dc
> gic_handle_irq+0x2c8/0x310
> el1_irq+0xcc/0x180
> arch_cpu_idle+0x4c/0x20c
> default_idle_call+0x20/0x30
> do_idle+0x1b4/0x270
> cpu_startup_entry+0x28/0x30
> secondary_start_kernel+0x1a4/0x1fc
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] drivers/perf: Fix kernel panic when rmmod PMU modules during perf sampling
      https://git.kernel.org/arm64/c/bdc5c744c7b6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
